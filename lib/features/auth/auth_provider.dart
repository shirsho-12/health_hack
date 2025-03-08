import '../../models/user.dart';

abstract class AuthProvider {
  Future<void> initialize();

  Future<User?> get currentUser;

  Future<User> logIn({required String email, required String password});

  Future<User> createUser({
    required String userName,
    required String email,
    required String password,
  });

  Future<void> logOut();
}
