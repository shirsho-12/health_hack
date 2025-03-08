import '../../models/user.dart';
import 'auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  AuthService(this.provider);

  // factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<User> createUser({
    required String userName,
    required String email,
    required String password,
  }) {
    return provider.createUser(
      userName: userName,
      email: email,
      password: password,
    );
  }

  @override
  Future<User?> get currentUser => provider.currentUser;

  @override
  Future<User> logIn({required String email, required String password}) {
    return provider.logIn(email: email, password: password);
  }

  @override
  Future<void> logOut() {
    return provider.logOut();
  }
}
