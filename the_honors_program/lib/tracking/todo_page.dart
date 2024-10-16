import 'package:flutter/material.dart';
import 'package:the_honors_program/tracking/database_helper.dart';
import 'todo_model.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<MajorStep> _majorSteps = [];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _populateInitialDataIfNeeded();
    await _loadMajorSteps();
  }

  Future<void> _populateInitialDataIfNeeded() async {
    final db = DatabaseHelper.instance;
    final steps = await db.getMajorSteps();
    if (steps.isEmpty) {
      await _populateInitialData();
    }
  }

  Future<void> _populateInitialData() async {
    final db = DatabaseHelper.instance;

    // Early Planning
    int earlyPlanningId = await db.insertMajorStep(
        MajorStep(name: "Early Planning (1st & 2nd Years)", tasks: []));
    await db.insertTodo(Todo(
        majorStepId: earlyPlanningId,
        name: "Fulfill Honors Requirements",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: earlyPlanningId,
        name: "Project Discussion",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: earlyPlanningId,
        name: "Initial Project Planning",
        completed: false));

    // Project Preparation
    int projectPrepId = await db.insertMajorStep(
        MajorStep(name: "Project Preparation (3rd Year)", tasks: []));
    await db.insertTodo(Todo(
        majorStepId: projectPrepId,
        name: "Identify Faculty Advisor",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectPrepId,
        name: "Meet with Honors Advisor",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectPrepId,
        name: "Turn in Approval Checksheet",
        completed: false));

    // Project Development
    int projectDevId = await db.insertMajorStep(
        MajorStep(name: "Project Development (4th Year - Fall)", tasks: []));
    await db.insertTodo(Todo(
        majorStepId: projectDevId,
        name: "Take HNRS 4980 Course",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectDevId,
        name: "Set Project Goals",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectDevId,
        name: "Submit 4980 Form 1",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectDevId,
        name: "Project Timeline & Bibliography",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectDevId,
        name: "Submit Project Proposal",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectDevId,
        name: "Identify Second Faculty Advisor",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectDevId,
        name: "Submit 4980 Form 2",
        completed: false));

    // Project Execution and Completion
    int projectExecId = await db.insertMajorStep(MajorStep(
        name: "Project Execution and Completion (4th Year - Spring)",
        tasks: []));
    await db.insertTodo(Todo(
        majorStepId: projectExecId,
        name: "Take HNRS 4990 Course",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectExecId,
        name: "Submit 4990 Form 1",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectExecId,
        name: "Complete the Project",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectExecId,
        name: "Presentation and Defense",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectExecId,
        name: "Final Draft Submission",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectExecId,
        name: "Submit 4990 Form 2",
        completed: false));
  }

  Future<void> _loadMajorSteps() async {
    final steps = await DatabaseHelper.instance.getMajorSteps();
    final loadedSteps = await Future.wait(steps.map((step) async {
      final tasks =
          await DatabaseHelper.instance.getTodosForMajorStep(step.id!);
      return MajorStep(id: step.id, name: step.name, tasks: tasks);
    }));
    setState(() {
      _majorSteps = loadedSteps;
    });
  }

  void _addTodoItem(String name, int majorStepId) async {
    final todo = Todo(majorStepId: majorStepId, name: name, completed: false);
    await DatabaseHelper.instance.insertTodo(todo);
    _loadMajorSteps();
    _textFieldController.clear();
  }

  void _handleTodoChange(Todo todo) async {
    todo.completed = !todo.completed;
    await DatabaseHelper.instance.updateTodo(todo);
    _loadMajorSteps();
  }

  void _deleteTodo(Todo todo) async {
    await DatabaseHelper.instance.deleteTodo(todo.id!);
    _loadMajorSteps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _majorSteps.length,
        itemBuilder: (context, index) {
          final step = _majorSteps[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                _buildMajorStepBlock(step),
                _buildTaskList(step),
                _buildAddTaskButton(step),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMajorStepBlock(MajorStep step) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Stack(
            children: [
              Container(
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                widthFactor: step.progress,
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Center(
                child: Text(
                  '${(step.progress * 100).toInt()}%',
                  style: TextStyle(
                    color: step.progress > 0.5 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList(MajorStep step) {
    return Column(
      children: step.tasks
          .map((todo) => TodoItem(
                todo: todo,
                onTodoChanged: _handleTodoChange,
                removeTodo: _deleteTodo,
              ))
          .toList(),
    );
  }

  Widget _buildAddTaskButton(MajorStep step) {
    return TextButton(
      child: Text('Add Task'),
      onPressed: () => _displayDialog(step.id!),
    );
  }

  Future<void> _displayDialog(int majorStepId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a task'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Type your task'),
            autofocus: true,
          ),
          actions: <Widget>[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_textFieldController.text, majorStepId);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
    required this.removeTodo,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  final void Function(Todo todo) onTodoChanged;
  final void Function(Todo todo) removeTodo;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTodoChanged(todo);
      },
      leading: Checkbox(
        checkColor: Colors.greenAccent,
        activeColor: Colors.red,
        value: todo.completed,
        onChanged: (value) {
          onTodoChanged(todo);
        },
      ),
      title: Row(children: <Widget>[
        Expanded(
          child: Text(todo.name, style: _getTextStyle(todo.completed)),
        ),
        IconButton(
          iconSize: 30,
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          alignment: Alignment.centerRight,
          onPressed: () {
            removeTodo(todo);
          },
        ),
      ]),
    );
  }
}
