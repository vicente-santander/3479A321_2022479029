import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_application_1/models/auditoria.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  // Método para obtener la instancia de la base de datos
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializar la base de datos
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'auditoria.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE auditoria(id INTEGER PRIMARY KEY AUTOINCREMENT, action TEXT)',
        );
      },
    );
  }

  // Insertar una nueva acción en la auditoría
  Future<void> insertAuditoria(Auditoria auditoria) async {
    final db = await database;
    await db.insert('auditoria', auditoria.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Recuperar todas las auditorías
  Future<List<Auditoria>> getAllAuditorias() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('auditoria');
    return List.generate(maps.length, (i) {
      return Auditoria.fromMap(maps[i]);
    });
  }
}
