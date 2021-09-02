import 'package:brew_crew_coffee_app/screens/services/auth.dart';
import 'package:brew_crew_coffee_app/shared/constants.dart';
import 'package:brew_crew_coffee_app/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
      ? Loading()
        : Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.brown[400],
                title: Text("Coffee Bre Crew App Sign In"),
                elevation: 0.0, //no shadow property
                actions: [
                  TextButton.icon(
                      onPressed: () {
                        
                        widget.toggleView();
                      },
                      icon: Icon(Icons.person),
                      label: Text("Sign Up")),
                ]),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),

                    // anonymous sign in code
                    // child: ElevatedButton(
                    //     onPressed: () async {
                    //       dynamic result = await _auth.signInAnon();
                    //       if (result == null) {
                    //         print("No user sign in, user is null");
                    //       } else {
                    //         print("User Sign in");
                    //         print(result.uid);
                    //       }
                    //     },
                    //     child: Text("SignIn")),

                    // Sign in with email password
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: "Email"),
                              validator: (val) =>
                                  val!.isEmpty ? "Enter an email" : null,
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: "Password"),
                                obscureText: true,
                                validator: (val) => val!.length < 6
                                    ? "Enter correct password"
                                    : null,
                                onChanged: (val) {
                                  setState(() => password = val);
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => loading = true);
                                    dynamic result =
                                        _auth.signInwithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        error =
                                            "Enter correct Email and Password";
                                        loading = false;
                                      });
                                    }
                                  }
                                },
                                child: Text("Sign in")),
                            Text(error,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0)),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
  }
}
