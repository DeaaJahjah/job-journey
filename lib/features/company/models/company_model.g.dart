// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) => CompanyModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      industry: Category.fromJson(json['industry']),
      location: json['location'] as String,
      description: json['description'] as String,
      foundingDate: json['founding_date'] as String,
      profilePicture: json['profile_picture'] as String?,
    );

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'profile_picture': instance.profilePicture,
      'password': instance.password,
      'industry': instance.industry.toJson(),
      'location': instance.location,
      'description': instance.description,
      'founding_date': instance.foundingDate,
    };
