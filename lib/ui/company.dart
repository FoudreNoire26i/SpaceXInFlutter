import 'package:flutter/material.dart';
import 'package:space_x_flutter_app/core/managers/company_manager.dart';
import 'package:space_x_flutter_app/core/managers/launch_manager.dart';
import 'package:space_x_flutter_app/core/models/company.dart';
import 'package:space_x_flutter_app/core/models/launch.dart';


class MyCompanyPage extends StatefulWidget {
  MyCompanyPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyCompanyPageState createState() => _MyCompanyPageState();
}

class _MyCompanyPageState extends State<MyCompanyPage> {



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
                  return ListTile(
                    leading: launches[position].links.patch.imageSmallUrl != null ? Image.network(launches[position].links.patch.imageSmallUrl) : Icon(Icons.image,),
                    title: Text(launches[position].name,style: new TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(launches[position].id),
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


