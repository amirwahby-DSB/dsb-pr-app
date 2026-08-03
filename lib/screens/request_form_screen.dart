import 'package:flutter/material.dart';
import '../models/pr_request.dart';
import '../theme/app_theme.dart';

/// Step 1: Pillar/service selection
/// Step 2: Dynamic details form
/// Step 3: Attachments
/// Step 4: Review & Submit
class RequestFormScreen extends StatefulWidget {
  final Pillar? preselectedPillar;
  final String? preselectedService;

  const RequestFormScreen({super.key, this.preselectedPillar, this.preselectedService});

  @override
  State<RequestFormScreen> createState() => _RequestFormScreenState();
}

class _RequestFormScreenState extends State<RequestFormScreen> {
  int _step = 0;
  Pillar? _pillar;
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String _priority = 'normal';
  final List<String> _attachedFiles = [];

  @override
  void initState() {
    super.initState();
    _pillar = widget.preselectedPillar;
    if (widget.preselectedService != null) {
      _titleController.text = widget.preselectedService!;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _next() {
    if (_step == 0 && _pillar == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('يرجى اختيار القسم أولاً')));
      return;
    }
    if (_step == 1 && _titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('يرجى إدخال عنوان الطلب')));
      return;
    }
    if (_step < 3) {
      setState(() => _step++);
    } else {
      _submit();
    }
  }

  void _submit() {
    // final newRequest = PRRequest(
    //   requestId: 'PR-${DateTime.now().millisecondsSinceEpoch}',
    //   pillar: _pillar!,
    //   serviceType: _titleController.text,
    //   title: _titleController.text,
    //   description: _descController.text,
    //   requesterId: MockDataService.instance.currentUser.userId,
    //   status: RequestStatus.pending,
    //   createdAt: DateTime.now(),
    // );
    // TODO: POST newRequest.toJson() to backend / Firestore collection 'requests'
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تم إرسال الطلب'),
        content: const Text('سيتواصل معك مكتب العلاقات العامة قريباً لمتابعة طلبك.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('طلب خدمة جديد')),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (_step > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(() => _step--),
                    child: const Text('السابق'),
                  ),
                ),
              if (_step > 0) const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: _next,
                  child: Text(_step == 3 ? 'إرسال الطلب' : 'التالي'),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          _StepIndicator(step: _step),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: IndexedStack(
                index: _step,
                children: [
                  _pillarStep(),
                  _detailsStep(),
                  _attachmentsStep(),
                  _reviewStep(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pillarStep() {
    return ListView(
      children: [
        const Text('اختر القسم المعني بالطلب',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(height: 12),
        ...Pillar.values.map((p) => RadioListTile<Pillar>(
              value: p,
              groupValue: _pillar,
              onChanged: (v) => setState(() => _pillar = v),
              title: Text(p.titleAr),
              subtitle: Text(p.titleEn),
              activeColor: DSBAColors.primaryCrimson,
            )),
      ],
    );
  }

  Widget _detailsStep() {
    return ListView(
      children: [
        const Text('تفاصيل الطلب', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(height: 12),
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(labelText: 'عنوان الطلب'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _descController,
          maxLines: 4,
          decoration: const InputDecoration(labelText: 'وصف تفصيلي / ملاحظات'),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _priority,
          decoration: const InputDecoration(labelText: 'الأولوية'),
          items: const [
            DropdownMenuItem(value: 'low', child: Text('منخفضة')),
            DropdownMenuItem(value: 'normal', child: Text('عادية')),
            DropdownMenuItem(value: 'high', child: Text('عالية')),
            DropdownMenuItem(value: 'urgent', child: Text('عاجلة')),
          ],
          onChanged: (v) => setState(() => _priority = v ?? 'normal'),
        ),
      ],
    );
  }

  Widget _attachmentsStep() {
    return ListView(
      children: [
        const Text('المرفقات (اختياري)',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () => setState(
              () => _attachedFiles.add('مستند_${_attachedFiles.length + 1}.pdf')),
          icon: const Icon(Icons.attach_file),
          label: const Text('إرفاق ملف'),
        ),
        const SizedBox(height: 12),
        ..._attachedFiles.map((f) => Card(
              child: ListTile(
                leading: const Icon(Icons.insert_drive_file_outlined),
                title: Text(f),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => _attachedFiles.remove(f)),
                ),
              ),
            )),
      ],
    );
  }

  Widget _reviewStep() {
    return ListView(
      children: [
        const Text('مراجعة الطلب', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _reviewRow('القسم', _pillar?.titleAr ?? '-'),
                _reviewRow('العنوان', _titleController.text),
                _reviewRow('الوصف', _descController.text.isEmpty ? '-' : _descController.text),
                _reviewRow('الأولوية', _priority),
                _reviewRow('المرفقات', '${_attachedFiles.length} ملف'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _reviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 90,
              child: Text(label,
                  style: const TextStyle(color: DSBAColors.textMuted, fontSize: 12))),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final int step;
  const _StepIndicator({required this.step});

  @override
  Widget build(BuildContext context) {
    const labels = ['القسم', 'التفاصيل', 'المرفقات', 'المراجعة'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: List.generate(labels.length, (i) {
          final active = i <= step;
          return Expanded(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor:
                      active ? DSBAColors.primaryCrimson : const Color(0xFFE0E0E0),
                  child: Text('${i + 1}',
                      style: TextStyle(
                          color: active ? Colors.white : DSBAColors.textMuted, fontSize: 12)),
                ),
                const SizedBox(height: 4),
                Text(labels[i], style: const TextStyle(fontSize: 10)),
              ],
            ),
          );
        }),
      ),
    );
  }
}
