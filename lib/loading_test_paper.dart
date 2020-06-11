


import 'package:dydindia/count_down.dart';

import 'package:dydindia/services/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingTestPaper extends StatefulWidget {
  final String paper_id;
  final String duration;

  const LoadingTestPaper({this.paper_id,this.duration}) ;
  @override
  _LoadingTestPaperState createState() => _LoadingTestPaperState();
}

class _LoadingTestPaperState extends State<LoadingTestPaper> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nextScreen();
  }

  void qpaper(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {

            return CountDown();
          }
      ));
    });
  }

  void nextScreen() async {
    print(widget.paper_id);
    HTTPHelper helper = HTTPHelper(
        'http://dydindia.com/admin/api/getpaperdetails/?&paper_id=${widget.paper_id}');
    int rowCount = 0;
    var examData = await helper.getResponse();
    for (var k in examData) {
      rowCount++;
    }
    print(rowCount);
    //0.questions[0].question_text

    //print(examData[2]['questions'][0]['question_text']);
    print(examData[0]['questions'][118]['question_image'] );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return CountDown(examData: examData,duration: widget.duration,);
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

