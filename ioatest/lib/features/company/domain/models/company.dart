import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

///The company entity
@immutable
class Company extends Equatable {
  ///The construcotr of company
  Company(
      {required this.id,
      required this.enterpriseName,
      required this.description,
      this.emailEnterprise,
      this.facebook,
      this.twitter,
      this.linkedin,
      this.phone,
      this.photo,
      required this.ownEnterprise,
      required this.value,
      required this.shares,
      required this.sharePrice,
      required this.ownShare,
      required this.city,
      required this.country,
      required this.enterpriseType});

  final int id;
  final String enterpriseName;
  final String description;
  final String? emailEnterprise;
  final String? facebook;
  final String? twitter;
  final String? linkedin;
  final String? phone;
  final bool ownEnterprise;
  final String? photo;
  final int? value;
  final int? shares;
  final num sharePrice;
  final int? ownShare;
  final String city;
  final String country;
  final EnterpriseType enterpriseType;

  @override
  List<Object?> get props => [
        id,
        enterpriseName,
        description,
        emailEnterprise,
        facebook,
        twitter,
        linkedin,
        phone,
        ownEnterprise,
        photo,
        value,
        shares,
        sharePrice,
        ownShare,
        city,
        country,
        enterpriseType,
      ];
}

///The entity of type
class EnterpriseType extends Equatable {
  ///The constructor of type company
  EnterpriseType({required this.id, required this.enterpriseTypeName});

  /// the id of type
  final int id;

  /// the name of type
  final String enterpriseTypeName;

  @override
  List<Object?> get props => [id, enterpriseTypeName];
}
