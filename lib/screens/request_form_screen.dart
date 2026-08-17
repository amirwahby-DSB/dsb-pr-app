import 'package:flutter/material.dart';
import '../models/pr_request.dart';
import '../theme/app_theme.dart';
import 'request_form_strings.dart';

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
          .showSnackBar(SnackBar(content: Text(RequestFormStrings.selectPillarFirst)));
      return;
    }
    if (_step == 1 && _titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(RequestFormStrings.enterTitleFirst)));
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
        title: Text(RequestFormStrings.submittedTitle),
        content: Text(RequestFormStrings.submittedBody),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(RequestFormStrings.ok),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(RequestFormStrings.newRequestTitle)),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (_step > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(() => _step--),
                    child: Text(RequestFormStrings.previous),
                  ),
                ),
              if (_step > 0) const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: _next,
                  child: Text(_step == 3 ? RequestFormStrings.submitRequest : RequestFormStrings.next),
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
        Text(RequestFormStrings.choosePillarHeader,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(height: 12),
        ...Pillar.values.map((p) => RadioListTile<Pillar>(
              value: p,
              groupValue: _pillar,
              onChanged: (v) => setState(() => _pillar = v),
              title: Text(p.title),
              activeColor: DSBAColors.primaryCrimson,
            )),
      ],
    );
  }

  Widget _detailsStep() {
    return ListView(
      children: [
        Text(RequestFormStrings.detailsHeader, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(height: 12),
        TextField(
          controller: _titleController,
          decoration: InputDecoration(labelText: RequestFormStrings.requestTitleLabel),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _descController,
          maxLines: 4,
          decoration: InputDecoration(labelText: RequestFormStrings.descriptionLabel),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _priority,
          decoration: InputDecoration(labelText: RequestFormStrings.priorityLabel),
          items: [
            DropdownMenuItem(value: 'low', child: Text(RequestFormStrings.priorityLow)),
            DropdownMenuItem(value: 'normal', child: Text(RequestFormStrings.priorityNormal)),
            DropdownMenuItem(value: 'high', child: Text(RequestFormStrings.priorityHigh)),
            DropdownMenuItem(value: 'urgent', child: Text(RequestFormStrings.priorityUrgent)),
          ],
          onChanged: (v) => setState(() => _priority = v ?? 'normal'),
        ),
      ],
    );
  }

  Widget _attachmentsStep() {
    return ListView(
      children: [
        Text(RequestFormStrings.attachmentsHeader,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () => setState(
              () => _attachedFiles.add('${RequestFormStrings.documentPrefix}_${_attachedFiles.length + 1}.pdf')),
          icon: const Icon(Icons.attach_file),
          label: Text(RequestFormStrings.attachFile),
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
        Text(RequestFormStrings.reviewHeader, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _reviewRow(RequestFormStrings.reviewPillar, _pillar?.title ?? RequestFormStrings.noValue),
                _reviewRow(RequestFormStrings.reviewTitle, _titleController.text),
                _reviewRow(RequestFormStrings.reviewDescription,
                    _descController.text.isEmpty ? RequestFormStrings.noValue : _descController.text),
                _reviewRow(RequestFormStrings.priorityLabel, RequestFormStrings.priorityDisplay(_priority)),
                _reviewRow(RequestFormStrings.reviewAttachments, RequestFormStrings.filesCount(_attachedFiles.length)),
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
    final labels = [
      RequestFormStrings.stepPillar,
      RequestFormStrings.stepDetails,
      RequestFormStrings.stepAttachments,
      RequestFormStrings.stepReview,
    ];
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
