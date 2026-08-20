import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import '../models/pr_request.dart';
import '../services/locale_service.dart';

/// The reporting periods offered in the Executive Dashboard export sheet.
enum ReportPeriod { daily, weekly, monthly, halfYearly, yearly }

/// Builds a PDF report listing PR requests (type + date) for a chosen
/// period, for management reporting (daily/monthly/half-yearly/yearly).
class ReportGenerator {
  /// Returns only the requests whose [PRRequest.createdAt] falls within
  /// the given [period], counting back from now.
  static List<PRRequest> filterByPeriod(List<PRRequest> requests, ReportPeriod period) {
    final now = DateTime.now();
    final cutoff = switch (period) {
      ReportPeriod.daily => now.subtract(const Duration(days: 1)),
      ReportPeriod.weekly => now.subtract(const Duration(days: 7)),
      ReportPeriod.monthly => now.subtract(const Duration(days: 30)),
      ReportPeriod.halfYearly => now.subtract(const Duration(days: 182)),
      ReportPeriod.yearly => now.subtract(const Duration(days: 365)),
    };
    return requests.where((r) => r.createdAt.isAfter(cutoff)).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  static String periodLabel(ReportPeriod period) {
    final lang = LocaleService.instance.language;
    return switch (period) {
      ReportPeriod.daily => switch (lang) {
          AppLanguage.ar => 'تقرير يومي',
          AppLanguage.en => 'Daily Report',
          AppLanguage.de => 'Tagesbericht',
        },
      ReportPeriod.weekly => switch (lang) {
          AppLanguage.ar => 'تقرير أسبوعي',
          AppLanguage.en => 'Weekly Report',
          AppLanguage.de => 'Wochenbericht',
        },
      ReportPeriod.monthly => switch (lang) {
          AppLanguage.ar => 'تقرير شهري',
          AppLanguage.en => 'Monthly Report',
          AppLanguage.de => 'Monatsbericht',
        },
      ReportPeriod.halfYearly => switch (lang) {
          AppLanguage.ar => 'تقرير نصف سنوي',
          AppLanguage.en => 'Half-Yearly Report',
          AppLanguage.de => 'Halbjahresbericht',
        },
      ReportPeriod.yearly => switch (lang) {
          AppLanguage.ar => 'تقرير سنوي',
          AppLanguage.en => 'Yearly Report',
          AppLanguage.de => 'Jahresbericht',
        },
    };
  }

  /// Loads the bundled Tajawal font so Arabic (and Latin/German) glyphs
  /// render correctly in the PDF — the pdf package's default (Helvetica)
  /// has no Arabic glyphs at all.
  static Future<pw.ThemeData> _buildTheme() async {
    final regularData = await rootBundle.load('assets/fonts/Tajawal-Regular.ttf');
    final boldData = await rootBundle.load('assets/fonts/Tajawal-Bold.ttf');
    final regular = pw.Font.ttf(regularData);
    final bold = pw.Font.ttf(boldData);
    return pw.ThemeData.withFont(
      base: regular,
      bold: bold,
    );
  }

  /// Loads the DSBA logo to be drawn as a faint watermark behind each page.
  static Future<pw.MemoryImage> _buildWatermark() async {
    final logoData = await rootBundle.load('assets/branding/dsba_logo.jpg');
    return pw.MemoryImage(logoData.buffer.asUint8List());
  }

  /// Builds the PDF document bytes for the given period.
  /// [allRequests] should come from MockDataService.instance.getAllRequests()
  /// (or a real backend call once wired up).
  static Future<Uint8List> buildReport({
    required List<PRRequest> allRequests,
    required ReportPeriod period,
  }) async {
    final theme = await _buildTheme();
    final logo = await _buildWatermark();
    final doc = pw.Document(theme: theme);
    final filtered = filterByPeriod(allRequests, period);
    final lang = LocaleService.instance.language;
    final title = periodLabel(period);

    // Arabic reads right-to-left; English/German read left-to-right.
    final textDirection = lang == AppLanguage.ar ? pw.TextDirection.rtl : pw.TextDirection.ltr;
    final tableAlignment = lang == AppLanguage.ar ? pw.Alignment.centerRight : pw.Alignment.centerLeft;

    final generatedOnLabel = switch (lang) {
      AppLanguage.ar => 'تاريخ الإصدار',
      AppLanguage.en => 'Generated on',
      AppLanguage.de => 'Erstellt am',
    };
    final totalLabel = switch (lang) {
      AppLanguage.ar => 'إجمالي الطلبات',
      AppLanguage.en => 'Total Requests',
      AppLanguage.de => 'Gesamtanträge',
    };
    final headers = switch (lang) {
      AppLanguage.ar => ['رقم الطلب', 'النوع', 'التاريخ', 'الحالة'],
      AppLanguage.en => ['Request ID', 'Type', 'Date', 'Status'],
      AppLanguage.de => ['Antrags-ID', 'Typ', 'Datum', 'Status'],
    };

    doc.addPage(
      pw.MultiPage(
        // pageFormat + textDirection + the background watermark all live
        // together inside PageTheme in this version of the pdf package.
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          textDirection: textDirection,
          buildBackground: (context) => pw.Center(
            child: pw.Opacity(
              opacity: 0.07,
              child: pw.Image(logo, width: 320),
            ),
          ),
        ),
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              title,
              textDirection: textDirection,
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Text(
            '$generatedOnLabel: ${DateTime.now().toString().split('.').first}',
            textDirection: textDirection,
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
          ),
          pw.Text(
            '$totalLabel: ${filtered.length}',
            textDirection: textDirection,
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 16),
          pw.Directionality(
            textDirection: textDirection,
            child: pw.TableHelper.fromTextArray(
              headers: headers,
              data: filtered
                  .map((r) => [
                        r.requestId,
                        r.pillar.title, // locale-aware (ar/en/de) instead of manual ar/en ternary
                        '${r.createdAt.year}-${r.createdAt.month.toString().padLeft(2, '0')}-${r.createdAt.day.toString().padLeft(2, '0')}',
                        r.status.label, // locale-aware (ar/en/de) instead of hardcoded labelAr
                      ])
                  .toList(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
              cellStyle: const pw.TextStyle(fontSize: 9),
              cellAlignment: tableAlignment,
              headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
            ),
          ),
        ],
      ),
    );

    return doc.save();
  }
}
