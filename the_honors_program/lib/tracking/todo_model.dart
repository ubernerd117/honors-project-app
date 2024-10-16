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
  bool completed;

  Todo(
      {this.id,
      required this.majorStepId,
      required this.name,
      required this.completed});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'majorStepId': majorStepId,
      'name': name,
      'completed': completed ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      majorStepId: map['majorStepId'],
      name: map['name'],
      completed: map['completed'] == 1,
    );
  }
}
