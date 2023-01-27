import 'package:flutter/foundation.dart';

abstract class StateNotifier<T> extends ChangeNotifier {
  StateNotifier(this._state);

  T _state;
  bool _mounted = true;

  bool get mounted => _mounted;
  T get state => _state;

  void update(T newState) => _updateState(newState);

  void onlyUpdate(T newState) {
    _updateState(newState, notify: false);
  }

  void _updateState(T newState, {bool? notify = true}) {
    if (newState != _state) {
      _state = newState;
      if (notify != null && notify) {
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}