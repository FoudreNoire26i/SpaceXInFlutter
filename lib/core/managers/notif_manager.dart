import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:space_x_flutter_app/core/models/launch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'launch_manager.dart';

class NotifiManager {
  static final NotifiManager _instance = NotifiManager._internal();

  factory NotifiManager() => _instance;

  NotifiManager._internal();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void setNextLaunchNotif(bool isNextLaunchActivated) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isAllLaunchActivated = sharedPreferences.getBool("isAllLaunchNotifActivated") ?? false;

    LaunchManager().getNextLaunchDetail().then((value)=> {
      if (isNextLaunchActivated && !isAllLaunchActivated){
        setNotif(value)
      } else if (!isNextLaunchActivated && !isAllLaunchActivated){
        removeNotif(value.date_unix)
      }
    });
    await sharedPreferences.setBool("isNextLaunchNotifActivated", isNextLaunchActivated || isAllLaunchActivated);
  }

  Future<bool> isNextLaunchNotifActivated() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("isNextLaunchNotifActivated") || sharedPreferences.getBool("isAllLaunchNotifActivated");
  }

  void setFavLaunchNotif(bool isFavLaunchActivated) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isAllLaunchActivated = sharedPreferences.getBool("isAllLaunchNotifActivated") ?? false;
    LaunchManager().getFavLaunches().then((value) => {
      value.forEach((element) {
        if (isFavLaunchActivated && !isAllLaunchActivated){
          setNotif(element);
        } else if (!isFavLaunchActivated && !isAllLaunchActivated){
          removeNotif(element.date_unix);
        }
      })
    });

    await sharedPreferences.setBool("isFavLaunchNotifActivated", isFavLaunchActivated || isAllLaunchActivated);
  }

  Future<bool> isFavLaunchNotifActivated() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("isFavLaunchNotifActivated") || sharedPreferences.getBool("isAllLaunchNotifActivated")  ?? false;
  }

  void setAllLaunchNotif(bool isAllLaunchActivated) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (isAllLaunchActivated){
      LaunchManager().getData().then((value) => {
        value.forEach((element) {
          setNotif(element);
        })
      });
    }else {
      flutterLocalNotificationsPlugin.cancelAll();
      setFavLaunchNotif(true);
      setNextLaunchNotif(true);
    }
    await sharedPreferences.setBool("isAllLaunchNotifActivated", isAllLaunchActivated);
  }

  Future<bool> isAllLaunchNotifActivated() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("isAllLaunchNotifActivated") ?? false;
  }

  void setNotif(Launch value){
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Europe/Paris"));

    if (DateTime.parse(value.date_utc).subtract(const Duration(hours:1)).isAfter(DateTime.now())){
      var initializationSettingsAndroid = AndroidInitializationSettings('launch_background');
      var initializationSettingsIOs = IOSInitializationSettings();
      final MacOSInitializationSettings initializationSettingsMacOS = MacOSInitializationSettings();
      var initSetttings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOs, macOS: initializationSettingsMacOS);
      flutterLocalNotificationsPlugin.initialize(
          initSetttings,
          onSelectNotification: selectNotification
      );
      flutterLocalNotificationsPlugin.zonedSchedule(
          value.date_unix,
          "${value.name} will be launch in one hour",
          'Launch Date : ${DateTime.parse(value.date_utc).toLocal().toIso8601String()}',
          tz.TZDateTime.from(DateTime.parse(value.date_utc), tz.local).subtract(const Duration(hours: 1)),
          const NotificationDetails(
            android: AndroidNotificationDetails(
                "0",
                'launch',
                'Launch notification one hour before it'
            ),
          ),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
      );
    } else {
      print("ERROR : can't create notification before now");
    }


  }

  void removeNotif(int notitificationDateUnix) {
    flutterLocalNotificationsPlugin.cancel(notitificationDateUnix);
  }

  Future selectNotification(String payload) async {
    print("Notifications clicked");
  }
}