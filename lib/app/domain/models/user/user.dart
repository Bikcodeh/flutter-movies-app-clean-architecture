import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

// To generate class user.g.dart on terminal run:
//flutter pub run build_runner build
part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final int id;
  final String username;
  @JsonKey(name: 'avatar', fromJson: avatarPathFromJson)
  final String? avatarPath;

  const User({
    required this.id,
    required this.username,
    this.avatarPath,
  });

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  List<Object?> get props => [id, username];
}

String? avatarPathFromJson(Map<String, dynamic> json) {
  return json['tmdb']?['avatar_path'] as String?;
}
