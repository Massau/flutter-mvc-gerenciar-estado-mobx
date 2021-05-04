import 'package:flutter/material.dart';
import 'package:mvc_com_mobx/views/produtos/produto_add.dart';
import 'package:mvc_com_mobx/views/produtos/produto_list.dart';
import 'package:mvc_com_mobx/views/produtos/produto_view.dart';

void main() {
  runApp(Inicio());
}

class Inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => ProdutoAdd(),
        '/produtos/list': (context) => ProdutoList(),
        '/produtos/view': (context) => ProdutoView(ModalRoute.of(context)!.settings.arguments, ModalRoute.of(context)!.settings.arguments),
      },
      initialRoute: '/',
    );
  }
}