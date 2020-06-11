


import 'package:dydindia/homepage.dart';

import 'package:dydindia/services/network_helper.dart';
import 'package:dydindia/user/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Open the database and store the reference.


    loginPage();
  }



  void loginPage(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return Login();
          }
      ));
    });
  }

  void nextScreen() async {
    HTTPHelper helper = HTTPHelper(
        'http://dydindia.com/admin/examlist/getexamdata');
    int rowCount = 0;
    var examData = await helper.getResponse();
    for (var k in examData) {
      rowCount++;
    }

    print(examData);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return HomePage(
              examData: examData,
              rowCount: rowCount,
            );
          }
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('images/logo.png'),
              width: 150,
              height: 150,
            ),
            SizedBox(
              height: 10.0,
            ),
            SpinKitWave(
              color: Colors.blue,
              size: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}

