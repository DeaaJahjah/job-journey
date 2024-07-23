// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) => CompanyModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
      email: json['email'] as String,
      profilePicture: json['profile_picture'] as String?,
      password: json['password'] as String,
      industry: json['industry'] as String,
      location: json['location'] as String,
      contactPhone: json['contact_phone'] as String?,
      contactEmail: json['contact_email'] as String?,
      description: json['description'] as String,
      foundingDate: DateTime.parse(json['founding_date'] as String),
    );

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'profile_picture': instance.profilePicture,
      'password': instance.password,
      'industry': instance.industry,
      'location': instance.location,
      'contact_phone': instance.contactPhone,
      'contact_email': instance.contactEmail,
      'description': instance.description,
      'founding_date': instance.foundingDate.toIso8601String(),
    };
