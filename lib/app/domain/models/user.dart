import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

// To generate class user.g.dart on terminal run:
//flutter pub run build_runner build
part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final int id;
  final String username;

  const User({
    required this.id,
    required this.username,
  });

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  List<Object?> get props => [id, username];
}
