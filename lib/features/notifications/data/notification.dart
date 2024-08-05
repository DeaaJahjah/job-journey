// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'notification.g.dart';

@JsonSerializable()
class NotificationModel extends Equatable {
  final String id;
  final String title;
  final String body;
  final String imageUrl;
  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.imageUrl,
  });
  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
  factory NotificationModel.fromFirestore(DocumentSnapshot documentSnapshot) {
    NotificationModel notification = NotificationModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    notification = notification.copyWith(id: documentSnapshot.id);
    return notification;
  }
  @override
  List<Object?> get props => [
        id,
        title,
        body,
        imageUrl,
      ];

  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    String? imageUrl,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
