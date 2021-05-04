class Produto {
  var id;
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

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['nome'] = this.nome;
  //   data['preco'] = this.preco;

  //   return data;
  // }
}
