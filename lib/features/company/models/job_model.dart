// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:job_journey/features/company/models/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_model.g.dart';

@JsonSerializable()
class JobModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String location;
  final Category category;
  @JsonKey(name: 'job_type')
  final String jobType;
  final List<String> requirements;
  final List<String>? benefits;
  @JsonKey(name: 'application_deadline')
  final String? applicationDeadline;
  @JsonKey(name: 'required_documents')
  final List<String> requiredDocuments;
  @JsonKey(name: 'additional_info')
  final String? additionalInfo;
  @JsonKey(name: 'experience_level')
  final String experienceLevel;
  final double salary;
  @JsonKey(name: 'company_id')
  final String companyId;
  @JsonKey(name: 'company_name')
  final String companyName;
  @JsonKey(name: 'company_picture')
  final String? companyPicture;
  const JobModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.location,
      required this.category,
      required this.jobType,
      required this.requirements,
      required this.requiredDocuments,
      required this.experienceLevel,
      required this.salary,
      required this.companyId,
      required this.companyName,
      this.benefits,
      this.companyPicture,
      this.additionalInfo,
      this.applicationDeadline});

  factory JobModel.fromJson(Map<String, dynamic> json) => _$JobModelFromJson(json);
  Map<String, dynamic> toJson() => _$JobModelToJson(this);
  factory JobModel.fromFirestore(DocumentSnapshot documentSnapshot) {
    JobModel job = JobModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    job = job.copyWith(id: documentSnapshot.id);
    return job;
  }

  JobModel copyWith({
    String? id,
    String? title,
    String? description,
    String? location,
    Category? category,
    String? jobType,
    List<String>? requirements,
    List<String>? benefits,
    String? applicationDeadline,
    List<String>? requiredDocuments,
    String? additionalInfo,
    String? experienceLevel,
    double? salary,
    String? companyId,
    String? companyName,
    String? companyPicture,
  }) {
    return JobModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      category: category ?? this.category,
      jobType: jobType ?? this.jobType,
      requirements: requirements ?? this.requirements,
      benefits: benefits ?? this.benefits,
      applicationDeadline: applicationDeadline ?? this.applicationDeadline,
      requiredDocuments: requiredDocuments ?? this.requiredDocuments,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      salary: salary ?? this.salary,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      companyPicture: companyPicture ?? this.companyPicture,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        location,
        category,
        jobType,
        requirements,
        requiredDocuments,
        experienceLevel,
        salary,
        companyId,
        companyName,
        benefits,
        companyPicture,
        additionalInfo,
        applicationDeadline,
      ];
}
