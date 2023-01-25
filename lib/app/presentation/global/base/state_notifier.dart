import 'package:flutter/foundation.dart';

abstract class StateNotifier<T> extends ChangeNotifier {
  StateNotifier(this._state);

  T _state;
  bool _mounted = true;

  bool get mounted => _mounted;
  T get state => _state;

  set state(T newState) => _update(newState);

  void onlyUpdate(T newState) {
    _update(newState, notify: false);
  }

  void _update(T newState, {bool? notify = true}) {
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
