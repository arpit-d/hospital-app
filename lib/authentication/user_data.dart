import 'package:firebase_auth/firebase_auth.dart';
import 'package:hospital_app/authentication/authentication_service.dart';

class UserData extends AuthenticationService {
  UserData(FirebaseAuth firebaseAuth) : super(firebaseAuth);

  String getDisplayName() {
    return firebaseAuth.currentUser.displayName;
  }

  String getEmail() {
    return firebaseAuth.currentUser.email;
  }
}
