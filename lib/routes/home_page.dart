import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/authentication/authentication_service.dart';
import 'package:hospital_app/routes/appointment.dart';
import 'package:hospital_app/routes/sign_in.dart';
import 'package:hospital_app/services/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello, Arpit',
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        bottomOpacity: 0.0,
        actions: [
          FlatButton(
            onPressed: () {
              context.read<AuthenticationService>().signOut();
              setState(() {});
            },
            child: Text("Sign out"),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Appointment(),
                        ),
                      );
                    },
                    leading: Icon(LineAwesomeIcons.hospital_o),
                    title: Text('Book an online consultation'),
                    subtitle: Text("Consult online from your home to a Doctor"),
                    trailing: Icon(LineAwesomeIcons.angle_right)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Appointment(),
                        ),
                      );
                    },
                    leading: Icon(LineAwesomeIcons.hospital_o),
                    title: Text('Book an online consultation'),
                    subtitle: Text("Consult online from your home to a Doctor"),
                    trailing: Icon(LineAwesomeIcons.angle_right)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
