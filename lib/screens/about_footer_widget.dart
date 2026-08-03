import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Official credit block — must appear on every Settings/About screen
/// per the DSBA PR office requirement.
class AboutFooter extends StatelessWidget {
  const AboutFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: DSBAColors.neutralDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.white,
            backgroundImage: const AssetImage('assets/branding/dsba_logo.jpg'),
            onBackgroundImageError: (_, __) {},
          ),
          const SizedBox(height: 10),
          const Text(
            'Deutsche Schule der Borromäerinnen Alexandria (DSBA)',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13),
          ),
          const SizedBox(height: 6),
          const Text(
            'Concept & Operational Execution by:\nAmir Wahby — Public Relations Manager (DSBA)',
            textAlign: TextAlign.center,
            style: TextStyle(color: DSBAColors.accentGold, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 10),
          const Divider(color: Colors.white24),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.email_outlined, size: 14, color: Colors.white70),
              SizedBox(width: 6),
              Text('p.r@dsb-alexandria.de',
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.phone_outlined, size: 14, color: Colors.white70),
              SizedBox(width: 6),
              Text('+20 101 35 35 436', style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
