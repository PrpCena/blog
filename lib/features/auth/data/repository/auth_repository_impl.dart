import 'package:clean/core/error/exception.dart';
import 'package:clean/core/error/failures.dart';
import 'package:clean/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:clean/core/common/entities/my_user.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, MyUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signInWithEmailAndPassword(
        password: password,
        email: email,
      ),
    );
  }

  @override
  Future<Either<Failure, MyUser>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailAndPassword(
        name: name,
        password: password,
        email: email,
      ),
    );
  }

  Future<Either<Failure, MyUser>> _getUser(Future<MyUser> Function() fn) async {
    try {
      final user = await fn();
      return right(user);
    } on AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }

  @override
  Future<Either<Failure, MyUser>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure("User not Logged in"));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }
}
