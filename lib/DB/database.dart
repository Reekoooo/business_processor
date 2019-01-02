



import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String dbName = 'mainDB';
  final String maintTable = 'mainTable';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnCompany = 'company';
  final String columnSignature = 'signature';
  final String columnReliability = 'reliability';

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {return _db;}
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $maintTable($columnId INTEGER PRIMARY KEY, $columnName TEXT, $columnCompany TEXT, $columnSignature TEXT, $columnReliability INTEGER)');
  }

  Future<int> saveClient(Client client) async {
    var dbClient = await db;
    var result = await dbClient.insert(maintTable, client.toMap());
    return result;
  }

  Future<List<Client>> getClientsList() async {
   List<Client> items = [];
    var dbClient = await db;
    await dbClient.query(maintTable, columns: [
      columnId,columnName,columnCompany,columnSignature,columnReliability]).
      then((client) {client.forEach((client) {items.add(Client.fromMap(client));
      });
    });
    return items;
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $maintTable'));
  }

  Future<Client> getClient(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(maintTable,
        columns: [
          columnId,
          columnName,
          columnCompany,
          columnSignature,
          columnReliability,
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (result.length > 0) {
      return new Client.fromMap(result.first);
    }
    return null;
  }

  Future<int> deleteClient(Client client) async {
    var dbClient = await db;
    return await dbClient
        .delete(maintTable, where: '$columnId = ?', whereArgs: [client.id]);
  }

  Future<int> updateClient(Client client) async {
    var dbClient = await db;
    return await dbClient.update(maintTable, client.toMap(),
        where: "$columnId = ?", whereArgs: [client.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}