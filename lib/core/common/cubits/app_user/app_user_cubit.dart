import 'package:bloc/bloc.dart';
import 'package:clean/core/common/entities/my_user.dart';
import 'package:meta/meta.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(MyUser? user){ 
    if(user == null){ 
      emit(AppUserInitial());
    }else{ 
      emit(AppUserLoggedIn(user)); 
    }
  }
}
