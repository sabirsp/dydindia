import 'package:dydindia/calculator/scientificCalculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'dart:math' as math;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'design/answer_widget.dart';

enum  Options {a,b,c,d}

class CountDown extends StatefulWidget {
  final examData;
  final String duration;
  static List<Questions> questionDataList=[];
  CountDown({this.examData,this.duration});
  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> with TickerProviderStateMixin {



  TabController _tabController;
  AnimationController controller;
  int _currentPageIndex = 0;
  PageController _pageController;
  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  //TODO: tabs Widget List
  List<Text> sectionList(){
    List<Text> list = [];
    for(int i=0;i<widget.examData.length;i++){


      Text text = Text(widget.examData[i]['section_name']);
      list.add(text);
    }
    return list;
  }

  //TODO: TabbarView children widget List

  List<Widget> tabbarViewChildren(){
    List<Widget> list = [];
    for( int i=0; i<widget.examData.length;i++){

      SectionData sectiondata = SectionData(
        sIndex: i,
        examData: widget.examData,
        qIndex: _currentPageIndex,
      );

//      PageView page = PageView(
//        controller: _pageController,
//        children: questionList(i),
//      );
      list.add(sectiondata);
    }
    return list;
  }




  // TODO:: Question List
  List<ListView> questionList(int index){
    List<ListView> list = [];
    for(int i=0;i< widget.examData[index]['questions'].length;i++){
      ListView question =
      ListView(
        children: <Widget>[
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        FloatingActionButton(
                          heroTag: i ,
                          mini: true,
                          child: Text(widget.examData[index]['questions'][i]['question_no']),
                          backgroundColor: Colors.cyan,
                        ),
                        SizedBox( width: 8.0,),
                        Text(' +${widget.examData[index]['marks']}    -${widget.examData[index]['negative_marks']}'),

                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.warning),
                          onPressed: (){},
                        ),
                        IconButton(
                          icon: Icon(Icons.bookmark),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        /*TeXView(
                          teXHTML: widget.examData[index]['questions'][i]['question_text'] != null ?  widget.examData[index]['questions'][i]['question_text'] : '',
                          renderingEngine: RenderingEngine.Katex,  // Katex for fast render and MathJax for quality render.
                          onRenderFinished: (height) {
                            print("Widget Height is : $height");
                          },
                          onPageFinished: (string) {
                            print("Page Loading finished");
                          },


                        ),*/
                        Html(
                          data: """ ${widget.examData[index]['questions'][i]['question_text'] != null ?  widget.examData[index]['questions'][i]['question_text'] : ''} """,
                          useRichText: true,
                        ),


                        //Text(widget.examData[2]['questions'][0]['question_text'], textAlign: TextAlign.justify,
                        // style: TextStyle(fontSize: 16.0),),
                      ),
                      widget.examData[index]['questions'][i]['question_image'] != null  ? Image(image: NetworkImage('http://dydindia.com/qpaper/${widget.examData[index]['questions'][i]['question_image']}'),height: 100 ,):Text(''),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AnswerWidget(
            examData: widget.examData,
            qIndex: i,
            sIndex: index,
          ),


        ],
      );

      list.add(question);
    }
    return list;
  }

  //TODO:: Drawer Section List CReation

  List<ExpansionTile> drawerSectionList(){
    List<ExpansionTile> list = [];
    for(int i=0;i<widget.examData.length;i++){
      ExpansionTile expansionTile = ExpansionTile(
        title: Text(widget.examData[i]['section_name']),
        children: <Widget>[
          Divider(height: 1.0,color: Colors.grey,),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.star,size: 18, color: Colors.red,),
                SizedBox(width: 5.0,),
                Text('00', style: TextStyle(fontSize: 18),),
                SizedBox(width: 15.0,),
                Icon(FontAwesomeIcons.solidCircle,size: 18, color: Colors.cyan,),
                SizedBox(width: 5.0,),
                Text('00',style: TextStyle(fontSize: 18),),
                SizedBox(width: 15.0,),
                Icon(FontAwesomeIcons.solidCircle,size: 18, color: Colors.grey,),
                SizedBox(width: 5.0,),
                Text('00',style: TextStyle(fontSize: 18),),
                SizedBox(width: 15.0,),
                Icon(FontAwesomeIcons.circle,size: 18, color: Colors.grey,),
                SizedBox(width: 5.0,),
                Text('00',style: TextStyle(fontSize: 18),),
              ],
            ),
          ),
          Divider(height: 1.0,color: Colors.grey,),
          GridView.count(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 5.0,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 4),
            crossAxisCount: 4,
            children: endDrawerQuestions(i),
          )
        ],
      );

      list.add(expansionTile);

    }
    return list;
  }

  //TODO:: End Drawer Questions of Section
  List<FloatingActionButton> endDrawerQuestions( int index){
    List<FloatingActionButton> list = [];
    for(int i=0;i<widget.examData[index]['questions'].length;i++){
      FloatingActionButton button =   FloatingActionButton(
        heroTag: i,
        onPressed: (){

          _tabController.animateTo(index);


          setState(() {
            _currentPageIndex = i;
          });
          goToQuestion();

        },
        child:  Text(widget.examData[index]['questions'][i]['question_no']),
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey,
      ) ;
      list.add(button);
    }
    return list;
  }

  //TODO:: Go to Question

  void goToQuestion(){


      if(_pageController.hasClients){
        _pageController.jumpToPage(_currentPageIndex);
      }
      print(_currentPageIndex);


  }

  @override
  void initState() {
    print(widget.duration);
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: widget.examData.length,vsync: this);
    _pageController = PageController(initialPage: _currentPageIndex);

    controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: int.parse(widget.duration)),
    );

    controller.reverse(from: 1.0);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Text('Examination is timed out..'),
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {



    Color _selectedColor = Colors.green.shade100;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Container(
          margin: EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (BuildContext context, Widget child) {
                    return CustomPaint(
                      painter: TimerPainter(
                        animation: controller,
                        backgroundColor: Colors.white,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: FractionalOffset.center,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      AnimatedBuilder(
                        animation: controller,
                        builder: (BuildContext context, Widget child) {
                          return GestureDetector(
                            child: Icon(controller.isAnimating
                                ? Icons.pause
                                : Icons.play_arrow),
                            onTap: () {
                              if (controller.isAnimating) {
                                controller.stop();
                              } else {
                                controller.reverse(
                                  from: controller.value == 0.0
                                      ? 1.0
                                      : controller.value,
                                );
                              }
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Material(
              elevation: 50,
              color: Colors.black,
              child: AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget child) {
                  return Text(
                    timerString,
                    style: TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
            Material(
                elevation: 0,
                color: Colors.black,
                child: Text(
                  'WBCS Preli- Mock Test 01',
                  style: TextStyle(color: Colors.white70),
                )),
          ],
        ),
        bottom: TabBar(
          indicatorColor: Colors.white,
          isScrollable: true,
          controller: _tabController,
          onTap: (int i){
            setState(() {
              _currentPageIndex = 0;
            });
          },

          tabs: sectionList(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.calculator),
            onPressed: (){

               showDialog(context: context,

               builder: (BuildContext context){
                 return Container(

                    margin: EdgeInsets.symmetric(horizontal: 75, vertical: 100),
                     child:ScientificCalculator());
               });
            },
          ),
          IconButton(
            onPressed: (){
              _scaffoldKey.currentState.openEndDrawer();
            },
            icon: Icon(FontAwesomeIcons.slidersH, color: Colors.white,),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.red,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Mark for Review'),
                      SizedBox(
                        width: 30,
                      ),
                      Icon(
                        FontAwesomeIcons.solidCircle,
                        size: 18,
                        color: Colors.cyan,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Attempted'),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.solidCircle,
                        size: 18,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Mark for Review'),
                      SizedBox(
                        width: 30,
                      ),
                      Icon(
                        FontAwesomeIcons.circle,
                        size: 18,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Unseen'),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(
                height: 1,
                color: Colors.grey,
              ),
            ),

            SingleChildScrollView(
              child: Column(
                children: drawerSectionList(),
              ),
            ),
            Container(child: Center(child:
              RaisedButton(
                color: Colors.cyan,
                elevation: 3.0,
                onPressed: (){},
                child: Text('Submit'),
              ),),)
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Material(
          elevation: 3.0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.all(15.0),
                  onPressed: (){},
                  color: Colors.blue,
                  child: Text('Mark & Next', style: TextStyle(color: Colors.white),),
                ),
                RaisedButton(
                  padding: EdgeInsets.all(15.0),
                  onPressed: (){},
                  color: Colors.blue,
                  child: Text('Clear Response', style: TextStyle(color: Colors.white),),
                ),
                RaisedButton(
                  padding: EdgeInsets.all(15.0),
                  onPressed: (){
                   setState(() {

                     _currentPageIndex++;

                   });


                   print('Option: of ${CountDown.questionDataList[_currentPageIndex].question_id}${CountDown.questionDataList[_currentPageIndex].option_id}');
                   print('Status: ${CountDown.questionDataList[_currentPageIndex].answer_status}');
                  },
                  color: Colors.blue,
                  child: Text('Save & Next',style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabbarViewChildren(),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({this.animation, this.backgroundColor, this.color})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;

    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    // TODO: implement shouldRepaint
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }

  final Animation<double> animation;
  final Color backgroundColor, color;
}

class SectionData extends StatefulWidget {
  final examData;
  final int sIndex;
  final int qIndex;

  SectionData({this.examData,this.sIndex,this.qIndex});
  @override
  _SectionDataState createState() => _SectionDataState();
}

class _SectionDataState extends State<SectionData> with AutomaticKeepAliveClientMixin {

  PageController _pageController;

  List<ListView> questionList(int index){
    List<ListView> list = [];
    for(int i=0;i< widget.examData[index]['questions'].length;i++){
      Questions questionData = Questions(
        index: widget.qIndex,
        question_id: widget.examData[widget.sIndex]['questions'][i]['question_id'],
        question_no: widget.examData[widget.sIndex]['questions'][i]['question_no'],
        section_ndex: widget.sIndex,
      );
      CountDown.questionDataList.add(questionData);
      ListView question =
      ListView(
        children: <Widget>[
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        FloatingActionButton(
                          heroTag: i ,
                          mini: true,
                          child: Text(widget.examData[index]['questions'][i]['question_no']),
                          backgroundColor: Colors.cyan,
                        ),
                        SizedBox( width: 8.0,),
                        Text(' +${widget.examData[index]['marks']}    -${widget.examData[index]['negative_marks']}'),

                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.warning),
                          onPressed: (){},
                        ),
                        IconButton(
                          icon: Icon(Icons.bookmark),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        /*TeXView(
                          teXHTML: widget.examData[index]['questions'][i]['question_text'] != null ?  widget.examData[index]['questions'][i]['question_text'] : '',
                          renderingEngine: RenderingEngine.Katex,  // Katex for fast render and MathJax for quality render.
                          onRenderFinished: (height) {
                            print("Widget Height is : $height");
                          },
                          onPageFinished: (string) {
                            print("Page Loading finished");
                          },


                        ),*/
                        Html(
                          data: """ ${widget.examData[index]['questions'][i]['question_text'] != null ?  widget.examData[index]['questions'][i]['question_text'] : ''} """,
                          useRichText: true,
                        ),


                        //Text(widget.examData[2]['questions'][0]['question_text'], textAlign: TextAlign.justify,
                        // style: TextStyle(fontSize: 16.0),),
                      ),
                      widget.examData[index]['questions'][i]['question_image'] != null  ? Image(image: NetworkImage('http://dydindia.com/qpaper/${widget.examData[index]['questions'][i]['question_image']}'),height: 100 ,):Text(''),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AnswerWidget(
            examData: widget.examData,
            qIndex: i,
            sIndex: index,
            question: questionData,
          ),


        ],
      );

      list.add(question);
    }
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.qIndex);
    _pageController = PageController(initialPage: widget.qIndex);

  }
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: questionList(widget.sIndex),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class Questions{
  final int index;
  final int section_ndex;
  final String question_no;
  final String question_id;
  String option_id;
 status answer_status;

  Questions({this.index, this.section_ndex, this.question_no, this.question_id});
  void saveAnswer(String option){
    option_id = option;
  }
  void changeStatus(status newStatus){
    answer_status = newStatus;
  }
}

enum status{
  attempted,
  markforreview,
  bookmark,
  unseen,
  unattempted,
  seen
}