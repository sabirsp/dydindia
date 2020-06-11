import 'package:dydindia/count_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
class AnswerWidget extends StatefulWidget {
  final examData;
  final int sIndex;
  final int qIndex;
  final Questions question;
  AnswerWidget({this.examData,this.qIndex,this.sIndex,this.question});
  @override
  _AnswerWidgetState createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
   String  _selectedCard;

  //TODO:: Answer List
  List<Widget> answerList(){

    List<Widget> list=[];
    for(int i=0; i< widget.examData[widget.sIndex]['questions'][widget.qIndex]['answer_options'].length;i++){
      Padding padding = Padding(
        padding: const EdgeInsets.all(18.0),
        child:
        Card(
          color: _selectedCard == widget.examData[widget.sIndex]['questions'][widget.qIndex]['answer_options'][i]['option_id']  ? Colors.green.shade100 : Colors.white,
          child: ListTile(



            onTap: (){
              setState(() {
                _selectedCard = widget.examData[widget.sIndex]['questions'][widget.qIndex]['answer_options'][i]['option_id'];
                widget.question.changeStatus(status.attempted);
                widget.question.saveAnswer(_selectedCard);
              });
              //print(widget.examData[sIndex]['questions'][qIndex]['options'][i]);

            },
            title:
            Html(data: """ ${widget.examData[widget.sIndex]['questions'][widget.qIndex]['answer_options'][i]['answer_option']} """, useRichText: true,),



          ),
        ),

      );
      list.add(padding);
    }
    return list;
  }
  @override
  Widget build(BuildContext context) {
    return   Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: answerList() ,


    );
  }
}
