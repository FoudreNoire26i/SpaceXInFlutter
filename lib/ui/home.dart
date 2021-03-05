import 'package:flutter/material.dart';
import 'package:space_x_flutter_app/core/managers/company_manager.dart';
import 'package:space_x_flutter_app/core/managers/landpad_manager.dart';
import 'package:space_x_flutter_app/core/managers/launch_manager.dart';
import 'package:space_x_flutter_app/core/managers/launchpad_manager.dart';
import 'package:space_x_flutter_app/core/models/company.dart';
import 'package:space_x_flutter_app/core/models/landpad.dart';
import 'package:space_x_flutter_app/core/models/launch.dart';
import 'package:space_x_flutter_app/core/models/launchpad.dart';

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

      body: FutureBuilder(
        future : LaunchManager().getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var launches = snapshot.data as List<Launch>;
            return ListView.builder(
                itemCount : launches.length - 1,
                itemBuilder: (context,position){
                  final launch = launches[position];
                  return ListTile(
                    leading: launch.links.patch.imageSmallUrl != null ? Image.network(launch.links.patch.imageSmallUrl) : Icon(Icons.image,),
                    title: Text(launch.name,style: new TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(launch.id),
                    onTap: (){
                      Navigator.push(context, new MaterialPageRoute(builder: (context)=>DetailItem(selectedIndex: position)));
                    },
                    trailing: FutureBuilder(
                        future: LaunchManager().isLaunchFavorite(launch.id),
                        builder: (context, snapshot) {
                          bool isFav = false;
                          if (snapshot.hasData){
                            isFav = snapshot.data;
                          }
                          return IconButton(
                                      icon: Icon(isFav ? Icons.favorite : Icons.favorite_border_outlined, color: Colors.red),
                                      onPressed: () {
                                        LaunchManager().setLaunchFavorite(launch.id, isFav);
                                        setState(() {
                                        });
                                      }
                          );
                        })

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


