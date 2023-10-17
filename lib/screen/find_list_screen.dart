import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jejunu_lost_property/component/appbar.dart';



class FindListScreen extends StatefulWidget {
  const FindListScreen({Key? key}) : super(key: key);

  @override
  State<FindListScreen> createState() => _FindListScreenState();

}

class _FindListScreenState extends State<FindListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RenderAppBar(title: "잃어버린 분"),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            Card(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                              height: 800.0,
                              child: FindListModel(context),

                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),

    );
  }

  Widget FindListModel (BuildContext context){
    return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('findlist')
        .orderBy('title', descending:true)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError)
        return new Text('Error: ${snapshot.error}');
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return new Text('Loading...');
        default:
          return new ListView(
            children:
            snapshot.data!.docs.map((DocumentSnapshot e) {
              return new Column(
                children: <Widget>[
                  SizedBox(
                    height: 70,
                    child: new ListTile(
                      title: Text('1'),
                      subtitle: Text('1'),
                      onTap:() {},
                    ),
                  ),
                  Divider(thickness: 1.0,
                  )
                ],
              );
            }).toList(),
          );
      }
    },
    );

  }

  }


