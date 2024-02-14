// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountImpl _$$AccountImplFromJson(Map<String, dynamic> json) =>
    _$AccountImpl(
      id: json['id'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      isVerified: json['isVerified'] as bool,
      isActive: json['isActive'] as bool,
      isSoftDeleted: json['isSoftDeleted'] as bool,
      created: json['created'] as int,
      edited: json['edited'] as int?,
    );

Map<String, dynamic> _$$AccountImplToJson(_$AccountImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'email': instance.email,
      'isVerified': instance.isVerified,
      'isActive': instance.isActive,
      'isSoftDeleted': instance.isSoftDeleted,
      'created': instance.created,
      'edited': instance.edited,
    };
