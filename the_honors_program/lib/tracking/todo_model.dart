class MajorStep {
  final int? id;
  final String name;
  late final List<Todo> tasks;

  MajorStep({this.id, required this.name, required this.tasks});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory MajorStep.fromMap(Map<String, dynamic> map) {
    return MajorStep(
      id: map['id'],
      name: map['name'],
      tasks: [],
    );
  }

  double get progress {
    if (tasks.isEmpty) return 0.0;
    int completed = tasks.where((task) => task.completed).length;
    return completed / tasks.length;
  }
}

class Todo {
  final int? id;
  final int majorStepId;
  final String name;
  final String description;
  final DateTime? deadline;
  bool completed;

  Todo({
    this.id,
    required this.majorStepId,
    required this.name,
    required this.description,
    this.deadline,
    required this.completed,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'majorStepId': majorStepId,
      'name': name,
      'description': description,
      'deadline': deadline?.toIso8601String(),
      'completed': completed ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      majorStepId: map['majorStepId'] ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      deadline:
          map['deadline'] != null ? DateTime.parse(map['deadline']) : null,
      completed: map['completed'] == 1,
    );
  }
}
