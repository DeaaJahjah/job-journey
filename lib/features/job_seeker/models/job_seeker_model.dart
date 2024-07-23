// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_seeker_model.g.dart';

@JsonSerializable()
class JobSeekerModel extends Equatable {
  final String id;
  final String name;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  final String email;
  @JsonKey(name: 'profile_picture')
  final String? profilePicture;
  final String password;
  final String location;
  @JsonKey(name: 'resume_url')
  final String resumeUrl;

  const JobSeekerModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.profilePicture,
    required this.password,
    required this.location,
    required this.resumeUrl,
  });

  factory JobSeekerModel.fromJson(Map<String, dynamic> json) => _$JobSeekerModelFromJson(json);
  Map<String, dynamic> toJson() => _$JobSeekerModelToJson(this);

  @override
  List<Object?> get props => [id, name, phoneNumber, email, profilePicture, password, location, resumeUrl];
}
