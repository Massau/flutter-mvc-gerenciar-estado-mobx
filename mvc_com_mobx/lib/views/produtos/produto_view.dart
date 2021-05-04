import 'package:flutter/material.dart';
import 'package:mvc_com_mobx/controllers/produto_controller.dart';
import 'package:mvc_com_mobx/models/produto.dart';
import 'package:mvc_com_mobx/repositories/databases/dao/produto_repository_dao.dart';
import 'package:mvc_com_mobx/shared/constantes.dart';

class ProdutoView extends StatefulWidget {

  // ProdutoView(this.index);
  final produtoClicado;
  final index;

  ProdutoView(
    this.produtoClicado,
    this.index,
  );
  @override
  _ProdutoViewState createState() => _ProdutoViewState();
}

class _ProdutoViewState extends State<ProdutoView> {
  ProdutoController produtoController = ProdutoController();
  // final TextEditingController nomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {

  print(widget.index);
  print(widget.produtoClicado);
  print(widget.produtoClicado[widget.index][widget.index].nome);
    // nomeController.value = nomeController.value.copyWith(text: widget.index);
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizar Produto'),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          tooltip: 'Voltar',
          onPressed: () => Navigator.defaultRouteName,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constaints) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Text(widget.produto),
                // TextField(
                //   onChanged: produtoController.setNome,
                //   controller: nomeController,
                //   decoration: InputDecoration(
                //     labelText: 'Nome',
                //     hintText: 'Nome',
                //   ),
                // ),
                TextField(
                  onChanged: produtoController.setPreco,
                  decoration: InputDecoration(
                    labelText: 'Preço',
                    hintText: 'Preço',
                  ),
                ),
                ElevatedButton(
                  child: Text('Gravar'),
                  onPressed: produtoController.formularioValido
                      ? () async {
                          ProdutoRepositoryDao _produtoRepositoryDao =
                              ProdutoRepositoryDao();
                          // var produto = Produto(produtoController.nome, produtoController.preco);
                          // produto?.nome = produtoController.nome;
                          // produto?.preco = produtoController.preco;
                          produto?.nome = produtoController.nome;
                          produto?.preco = produtoController.preco;
                          await _produtoRepositoryDao.save(produto ?? Produto('', '', ''));

                          Navigator.pushNamed(context, '/produtos/list');
                        }
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: ElevatedButton(
      //   child: Text('Gravar'),
      //   onPressed: produtoController.formularioValido
      //       ? () async {
      //           ProdutoRepositoryDao _produtoRepositoryDao =
      //               ProdutoRepositoryDao();
      //           var produto =
      //               Produto(produtoController.nome, produtoController.preco);
      //           await _produtoRepositoryDao.save(produto);

      //           Navigator.pushNamed(context, '/produtos/list');
      //         }
      //       : null,
      // ),
    );
  }
}
