// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_model.g.dart';

@JsonSerializable()
class CompanyModel extends Equatable {
  final String id;
  final String name;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  final String email;
  @JsonKey(name: 'profile_picture')
  final String? profilePicture;
  final String password;
  final String industry;
  final String location;
  @JsonKey(name: 'contact_phone')
  final String? contactPhone;
  @JsonKey(name: 'contact_email')
  final String? contactEmail;
  final String description;
  @JsonKey(name: 'founding_date')
  final DateTime foundingDate;

  const CompanyModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.industry,
    required this.location,
    required this.description,
    required this.foundingDate,
    this.profilePicture,
    this.contactPhone,
    this.contactEmail,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) => _$CompanyModelFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        phoneNumber,
        email,
        password,
        industry,
        location,
        description,
        foundingDate,
        profilePicture,
        contactPhone,
        contactEmail
      ];
}
