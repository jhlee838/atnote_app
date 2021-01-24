import 'package:flutter/material.dart';
import 'package:atnote/db.dart';

class Index extends StatefulWidget {
  @override
  IndexState createState() => IndexState();
}

class IndexState extends State<Index> {
  var poem;
  void initState() {
    super.initState();
    poem = getPoems();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: poem,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xffd6d6d6), width: 0),
                  boxShadow: [BoxShadow(
                    color: Colors.black12,
                    offset: Offset(7, 7),
                    blurRadius: 10,
                    spreadRadius: 0
                  ),],
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Center(
                  child: Text(snapshot.data[i].title),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
