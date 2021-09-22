import '../model/user_model.dart';

abstract class AuthBase {
  Future<MyUser> curretUser();
  Future<MyUser?> signInAnonim();
  Future<bool> signOut();
  Future<MyUser?> signInEmail(String email, String password);
}
