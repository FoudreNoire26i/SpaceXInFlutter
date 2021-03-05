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
        future : CompanyManager().getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var companyData = snapshot.data as Company;
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(companyData.name,style: new TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                  SizedBox(height: 10),
                  Text(companyData.founder,textAlign: TextAlign.center),
                  SizedBox(height: 10),
                  Text(companyData.employeesNb.toString(),textAlign: TextAlign.center),
                  SizedBox(height: 10),
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



