import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mvc_com_mobx/controllers/produto_controller.dart';
import 'package:mvc_com_mobx/models/produto.dart';
import 'package:mvc_com_mobx/repositories/databases/dao/produto_repository_dao.dart';

class ProdutoList extends StatefulWidget {
  @override
  _ProdutoListState createState() => _ProdutoListState();
}

class _ProdutoListState extends State<ProdutoList> {
  ProdutoController _produtoController = ProdutoController();
  List<Produto> filtro = [];

  @override
  void initState() {
    super.initState();
    _produtoController.exibirLista();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
        leading: Container(),
      ),
      body: Container(
        child: Observer(
          builder: (context) {
            final listaProdutos = _produtoController.listaProdutos;

            return listaProdutos.length != 0
                ? ListView.builder(
                    itemCount: listaProdutos.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            onTap: () async {
                              ProdutoRepositoryDao _produtoRepositoryDao =
                                  ProdutoRepositoryDao();
                              var produto = await _produtoRepositoryDao
                                  .find(listaProdutos[index].id);
                              Navigator.pushNamed(context, '/produtos/view',
                                  arguments: [produto, index]);
                            },
                            title: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                listaProdutos[index].nome,
                              ),
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'R\$ ' + listaProdutos[index].preco,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                        'Insira um novo produto para visualizá-lo na lista'),
                  );
          },
        ),
      ),
      floatingActionButton: Container(
        height: 80,
        width: 80,
        child: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/'),
          child: Icon(
            Icons.add,
            color: Colors.black,
            size: 25,
          ),
          backgroundColor: Colors.white,
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: InkWell(
      //     onTap: () => Navigator.defaultRouteName
      //   ),
      // ),
    );
  }
}
