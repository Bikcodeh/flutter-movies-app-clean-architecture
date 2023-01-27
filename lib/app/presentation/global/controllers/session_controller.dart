import '../../../domain/models/user/user.dart';
import '../../../domain/repository/authentication_repository.dart';
import '../base/state_notifier.dart';

class SessionController extends StateNotifier<User?> {
  final AuthenticationRepository authenticationRepository;
  SessionController({required this.authenticationRepository}) : super(null);

  void setUser(User user) {
    update(user);
  }

  void signOut() {
    onlyUpdate(null);
    authenticationRepository.signOut();
  }
}
