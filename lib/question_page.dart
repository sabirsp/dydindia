import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';

class QuestionPaper extends StatefulWidget {
  final String paperName;
  QuestionPaper({this.paperName});
  @override
  _QuestionPaperState createState() => _QuestionPaperState();
}

class _QuestionPaperState extends State<QuestionPaper>
    with TickerProviderStateMixin {
  Timer _timer;
  int _start = 120 * 60;
  int _selectedQuestion;
  String _currentSection = 'Section A';
  List<String> sections = ['Section A', 'Section B', 'Section C'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) =>
          setState(
                () {
              if (_start < 1) {
                timer.cancel();
              } else {
                _start = _start - 1;
              }
            },
          ),
    );
  }

  List<String> _printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }
    List<String> list = [];
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    //return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    list.add(twoDigits(duration.inHours));
    list.add(twoDigitMinutes);
    list.add(twoDigitSeconds);
    return list;

  }

  void updateQestionNo(int newValue) {
    setState(() {
      _selectedQuestion = newValue;
    });
    Fluttertoast.showToast(msg: 'Question No $_selectedQuestion selected',
    toastLength: Toast.LENGTH_SHORT);
  }

  List<Widget> questionUI(){
    int _total_qestion=15;
    List<Widget> list=[];
    for(int i=1;i<=_total_qestion;i++){
      QuestionNo q = QuestionNo(qno: i,onPressed: (){
        updateQestionNo(i);
      },);
      list.add(q);
      list.add(SizedBox(width: 10.0,));
    }

    return list;
  }

  List<Widget> sectionUI(){
    List<String> qsection = [
      'Aptitude',
      'Logic and Reasoning',
      'General Knowledge'
    ];
    List<Widget> list = [];
    for(int i=0;i<qsection.length;i++){
      FlatButton flatButton = FlatButton(
        onPressed: (){
          //loadSection(qsection[i]);
          setState(() {
            _currentSection = qsection[i];
          });
        },
        child: Text(qsection[i],
        style: TextStyle(
          color: _currentSection == qsection[i]?Colors.black:Colors.grey,
        ),),

      );
      list.add(flatButton);
    }
    return list;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.purple.shade400,

            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.home),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Time Remaining',style: TextStyle(
                        color:Colors.white,
                        fontSize: 16.0,
                      ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TimeRemaining(
                            identifier: 'H',
                            val: _printDuration(Duration(seconds: _start))[0],
                          ),
                          TimeRemaining(
                            identifier: 'M',
                            val: _printDuration(Duration(seconds: _start))[1],
                          ),
                          TimeRemaining(
                            identifier: 'S',
                            val: _printDuration(Duration(seconds: _start))[2],
                          ),



                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        IconButton(
                          icon: Icon(Icons.filter_list),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.menu),
                          color: kWhiteColor,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),  
          ),
          Container(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('WBCS',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal
                    ) ,),
                  Text(widget.paperName,
                  style: TextStyle(
                    color: Colors.green.shade900,
                    fontSize: 16.0,
                  ),),


                ],
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: Card(
              elevation: 20,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: sectionUI(),

              ),
            ),
          ),
          SizedBox(
            height: 150,
            child: Card(
              elevation: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  DropdownButton(
                    hint: Text('Go To Section'),
                    onChanged: (String newValue) {
                      setState(() {
                        _currentSection = newValue;
                      });
                    },
                    items:
                    sections.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Container(
                    child: Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: questionUI(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height-150,
            child: Container
              (
              color: Colors.red,
              child: Column(
                children: <Widget>[
                  Image(image: AssetImage('images/chem1.PNG'),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeRemaining extends StatelessWidget {
  TimeRemaining({this.identifier, this.val});
  final String identifier;
  final String val;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[

          Container(

            decoration: BoxDecoration(

              shape: BoxShape.circle,
              color: Colors.white,


            ),
            child: Text(val, style: TextStyle(
              fontSize: 18.0,
            ),),
            padding: EdgeInsets.all(8.0),

          ),
          SizedBox(height: 3.0,),
          Text(identifier, style: TextStyle(color: Colors.white),),
        ],
      ),
    );
  }
}

class QuestionNo extends StatelessWidget {
    QuestionNo({this.qno, this.onPressed});
    final int qno;
    final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.black,
        child: Text(
          qno.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
