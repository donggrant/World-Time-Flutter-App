import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference locationsCollection = Firestore.instance.collection('locations');

  Future updateUserData(String country, String city) async {
    return await locationsCollection.document(uid).setData({
      'country': country,
      'city': city,
    });
  }

  // get location stream
  Stream<QuerySnapshot> get locations {
    return locationsCollection.snapshots();
  }
}