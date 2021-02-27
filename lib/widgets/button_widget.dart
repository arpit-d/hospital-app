import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final GestureTapCallback onPressed;
  const ButtonWidget({@required this.onPressed, @required this.buttonText});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(buttonText),
      onPressed: onPressed,
    );
  }
}
