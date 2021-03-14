import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

///The user entity
@immutable
class User extends Equatable {
  ///The user os system.
  User({
    required this.id,
    required this.investorName,
  });

  final int id;
  final String investorName;

  @override
  List<Object> get props => [id, investorName];
}
