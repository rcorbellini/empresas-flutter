import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class User extends Equatable {
  final int id;
  final String investorName;

  User({
    required this.id,
    required this.investorName,
  });

  @override
  List<Object> get props => [id, investorName];
}
