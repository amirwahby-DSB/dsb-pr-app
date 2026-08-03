import 'package:flutter/material.dart';
import '../models/pr_request.dart';
import '../theme/app_theme.dart';
import 'chat_screen.dart';

class RequestTrackerScreen extends StatelessWidget {
  final PRRequest request;
  const RequestTrackerScreen({super.key, required this.request});

  static const _stages = [
    RequestStatus.pending,
    RequestStatus.inProgress,
    RequestStatus.completed,
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = _stages.indexOf(request.status).clamp(0, _stages.length - 1);

    return Scaffold(
      appBar: AppBar(title: Text(request.requestId)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(request.pillar.titleAr,
                      style: const TextStyle(color: DSBAColors.textMuted, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(request.title,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(request.description, style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('حالة الطلب', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 16),
          Row(
            children: List.generate(_stages.length, (i) {
              final done = i <= currentIndex;
              final isLast = i == _stages.length - 1;
              return Expanded(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: done ? statusColor(_stages[i].id) : const Color(0xFFE0E0E0),
                            shape: BoxShape.circle,
                          ),
                          child: done
                              ? const Icon(Icons.check, size: 15, color: Colors.white)
                              : null,
                        ),
                        const SizedBox(height: 6),
                        Text(_stages[i].labelAr, style: const TextStyle(fontSize: 10)),
                      ],
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          height: 3,
                          color: i < currentIndex
                              ? DSBAColors.primaryCrimson
                              : const Color(0xFFE0E0E0),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          const Text('السجل الزمني', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person_outline, color: DSBAColors.primaryCrimson),
              title: const Text('أمير وهبي — مسؤول العلاقات العامة'),
              subtitle: Text('آخر تحديث: ${request.createdAt.toString().split('.').first}'),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ChatScreen(threadId: request.requestId)),
            ),
            icon: const Icon(Icons.chat_bubble_outline),
            label: const Text('فتح محادثة حول هذا الطلب'),
          ),
        ],
      ),
    );
  }
}
