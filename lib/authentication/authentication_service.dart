import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth firebaseAuth;
  const AuthenticationService(this.firebaseAuth);

  Stream<User> get authStateChanges => firebaseAuth.idTokenChanges();

  String getDisplayName() {
    return firebaseAuth.currentUser.displayName;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return "signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp(
      {String email, String password, String displayName}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await firebaseAuth.currentUser.updateProfile(displayName: displayName);
      firebaseAuth.currentUser.reload();

      return "signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
