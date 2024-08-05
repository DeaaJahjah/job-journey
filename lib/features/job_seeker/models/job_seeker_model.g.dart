// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_seeker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobSeekerModel _$JobSeekerModelFromJson(Map<String, dynamic> json) =>
    JobSeekerModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
      email: json['email'] as String,
      profilePicture: json['profile_picture'] as String?,
      password: json['password'] as String?,
      location: json['location'] as String,
      summary: json['summary'] as String,
      certificates: (json['certificates'] as List<dynamic>?)?.map((e) => e as String).toList(),
      skills: (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
      softSkills: (json['soft_skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
      languages: (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList(),
      topicsSubscription: (json['topics_subscription'] as List<dynamic>?)?.map((e) => e as String).toList(),
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
      'summary': instance.summary,
      'certificates': instance.certificates,
      'skills': instance.skills,
      'soft_skills': instance.softSkills,
      'languages': instance.languages,
      'topics_subscription': instance.topicsSubscription,
    };
