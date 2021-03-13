import 'package:ioatest/features/company/domain/models/user.dart';

class UserEntity extends User {
  UserEntity({required id, required investorName})
      : super(id: id, investorName: investorName);

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] as int,
      investorName: json['investor_name'] as String,
    );
  }
}
