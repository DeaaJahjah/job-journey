// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      phoneNumber: json['phone'] as String,
      email: json['email'] as String,
      bio: json['bio'] as String?,
      imgUrl: json['avatar'] as String?,
      fcmUserId: json['fcm_user_id'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'bio': instance.bio,
      'phone': instance.phoneNumber,
      'avatar': instance.imgUrl,
      'fcm_user_id': instance.fcmUserId,
      'imageUrl': instance.imageUrl,
    };
