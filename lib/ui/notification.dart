import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:space_x_flutter_app/core/managers/launchpad_manager.dart';
import 'package:space_x_flutter_app/core/managers/notif_manager.dart';
import 'package:space_x_flutter_app/core/models/launchpad.dart';

class MyNotificationPage extends StatefulWidget {
  MyNotificationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyNotificationPageState createState() => _MyNotificationPageState();
}

class _MyNotificationPageState extends State<MyNotificationPage> {
  bool isNextLaunchNotifActivated = false;
  bool isFavLaunchNotifActivated = false;
  bool isAllLaunchNotifActivated = false;

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: Future.wait([NotifiManager().isNextLaunchNotifActivated(), NotifiManager().isFavLaunchNotifActivated(), NotifiManager().isAllLaunchNotifActivated()]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        print(snapshot.connectionState.toString());
        var connectionState = snapshot.connectionState;

        if (connectionState == ConnectionState.done) {
          print(snapshot.data);
          if (snapshot.data[0] != null) {
            isNextLaunchNotifActivated = snapshot.data[0];
          }
          if (snapshot.data[1] != null) {
            isFavLaunchNotifActivated = snapshot.data[1];
          }
          if (snapshot.data[2] != null) {
            isAllLaunchNotifActivated = snapshot.data[2];
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Allow notification for next launch"),
                    Switch(value: isNextLaunchNotifActivated, onChanged: (newVal){
                      setState(() {
                        isNextLaunchNotifActivated = newVal;
                        NotifiManager().setNextLaunchNotif(isNextLaunchNotifActivated);
                      });
                    },)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Allow notification for favorite launches"),
                    Switch(value: isFavLaunchNotifActivated, onChanged: (newVal){
                      setState(() {
                        isFavLaunchNotifActivated = newVal;
                        NotifiManager().setFavLaunchNotif(isFavLaunchNotifActivated);
                      });
                    },)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Allow notification for all launches"),
                    Switch(value: isAllLaunchNotifActivated, onChanged: (newVal){
                      setState(() {
                        isAllLaunchNotifActivated = newVal;
                        NotifiManager().setAllLaunchNotif(isAllLaunchNotifActivated);
                      });
                    },)
                  ],
                ),
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}
