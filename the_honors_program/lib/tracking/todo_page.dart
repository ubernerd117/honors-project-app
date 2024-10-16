import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;

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
        description:
            "Complete other Honors requirements, including 20 Honors credits.",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: earlyPlanningId,
        name: "Project Discussion",
        description:
            "Discuss interests for the project with your Honors advisor.",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: earlyPlanningId,
        name: "Initial Project Planning",
        description:
            "Draft a general timeline, outline, and ideas for your project.",
        completed: false));

    // Project Preparation
    int projectPrepId = await db.insertMajorStep(
        MajorStep(name: "Project Preparation (3rd Year)", tasks: []));
    await db.insertTodo(Todo(
        majorStepId: projectPrepId,
        name: "Identify Faculty Advisor",
        description:
            "Identify one faculty advisor to help supervise your project.",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectPrepId,
        name: "Meet with Honors Advisor",
        description:
            "Schedule and attend a meeting with your Honors advisor to discuss your project plans.",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectPrepId,
        name: "Turn in Approval Checksheet",
        description: "Submit the Checksheet for Honors Project Approval.",
        completed: false));

    // Project Development
    int projectDevId = await db.insertMajorStep(
        MajorStep(name: "Project Development (4th Year - Fall)", tasks: []));
    await db.insertTodo(Todo(
        majorStepId: projectDevId,
        name: "Take HNRS 4980 Course",
        description:
            "Enroll in and complete the HNRS 4980: Honors Project Development course.",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectDevId,
        name: "Set Project Goals",
        description:
            "Meet with your faculty advisor and establish clear goals for your project.",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectDevId,
        name: "Submit 4980 Form 1",
        description:
            "Complete and submit the first form required for HNRS 4980.",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectDevId,
        name: "Project Timeline & Bibliography",
        description:
            "Create a detailed project timeline and compile an annotated bibliography.",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectDevId,
        name: "Submit Project Proposal",
        description: "Develop and submit a comprehensive project proposal.",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectDevId,
        name: "Identify Second Faculty Advisor",
        description: "Select a second faculty advisor for your project.",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectDevId,
        name: "Submit 4980 Form 2",
        description:
            "Complete and submit the second form required for HNRS 4980.",
        completed: false));

    // Project Execution and Completion
    int projectExecId = await db.insertMajorStep(MajorStep(
        name: "Project Execution and Completion (4th Year - Spring)",
        tasks: []));
    await db.insertTodo(Todo(
        majorStepId: projectExecId,
        name: "Take HNRS 4990 Course",
        description:
            "Enroll in and complete the HNRS 4990: Honors Project course.",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectExecId,
        name: "Submit 4990 Form 1",
        description:
            "Complete and submit the first form required for HNRS 4990.",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectExecId,
        name: "Complete the Project",
        description:
            "Execute and finalize your Honors Project, ensuring it meets all requirements.",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectExecId,
        name: "Presentation and Defense",
        description:
            "Schedule and complete the oral presentation and defense of your project.",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectExecId,
        name: "Final Draft Submission",
        description: "Submit the final draft of your project to ScholarWorks.",
        completed: false));
    await db.insertTodo(Todo(
        majorStepId: projectExecId,
        name: "Submit 4990 Form 2",
        description:
            "Complete and submit the second form required for HNRS 4990.",
        completed: false));
  }

  Future<void> _loadMajorSteps() async {
    try {
      final steps = await DatabaseHelper.instance.getMajorSteps();
      final loadedSteps = await Future.wait(steps.map((step) async {
        final tasks =
            await DatabaseHelper.instance.getTodosForMajorStep(step.id!);
        return MajorStep(id: step.id, name: step.name, tasks: tasks);
      }));
      setState(() {
        _majorSteps = loadedSteps;
      });
    } catch (e) {
      print('Error loading major steps: $e');
      
    }
  }

  void _addTodoItem(String name, String description, DateTime? deadline,
      int majorStepId) async {
    final todo = Todo(
      majorStepId: majorStepId,
      name: name,
      description: description,
      deadline: deadline,
      completed: false,
    );
    await DatabaseHelper.instance.insertTodo(todo);
    _loadMajorSteps();
    _nameController.clear();
    _descriptionController.clear();
    _selectedDate = null;
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
    _selectedDate = null;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add a task'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(hintText: 'Task name'),
                      autofocus: true,
                    ),
                    TextField(
                      controller: _descriptionController,
                      decoration:
                          const InputDecoration(hintText: 'Description'),
                      maxLines: 3,
                    ),
                    ListTile(
                      title: Text(_selectedDate == null
                          ? 'No date selected'
                          : 'Deadline: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != _selectedDate) {
                          setState(() {
                            _selectedDate = picked;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Add'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _addTodoItem(
                        _nameController.text,
                        _descriptionController.text,
                        _selectedDate,
                        majorStepId);
                  },
                ),
              ],
            );
          },
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
    return ExpansionTile(
      leading: Checkbox(
        value: todo.completed,
        onChanged: (bool? value) {
          onTodoChanged(todo);
        },
      ),
      title: Text(todo.name, style: _getTextStyle(todo.completed)),
      subtitle: todo.deadline != null
          ? Text('Deadline: ${DateFormat('yyyy-MM-dd').format(todo.deadline!)}')
          : null,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Description: ${todo.description}'),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => removeTodo(todo),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
