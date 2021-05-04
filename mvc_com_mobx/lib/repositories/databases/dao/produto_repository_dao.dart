import 'package:mvc_com_mobx/interface/produto_repository_interface.dart';
import 'package:mvc_com_mobx/models/produto.dart';
import 'package:sqflite/sqflite.dart';
import '../app_database.dart';

class ProdutoRepositoryDao implements IProdutoRepository {
  static final String tableSql = 'CREATE TABLE produto('
  'id TEXT,'
  'nome TEXT,'
  'preco TEXT)';

  static const String _tableName = 'produto';
  static const String _id = 'id';
  static const String _nome = 'nome';
  static const String _preco = 'preco';

  @override
  Map<String, dynamic> toMap(Produto produto) {
    final Map<String, dynamic> produtoMap = Map();
    produtoMap[_id] = produto.id;
    produtoMap[_nome] = produto.nome;
    produtoMap[_preco] = produto.preco;

    return produtoMap;
  }

  @override
  List<Produto> toList(List<dynamic> produtoDBs) {
    final List<Produto> produtos = [];
    for (Map<String, dynamic> produtoDB in produtoDBs) {
      print(produtoDB);
      print(produtoDB);
      final Produto produto = Produto(
        produtoDB[_id],
        produtoDB[_nome],
        produtoDB[_preco],
      );
      produtos.add(produto);
    }
    return produtos;
  }

  @override
  Future<dynamic> save(Produto produto) async {
    final Database db = await getDatabase();

    Map<String, dynamic> produtoMap = toMap(produto);

    var produtoSalvo = await db.insert(_tableName, produtoMap, conflictAlgorithm: ConflictAlgorithm.ignore);

    return produtoSalvo;
  }

  @override
  Future<List<Produto>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> produtoDBs = await db.rawQuery('SELECT * FROM $_tableName');
    List<Produto> produtos = toList(produtoDBs);

    return produtos;
  }

  @override
  Future<List<Produto>> find(id) async {
    final Database db = await getDatabase();
    var consultaProduto = [];
    consultaProduto = await db.rawQuery('SELECT * FROM $_tableName WHERE id = ?', [id]);
    List<Produto> produtos = toList(consultaProduto);

    return produtos;
  }
}