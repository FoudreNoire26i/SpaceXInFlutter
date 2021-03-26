import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:space_x_flutter_app/core/managers/launch_manager.dart';
import 'package:space_x_flutter_app/ui/company.dart';
import 'package:space_x_flutter_app/ui/home.dart';
import 'package:space_x_flutter_app/ui/map.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    MyMapPage(title: 'Carte'),
    MyHomePage(title: 'Accueil'),
    MyCompanyPage(title: 'Space X'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  @override
  Widget build(BuildContext context) {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Europe/Paris"));




    launchNotif();


    return Scaffold(
      appBar: AppBar(
        title: const Text('Space X Project'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Carte',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplanemode_active),
            label: 'Space X',
            backgroundColor: Colors.lightBlueAccent,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.shifting,
      ),
    );
  }

  void launchNotif() async{
    var initializationSettingsAndroid = AndroidInitializationSettings('launch_background');
    var initializationSettingsIOs = IOSInitializationSettings();
    final MacOSInitializationSettings initializationSettingsMacOS = MacOSInitializationSettings();
    var initSetttings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOs, macOS: initializationSettingsMacOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
      onSelectNotification: selectNotification,);
    //showTestNotification();
    createNotifWithDate();
    LaunchManager().getNextLaunchDetail().then((value) => {
      flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      "${value.name} will be launch soon",
      'Launch Date : ${value.date_local}',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),

      const NotificationDetails(
      android: AndroidNotificationDetails('your channel id',
      'your channel name', 'your channel description'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime)
    });

  }

  void createNotifWithDate() async{

  }

  Future selectNotification(String payload) async {
    print("Notifications clicked");
  }

  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
    //showTestNotification();
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyStatefulWidget(),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void showTestNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'space-x', 'Space X', 'Space X notification channel',
        importance: Importance.max,
        priority: Priority.max,
        showWhen: false);
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'Notif test', 'Hello', platformChannelSpecifics,
        payload: 'item x');
  }
}

