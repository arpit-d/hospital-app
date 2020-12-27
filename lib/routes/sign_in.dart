import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/authentication/authentication_service.dart';
import 'package:hospital_app/routes/register_user.dart';
import 'package:hospital_app/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('MGM'),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_sharp),
                    labelText: "Email",
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Password",
                  ),
                ),
                SizedBox(height: 10),
                ButtonWidget(
                  onPressed: () {
                    context.read<AuthenticationService>().signIn(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim());
                  },
                  buttonText: ("Sign In"),
                ),
                SizedBox(height: 10),
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Don\'t have an account?',
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                      text: ' Sign up here!',
                      style: TextStyle(color: Colors.green),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterUser()),
                            ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
