// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
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
  final String password;
  final String location;

  final String aboutYou;
  final List<String>? certificates;
  final List<String>? skills;
  @JsonKey(name: 'soft_skills')
  final List<String>? softSkills;
  final List<String>? languages;
  @JsonKey(name: 'topics_subscription')
  final List<String>? topicsSubscription;

  const JobSeekerModel({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.profilePicture,
    required this.password,
    required this.location,
    required this.aboutYou,
    this.certificates,
    this.skills,
    this.softSkills,
    this.languages,
    this.topicsSubscription,
  });

  factory JobSeekerModel.fromJson(Map<String, dynamic> json) => _$JobSeekerModelFromJson(json);
  Map<String, dynamic> toJson() => _$JobSeekerModelToJson(this);

  JobSeekerModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? profilePicture,
    String? password,
    String? location,
    String? aboutYou,
    List<String>? certificates,
    List<String>? skills,
    List<String>? softSkills,
    List<String>? languages,
    List<String>? topicsSubscription,
  }) {
    return JobSeekerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      password: password ?? this.password,
      location: location ?? this.location,
      aboutYou: aboutYou ?? this.aboutYou,
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
        aboutYou,
        languages,
        skills,
        softSkills,
        certificates,
      ];
}
