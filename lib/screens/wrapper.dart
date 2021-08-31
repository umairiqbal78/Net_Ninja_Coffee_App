import 'package:brew_crew_coffee_app/models/user.dart';
import 'package:brew_crew_coffee_app/screens/authentication/authentication.dart';
import 'package:brew_crew_coffee_app/screens/home/home.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUid?>(context);
    print(user);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
