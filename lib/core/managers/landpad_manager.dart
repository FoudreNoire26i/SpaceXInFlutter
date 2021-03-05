import 'package:dio/dio.dart';
import 'package:space_x_flutter_app/core/models/landpad.dart';

class LandPadManager {

  List<LandPad> landPadsList;
  LandPad landPadDetail;

  static final LandPadManager _instance = LandPadManager._internal();

  factory LandPadManager() => _instance;

  LandPadManager._internal();
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

  List<LandPad> getLandPadsByName(String name) {
    List<LandPad> matchingLaunches = List();
    if (landPadsList != null && landPadsList.isNotEmpty) {
      for (LandPad landPad in landPadsList) {
        if (landPad.name.toLowerCase().contains(name.toLowerCase())) {
          matchingLaunches.add(landPad);
        }
      }
    }
    return matchingLaunches;
  }

  Future<LandPad> getLandPadDetail(String id) async {
    var dio = Dio();
    try {
      landPadDetail = await dio.get<Map<String, dynamic>>("https://api.spacexdata.com/v4/landpads/$id")
          .then((response) {
        return LandPad.fromJson(response.data);
      }
      );
      return landPadDetail;
    }
    catch (e) {
      print("Erreur get detail : $e");
      return null;
    }
  }

  Future<List<LandPad>> getData() async {
    var dio = Dio();
    try {
      List<LandPad> apiLandPads = await dio.get<List<dynamic>>("https://api.spacexdata.com/v4/landpads")
          .then((response) {
        return parseLandPads(response.data);
      }
      );
      return apiLandPads;
    }
    catch (e) {
      print("Erreur get : $e");
      return null;
    }

  }

  List<LandPad> parseLandPads(List<dynamic> json){
    landPadsList = json.map<LandPad>((js) => LandPad.fromJson(js)).toList();
    return landPadsList;
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