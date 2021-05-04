import 'package:mobx/mobx.dart';
import 'package:mvc_com_mobx/models/produto.dart';
import 'package:mvc_com_mobx/repositories/databases/dao/produto_repository_dao.dart';
part 'produto_controller.g.dart';

class ProdutoController = _ProdutoController with _$ProdutoController;

abstract class _ProdutoController with Store {
  ProdutoRepositoryDao _produtoRepositoryDao = ProdutoRepositoryDao();

  _ProdutoController() {
    _produtoRepositoryDao = ProdutoRepositoryDao();
  }

  @observable
  String nome = '';

  @observable
  String preco = '';

  @observable
  ObservableList<Produto> listaProdutos = ObservableList<Produto>();

  @action
  void setNome(String value) => nome = value;

  @action
  void setPreco(String value) => preco = value;

  @action
  exibirLista() async {
    listaProdutos = ObservableList<Produto>.of(await _produtoRepositoryDao.findAll());
  }

  // @action
  // preencherCampos() async {
  //   listaProdutos = ObservableList<Produto>.of(await _produtoRepositoryDao.find(id));
  // }

  @computed
  bool get validaNomeVazio => nome.length > 0;

  @computed
  bool get validaPrecoVazio => preco.length > 0;

  @computed
  bool get formularioValido => nome.length > 0 && preco.length > 0;

}