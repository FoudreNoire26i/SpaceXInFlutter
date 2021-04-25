import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
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
        future: LaunchManager().getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var launches = snapshot.data as List<Launch>;

            return Column(
              children: [
                FutureBuilder(
                    future: LaunchManager().getNextLaunchDetail(),
                    builder: (context, snapshot) {
                      int endTime = 0;
                      Launch nextLaunch;
                      if (snapshot.hasData){
                        nextLaunch = snapshot.data;
                        endTime = DateTime.now().millisecondsSinceEpoch + (DateTime.parse(nextLaunch.date_local).millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch);
                      }


                      return new InkWell(
                        onTap: (){
                          Navigator.push(
                          context,
                          new MaterialPageRoute(
                          builder: (context) =>
                          DetailItem(selectedIndex: 0)));
                      },
                          child: Container(
                            width: double.infinity,
                            color: Colors.grey,
                            padding: const EdgeInsets.all(30.0),
                            child: CountdownTimer(
                              widgetBuilder: (_, CurrentRemainingTime time) {
                                if (time == null) {
                                  return Center(
                                      child : Text('NEW LAUNCH !',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                              color: Colors.blueAccent))
                                  );
                                }
                                return Center(
                                  child: Text(
                                      'Next launch in : \ndays: ${time.days != null ? time.days : 0} , hours: ${time.hours != null ? time.hours : 0} , min: ${time.min != null ? time.min : 0} , sec: ${time.sec} ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          color: Colors.blueAccent)),
                                );
                              },
                              endTime: endTime,
                            ),
                          ),
                      );
                    }),
                Expanded(
                  child: ListView.builder(
                      itemCount: launches.length - 1,
                      shrinkWrap: true,
                      primary: true,
                      itemBuilder: (context, position) {
                        final launch = launches[position];
                        return ListTile(
                          leading: launches[position]
                                      .links
                                      .patch
                                      .imageSmallUrl !=
                                  null
                              ? Image.network(
                                  launches[position].links.patch.imageLargeUrl)
                              : Icon(
                                  Icons.image,
                                ),
                          title: Text(launches[position].name,
                              style:
                                  new TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(launches[position].date_local),
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        DetailItem(selectedIndex: position)));
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
                      }),
                )
              ],
            );
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
