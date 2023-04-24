import 'package:dartz/dartz.dart';
import 'package:bubble/domain/app_failure/app_failure.dart';

typedef FutureEither<T> = Future<Either<AppFailure, T>>;
typedef EitherFailure<T> = Either<AppFailure, T>;
