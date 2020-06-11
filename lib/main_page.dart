import 'package:dydindia/constants.dart';
import 'package:dydindia/question_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.purple,
                Colors.blue,
              ],
              begin: Alignment.topLeft,
              stops: [0.0, 1.0])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: <Widget>[
            Padding(
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
            Container(
              child: Center(
                child: Text(
                  'eAcademy',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
              child: Center(
                child: Text(
                  'Online Mock Tests',
                  style: TextStyle(
                    color: kWhiteColor,
                   // fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              padding: EdgeInsets.only(top: 30.0),
              height: MediaQuery.of(context).size.height - 200.0,
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
              ),
              child: ListView(
                primary: false,
                padding: EdgeInsets.only(
                  left: 20.0,
                ),
                children: <Widget>[
                  TestItem(
                    avatorColor: Colors.green,
                    iconData: Icons.play_arrow,
                    imageProvider: AssetImage('images/logo.png'),
                    testText: 'WBCS Preliminary',
                    onPress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return QuestionPaper(paperName: 'WBCS Preli Mock Test',);
                      }));
                    },
                  ),
                  TestItem(
                    avatorColor: Colors.green,
                    iconData: Icons.play_arrow,
                    imageProvider: AssetImage('images/logo.png'),
                    testText: 'WBCS Preliminary',
                    onPress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return QuestionPaper(paperName: 'WBCS Preli Mock Test',);
                      }));
                    },
                  ),
                  TestItem(
                    avatorColor: Colors.green,
                    iconData: Icons.play_arrow,
                    imageProvider: AssetImage('images/logo.png'),
                    testText: 'WBCS Preliminary',
                    onPress: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                      return QuestionPaper(paperName: 'WBCS Preli Mock Test',);}));

                    },
                  ),
                  TestItem(
                    avatorColor: Colors.green,
                    iconData: Icons.play_arrow,
                    imageProvider: AssetImage('images/logo.png'),
                    testText: 'WBCS Preliminary',
                    onPress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return QuestionPaper(paperName: 'WBCS Preli Mock Test',);
                      }));
                    },
                  ),
                  TestItem(
                    avatorColor: Colors.green,
                    iconData: Icons.play_arrow,
                    imageProvider: AssetImage('images/logo.png'),
                    testText: 'WBCS Preliminary',
                    onPress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return QuestionPaper(paperName: 'WBCS Preli Mock Test',);
                      }));
                    },
                  ),
                  TestItem(
                    avatorColor: Colors.green,
                    iconData: Icons.play_arrow,
                    imageProvider: AssetImage('images/logo.png'),
                    testText: 'WBCS Preliminary',
                    onPress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return QuestionPaper(paperName: 'WBCS Preli Mock Test',);
                      }));
                    },
                  ),
                  TestItem(
                    avatorColor: Colors.green,
                    iconData: Icons.play_arrow,
                    imageProvider: AssetImage('images/logo.png'),
                    testText: 'WBCS Preliminary',
                    onPress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return QuestionPaper(paperName: 'WBCS Preli Mock Test',);
                      }));
                    },
                  ),
                  TestItem(
                    avatorColor: Colors.green,
                    iconData: Icons.play_arrow,
                    imageProvider: AssetImage('images/logo.png'),
                    testText: 'WBCS Preliminary',
                    onPress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return QuestionPaper(paperName: 'WBCS Preli Mock Test',);
                      }));
                    },
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TestItem extends StatelessWidget {
  final ImageProvider imageProvider;
  final String testText;
  final Color avatorColor;
  final IconData iconData;
  final Function onPress;

  TestItem({ this.imageProvider, this.onPress, this.testText, this.avatorColor, this.iconData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, right: 10.0),
        child: Card(
          elevation: 20.0,
          child: Container(
            padding: EdgeInsets.only(right: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image(
                  image: imageProvider,
                  width: 80.0,
                  height: 80.0,
                  fit: BoxFit.contain,
                ),
                Text(testText),
                CircleAvatar(
                    backgroundColor: avatorColor,
                    radius: 20.0,
                    child: IconButton(
                      icon: Icon(
                        iconData,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
