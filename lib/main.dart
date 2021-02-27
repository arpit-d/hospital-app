import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/models/appointment_model.dart';

import 'package:hospital_app/resources/theme.dart';
import 'package:hospital_app/routes/appointment.dart';

import 'package:provider/provider.dart';

import 'authentication/authentication_service.dart';
import 'providers/appointment_provider.dart';
import 'routes/home_page.dart';
import 'routes/sign_in.dart';
import 'services/firebase_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// 497724
class MyApp extends StatelessWidget {
  final db = Database();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
        ChangeNotifierProvider<AppointmentProvider>(
          create: (_) => AppointmentProvider(),
        ),
      ],
      child: MaterialApp(
        key: GlobalObjectKey(context),
        debugShowCheckedModeBanner: false,
        title: 'Hospital App',
        theme: appTheme,
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  final db = Database();
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      print('true');
      return StreamProvider<List<AppointmentModel>>(
        key: ObjectKey(FirebaseAuth.instance.currentUser.uid),
        create: (context) => db.getAppointments(),
        catchError: (context, error) {
          print(error);
        },
        child: Appointment(),
      );
    } else {
      print('fas');
      return SignInPage();
    }
  }
}
