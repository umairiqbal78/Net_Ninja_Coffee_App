
import 'package:brew_crew_coffee_app/models/user.dart';
import 'package:brew_crew_coffee_app/screens/services/auth.dart';
import 'package:brew_crew_coffee_app/screens/services/database.dart';
import 'package:brew_crew_coffee_app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading() : StreamProvider<QuerySnapshot?>.value(
      initialData: null,
      value: dataBaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("BrewCrew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            TextButton.icon(
                onPressed: () async {
                  setState(() => loading = true);
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text("Sign Out"))
          ],
        ),
      ),
    );
  }
}
