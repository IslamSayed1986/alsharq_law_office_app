import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alsharq_law_office_app/models/task.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task task;

  const TaskDetailsScreen({super.key, required this.task});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late DateTime dueDate;
  late DateTime? hijriDueDate;
  late TimeOfDay dueTime;
  late TaskPriority priority;
  late String assignedTo;
  late TaskStatus status;
  late String relatedTo;
  late String relatedType;
  bool isRecurring = false;
  bool hasReminder = false;
  DateTime? reminderDate;
  String? dependsOn;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);
    dueDate = DateTime.now();
    dueTime = TimeOfDay.now();
    priority = widget.task.priority;
    assignedTo = widget.task.assignedTo;
    status = widget.task.status;
    relatedTo = '';
    relatedType = '';
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'تعديل المهمة',
            style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: _deleteTask,
              tooltip: 'حذف',
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTaskDetails(),
              const SizedBox(height: 24),
              _buildAssignmentAndStatus(),
              const SizedBox(height: 24),
              _buildDueDates(),
              const SizedBox(height: 24),
              _buildRecurrenceAndReminders(),
              const SizedBox(height: 24),
              _buildDependencies(),
              const SizedBox(height: 32),
              _buildBottomButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskDetails() {
    return _buildSection(
      title: 'تفاصيل المهمة',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'عنوان المهمة*',
                  labelStyle: GoogleFonts.cairo(),
                  border: const OutlineInputBorder(),
                ),
                style: GoogleFonts.cairo(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'الوصف',
                  labelStyle: GoogleFonts.cairo(),
                  border: const OutlineInputBorder(),
                ),
                maxLines: 4,
                style: GoogleFonts.cairo(),
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'متعلق بـ*',
                value: relatedType,
                items: ['عميل', 'قضية', 'مستند'].map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type, style: GoogleFonts.cairo()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => relatedType = value!);
                },
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'اختر*',
                value: relatedTo,
                items: ['اختر...'].map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item, style: GoogleFonts.cairo()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => relatedTo = value!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAssignmentAndStatus() {
    return _buildSection(
      title: 'التعيين والحالة',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildDropdownField(
                label: 'معين إلى',
                value: assignedTo,
                items: ['أحمد محمد', 'علي أحمد'].map((name) {
                  return DropdownMenuItem(
                    value: name,
                    child: Text(name, style: GoogleFonts.cairo()),
                  );
                }).toList(),
                onChanged: (value) => setState(() => assignedTo = value!),
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'حالة المهمة*',
                value: status,
                items: TaskStatus.values.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status.label, style: GoogleFonts.cairo()),
                  );
                }).toList(),
                onChanged: (value) => setState(() => status = value!),
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'الأولوية*',
                value: priority,
                items: TaskPriority.values.map((priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority.label, style: GoogleFonts.cairo()),
                  );
                }).toList(),
                onChanged: (value) => setState(() => priority = value!),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDueDates() {
    return _buildSection(
      title: 'تاريخ الاستحقاق',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              InkWell(
                onTap: _selectDueDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'تاريخ الاستحقاق*',
                    labelStyle: GoogleFonts.cairo(),
                    border: const OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDate(dueDate),
                        style: GoogleFonts.cairo(),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: _selectHijriDueDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Hijri Due Date',
                    labelStyle: GoogleFonts.cairo(),
                    border: const OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        hijriDueDate != null ? _formatDate(hijriDueDate!) : '',
                        style: GoogleFonts.cairo(),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: _selectDueTime,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'messages.due_time',
                    labelStyle: GoogleFonts.cairo(),
                    border: const OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dueTime.format(context),
                        style: GoogleFonts.cairo(),
                      ),
                      const Icon(Icons.access_time),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecurrenceAndReminders() {
    return _buildSection(
      title: 'التكرار والتذكيرات',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SwitchListTile(
                title: Text('التكرار', style: GoogleFonts.cairo()),
                value: isRecurring,
                onChanged: (value) => setState(() => isRecurring = value),
              ),
              if (isRecurring) ...[
                const SizedBox(height: 16),
                _buildDropdownField(
                  label: 'نوع التكرار',
                  value: 'يومي',
                  items: ['يومي', 'أسبوعي', 'شهري'].map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type, style: GoogleFonts.cairo()),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
              ],
              const Divider(),
              SwitchListTile(
                title: Text('تاريخ التذكير', style: GoogleFonts.cairo()),
                value: hasReminder,
                onChanged: (value) => setState(() => hasReminder = value),
              ),
              if (hasReminder) ...[
                const SizedBox(height: 16),
                InkWell(
                  onTap: _selectReminderDate,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'تاريخ التذكير',
                      labelStyle: GoogleFonts.cairo(),
                      border: const OutlineInputBorder(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          reminderDate != null ? _formatDate(reminderDate!) : '',
                          style: GoogleFonts.cairo(),
                        ),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDependencies() {
    return _buildSection(
      title: 'الاعتماديات',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildDropdownField(
            label: 'يعتمد على',
            value: dependsOn,
            items: ['اختر...'].map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item, style: GoogleFonts.cairo()),
              );
            }).toList(),
            onChanged: (value) => setState(() => dependsOn = value),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _saveTask,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              'حفظ',
              style: GoogleFonts.cairo(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              'إلغاء',
              style: GoogleFonts.cairo(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildDropdownField<T>({
    required String label,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required void Function(T?) onChanged,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.cairo(),
        border: const OutlineInputBorder(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          isExpanded: true,
        ),
      ),
    );
  }

  Future<void> _selectDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => dueDate = picked);
    }
  }

  Future<void> _selectHijriDueDate() async {
    // Implement Hijri date picker
  }

  Future<void> _selectDueTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: dueTime,
    );
    if (picked != null) {
      setState(() => dueTime = picked);
    }
  }

  Future<void> _selectReminderDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: reminderDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => reminderDate = picked);
    }
  }

  void _saveTask() {
    // Implement save functionality
    Navigator.pop(context);
  }

  void _deleteTask() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تأكيد الحذف', style: GoogleFonts.cairo()),
        content: Text('هل أنت متأكد من حذف هذه المهمة؟', style: GoogleFonts.cairo()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إلغاء', style: GoogleFonts.cairo()),
          ),
          TextButton(
            onPressed: () {
              // Implement delete functionality
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to previous screen
            },
            child: Text(
              'حذف',
              style: GoogleFonts.cairo(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
} 