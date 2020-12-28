import 'package:json_annotation/json_annotation.dart';
part 'UserProfile.g.dart';

@JsonSerializable(nullable: false)
class UserProfile{

  String companyName;

  String listOfArea;

  UserProfile(this.companyName, this.listOfArea);

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

}