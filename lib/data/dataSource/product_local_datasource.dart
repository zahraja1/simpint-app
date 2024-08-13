import 'package:katalog/data/models/response/product_response_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductLocalDatasource {
  ProductLocalDatasource._init();
  static final ProductLocalDatasource instance =
      ProductLocalDatasource._init();
  final String tableProducts = 'products';
  static Database? _database;
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE $tableProducts(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER,
        writer_name TEXT,
        title TEXT,
        desc TEXT,
        price INTEGER,
        img TEXT,
        category TEXT,
        is_best_seller INTEGER,
        is_sync INTEGER DEFAULT 0
      )
''');
  }
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('posapp34.db');
    return _database!;
  }
  //get all data product
  Future<List<Product>> getAllProduct() async {
    final db = await instance.database;
    final result = await db.query(tableProducts);

    return result.map((e) => Product.fromMap(e)).toList();
  }

}
