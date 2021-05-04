import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dao/produto_repository_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'banco.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ProdutoRepositoryDao.tableSql);
    },
    version: 1,
  );
}