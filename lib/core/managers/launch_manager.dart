import 'package:dio/dio.dart';
import 'package:space_x_flutter_app/core/models/launch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaunchManager {

  List<Launch> launchsList;
  Launch launchDetail;
  Launch nextLaunch;

  static final LaunchManager _instance = LaunchManager._internal();

  factory LaunchManager() => _instance;

  LaunchManager._internal();
/*
  /// Charge et renvoie la liste complète de spots depuis le fichier json local
  Future<List<Launch>> loadSpots(BuildContext context) async {
    // Opening json file
    var jsonString = await DefaultAssetBundle.of(context)
        .loadString("assets/json/spots.json");
    // Decoding json
    var json = jsonDecode(jsonString);
    // Mapping data
    spots = List<Map<String, dynamic>>.from(json["data"])
        .map((json) => Spot.fromJson(json))
        .toList();
    return spots;
  }

  /// Renvoie un spot aléatoire de la liste pré-chargée
  Spot getRandomSpot() {
    if (spots != null && spots.isNotEmpty) {
      var random = Random();
      int randomIndex = random.nextInt(spots.length - 1);
      return spots[randomIndex];
    }
    return null;
  }

  /// Renvoie les spots de l'interval défini
  /// [startIndex] est l'index de début de l'interval
  /// [endIndex] est l'index de fin de l'interval
  List<Spot> getSomeSpots({int startIndex = 0, int endIndex = 15}) {
    if (spots != null &&
        spots.isNotEmpty &&
        startIndex < spots.length &&
        startIndex < endIndex) {
      if (endIndex > spots.length) {
        endIndex = spots.length;
      }
      return spots.getRange(startIndex, endIndex).toList();
    }
    return null;
  }
*/
  
  List<Launch> getLaunchesByName(String name) {
    List<Launch> matchingLaunches = [];
    if (launchsList != null && launchsList.isNotEmpty) {
      for (Launch launch in launchsList) {
        if (launch.name.toLowerCase().contains(name.toLowerCase())) {
          matchingLaunches.add(launch);
        }
      }
    }
    return matchingLaunches;
  }

  Future<Launch> getLaunchDetail(String id) async {
    var dio = Dio();
    try {
      launchDetail = await dio.get<Map<String, dynamic>>("https://api.spacexdata.com/v4/launches/$id")
          .then((response) {
        return Launch.fromJson(response.data);
      }
      );
      return launchDetail;
    }
    catch (e) {
      print("Erreur get detail : $e");
      return null;
    }
  }

  Future<Launch> getNextLaunchDetail() async {
    var dio = Dio();
    try {
      nextLaunch = await dio.get<Map<String, dynamic>>("https://api.spacexdata.com/v4/launches/next")
          .then((response) {
        return Launch.fromJson(response.data);
      }
      );
      return nextLaunch;
    }
    catch (e) {
      print("Erreur get nextLaunch : $e");
      return null;
    }
  }

  Future<List<Launch>> getData() async {
    var dio = Dio();
    try {
      List<Launch> apiLaunchs = await dio.get<List<dynamic>>("https://api.spacexdata.com/v4/launches/upcoming")
          .then((response) {
        return parseLaunches(response.data);
      }
      );
      return apiLaunchs;
    }
    catch (e) {
      print("Erreur get : $e");
      return null;
    }
  }

  Future<List<Launch>> getOldData() async {
    var dio = Dio();
    try {
      List<Launch> apiLaunchs = await dio.get<List<dynamic>>("https://api.spacexdata.com/v4/launches/past")
          .then((response) {
        return parseLaunches(response.data);
      }
      );
      return apiLaunchs;
    }
    catch (e) {
      print("Erreur get : $e");
      return null;
    }
  }


  List<Launch> parseLaunches(List<dynamic> json){
    launchsList = json.map<Launch>((js) => Launch.fromJson(js)).toList();
    return launchsList;
  }


  void setLaunchFavorite(String launchId, bool isFavorite) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isFav = await isLaunchFavorite(launchId) ?? false;
    await sharedPreferences.setBool("launch_$launchId", !isFav);
  }

  Future<bool> isLaunchFavorite(String launchId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("launch_$launchId");
  }
}