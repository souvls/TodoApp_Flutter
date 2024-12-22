import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist_app/data/data.dart';
import 'package:todolist_app/utils/utils.dart';

class TaskDatasource {
  static final TaskDatasource _instance = TaskDatasource._();
  factory TaskDatasource() => _instance;

  TaskDatasource._() {
    _initDB();
  }
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DBKeys.dbName);
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE ${DBKeys.dbTable}(
    ${DBKeys.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${DBKeys.titleColumn} TEXT,
    ${DBKeys.noteColumn} TEXT,
    ${DBKeys.timeColumn} TEXT,
    ${DBKeys.dateColumn} TEXT,
    ${DBKeys.categoryColumn} TEXT,
    ${DBKeys.isCompletedColumn} INTEGER
    )
    ''');
  }

  Future<int> addTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      final id = await txn.insert(DBKeys.dbTable, task.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return id;
    });
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      final id = await txn.update(DBKeys.dbTable, task.toJson(),
          where: '${DBKeys.idColumn} = ?', whereArgs: [task.id]);
      return id;
    });
  }

  Future<int> deleteTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      final id = await txn.delete(DBKeys.dbTable,
          where: '${DBKeys.idColumn} = ?', whereArgs: [task.id]);
      return id;
    });
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(DBKeys.dbTable, orderBy: 'id DESC');
    return List.generate(maps.length, (index) {
      return Task.fromJson(maps[index]);
    });
  }
}
