import 'package:clean/core/error/failures.dart';
import 'package:clean/core/common/entities/my_user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, MyUser>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, MyUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, MyUser>> currentUser();
}
