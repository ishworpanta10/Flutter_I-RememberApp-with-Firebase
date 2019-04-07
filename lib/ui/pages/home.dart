import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1_iremember/resources/firebase_auth_provider.dart';
import 'package:project1_iremember/resources/firestore_provider.dart';
import './add.dart';
import './detail.dart';
import '../../resources/db_provider.dart';
import '../../models/item_model.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List items = [];

  void initState() {
    super.initState();
  }

  Future<List> getItems() async {
    return DbProvider().fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        leading: Icon(Icons.home),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app),onPressed: (){
            FirebaseAuthProvider().logout();
          },)
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder(
        stream: FirestoreProvider().getItems(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
          if(snapshot.hasError) return Center(child: Text("There was an error ${snapshot.error}" ),);
          QuerySnapshot items = snapshot.data;
          List<DocumentSnapshot> documents = items.documents;

          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              ItemModel item = ItemModel.fromMap(documents[index]);
              return Column(
                children: <Widget>[
                  ListTile(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => DetailPage(item: item, onDelete: _delete,))),
                    isThreeLine: true,
                    title: Text(item.title),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: ()=>_delete(item),
                    ),
                    // leading: CircleAvatar(
                    //   backgroundImage: FileImage(
                    //     File(item.image),
                    //   ),
                    //   radius: 34,
                    // ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(item.description),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  
                  ),
                  Divider(),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => AddPage())),
        tooltip: "Add Item",
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.green[200],
    );
  }

  void _delete(ItemModel item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete item"),
          content: Text("Are you sure you want to delete Item?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: ()=>Navigator.pop(context),
            ),
            FlatButton(
              child: Text("Delete"),
              onPressed: (){
                removeItem(item);
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (_) => HomePage()
                ));
                
              }
            )
          ],
        );
      }
    );
  }

  void removeItem(ItemModel item) {
    setState(() { 
      // DbProvider().deleteItem(item.id);
    });
  }

}
