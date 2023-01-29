import '../common/either/either.dart';
import '../common/failure/sign_in_failure.dart';
import '../models/user/user.dart';

abstract class AuthenticationRepository {
  Future<bool> get isSignedIn;
  Future<User?> getUserData();
  Future<Either<SignInFailure, User>> signIn(
    String username,
    String password,
  );
  void signOut();
}
