import 'package:clean/core/error/exception.dart';
import 'package:clean/core/error/failures.dart';
import 'package:clean/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:clean/features/auth/domain/entities/my_user.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, MyUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, MyUser>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signUpWithEmailAndPassword(
        name: name,
        password: password,
        email: email,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }
}
