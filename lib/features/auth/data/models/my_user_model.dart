import 'package:clean/core/common/entities/my_user.dart';

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

  MyUserModel copyWith({
    String? id,
    String? name,
    String? email,
  }) =>
      MyUserModel(
          id: id ?? this.id,
          name: name ?? this.name,
          email: email ?? this.email);
}
