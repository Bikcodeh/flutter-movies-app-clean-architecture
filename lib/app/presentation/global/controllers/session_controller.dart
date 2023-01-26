import '../../../domain/models/user.dart';
import '../base/state_notifier.dart';

class SessionController extends StateNotifier<User?> {
  SessionController() : super(null);

  void setUser(User user) {
    update(user);
  }

  void signOut() {
    onlyUpdate(null);
  }
}
