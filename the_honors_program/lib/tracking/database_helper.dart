import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'todo_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('honors_project.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1, // Increment this when you add a new migration
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE major_steps(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE todos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        majorStepId INTEGER NOT NULL,
        name TEXT NOT NULL,
        description TEXT,
        deadline TEXT,
        completed INTEGER NOT NULL,
        FOREIGN KEY (majorStepId) REFERENCES major_steps(id)
      )
    ''');
  }

  Future<int> insertMajorStep(MajorStep step) async {
    final db = await instance.database;
    return await db.insert('major_steps', step.toMap());
  }

  Future<int> insertTodo(Todo todo) async {
    final db = await instance.database;
    return await db.insert('todos', todo.toMap());
  }

  Future<List<MajorStep>> getMajorSteps() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('major_steps');
    return List.generate(maps.length, (i) {
      return MajorStep.fromMap(maps[i]);
    });
  }

  // Update the getTodosForMajorStep method
  Future<List<Todo>> getTodosForMajorStep(int majorStepId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'todos',
      where: 'majorStepId = ?',
      whereArgs: [majorStepId],
    );
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await instance.database;
    return await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> deleteTodo(int id) async {
    final db = await instance.database;
    return await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('Upgrading database from version $oldVersion to $newVersion');

    if (oldVersion < 2) {
      // Example: Adding a new column to the todos table
      await db
          .execute('ALTER TABLE todos ADD COLUMN priority INTEGER DEFAULT 0');
    }

    if (oldVersion < 3) {
      // Example: Creating a new table for categories
      await db.execute('''
        CREATE TABLE categories(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL
        )
      ''');
    }

    // Add more conditions here for future versions
    // if (oldVersion < 4) { ... }
    // if (oldVersion < 5) { ... }

    // After all migrations are done, update the user_version
    await db.setVersion(newVersion);
  }
}
