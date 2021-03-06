import 'package:cloud_firestore/cloud_firestore.dart';

import '../resources/constants.dart';

class ItemModel {
  final String title;
  final String id;
  final String image;
  final String description;

  ItemModel({
    this.title,
    this.id,
    this.image,
    this.description
  });

  ItemModel.fromMap(DocumentSnapshot parsedJson) :
        id = parsedJson.documentID,
        title = parsedJson[columnTitle],
        description = parsedJson[columnDescription],
        image = parsedJson[columnDescription];
        
  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map[columnId] = id;
    map[columnTitle] = title;
    map[columnDescription] = description;
    map[columnImage] = image;
    return map;
  }

}