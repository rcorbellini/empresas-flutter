import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/*{
    "enterprise": {
        "id": 1,
        "enterprise_name": "Fluoretiq Limited",
        "description": "FluoretiQ is a Bristol based medtech start-up developing diagnostic technology to enable bacteria identification within the average consultation window, so that patients can get the right anti-biotics from the start.  ",
        "email_enterprise": null,
        "facebook": null,
        "twitter": null,
        "linkedin": null,
        "phone": null,
        "own_enterprise": false,
        "photo": "/uploads/enterprise/photo/1/240.jpeg",
        "value": 0,
        "shares": 100,
        "share_price": 10000,
        "own_shares": 0,
        "city": "Bristol",
        "country": "UK",
        "enterprise_type": {
            "id": 3,
            "enterprise_type_name": "Health"
        }
    },
    "success": true
}*/

@immutable
class Company extends Equatable {
  final int id;
  final String enterpriseName;
  final String description;
  final String? emailEnterprise;
  final String? facebook;
  final String? twitter;
  final String? linkedin;
  final String? phone;
  final bool ownEnterprise = false;
  final String? photo;
  final int value;
  final int shares;
  final num sharePrice;
  final int ownShare;
  final String city;
  final String country;
  final EnterpriseType enterpriseType;

  Company({required this.id,required  this.enterpriseName,required  this.description, this.emailEnterprise, this.facebook, this.twitter, this.linkedin, this.phone, this.photo, required  this.value,required  this.shares, required this.sharePrice, required this.ownShare, required this.city, required this.country, required this.enterpriseType});

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

class EnterpriseType extends Equatable{
  final int id;
  final String enterpriseTypeName;

  EnterpriseType({required this.id, required this.enterpriseTypeName});

  @override
  List<Object?> get props => [id, enterpriseTypeName];
}