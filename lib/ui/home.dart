import 'package:flutter/material.dart';
import 'package:space_x_flutter_app/core/managers/launch_manager.dart';
import 'package:space_x_flutter_app/core/models/launch.dart';

import 'detailItem.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: FutureBuilder(
        future : LaunchManager().getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount : LaunchManager().launchsList.length - 1,
                itemBuilder: (context,position){
                  return ListTile(
                    //leading: Image.network(LaunchManager().launchsList[position].name),
                    title: Text((snapshot.data as List<Launch>)[position].name,style: new TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(LaunchManager().launchsList[position].id),
                    onTap: (){
                      Navigator.push(context, new MaterialPageRoute(builder: (context)=>DetailItem(selectedIndex: position)));
                    },
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}


