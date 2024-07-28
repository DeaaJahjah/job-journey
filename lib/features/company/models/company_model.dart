// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
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
  factory CompanyModel.fromFirestore(DocumentSnapshot documentSnapshot) {
    CompanyModel company = CompanyModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    company = company.copyWith(id: documentSnapshot.id);
    return company;
  }
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

  CompanyModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? profilePicture,
    String? password,
    String? industry,
    String? location,
    String? contactPhone,
    String? contactEmail,
    String? description,
    DateTime? foundingDate,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      password: password ?? this.password,
      industry: industry ?? this.industry,
      location: location ?? this.location,
      contactPhone: contactPhone ?? this.contactPhone,
      contactEmail: contactEmail ?? this.contactEmail,
      description: description ?? this.description,
      foundingDate: foundingDate ?? this.foundingDate,
    );
  }
}
