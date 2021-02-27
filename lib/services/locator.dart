import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hospital_app/authentication/authentication_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Replace this with the object you're trying to listen to.
  User user;
  Stream<User> userStream =
      AuthenticationService(FirebaseAuth.instance).authStateChanges;
  userStream.listen((event) => user = event);
  locator.registerLazySingleton(() => user); // Register your object
}
