import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  Firestore _store = Firestore.instance;

  Stream<QuerySnapshot> getItems() {
    return _store.collection('items').snapshots();
  }
  
  Future<DocumentReference> addItem(Map<String, dynamic> item) {
    return _store.collection('items').add(item);
  }

}