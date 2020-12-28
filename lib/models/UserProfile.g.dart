// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserProfile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return UserProfile(
    json['companyName'] as String,
    json['listOfArea'] as String,
  );
}

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'listOfArea': instance.listOfArea,
    };
