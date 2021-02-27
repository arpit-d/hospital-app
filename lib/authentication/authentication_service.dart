import 'package:firebase_auth/firebase_auth.dart';
import 'package:hospital_app/enums/auth_result_status.dart';
import 'package:hospital_app/services/auth_exception_handler.dart';

class AuthenticationService {
  final FirebaseAuth firebaseAuth;
  const AuthenticationService(this.firebaseAuth);
  static AuthResultStatus _status;

  Stream<User> get authStateChanges => firebaseAuth.idTokenChanges();

  String getDisplayName() {
    return firebaseAuth.currentUser.displayName;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<AuthResultStatus> signUp({email, password, displayName}) async {
    try {
      final authResult = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
        await firebaseAuth.currentUser.updateProfile(displayName: displayName);
        await firebaseAuth.currentUser.reload();
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<AuthResultStatus> signIn({String email, String password}) async {
    try {
      final authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }
}
