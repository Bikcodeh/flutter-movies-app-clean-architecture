import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/media/media.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState.loading(bool isLoading) = HomeStateLoading;
  factory HomeState.error() = HomeStateError;
  factory HomeState.success(List<Media> data) = HomeStateSuccess;
  factory HomeState.idle() = HomeStateIdle;
}
