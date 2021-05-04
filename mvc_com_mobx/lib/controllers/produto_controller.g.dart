// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProdutoController on _ProdutoController, Store {
  Computed<bool>? _$validaNomeVazioComputed;

  @override
  bool get validaNomeVazio =>
      (_$validaNomeVazioComputed ??= Computed<bool>(() => super.validaNomeVazio,
              name: '_ProdutoController.validaNomeVazio'))
          .value;
  Computed<bool>? _$validaPrecoVazioComputed;

  @override
  bool get validaPrecoVazio => (_$validaPrecoVazioComputed ??= Computed<bool>(
          () => super.validaPrecoVazio,
          name: '_ProdutoController.validaPrecoVazio'))
      .value;
  Computed<bool>? _$formularioValidoComputed;

  @override
  bool get formularioValido => (_$formularioValidoComputed ??= Computed<bool>(
          () => super.formularioValido,
          name: '_ProdutoController.formularioValido'))
      .value;

  final _$nomeAtom = Atom(name: '_ProdutoController.nome');

  @override
  String get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  final _$precoAtom = Atom(name: '_ProdutoController.preco');

  @override
  String get preco {
    _$precoAtom.reportRead();
    return super.preco;
  }

  @override
  set preco(String value) {
    _$precoAtom.reportWrite(value, super.preco, () {
      super.preco = value;
    });
  }

  final _$listaProdutosAtom = Atom(name: '_ProdutoController.listaProdutos');

  @override
  ObservableList<Produto> get listaProdutos {
    _$listaProdutosAtom.reportRead();
    return super.listaProdutos;
  }

  @override
  set listaProdutos(ObservableList<Produto> value) {
    _$listaProdutosAtom.reportWrite(value, super.listaProdutos, () {
      super.listaProdutos = value;
    });
  }

  final _$exibirListaAsyncAction =
      AsyncAction('_ProdutoController.exibirLista');

  @override
  Future exibirLista() {
    return _$exibirListaAsyncAction.run(() => super.exibirLista());
  }

  final _$_ProdutoControllerActionController =
      ActionController(name: '_ProdutoController');

  @override
  void setNome(String value) {
    final _$actionInfo = _$_ProdutoControllerActionController.startAction(
        name: '_ProdutoController.setNome');
    try {
      return super.setNome(value);
    } finally {
      _$_ProdutoControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPreco(String value) {
    final _$actionInfo = _$_ProdutoControllerActionController.startAction(
        name: '_ProdutoController.setPreco');
    try {
      return super.setPreco(value);
    } finally {
      _$_ProdutoControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nome: ${nome},
preco: ${preco},
listaProdutos: ${listaProdutos},
validaNomeVazio: ${validaNomeVazio},
validaPrecoVazio: ${validaPrecoVazio},
formularioValido: ${formularioValido}
    ''';
  }
}
