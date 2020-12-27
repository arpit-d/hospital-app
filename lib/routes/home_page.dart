import 'package:flutter/material.dart';
import 'package:hospital_app/authentication/authentication_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<AuthenticationService>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () {
              context.read<AuthenticationService>().signOut();
            },
            child: Text("Sign out"),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(p.getDisplayName().toString()),
          ],
        ),
      ),
    );
  }
}
