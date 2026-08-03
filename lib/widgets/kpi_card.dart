import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color accent;

  const KpiCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.accent = DSBAColors.primaryCrimson,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: accent, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  Text(label,
                      style: const TextStyle(fontSize: 11, color: DSBAColors.textMuted)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
