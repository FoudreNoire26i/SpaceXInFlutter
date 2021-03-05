import 'package:dio/dio.dart';
import 'package:space_x_flutter_app/core/models/company.dart';

class CompanyManager {

  Company company;

  static final CompanyManager _instance = CompanyManager._internal();

  factory CompanyManager() => _instance;

  CompanyManager._internal();

  Future<Company> getData() async {
    var dio = Dio();
    try {
      Company apiCompanys = await dio.get<Map<String, dynamic>>("https://api.spacexdata.com/v4/company")
          .then((response) {
        return parseCompany(response.data);
      }
      );
      return apiCompanys;
    }
    catch (e) {
      print("Erreur get : $e");
      return null;
    }

  }

  Company parseCompany(Map<String, dynamic> json){
    company = Company.fromJson(json);
    return company;
  }

}