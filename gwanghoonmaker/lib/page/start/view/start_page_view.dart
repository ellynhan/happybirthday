import 'package:flutter/material.dart';
import 'package:gwanghoonmaker/DB/collection_data.dart';
import 'package:gwanghoonmaker/model/collections.dart';
import 'package:gwanghoonmaker/page/collections/view/collection_page_view.dart';
import 'package:gwanghoonmaker/page/main/view/main_page_view.dart';

class StartPageView extends StatefulWidget {
  const StartPageView({Key? key}) : super(key: key);

  @override
  _StartPageViewState createState() => _StartPageViewState();
}

class _StartPageViewState extends State<StartPageView> {
  String text = "";
  int touched = 0;
  int topTouched = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Stack(
              children: [
                GestureDetector(
                    child: Container(
                        height:200,
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text('${text}', textAlign: TextAlign.center, style: TextStyle(fontSize:25, fontWeight: FontWeight.bold, color: Colors.amber))],)
                    ),
                    onTap: (){
                      topTouched+=1;
                      print(topTouched);
                      if(topTouched == 25){
                        setState(() {
                          text = "🎉HAPPY BIRTHDAY🎂\n정광훈의 생일을 축하합니다!";
                        });
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(milliseconds: 2000),
                          content: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              '이스터 에그 발견을 축하해!\n다시 한번 생일 축하해!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ));
                        _update(3);
                      }
                      if(topTouched == 26){
                        topTouched = 1;
                        setState(() {text = " ";});
                      }
                    }
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _titleText('GWANGHOON MAKER'),
                    _titleText('~정광훈 키우기 게임~'),
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainPageView()),
                        );
                      },
                      child: _buttonText('게임 시작하기'),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CollectionPageView()),
                        );
                      },
                      child: _buttonText('컬렉션'),
                    ),
                    TextButton(
                      onPressed: (){
                        touched ++;
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        if(touched != 6){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            duration: Duration(milliseconds: 1000),
                            content: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                '한재원 2022년 1월 24일 제작.\n팡훈아 25살 생일 진짜 축하한다!!',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ));
                        }else{
                          touched=0;
                          _update(0);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            duration: Duration(milliseconds: 5000),
                            content: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                '이스터 에그 발견을 축하해!\n 내가 광훈이 너를 알게된지 6년이 되어가고 있어.너처럼 매사에 최선을 다하고 친구들에게 진심으로 다가가주는 사람은 없었던 것 같아. 내가 입사를 하게되고, 너가 여전히 부산에 남아 더욱 학업에 정진하게 되어서 앞으로 2년은 자주 못보게 될 것 같아서 많이 아쉽다. 덕분에 정말 즐거운 대학 생활 했고 많은 추억을 남겼어! 항상 고마웠고, 생일 다시한번 축하해😊',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ));
                        }
                      },
                      child: _buttonText('제작자'),
                    ),
                  ],
                ),
              ],
            )
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
        textAlign: TextAlign.center,
      ),
    );
  }

  _update(int index){
    updateCollection(-1,index);
  }
}


