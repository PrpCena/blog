import 'package:clean/core/error/exception.dart';
import 'package:clean/features/auth/data/models/my_user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<MyUserModel> signUpWithEmailAndPassword({
    required String name,
    required String password,
    required String email,
  });
  Future<MyUserModel> signInWithEmailAndPassword({
    required String password,
    required String email,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<MyUserModel> signInWithEmailAndPassword({
    required String password,
    required String email,
  }) {
    // TODO: implement logInWithEmailAndPassword
    throw UnimplementedError();
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

      return MyUserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
