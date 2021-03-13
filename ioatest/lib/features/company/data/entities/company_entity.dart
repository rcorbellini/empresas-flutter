import 'package:flutter/foundation.dart';
import 'package:ioatest/features/company/domain/models/company.dart';

class CompanyEntity extends Company {
  CompanyEntity(
      {required id,
      required enterpriseName,
      required description,
      emailEnterprise,
      facebook,
      twitter,
      linkedin,
      phone,
      photo,
      required ownEnterprise,
      required value,
      required shares,
      required sharePrice,
      required ownShare,
      required city,
      required country,
      required enterpriseType})
      : super(
            id: id,
            enterpriseName: enterpriseName,
            description: description,
            emailEnterprise: emailEnterprise,
            facebook: facebook,
            twitter: twitter,
            linkedin: linkedin,
            phone: phone,
            ownEnterprise: ownEnterprise,
            photo: photo,
            value: value,
            shares: shares,
            sharePrice: sharePrice,
            ownShare: ownShare,
            city: city,
            country: country,
            enterpriseType: enterpriseType);

// ignore: slash_for_doc_comments
/** "enterprise": {
        "id": 10,
        "enterprise_name": "Nitechain & Nightset",
        "description": "Nightset is the first decentralised mobile app based nightlife marketplace, combining social networking, discovery, booking and dating features on one platform globally. \n\nIt is being built to disrupt multibillion dollar worth nightlife sector and fulfil our mission to improve the nightlife offering for all (consumers, venues, DJs) to create more efficient, safer and rewarding environments. It is innovative solution for the leisure sector as we have created end-to-end application governed by community that shares information, recommendations in real time from venues and happenings in the moment, interacts with each other and transacts. We are enabling Nightset through blockchain technology “Nitechain” to align all stakeholders’ incentives and reward good actors in Tokens for their contributions via upvoting system that can be later used within nightlife ecosystem on drinks, tables and tickets.\n\nTo date, we have raised £500k from a Bacardi family member and shareholder, won Forbes 30 Under 30 award in Europe Technology, RealBusiness Top 50 young UK most disruptive companies, got accepted into Mayor of London’s incubator programme and won the 3rd place out of entire cohort in the Investors Readiness Competition, partnered with London Bar & Club awards & Night Time Industry Association that took part in creating Night Czar in London. \n\nNightlife matters - it is a multibilion dollar worth industry, with the UK standing alone at £66bn and London at £26bn.  It also saved Berlin from Bankruptcy, and relates to everyone that appreciates their social life, and we are on the mission to improve it globally. ",
        "email_enterprise": null,
        "facebook": null,
        "twitter": null,
        "linkedin": null,
        "phone": null,
        "own_enterprise": false,
        "photo": "/uploads/enterprise/photo/10/240.jpeg",
        "value": 0,
        "shares": 100,
        "share_price": 10000,
        "own_shares": 0,
        "city": "London",
        "country": "UK",
        "enterprise_type": {
            "id": 13,
            "enterprise_type_name": "Social"
        }
    },
 */
  factory CompanyEntity.fromJson(Map<String, dynamic> json) {
    return CompanyEntity(
      id: json['id'] as int,
      enterpriseName: json['enterprise_name'] as String,
      description: json['description'] as String,
      emailEnterprise: json['email_enterprise'] as String?,
      facebook: json['facebook'] as String?,
      twitter: json['twitter'] as String?,
      linkedin: json['linkedin'] as String?,
      phone: json['phone'] as String?,
      ownEnterprise: json['own_enterprise'] as bool,
      photo: json['photo'] as String?,
      value: json['value'] as int,
      shares: json['shares'] as int?,
      sharePrice: json['share_price'] as num,
      ownShare: json['own_shares'] as int?,
      city: json['city'] as String,
      country: json['country'] as String,
      enterpriseType: EnterpriseTypeEntity.fromJson(
          json['enterprise_type'] as Map<String, dynamic>),
    );
  }
}

class EnterpriseTypeEntity extends EnterpriseType {
  EnterpriseTypeEntity({required id, required enterpriseTypeName})
      : super(id: id, enterpriseTypeName: enterpriseTypeName);

  factory EnterpriseTypeEntity.fromJson(Map<String, dynamic> json) {
    return EnterpriseTypeEntity(
        id: json['id'] as int,
        enterpriseTypeName: json['enterprise_type_name'] as String);
  }
}
