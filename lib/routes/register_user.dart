import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/authentication/authentication_service.dart';
import 'package:hospital_app/routes/sign_in.dart';
import 'package:hospital_app/widgets/button_widget.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class RegisterUser extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_sharp),
                  labelText: "Email",
                ),
              ),
              TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Password",
                ),
              ),
              TextFormField(
                controller: displayNameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.notes),
                  labelText: "Name",
                ),
              ),
              SizedBox(height: 10),
              ButtonWidget(
                buttonText: 'Sign Up',
                onPressed: () {
                  context
                      .read<AuthenticationService>()
                      .signUp(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          displayName: displayNameController.text)
                      .then((value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => HomePage()),
                          (Route<dynamic> route) => false));
                },
              ),
              SizedBox(height: 10),
              RichText(
                  text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Already have an account?',
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                    text: ' Log in here!',
                    style: TextStyle(color: Colors.green),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInPage()),
                          ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
