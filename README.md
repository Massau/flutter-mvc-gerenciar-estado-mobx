# flutter-mvc-gerenciar-estado-mobx
Aplicação com finalidade de implementar gerenciamento de estados em um projeto MVC usando Mobx


### Primeiros passos: Importação no Pubspec.yaml

Necessário importar nas **dependencies**
- mobx
- flutter_mobx

Bem como importar nas **dev_dependencies**
- build_runner
- mobx_codegen


### Criando estrutura MVC

Dentro do diretório lib, criar os seguintes diretórios:
- controllers
- interface
- models
- repositories
- shared
- views


#### controllers
#### interface

Interfaces são benéficas em questão de injeção de dependência, pois não é mais necessário dar import em vários arquivos, apenas implementar a interface, possibilitando criar uma interface com vários métodos que você quer que tenha em determinadas classes e essas classe serão obrigadas a implementar esses métodos.


#### models
#### repositories

Aqui será armazenado código referente a dados. Quando vamos persistir informações no DAO ou consumir uma API, será feito aqui.
Também serão implementados métodos com o mesmo nome de métodos definidos lá na [interface](https://github.com/JoyceMassau/flutter-gestao-estado-mobx-mvc#interface) e, como as classes criadas nos arquivos dentro deste diretório implementam a interface, eles também substituem o método herdado da interface.


#### shared

Aqui haverão arquivos que poderão ser compartilhados no App todo.


#### views


#### pubspec.yaml

Incluir **build_runner** e **mobx_codegen** no *dev_dependencies* e, como iremos persistir dados no DAO, utilizaremos também os packages **"sqflite"** e **"path"** e o **"equatable"** para comparar objetos de forma mais facilitada. Mais sobre este package [aqui](https://pub.dev/packages/equatable)

```dart
dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.0.1
  mobx_codegen: ^2.0.1+3
  sqflite:
  path:
```

Incluir **mobx** e **flutter_mobx** no *dependencies*

```dart
dependencies:
  flutter:
    sdk: flutter
  mobx: ^2.0.1
  flutter_mobx: ^2.0.0
```

### Passos a passo

- Após criar a estrutura de diretórios mencionada acima, criar dentro do diretório **"models"** o arquivo referente à entidade que queremos criar. O arquivo deste exempo irá chamar **"produto.dart"**

```dart
class Produto {
  int id;
  String nome;
  String descricao;
  String imagem;
  String preco;
  String created;
  String modified;
  String deleted;

  Produto(
    this.id,
    this.nome,
    this.descricao,
    this.imagem,
    this.preco,
    this.created,
    this.modified,
    this.deleted,
  );

  @override
  String toString() {
    return 'Produto{id: $id, nome: $nome, descricao: $descricao, imagem: $imagem, preco: $preco, created: $created, modified: $modified, deleted: $deleted}';
  }

  List<Object> get props => [id, nome, descricao, imagem, preco, created, modified, deleted];

  Produto.fromJson(Map<String,dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    imagem = json['imagem'];
    preco = json['preco'];
    created = json['created'];
    modified = json['modified'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['imagem'] = this.imagem;
    data['preco'] = this.preco;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['deleted'] = this.deleted;

    return data;
  }
}
```

- Dentro do diretório **"interfaces"** criaremos um arquivo chamado produto_repository_interface.dart. Criaremos essa interface com os métodos que desejamos que as classes contenham, de modo que a classe será obrigada a implementar esses métodos. Posteriormente o arquivo que criarmos dentro do diretório "repository" implementará essa interface

```dart
import 'package:loja_mvc_mobx/models/produto.dart';

abstract class IProdutoRepository {
    Map<String, dynamic> toMap(Produto produto);
    Future save(Produto produto);
}
```

- Dentro do diretório **"repositories"** iremos criar um outro diretório, chamado **"databases"** e dentro dele um outro diretório, chamado **"dao"** onde criaremos o arquivo **"produto_dao",** ficando assim o caminho: lib / repositories / databases / dao /produto_dao.dart

```dart
import 'package:loja_mvc_mobx/interface/produto_repository_interface.dart';
import 'package:loja_mvc_mobx/models/produto.dart';
import 'package:loja_mvc_mobx/repositories/databases/app_database.dart';
import 'package:sqflite/sqflite.dart';

class ProdutoRepositoryDao implements IProdutoRepository {
  static final String tableSql = 'CREATE TABLE produto('
  'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
  'nome TEXT,'
  'descricao TEXT,'
  'imagem TEXT,'
  'preco TEXT,'
  'created TEXT,'
  'modified TEXT,'
  'deleted TEXT)';

  static const String _tableName = 'produto';
  static const String _id = 'id';
  static const String _nome = 'nome';
  static const String _descricao = 'descricao';
  static const String _imagem = 'imagem';
  static const String _preco = 'preco';
  static const String _created = 'created';
  static const String _modified = 'modified';
  static const String _deleted = 'deleted';

  @override
  Map<String, dynamic> toMap(Produto produto) {
    final Map<String, dynamic> produtoMap = Map();

    produtoMap[_id] = produto.id;
    produtoMap[_nome] = produto.nome;
    produtoMap[_descricao] = produto.descricao;
    produtoMap[_imagem] = produto.imagem;
    produtoMap[_preco] = produto.preco;
    produtoMap[_created] = produto.created;
    produtoMap[_modified] = produto.modified;
    produtoMap[_deleted] = produto.deleted;

    return produtoMap;
  }

  @override
  Future save(Produto produto) async {
    final Database db = await getDatabase();
    Map<String, dynamic> produtoMap = toMap(produto);

    return db.insert(_tableName, produtoMap, conflictAlgorithm: ConflictAlgorithm.ignore);
  }
}
```

- Dentro do diretório **"repositories"** criar um arquivo chamado **"app_database.dart".** O Dao que ele fará referência na instrução SQL é o criado anteriormente

```dart
import 'package:loja_mvc_mobx/repositories/databases/dao/produto_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'banco.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ProdutoDao.tableSql);
    },
    version: 1,
  );
}
```

- Criar, dentro de lib / controllers, o arquivo de controller que posteriormente utilizaremos. Conforme exemplo utilizado, ele chamará **"produto_controller.dart"**

- O arquivo produto_controller.dart conterá uma classe abstrata que vai utilizar um mixin chamado [Store](https://github.com/JoyceMassau/flutter-gestao-estado-mobx-mvc#Store), para isso utilizaremos a palavra reservada **"with"** e faremos referência ao mixin Store. Dessa forma posteriormente poderemos utilizar dentro da classe os @observable e os @action

```dart
import 'package:mobx/mobx.dart';

abstract class _ProdutoController with Store {

}
```

- Criaremos dentro do **"produto_controller.dart"** uma classe não abstrata que receberá a classe abstrata do já criada anteriormente bem como uma variável _$ProdutoController, que virá do arquivo que o package **"mobx_codegen"** criará para nós. Faremos também referência ao arquivo **'produto_controller.g.dart'** que não existe ainda, será criado pelo mobx_codegen

```dart
import 'package:mobx/mobx.dart';
part 'produto_controller.g.dart';

class ProdutoController = _ProdutoController with _$ProdutoController;

abstract class _ProdutoController with Store {

}
```

- Criaremos uma instância de ProdutoRepositoryDao e essa instância será passada no construtor da classe

```dart
import 'package:loja_mvc_mobx/repositories/databases/dao/produto_dao.dart';
import 'package:mobx/mobx.dart';
part 'produto_controller.g.dart';

class ProdutoController = _ProdutoController with _$ProdutoController;

abstract class _ProdutoController with Store {
  ProdutoRepositoryDao _produtoRepositoryDao;

  _ProdutoController() {
    _produtoRepositoryDao = ProdutoRepositoryDao();
  }
}
```

- Criaremos os observadores e as ações que eles estão observando, assim como computaremos as validações

```dart
import 'package:loja_mvc_mobx/repositories/databases/dao/produto_dao.dart';
import 'package:mobx/mobx.dart';
part 'produto_controller.g.dart';

class ProdutoController = _ProdutoController with _$ProdutoController;

abstract class _ProdutoController with Store {
  ProdutoRepositoryDao _produtoRepositoryDao;

  _ProdutoController() {
    _produtoRepositoryDao = ProdutoRepositoryDao();
  }

  @observable
  String nome = '';

  @observable
  String preco = '';

  @action
  void setNome(String value) => nome = value;

  @action
  void setPreco(String value) => preco = value;

  @computed
  bool get validaNomePreco => nome.length > 0 && preco.length > 0;

}
```

- Para executar as features das dependências que colocamos no pubspec.yaml, no terminal, no diretório que contém o arquivo pubspec.yaml: *flutter packages pub run build_runner clean* (sempre dar esse comando primeiro, com exceção da primeira vez, pois não terá nada para limpar) e *flutter packages pub run build_runner build*

- No arquivo produto_list.dart, criar uma classe StatefulWidget para receber as mudanças no arquivo que terá conteúdos sendo observados, envolver todos os widgets em um *Scaffold* e dentro dele criar um widget de *Observer* que terá o parâmetro builder como obrigatório

```dart
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProdutoList extends StatefulWidget {
  @override
  _ProdutoListState createState() => _ProdutoListState();
}

class _ProdutoListState extends State<ProdutoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Produtos'),
      ),
      body: Container(
        child: Observer(
          builder: (context) { }
        )
      ),
    );
  }
}
```

- No arquivo main, fazer referência ao arquivo que deseja que seja o primeiro a ser chamado quando o aplicativo é aberto. Neste exemplo estamos usando rotas nomeadas para realizar a navegação entre as páginas

```dart
import 'package:flutter/material.dart';
import 'package:loja_mvc_mobx/views/produtos/produto_list.dart';

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
        '/': (context) => ProdutoList(),
      },
      initialRoute: '/',
    );
  }
}
```

- Criar dentro do diretório **"views"** diretório referente à entidade que queremos criar telas. Neste exemplo criaremos a entidade Produto e em virtude disso, o diretório criado será o **"produtos"** e, dentro desse diretório, criaremos os arquivos referentes à view

![](https://github.com/JoyceMassau/flutter-gestao-estado-mobx-mvc/estrutura_projeto_mvc.jpg) 


### Referências


#### Store

#### Computed

[Valores @computed](https://www.youtube.com/watch?v=UjNKgwTFu74&list=PLR5GUTqrcwXim6ZCDvRpsak8CB8_mreCE&index=4)