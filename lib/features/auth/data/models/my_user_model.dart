import 'package:clean/features/auth/domain/entities/my_user.dart';

class MyUserModel extends MyUser {
  MyUserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory MyUserModel.fromJson(Map<String, dynamic> map) {
    return MyUserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
