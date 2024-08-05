// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';
// part 'application_model.g.dart';

// @JsonSerializable()
// class ApplicationModel extends Equatable {
//   final String id;
//   final String name;
//   @JsonKey(name: "profile_picture")
//   final String profilePicture;
//   final String address;
//   @JsonKey(name: "phone_number")
//   final String phoneNumber;
//   final String email;
//   final String about;
//   const ApplicationModel({
//     required this.id,
//     required this.name,
//     required this.profilePicture,
//     required this.address,
//     required this.phoneNumber,
//     required this.email,
//     required this.about,
//   });
//   factory ApplicationModel.fromJson(Map<String, dynamic> json) => _$ApplicationModelFromJson(json);
//   Map<String, dynamic> toJson() => _$ApplicationModelToJson(this);
//   factory ApplicationModel.fromFirestore(DocumentSnapshot documentSnapshot) {
//     ApplicationModel application = ApplicationModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
//     application = application.copyWith(id: documentSnapshot.id);
//     return application;
//   }
//   @override
//   List<Object?> get props => [
//         id,
//         name,
//         address,
//         phoneNumber,
//         email,
//         profilePicture,
//         about,
//       ];

//   ApplicationModel copyWith({
//     String? id,
//     String? name,
//     String? address,
//     String? phoneNumber,
//     String? email,
//     String? about,
//     String? profilePicture,
//   }) {
//     return ApplicationModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       address: address ?? this.address,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       email: email ?? this.email,
//       about: about ?? this.about,
//       profilePicture: profilePicture ?? this.profilePicture,
//     );
//   }
// }
