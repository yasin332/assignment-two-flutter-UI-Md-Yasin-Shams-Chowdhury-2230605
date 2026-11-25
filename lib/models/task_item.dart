enum Priority { high, medium, low }

enum TaskSection { today, tomorrow }

class TaskItem {
  TaskItem({
    required this.id,
    required this.title,
    required this.course,
    required this.when,
    required this.priority,
    required this.section,
    this.done = false,
  });

  final String id;
  final String title;
  final String course;
  final String when;
  final Priority priority;
  final TaskSection section;
  bool done;

  String get meta => '$course · $when';
}
