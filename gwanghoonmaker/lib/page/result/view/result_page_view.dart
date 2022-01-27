import 'package:flutter/material.dart';
import 'package:gwanghoonmaker/DB/collection_data.dart';
import 'package:gwanghoonmaker/main.dart';
import 'package:gwanghoonmaker/model/educated.dart';
import 'package:gwanghoonmaker/model/status.dart';

class ResultPageView extends StatelessWidget {
  ResultPageView({Key? key, required this.stats, required this.educated}) : super(key: key);
  List<String> items = ["ai.jpeg","badend.jpeg","fighter.jpeg","fire.jpeg","genius.jpeg", "guitar.jpeg", "harrypoter.png",
    "idol.jpeg", "noyeah.jpeg", "painter.jpeg", "pang1.jpeg", "sokpang.png", "sunbi.jpeg", "water.jpeg", "what.jpeg",
    "die.jpeg", "handsome.jpeg", "talker.jpeg",
  ];
  List<String> texts = [
    "AI와 동화된 천재 수석 엔지니어","허걱!!! ⚠️번아웃⚠️\n 더 많은 휴식을 주세요!","정팡훈 그는 목장갑만으로 무협지존",
    "불멍을 즐기는 팡훈", "세기의 인재, 더 지니어스 정광훈", "모든 것을 쏟아부은 줠라 멋진 기타&보컬리스트",
    "아즈카반에 수감된 팡훈이", "우리집으로 가자🎶 장기자랑 휩쓰는 광훈이", "교수님의 총애를 받는 대학원생",
    "드디어..!! 그림에 소질이 붙은 광훈이", "평범한 팡훈이", "팡크라테스",
    "선비", "광안바다 파도 물멍을 즐길 줄 아는 낭만가", "엥? 내가 뭘 배웠더라..",
    '"지금부터 서로 죽여라."', "정말 잘생겼다 정잘생.", "몰입도 1000% 최고의 이야기꾼"
  ];
  final Status stats;
  final Educated educated;
  String resultTextContent = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _resultText('내가 키운 25살 팡훈이는..'),
                Center(
                    child: _checkEduResult(),
                ),
                _resultText(resultTextContent)
              ],
            ),
            Positioned(
              top:10,
              right: 10,
              child: _backButton(context),
            ),
            Positioned(
              bottom:50,
              right: 0,
              left:0,
              child: _alertText('개발자: 공유기능 어케 넣는지 아직 공부안해서 모름. 결과는 스샷해서 공유ㄱ'),
            ),
          ],
        ),
      ),
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
            Navigator.popUntil(context, ModalRoute.withName("/"));
          },
        ),
        color: Colors.black12,
      ),
    );
  }

  _alertText(text){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(text,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 8
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _resultText(text){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(text,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _checkResult(){
    if(stats.sensitive>=25&&stats.charming>=25&&stats.stamina==-25&&stats.intelligence==-25){
      resultTextContent = "배고프지만 줠라 멋있는 기타&보컬리스트";
      return Image.asset('assets/guitar.jpeg', scale: 3,);
    }else if(stats.sensitive>=50 && stats.moral>=25){
      resultTextContent = "드디어 그림에 소질이 붙은 광훈이";
      return Image.asset('assets/painter.jpeg', scale: 3,);
    }else if(stats.stamina==25 && stats.charming==50 && stats.grace==-25){
      resultTextContent = "우리집에 가자며 장기자랑 휩쓰는 광훈이";
      return Image.asset('assets/idol.jpeg', scale: 3,);
    }else if(stats.grace==50 &&stats.moral==50 && stats.charming==25){
      resultTextContent = "교수님의 총애를 받는 대학원생";
      return Image.asset('assets/noyeah.jpeg', scale: 3,);
    }else if(stats.sensitive==75 && stats.grace==25){
      resultTextContent = "팡크라테스";
      return Image.asset( 'assets/sokpang.png', scale: 4,);
    }else if(stats.sensitive==25 && stats.intelligence==25 && stats.moral==-25){
      resultTextContent = "아즈카반에 수감된 팡훈이";
      return Image.asset('assets/harrypoter.png', scale: 3,);
    }else if(stats.stamina == 25 && stats.grace==25){
      resultTextContent = "어쩌면 무협지존 정팡훈";
      return Image.asset('assets/fighter.jpeg', scale: 3,);
    }else if(stats.intelligence==50){
      resultTextContent = "AI와 동화되버린 천재 수석 엔지니어";
      return Image.asset('assets/ai.jpeg', scale: 3,);
    }else if(stats.moral >= 15 && stats.grace >= 10){
      resultTextContent = "선비";
      return Image.asset('assets/sunbi.jpeg', scale: 3,);
    }else if(stats.sensitive >= 15 && stats.moral<=15){
      resultTextContent = "불멍을 즐기는 팡훈";
      return Image.asset('assets/fire.jpeg', scale: 3,);
    }else if(stats.sensitive >= 15){
      resultTextContent = "물멍을 즐길 줄 아는 사람";
      return Image.asset('assets/water.jpeg', scale: 3,);
    }else{
      resultTextContent = "평범한 팡훈이";
      return Image.asset('assets/pang1.jpeg', scale: 3,);
    }
  }

  _checkEduResultItem(int index){
    resultTextContent = texts[index];
    _update(index);
    print(items[index]);
    return Image.asset('assets/${items[index]}', scale: 3);
  }

  _checkEduResult(){
    if(educated.rest < 4){
      return _checkEduResultItem(1);
    }else if(educated.music >= 12){
      return _checkEduResultItem(5);
    }else if(educated.draw >= 12){
      return _checkEduResultItem(9);
    }else if(educated.dance >= 12){
      return _checkEduResultItem(7);
    }else if(educated.polite >= 12){
      return _checkEduResultItem(8);
    }else if(educated.poem >= 12){
      return _checkEduResultItem(11);
    }else if(educated.magic >= 12){
      return _checkEduResultItem(6);
    }else if(educated.sword >= 12){
      return _checkEduResultItem(2);
    }else if(educated.rest >= 12){
      return _checkEduResultItem(14);
    }else if(educated.study >= 12){
      return _checkEduResultItem(0);
    }else if(educated.polite >= 9){
      return _checkEduResultItem(12);
    }else if(educated.poem >= 9){
      return _checkEduResultItem(3);
    }else if(educated.music >= 9){
      return _checkEduResultItem(13);
    }else if(educated.study>=9 && educated.magic>=1 && educated.poem>=4 && educated.draw>=3 && educated.music>=3){
      return _checkEduResultItem(4);
    }else if(educated.sword>=5 && educated.magic>=5 && educated.dance>=2 && educated.draw >=2){
      return _checkEduResultItem(15);
    }else if(educated.dance>=5 && educated.polite >= 5 && educated.music >= 5){
      return _checkEduResultItem(16);
    }else if(educated.poem >= 9 && educated.magic >= 6 && educated.study >= 5){
      return _checkEduResultItem(17);
    }else{
      return _checkEduResultItem(10);
    }
  }

  _update(int index){
    updateCollection(index,-1);
  }
}

