import 'package:clean/core/error/failures.dart';
import 'package:clean/core/usecase/usecase.dart';
import 'package:clean/core/common/entities/my_user.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';


class CurrentUser implements UseCase<MyUser, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, MyUser>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
