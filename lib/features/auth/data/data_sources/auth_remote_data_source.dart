import 'package:clean/core/error/exception.dart';
import 'package:clean/features/auth/data/models/my_user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<MyUserModel> signUpWithEmailAndPassword({
    required String name,
    required String password,
    required String email,
  });
  Future<MyUserModel> signInWithEmailAndPassword({
    required String password,
    required String email,
  });
  Future<MyUserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<MyUserModel> signInWithEmailAndPassword({
    required String password,
    required String email,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );

      if (response.user == null) {
        throw ServerException('User is Null');
      }

      return MyUserModel.fromJson(response.user!.toJson()).copyWith(email: currentUserSession!.user.email);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<MyUserModel> signUpWithEmailAndPassword({
    required String name,
    required String password,
    required String email,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );

      if (response.user == null) {
        throw ServerException('User is Null');
      }

      return MyUserModel.fromJson(response.user!.toJson()).copyWith(email: currentUserSession!.user.email);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override

  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<MyUserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);
        return MyUserModel.fromJson(userData.first)
            .copyWith(email: currentUserSession!.user.email);
      }
      return null;
    } catch (e) {
      throw (ServerException(e.toString()));
    }
  }
}
