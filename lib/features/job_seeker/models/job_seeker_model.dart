// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:job_journey/features/company/models/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_seeker_model.g.dart';

@JsonSerializable()
class JobSeekerModel extends Equatable {
  final String? id;
  final String name;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  final String email;
  @JsonKey(name: 'profile_picture')
  final String? profilePicture;
  final String? password;
  final String location;

  final String summary;
  final List<String>? certificates;
  final List<String>? skills;
  @JsonKey(name: 'soft_skills')
  final List<String>? softSkills;
  final List<String>? languages;
  @JsonKey(name: 'topics_subscriptions')
  final List<Category>? topicsSubscription;

  const JobSeekerModel({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.location,
    required this.summary,
    this.certificates,
    this.skills,
    this.softSkills,
    this.languages,
    this.profilePicture,
    this.topicsSubscription,
  });

  Map<String, dynamic> getInfo() {
    return {
      'name': name,
      'phone_number': phoneNumber,
      'email': email,
      'profile_picture': profilePicture,
      'location': location
    };
  }

  factory JobSeekerModel.fromJson(Map<String, dynamic> json) => _$JobSeekerModelFromJson(json);
  Map<String, dynamic> toJson() => _$JobSeekerModelToJson(this);
  factory JobSeekerModel.fromFirestore(DocumentSnapshot documentSnapshot) {
    JobSeekerModel jobSeeker = JobSeekerModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    jobSeeker = jobSeeker.copyWith(id: documentSnapshot.id);
    return jobSeeker;
  }
  JobSeekerModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? profilePicture,
    String? password,
    String? location,
    String? summary,
    List<String>? certificates,
    List<String>? skills,
    List<String>? softSkills,
    List<String>? languages,
    List<Category>? topicsSubscription,
  }) {
    return JobSeekerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      password: password ?? this.password,
      location: location ?? this.location,
      summary: summary ?? this.summary,
      certificates: certificates ?? this.certificates,
      skills: skills ?? this.skills,
      softSkills: softSkills ?? this.softSkills,
      languages: languages ?? this.languages,
      topicsSubscription: topicsSubscription ?? this.topicsSubscription,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        phoneNumber,
        email,
        profilePicture,
        password,
        location,
        summary,
        languages,
        skills,
        softSkills,
        certificates,
      ];
}
