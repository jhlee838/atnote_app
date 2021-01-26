import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:atnote/view.dart';

class Search extends StatelessWidget{
  var poems;

  initPoem()async{
    return await Hive.openBox('poems');
  }

  Widget buildResults(BuildContext context){
    return FutureBuilder(
      future: poems==null?initPoem():poems,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          itemCount: snapshot.data.get('file')==null?0:snapshot.data.get('file').length,
          itemBuilder: (BuildContext context, int i){
            var file = File(snapshot.data.get('file')[i]);
            var content = jsonDecode(file.readAsStringSync());
            if(content[0]['trash']=="true"){
              return SizedBox.shrink();
            }
            return GestureDetector(
              onTap: (){
                Get.off(View(), arguments: [jsonEncode(content), file]);
              },
              child: Stack(
                children: [
                  Container(
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
                      child: Text(content[0]['title']),
                    ),
                  ),
                  Positioned(
                    child: content[0]['heart']=="true"
                        ?Icon(Icons.favorite, color: Colors.red,)
                        :Icon(Icons.favorite_outline),
                    right: 30,
                    bottom: 25,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("search"),
    );
  }

}