import 'package:brew_crew_coffee_app/screens/services/auth.dart';
import 'package:brew_crew_coffee_app/screens/wrapper.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<UserUid?>.value(
            initialData: null,
            value: AuthService().user,
            catchError: (User, UserUid) => null,
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: Wrapper(),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(height: 20.0, width: 20.0);
      },
    );
  }
}
