import 'package:brew_crew_coffee_app/models/brew.dart';
import 'package:brew_crew_coffee_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class dataBaseService {
  final String? uid;
  dataBaseService({this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("brew");

  Future updateUserCollection(
    String name,
    int strength,
    String sugars,
  ) async {
    return await brewCollection.doc(uid).set({
      'name': name,
      'strength': strength,
      'sugars': sugars,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.get('name') ?? 'no name',
        strength: doc.get('strength') ?? 0,
        sugars: doc.get('sugars') ?? '0',
      );
    }).toList();
  }

  // getting data from document
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapShot);
  }

  //user data from snapshot
  UserData _userDataFromDocumentSnapShot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('name'),
      sugars: snapshot.get('sugars'),
      strength: snapshot.get('strength'),
    );
  }

//getting current userdata from db
  Stream<UserData> get userData {
    return brewCollection
        .doc(uid)
        .snapshots()
        .map(_userDataFromDocumentSnapShot);
  }
}
