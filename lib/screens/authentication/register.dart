import 'package:brew_crew_coffee_app/screens/services/auth.dart';
import 'package:brew_crew_coffee_app/shared/constants.dart';
import 'package:brew_crew_coffee_app/shared/loading.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({required this.toggleView});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                title: Text("Coffee Bre Crew App Sign Up"),
                elevation: 0.0, //no shadow property
                actions: [
                  TextButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text(
                      "Sign Up",
                    ),
                  )
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
                                  val!.isEmpty ? "Enter an Email" : null,
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
                                validator: (val) => val!.length < 6
                                    ? "Enter atleast 6 digit password"
                                    : null,
                                obscureText: true,
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
                                        _auth.registerWithEmailandPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                          error = "Please Enter valid Email ";
                                      loading = false;
                                    }
                                  );
                                }}},
                                child: Text("Register")),
                            SizedBox(
                              height: 12.0,
                            ),
                            Text(
                              error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
  }
}
