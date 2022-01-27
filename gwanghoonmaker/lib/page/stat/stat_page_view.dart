import 'package:flutter/material.dart';
import 'package:gwanghoonmaker/DB/collection_data.dart';
import 'package:gwanghoonmaker/model/status.dart';

class StatPageView extends StatelessWidget {
  StatPageView({Key? key, required this.stats}) : super(key: key);
  final Status stats;
  List<bool> clicked = [];
  @override
  Widget build(BuildContext context) {
    clicked = [false,false,false,false,false,false,false,false];
    print(stats.charming);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _statText("근력   :   ${stats.stamina}", 0, context),
                  _statText("기품   :   ${stats.grace}", 1, context),
                  _statText("도덕성  :   ${stats.moral}", 2, context),
                  _statText("매력   :   ${stats.charming}", 3, context),
                  _statText("감수성  :   ${stats.sensitive}", 4, context),
                  _statText("지능   :   ${stats.intelligence}", 5, context),
                  _statText("추리력  :   ${stats.thinking}", 6, context),
                  _statText("스트레스  :   ${stats.stress}", 7, context),
                ],
              ),
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: _backButton(context),
              )
            ],
          )
        ),
      ),
    );
  }
  _statText(text, index, context){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        elevation: 0,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Text(text,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),
          textAlign: TextAlign.center,
        ),
        onPressed: (){
          clicked[index]=true;
          int cnt = 0;
          for(int i=0; i<8; i++){
            if(clicked[i] == true){
              cnt += 1;
            }
          }
          if(cnt == 8){
            _update(1,context);
          }
        },
      )
    );
  }

  _backButton(context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 80,
        height: 80,
        child: TextButton(
          child: const Text(
          '돌아가기',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        color: Colors.black12,
      ),
    );
  }

  _update(int index, context){
    updateCollection(-1,index);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      duration: Duration(milliseconds: 2000),
      content: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          '이스터 에그 발견을 축하해!\n숨겨진 진실을 얘기하자면,\n능력치는 엔딩에 전혀 상관없어!',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ));
    clicked = [false,false,false,false,false,false,false,false];
  }
}

