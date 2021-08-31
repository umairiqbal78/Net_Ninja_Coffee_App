import 'package:brew_crew_coffee_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//custom user obj based on firebaseUser
  UserUid? _userFromFirebaseuser(User user) {
    if (user != null) {
      return UserUid(uid: user.uid);
    } else {
      print("user is null");
      return null;
    }
  }

// auth change user stream
  Stream<UserUid?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseuser(user!));
  }

// register with email and password
  Future registerWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseuser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // login with email and password
  Future signInwithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseuser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//annonymous sigin
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseuser(user!);
    } catch (e) {
      print(e.toString());

      return null;
    }
  }

  // Sign Out

  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
