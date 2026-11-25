import 'package:flutter/material.dart';

import '../models/task_item.dart';
import '../theme/app_colors.dart';
import '../widgets/app_message.dart';
import '../widgets/priority_chip.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final _search = TextEditingController();
  final List<TaskItem> _tasks = [
    TaskItem(
      id: 'lab6',
      title: 'Lab 6: Navigation and routing',
      course: 'CSE 464',
      when: '11:59 PM',
      priority: Priority.high,
      section: TaskSection.today,
    ),
    TaskItem(
      id: 'ch7',
      title: 'Read chapter 7: Normalization',
      course: 'CSE 303',
      when: '6:00 PM',
      priority: Priority.medium,
      section: TaskSection.today,
    ),
    TaskItem(
      id: 'quiz3',
      title: 'Submit quiz 3 reflection',
      course: 'MAT 212',
      when: '2:00 PM',
      priority: Priority.low,
      section: TaskSection.today,
      done: true,
    ),
    TaskItem(
      id: 'er',
      title: 'ER diagram for library system',
      course: 'CSE 303',
      when: '5:00 PM',
      priority: Priority.medium,
      section: TaskSection.tomorrow,
    ),
    TaskItem(
      id: 'lec9',
      title: 'Watch lecture 9',
      course: 'CSE 464',
      when: '8:00 PM',
      priority: Priority.low,
      section: TaskSection.tomorrow,
    ),
  ];

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<TaskItem> _visible(TaskSection section) {
    final query = _search.text.trim().toLowerCase();
    return _tasks.where((task) {
      if (task.section != section) {
        return false;
      }
      if (query.isEmpty) {
        return true;
      }
      final haystack = '${task.title} ${task.course} ${task.when}'.toLowerCase();
      return haystack.contains(query);
    }).toList();
  }

  Future<void> _addTask() async {
    final title = TextEditingController();
    final course = TextEditingController();
    final created = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: title,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: course,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(labelText: 'Course'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    if (created == true && title.text.trim().isNotEmpty && mounted) {
      setState(() {
        _tasks.insert(
          0,
          TaskItem(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            title: title.text.trim(),
            course: course.text.trim().isEmpty ? 'CSE 464' : course.text.trim(),
            when: 'Today',
            priority: Priority.medium,
            section: TaskSection.today,
          ),
        );
      });
    }
    title.dispose();
    course.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final today = _visible(TaskSection.today);
    final tomorrow = _visible(TaskSection.tomorrow);

    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 96),
            children: [
              Row(
                children: [
                  const Text(
                    'Tasks',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => showAppMessage(context, 'Calendar'),
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: colors.ink,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _search,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search tasks, courses...',
                  hintStyle: TextStyle(color: colors.muted),
                  prefixIcon: Icon(Icons.search, color: colors.muted),
                  filled: true,
                  fillColor: colors.card,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              if (today.isNotEmpty)
                _TaskSection(
                  label: 'TODAY · FRI, 13 NOV',
                  tasks: today,
                  onToggle: _toggle,
                ),
              if (tomorrow.isNotEmpty) ...[
                const SizedBox(height: 8),
                _TaskSection(
                  label: 'TOMORROW · SAT, 14 NOV',
                  tasks: tomorrow,
                  onToggle: _toggle,
                ),
              ],
              if (today.isEmpty && tomorrow.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 48),
                  child: Text(
                    'No tasks found',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colors.muted),
                  ),
                ),
            ],
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              onPressed: _addTask,
              backgroundColor: AppPalette.blue,
              foregroundColor: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(Icons.add, size: 28),
            ),
          ),
        ],
      ),
    );
  }

  void _toggle(TaskItem task) {
    setState(() => task.done = !task.done);
  }
}

class _TaskSection extends StatelessWidget {
  const _TaskSection({
    required this.label,
    required this.tasks,
    required this.onToggle,
  });

  final String label;
  final List<TaskItem> tasks;
  final ValueChanged<TaskItem> onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final count = tasks.length == 1 ? '1 TASK' : '${tasks.length} TASKS';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: TextStyle(
                    color: colors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              count,
              style: const TextStyle(
                color: AppPalette.blue,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        for (final task in tasks) ...[
          _TaskTile(task: task, onToggle: () => onToggle(task)),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({required this.task, required this.onToggle});

  final TaskItem task;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final titleColor = task.done ? colors.muted : colors.ink;

    return Material(
      color: colors.card,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: colors.cardShadow,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              _CheckBox(checked: task.done),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        decoration: task.done
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationColor: colors.muted,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.meta,
                      style: TextStyle(color: colors.muted, fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              PriorityChip(priority: task.priority),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckBox extends StatelessWidget {
  const _CheckBox({required this.checked});

  final bool checked;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: checked ? AppPalette.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: checked ? AppPalette.blue : colors.line,
          width: 1.6,
        ),
      ),
      child: checked
          ? const Icon(Icons.check, size: 16, color: Colors.white)
          : null,
    );
  }
}
