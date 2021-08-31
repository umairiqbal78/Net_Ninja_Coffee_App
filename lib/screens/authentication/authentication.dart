import 'package:brew_crew_coffee_app/screens/authentication/register.dart';
import 'package:brew_crew_coffee_app/screens/authentication/signin.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignin = true;
  void toggleView() {
    setState(() => showSignin = !showSignin);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignin) {
      return SignIn(
        toggleView: toggleView,
      );
    } else {
      return SignUp(
        toggleView:toggleView,
      );
    }
  }
}
