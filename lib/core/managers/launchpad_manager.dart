import 'package:dio/dio.dart';
import 'package:space_x_flutter_app/core/models/launchpad.dart';

class LaunchPadManager {

  List<LaunchPad> launchPadsList;
  LaunchPad launchPadDetail;

  static final LaunchPadManager _instance = LaunchPadManager._internal();

  factory LaunchPadManager() => _instance;

  LaunchPadManager._internal();
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

  List<LaunchPad> getLaunchPadsByName(String name) {
    List<LaunchPad> matchingLaunches = List();
    if (launchPadsList != null && launchPadsList.isNotEmpty) {
      for (LaunchPad launchPad in launchPadsList) {
        if (launchPad.name.toLowerCase().contains(name.toLowerCase())) {
          matchingLaunches.add(launchPad);
        }
      }
    }
    return matchingLaunches;
  }

  Future<LaunchPad> getLaunchPadDetail(String id) async {
    var dio = Dio();
    try {
      launchPadDetail = await dio.get<Map<String, dynamic>>("https://api.spacexdata.com/v4/launchpads/$id")
          .then((response) {
        return LaunchPad.fromJson(response.data);
      }
      );
      return launchPadDetail;
    }
    catch (e) {
      print("Erreur get detail : $e");
      return null;
    }
  }

  Future<List<LaunchPad>> getData() async {
    var dio = Dio();
    try {
      List<LaunchPad> apiLaunchPads = await dio.get<List<dynamic>>("https://api.spacexdata.com/v4/launchpads")
          .then((response) {
        return parseLaunchPads(response.data);
      }
      );
      return apiLaunchPads;
    }
    catch (e) {
      print("Erreur get : $e");
      return null;
    }

  }

  List<LaunchPad> parseLaunchPads(List<dynamic> json){
    launchPadsList = json.map<LaunchPad>((js) => LaunchPad.fromJson(js)).toList();
    return launchPadsList;
  }

/*
  void setSpotFavorite(int spotId, bool isFavorite) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isFav = await isSpotFavorite(spotId) ?? false;
    await sharedPreferences.setBool("spot_$spotId", !isFav);
  }

  Future<bool> isSpotFavorite(int spotId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("spot_$spotId");
  }*/
}