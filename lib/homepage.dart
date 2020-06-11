import 'package:dydindia/all_exams.dart';
import 'package:dydindia/constants.dart';
import 'package:dydindia/design/popular_test.dart';
import 'package:dydindia/main_page.dart';
import 'package:dydindia/services/network_helper.dart';
import 'package:dydindia/tests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'design/menu_icon_button.dart';

class HomePage extends StatefulWidget {
  HomePage({this.examData, this.rowCount});
  final examData;
  final int rowCount;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Tests> popularTestsPage1 = [
    Tests(testImage: AssetImage('images/logo.png'), testName: 'Railway'),
    Tests(testImage: AssetImage('images/logo.png'), testName: 'RRB'),
    Tests(testImage: AssetImage('images/logo.png'), testName: 'SSC Preli'),
  ];

  List<Tests> popularTestsPage2 = [
    Tests(
        testImage: AssetImage('images/logo.png'), testName: 'Primary Teacher'),
    Tests(testImage: AssetImage('images/logo.png'), testName: 'WBCS Preli'),
    Tests(testImage: AssetImage('images/logo.png'), testName: 'WBCS Main'),
  ];

  List<PopularCourse> courseList = [
    PopularCourse(),
    PopularCourse(),
    PopularCourse(),
    PopularCourse(),
    PopularCourse(),
    PopularCourse(),
    PopularCourse(),
    PopularCourse(),
    PopularCourse(),
    PopularCourse(),
  ];

  List<Widget> popularExamUI() {
    List<Widget> list = [];
    if (widget.rowCount >= 3) {
      String exam_name1 = widget.examData[0]['exam_name'];
      String imageFileName1 = widget.examData[0]['exam_image'];
      ImageProvider exam_image1 =
          NetworkImage('http://dydindia.com/admin/image/$imageFileName1');
      String exam_name2 = widget.examData[1]['exam_name'];
      String imageFileName2 = widget.examData[1]['exam_image'];
      ImageProvider exam_image2 =
          NetworkImage('http://dydindia.com/admin/image/$imageFileName2');
      String exam_name3 = widget.examData[2]['exam_name'];
      String imageFileName3 = widget.examData[2]['exam_image'];
      ImageProvider exam_image3 =
          NetworkImage('http://dydindia.com/admin/image/$imageFileName3');

      TestCard card1 = TestCard(
        exam_image: exam_image1,
        exam_name: exam_name1,
      );
      TestCard card2 = TestCard(
        exam_image: exam_image2,
        exam_name: exam_name2,
      );
      TestCard card3 = TestCard(
        exam_image: exam_image3,
        exam_name: exam_name3,
      );

      list.add(card1);
      list.add(card2);
      list.add(card3);
    } else if (widget.rowCount == 2) {
      String exam_name1 = widget.examData[0]['exam_name'];
      String imageFileName1 = widget.examData[0]['exam_image'];
      ImageProvider exam_image1 =
          NetworkImage('http://dydindia.com/admin/image/$imageFileName1');
      String exam_name2 = widget.examData[1]['exam_name'];
      String imageFileName2 = widget.examData[1]['exam_image'];
      ImageProvider exam_image2 =
          NetworkImage('http://dydindia.com/admin/image/$imageFileName2');

      TestCard card1 = TestCard(
        exam_image: exam_image1,
        exam_name: exam_name1,
      );
      TestCard card2 = TestCard(
        exam_image: exam_image2,
        exam_name: exam_name2,
      );

      list.add(card1);
      list.add(card2);
    } else if (widget.rowCount == 1) {
      String exam_name1 = widget.examData[0]['exam_name'];
      String imageFileName1 = widget.examData[0]['exam_image'];
      ImageProvider exam_image1 =
          NetworkImage('http://dydindia.com/admin/image/$imageFileName1');

      TestCard card1 = TestCard(
        exam_image: exam_image1,
        exam_name: exam_name1,
      );

      list.add(card1);
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> itemList = [
      PopularTestItem(testItem: popularTestsPage1),
      PopularTestItem(testItem: popularTestsPage1),
    ];

    List<ImageProvider> imageProviderList = [
      AssetImage('images/slider1.png'),
      AssetImage('images/slider1.png'),
    ];

    List<Widget> menuButtons = [
      MenuIconButton(
        textColor: kprimaryThemeColor,
        iconColor: kWhiteColor,
        avatarColor: kprimaryThemeColor,
        buttonText: 'Video Lectures',
        iconData: FontAwesomeIcons.solidFileVideo,
      ),
      SizedBox(
        width: 10.0,
      ),
      MenuIconButton(
        textColor: kprimaryThemeColor,
        iconColor: kWhiteColor,
        avatarColor: kprimaryThemeColor,
        buttonText: 'Video Lectures',
        iconData: FontAwesomeIcons.solidFileVideo,
      ),
      SizedBox(
        width: 10.0,
      ),
      MenuIconButton(
        textColor: kprimaryThemeColor,
        iconColor: kWhiteColor,
        avatarColor: kprimaryThemeColor,
        buttonText: 'Video Lectures',
        iconData: FontAwesomeIcons.solidFileVideo,
      ),
      SizedBox(
        width: 10.0,
      ),
      MenuIconButton(
        textColor: kprimaryThemeColor,
        iconColor: kWhiteColor,
        avatarColor: kprimaryThemeColor,
        buttonText: 'Video Lectures',
        iconData: FontAwesomeIcons.solidFileVideo,
      ),
      SizedBox(
        width: 10.0,
      ),
      MenuIconButton(
        textColor: kprimaryThemeColor,
        iconColor: kWhiteColor,
        avatarColor: kprimaryThemeColor,
        buttonText: 'Video Lectures',
        iconData: FontAwesomeIcons.solidFileVideo,
      ),
      SizedBox(
        width: 10.0,
      ),
      MenuIconButton(
        textColor: kprimaryThemeColor,
        iconColor: kWhiteColor,
        avatarColor: kprimaryThemeColor,
        buttonText: 'Video Lectures',
        iconData: FontAwesomeIcons.solidFileVideo,
      ),
      SizedBox(
        width: 10.0,
      ),
      MenuIconButton(
        textColor: kprimaryThemeColor,
        iconColor: kWhiteColor,
        avatarColor: kprimaryThemeColor,
        buttonText: 'Video Lectures',
        iconData: FontAwesomeIcons.solidFileVideo,
      ),
    ];

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
        appBar: AppBar(
          centerTitle: true,
          title: Text('eAcademy'),
          backgroundColor: Colors.transparent,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              color: Colors.white70,
              child: CarouselSlider(
                height: 300.0,
                autoPlay: true,
                items: imageProviderList.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(
                            image: i,
                            fit: BoxFit.fill,
                            width: 400,
                            height: 280,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Material(
              elevation: 15.0,
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                color: Colors.white,
                child: SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      horizontalListItem(
                        iconData: Icons.play_arrow,
                        avatorColor: Colors.blue,
                        textString: 'Videos',
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      horizontalListItem(
                        iconData: FontAwesomeIcons.lightbulb,
                        textString: 'Quizes',
                        avatorColor: Colors.purple,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      horizontalListItem(
                        iconData: Icons.note,
                        avatorColor: Colors.green,
                        textString: 'Study Materials',
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      horizontalListItem(
                        iconData: FontAwesomeIcons.solidStickyNote,
                        avatorColor: Colors.blue,
                        textString: 'Test Series',
                      ),
                      horizontalListItem(
                        iconData: Icons.mouse,
                        avatorColor: Colors.red,
                        textString: 'Mock Tests',
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      horizontalListItem(
                        iconData: FontAwesomeIcons.lightbulb,
                        textString: 'Quizes',
                        avatorColor: Colors.purple,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // TODO: Test Card Starts
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Material(
                elevation: 20.0,
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Suggested Test Series',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return AllExams(
                                    examData: widget.examData,
                                  );
                                }));
                              },
                              child: Text(
                                'View All',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                        ),
                      ),
                      Container(
                        child: Column(
                          children: popularExamUI(),
                        ),
                      ),

                      /*Container(
                        child: SizedBox(
                          height: 300,
                          child: Swiper(
                            autoplay: true,
                            viewportFraction: 1.0,
                            itemCount: courseList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return courseList[index];
                            },
                          ),
                        ),
                      ),*/
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Material(
                elevation: 20.0,
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Popular Courses',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return MainPage();
                                }));
                              },
                              child: Text(
                                'View All',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                        ),
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                        elevation: 30.0,
                        child: Container(
                          padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                          margin: EdgeInsets.only(top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(children: <Widget>[
                                      Image(
                                        image: AssetImage('images/logo.png'),
                                        width: 150,
                                        height: 180,
                                      ),
                                      Text('Primary Tet'),
                                    ]),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Column(children: <Widget>[
                                      Image(
                                        image: AssetImage('images/logo.png'),
                                        width: 150,
                                        height: 180,
                                      ),
                                      Text('Primary Tet'),
                                    ]),
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(children: <Widget>[
                                      Image(
                                        image: AssetImage('images/logo.png'),
                                        width: 150,
                                        height: 180,
                                      ),
                                      Text('Primary Tet'),
                                    ]),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Column(children: <Widget>[
                                      Image(
                                        image: AssetImage('images/logo.png'),
                                        width: 150,
                                        height: 180,
                                      ),
                                      Text('Primary Tet'),
                                    ]),
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(children: <Widget>[
                                      Image(
                                        image: AssetImage('images/logo.png'),
                                        width: 150,
                                        height: 180,
                                      ),
                                      Text('Primary Tet'),
                                    ]),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Column(children: <Widget>[
                                      Image(
                                        image: AssetImage('images/logo.png'),
                                        width: 150,
                                        height: 180,
                                      ),
                                      Text('Primary Tet'),
                                    ]),
                                  ]),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//TODO test card
class TestCard extends StatelessWidget {
  final String exam_name;
  final ImageProvider exam_image;
  TestCard({this.exam_name, this.exam_image});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image(
              image: exam_image,
              width: 80,
              height: 80,
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(
                exam_name,
                style: TextStyle(color: Colors.green.shade900, fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class horizontalListItem extends StatelessWidget {
  final IconData iconData;
  final Color avatorColor;
  final String textString;

  const horizontalListItem({this.iconData, this.avatorColor, this.textString});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: avatorColor,
            radius: 20.0,
            child: IconButton(
              icon: Icon(iconData),
              color: Colors.white,
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(textString),
        ],
      ),
    );
  }
}

class PopularCourse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 10.0),
      child: Card(
        elevation: 20.0,
        child: Container(
          padding: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image(
                image: AssetImage('images/logo.png'),
                width: 80.0,
                height: 80.0,
                fit: BoxFit.contain,
              ),
              Text('WBCS Preli'),
              CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 20.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 10.0),
      child: Card(
        elevation: 20.0,
        child: Container(
          padding: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image(
                image: AssetImage('images/logo.png'),
                width: 80.0,
                height: 80.0,
                fit: BoxFit.contain,
              ),
              Text('WBCS Preli'),
              CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 20.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
