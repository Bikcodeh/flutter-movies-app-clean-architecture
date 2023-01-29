// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../common/typedef.dart';

//If we want to work with json serializable and also freezed, we need to use
//the 2 lines below
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String username,
    @JsonKey(name: 'avatar', fromJson: avatarPathFromJson) String? avatarPath,
  }) = _User;

  factory User.fromJson(Json json) => _$UserFromJson(json);

  //private constructor
  const User._();

  //If we want to use custom functions, we need to set private constructor
  String getFormattedUserName() {
    return '$username $id';
  }
}

String? avatarPathFromJson(Json json) {
  return json['tmdb']?['avatar_path'] as String?;
}
