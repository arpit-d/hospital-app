import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final GestureTapCallback onPressed;
  const ButtonWidget({this.onPressed, this.buttonText});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(buttonText),
      onPressed: onPressed,
    );
  }
}
