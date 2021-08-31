import 'package:cloud_firestore/cloud_firestore.dart';

class dataBaseService {
  final String uid;
  dataBaseService({required this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("brew");

  Future updateUserCollection(String sugar, String name, int strength) async {
    return await brewCollection
        .doc(uid)
        .set({'sugars': sugar, 'name': name, 'strength': strength});
  }
}
