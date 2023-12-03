import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2_escribo/core/failure/failures.dart';

abstract class UseCase<R, P> {
  Future<Either<Failure, R>> call(P paramenter);
}

class NoParamenter {}