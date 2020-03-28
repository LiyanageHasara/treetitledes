import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:treeapp/data/model/tree.dart';

class FirestoreService {
  static final FirestoreService _firestoreService =
      FirestoreService._internal();
  Firestore _db = Firestore.instance;

  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  Stream<List<Tree>> getTrees() {
    return _db.collection('plant').snapshots().map(
          (snapshot) => snapshot.documents.map(
            (doc) => Tree.fromMap(doc.data, doc.documentID),
          ).toList(),
        );
  }

  Future<void> addTree(Tree tree){
    return _db.collection('plant').add(tree.toMap());
  }

  Future<void> deleteTree(String id){
    return _db.collection('plant').document(id).delete();
  }

  Future<void> updateTree(Tree tree){
    return _db.collection('plant').document(tree.id).updateData(tree.toMap());
  }
}
