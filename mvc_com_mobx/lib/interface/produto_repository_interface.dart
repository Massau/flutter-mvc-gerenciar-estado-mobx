import 'package:mvc_com_mobx/models/produto.dart';

abstract class IProdutoRepository {
  Map<String, dynamic> toMap(Produto produto);
  List<Produto> toList(List<dynamic> produtoDBs);
  Future<dynamic> save(Produto produto);
  Future<List<Produto>> findAll();
  Future<List<Produto>> find(id);
}