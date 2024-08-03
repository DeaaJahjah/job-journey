// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobModel _$JobModelFromJson(Map<String, dynamic> json) => JobModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      jobType: json['job_type'] as String,
      requirements: (json['requirements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      requiredDocuments: (json['required_documents'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      experienceLevel: json['experience_level'] as String,
      salary: (json['salary'] as num).toDouble(),
      companyId: json['company_id'] as String,
      companyName: json['company_name'] as String,
      benefits: (json['benefits'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      companyPicture: json['company_picture'] as String?,
      additionalInfo: json['additional_info'] as String?,
      applicationDeadline: json['application_deadline'] as String?,
    );

Map<String, dynamic> _$JobModelToJson(JobModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'category': instance.category,
      'job_type': instance.jobType,
      'requirements': instance.requirements,
      'benefits': instance.benefits,
      'application_deadline': instance.applicationDeadline,
      'required_documents': instance.requiredDocuments,
      'additional_info': instance.additionalInfo,
      'experience_level': instance.experienceLevel,
      'salary': instance.salary,
      'company_id': instance.companyId,
      'company_name': instance.companyName,
      'company_picture': instance.companyPicture,
    };
