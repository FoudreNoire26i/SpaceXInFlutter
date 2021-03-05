import 'package:flutter/material.dart';
import 'package:space_x_flutter_app/core/managers/launch_manager.dart';
import 'package:space_x_flutter_app/core/models/launch.dart';

class DetailItem extends StatefulWidget {

  DetailItem({Key key, this.selectedIndex}) : super(key: key);

  final int selectedIndex;

  @override
  _DetailItem createState() => _DetailItem();
}

class _DetailItem extends State<DetailItem> {

  @override
  Widget build(BuildContext context) {

    Launch mylaunch= LaunchManager().launchsList[widget.selectedIndex];

    // This method is rerun every time setState is called.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(mylaunch.name),
      ),

      body: FutureBuilder(
        future: LaunchManager().getLaunchDetail(mylaunch.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                children: [
                  Image.network(mylaunch.links.patch.imageSmallUrl)!= null ? Image.network(mylaunch.links.patch.imageLargeUrl) : Icon(Icons.image,),
                  SizedBox(height: 10),
                  Text(mylaunch.name),
                  SizedBox(height: 10),
                ]
            );

          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}