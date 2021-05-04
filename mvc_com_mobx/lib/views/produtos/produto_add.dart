import 'package:flutter/material.dart';
import 'package:mvc_com_mobx/controllers/produto_controller.dart';
import 'package:mvc_com_mobx/models/produto.dart';
import 'package:mvc_com_mobx/shared/constantes.dart';

class ProdutoAdd extends StatefulWidget {
  @override
  _ProdutoAddState createState() => _ProdutoAddState();
}

class _ProdutoAddState extends State<ProdutoAdd> {
  ProdutoController produtoController = ProdutoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Produto'),
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
                TextField(
                  onChanged: produtoController.setNome,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Nome',
                  ),
                ),
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
                          produto?.nome = produtoController.nome;
                          produto?.preco = produtoController.preco;
                          await produtoRepositoryDao.save(produto ?? Produto(null, '', ''));

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
