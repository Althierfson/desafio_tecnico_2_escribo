abstract class Failure {
  String get message;

  @override
  String toString() => message;
}

class UnexpectedFailure extends Failure {
  @override
  String get message => "Erro inesperado!";
}

class NoInternetFailure extends Failure {
  @override
  String get message => "Sem Internet.";
}

class AccessServerFailure extends Failure{
  @override
  String get message => "Não foi possivel acessar o Servidor.";

}