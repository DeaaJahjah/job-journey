// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_seeker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobSeekerModel _$JobSeekerModelFromJson(Map<String, dynamic> json) =>
    JobSeekerModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
      email: json['email'] as String,
      profilePicture: json['profile_picture'] as String?,
      password: json['password'] as String,
      location: json['location'] as String,
      resumeUrl: json['resume_url'] as String,
    );

Map<String, dynamic> _$JobSeekerModelToJson(JobSeekerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'profile_picture': instance.profilePicture,
      'password': instance.password,
      'location': instance.location,
      'resume_url': instance.resumeUrl,
    };
