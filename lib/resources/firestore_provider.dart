import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  Firestore _store = Firestore.instance;

  Stream<QuerySnapshot> getItems() {
    return _store.collection('items').snapshots();
  }
  
}