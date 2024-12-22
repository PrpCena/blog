import 'package:clean/core/error/failures.dart';
import 'package:clean/core/usecase/usecase.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignOut implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  UserSignOut(this.authRepository);
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.signOut();
  }
}
