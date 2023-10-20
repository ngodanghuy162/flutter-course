import 'package:flutter_application_1/service/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initalize();
  
  AuthUser? get currentUser;

  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<void> logOut();

  Future<void> sendEmailVerify();
}
