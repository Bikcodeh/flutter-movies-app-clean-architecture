import '../common/either/either.dart';
import '../common/failure/failure.dart';
import '../models/user/user.dart';

abstract class AuthenticationRepository {
  Future<bool> get isSignedIn;
  Future<User?> getUserData();
  Future<Either<Failure, User>> signIn(
    String username,
    String password,
  );
  void signOut();
}
