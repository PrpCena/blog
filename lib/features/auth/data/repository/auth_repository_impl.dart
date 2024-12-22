import 'package:clean/core/common/constants/constant.dart';
import 'package:clean/core/error/exception.dart';
import 'package:clean/core/error/failures.dart';
import 'package:clean/core/network/connection_checker.dart';
import 'package:clean/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:clean/core/common/entities/my_user.dart';
import 'package:clean/features/auth/data/models/my_user_model.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);

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
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(Constant.noInternetConnnectionMessage));
      }

      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }

  @override
  Future<Either<Failure, MyUser>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentUserSession;

        if (session == null) {
          return left(Failure('User not Logged in'));
        }

        return right(MyUserModel(
          id: session.user.id,
          name: '',
          email: session.user.email!,
        ));
      }

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
