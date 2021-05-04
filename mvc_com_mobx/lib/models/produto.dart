class Produto {
  int? id;
  String nome;
  String preco;

  Produto(
    this.id,
    this.nome,
    this.preco,
  );

  @override
  String toString() {
    return 'Produto{id: $id, nome: $nome, preco: $preco}';
  }

  Produto.fromJson(Map<String,dynamic> json) :
    id = json['id'],
    nome = json['nome'],
    preco = json['preco'];

}
