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

  /// Builds the PDF document bytes for the given period.
  /// [allRequests] should come from MockDataService.instance.getAllRequests()
  /// (or a real backend call once wired up).
  static Future<Uint8List> buildReport({
    required List<PRRequest> allRequests,
    required ReportPeriod period,
  }) async {
    final doc = pw.Document();
    final filtered = filterByPeriod(allRequests, period);
    final lang = LocaleService.instance.language;
    final title = periodLabel(period);

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
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(title, style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Text('$generatedOnLabel: ${DateTime.now().toString().split('.').first}',
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
          pw.Text('$totalLabel: ${filtered.length}',
              style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 16),
          pw.TableHelper.fromTextArray(
            headers: headers,
            data: filtered
                .map((r) => [
                      r.requestId,
                      lang == AppLanguage.ar ? r.pillar.titleAr : r.pillar.titleEn,
                      '${r.createdAt.year}-${r.createdAt.month.toString().padLeft(2, '0')}-${r.createdAt.day.toString().padLeft(2, '0')}',
                      r.status.labelAr,
                    ])
                .toList(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
            cellStyle: const pw.TextStyle(fontSize: 9),
            cellAlignment: pw.Alignment.centerLeft,
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
          ),
        ],
      ),
    );

    return doc.save();
  }
}
