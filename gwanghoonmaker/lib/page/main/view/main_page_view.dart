import 'package:flutter/material.dart';
import 'package:gwanghoonmaker/DB/collection_data.dart';
import 'package:gwanghoonmaker/model/educated.dart';
import 'package:gwanghoonmaker/model/status.dart';
import 'package:gwanghoonmaker/page/education/view/edu_page_view.dart';
import 'package:gwanghoonmaker/page/result/view/result_page_view.dart';
import 'package:gwanghoonmaker/page/stat/stat_page_view.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({Key? key}) : super(key: key);

  @override
  _MainPageViewState createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  final globalKey = GlobalKey<ScaffoldState>();
  Status stat = Status();
  Educated educated = Educated();
  int week = 1;
  bool isEnding = false;
  int clicked = 0;
  int celebrateClicked = 0;
  List<String> pang = ["pang1", "model1", "model2", "model3", "model4", "model5"];//0 1 2 3 4 5 /5
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Padding(padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _titleText('$week / 25살'),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: GestureDetector(
                        child: Image.asset('assets/${pang[(clicked/5).toInt()]}.jpeg', scale: 3,),
                        onTap: (){
                          clicked+=1;
                          setState(() {});
                          if(clicked==25){
                            _update(2);
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              duration: Duration(milliseconds: 2000),
                              content: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  '이스터 에그 발견을 축하해!\n광훈이는 사실... 모델이야.\n그는 프로라구!',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ));
                          }
                          if(clicked==26){clicked=0;}
                        }
                      )
                  ),
                  Padding(padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    child: Text('정광훈\n🎉1998/01/25🎉',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20 + celebrateClicked*3
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onTap: (){
                      celebrateClicked += 1;
                      if(celebrateClicked == 5){
                        _update(4);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(milliseconds: 2000),
                          content: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              '으악!!\n이거 그만 커져야할 것 같은데!!\n이스터 에그 발견을 축하해!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ));
                      }
                      if(celebrateClicked == 6){
                        celebrateClicked = 0;
                      }
                      setState(() {});
                    }
                  )
                  ),
                  isEnding?
                  Center(
                    child: Container(
                      color: Colors.red,
                      child: TextButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultPageView(stats: stat, educated: educated),
                          ),
                        );
                      }, child: _buttonText('엔딩 보기')),
                    ),
                  ):Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StatPageView(stats: stat),
                          ),
                        );
                      }, child: _buttonText('능력치 확인')),
                      TextButton(onPressed: (){
                        _navigateAndDisplayEduResult(context);
                      }, child: _buttonText('교육하기'))
                    ],
                  )
                ],
              ),
              Positioned(
                top:50,
                right: 0,
                child: _backButton(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buttonText(text){
    return Text(text,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20
      ),
      textAlign: TextAlign.center,
    );
  }

  _titleText(text){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(text,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30
        ),
      ),
    );
  }

  _navigateAndDisplayEduResult(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EduPageView()),
    );
    String resultString = "";
    for (var value in result) {
      resultString += "${value}";
    }
    if(result!=null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(milliseconds: 500),
        content: _titleText("알차게 배웠습니다."),
      ));
      _specUp(result);
      _eduUp(result);
      _updateWeek();
    }
  }

  _updateWeek(){
    week += 5;
    if(week == 26){
      isEnding = true;
      week -= 1;
    }
    setState(() {});
  }

  _specUp(educations){
    stat.stress += 1;
    for (var edu in educations) {
      if(edu == "자연과학"){
        stat.intelligence += 2;
        stat.thinking += 1;
      }else if(edu == "검술"){
        stat.stamina += 1;
        stat.grace += 1;
      }else if(edu == "쉬기"){
        stat.stress = 0;
      }else if(edu == "마법"){
        stat.sensitive += 1;
        stat.intelligence += 1;
        stat.thinking += 1;
        stat.moral -= 1;
      }else if(edu == "시문학"){
        stat.sensitive += 3;
        stat.grace += 1;
        stat.thinking += 1;
      }else if(edu == "예법"){
        stat.grace += 2;
        stat.moral += 2;
        stat.charming += 1;
      }else if(edu == "무용"){
        stat.stamina += 1;
        stat.charming += 2;
        stat.grace -= 1;
      }else if(edu == "미술"){
        stat.sensitive += 2;
        stat.moral += 1;
      }else if(edu == "음악"){
        stat.sensitive += 1;
        stat.charming += 1;
        stat.stamina -= 1;
        stat.intelligence -=1;
      }
    }
  }

  _eduUp(educations){
    for (var edu in educations) {
      if(edu == "자연과학"){
        educated.study += 1;
      }else if(edu == "검술"){
        educated.sword += 1;
      }else if(edu == "마법"){
        educated.magic += 1;
      }else if(edu == "시문학"){
        educated.poem += 1;
      }else if(edu == "예법"){
        educated.polite += 1;
      }else if(edu == "무용"){
        educated.dance += 1;
      }else if(edu == "미술"){
        educated.draw += 1;
      }else if(edu == "음악"){
        educated.music += 1;
      }else if(edu == "쉬기"){
        educated.rest += 1;
      }
    }
  }

  _backButton(context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 80,
        height: 80,
        child: TextButton(
          child: const Text(
            '메인으로',
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

  _update(int index){
    updateCollection(-1,index);
  }
}
