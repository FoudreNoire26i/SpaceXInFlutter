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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(companyData.name,style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 50),textAlign: TextAlign.center),
                      SizedBox(height: 10),
                      Text("Fondée par "+companyData.founder,textAlign: TextAlign.center,style: new TextStyle(fontStyle: FontStyle.italic)),
                      SizedBox(height: 10),
                      Text("Adresse : "),
                      SizedBox(height: 10),
                      Text(companyData.headquarters.address,textAlign: TextAlign.center),
                      Text(companyData.headquarters.city,textAlign: TextAlign.center),
                      Text(companyData.headquarters.state,textAlign: TextAlign.center),
                    ]
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Nombre d'employés : "+companyData.employeesNb.toString(),textAlign: TextAlign.center),
                      ]
                  ),

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



