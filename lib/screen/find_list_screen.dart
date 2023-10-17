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
      builder: (context, snapshot) {
        // 가져오는 동안 에러가 발생하면 보여줄 메세지 화면
        if (snapshot.hasError) {
          return Center(
            child: Text("목록을 가져오지 못했습니다."),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          const CircularProgressIndicator();
          //return Container(child: CircularProgressIndicator());
        }
        final findlists = snapshot.data!.docs
            .map(
              (QueryDocumentSnapshot e)=>
              FindListModel.fromJson(
                  json: (e.data() as Map<String, dynamic>)),
        ).toList();

        return Scaffold(
        body:
        ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              final findlist = findlists[index];
              return new Column(
                children: <Widget>[
                  SizedBox(
                    height: 70,
                    child: new ListTile(
                      title: Text(findlist.title),
                      subtitle: Text(findlist.content),
                      onTap: () {},
                    ),
                  ),
                  Divider(thickness: 1.0,
                  )

                ],
              );
            }
            )
              );
            }

        );

      }
  
      }




