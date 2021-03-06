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
                          text = "๐HAPPY BIRTHDAY๐\n์ ๊ดํ์ ์์ผ์ ์ถํํฉ๋๋ค!";
                        });
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(milliseconds: 2000),
                          content: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              '์ด์คํฐ ์๊ทธ ๋ฐ๊ฒฌ์ ์ถํํด!\n๋ค์ ํ๋ฒ ์์ผ ์ถํํด!',
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
                    _titleText('~์ ๊ดํ ํค์ฐ๊ธฐ ๊ฒ์~'),
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainPageView()),
                        );
                      },
                      child: _buttonText('๊ฒ์ ์์ํ๊ธฐ'),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CollectionPageView()),
                        );
                      },
                      child: _buttonText('์ปฌ๋ ์'),
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
                                'ํ์ฌ์ 2022๋ 1์ 24์ผ ์ ์.\nํกํ์ 25์ด ์์ผ ์ง์ง ์ถํํ๋ค!!',
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
                                '์ด์คํฐ ์๊ทธ ๋ฐ๊ฒฌ์ ์ถํํด!\n ๋ด๊ฐ ๊ดํ์ด ๋๋ฅผ ์๊ฒ๋์ง 6๋์ด ๋์ด๊ฐ๊ณ  ์์ด.๋์ฒ๋ผ ๋งค์ฌ์ ์ต์ ์ ๋คํ๊ณ  ์น๊ตฌ๋ค์๊ฒ ์ง์ฌ์ผ๋ก ๋ค๊ฐ๊ฐ์ฃผ๋ ์ฌ๋์ ์์๋ ๊ฒ ๊ฐ์. ๋ด๊ฐ ์์ฌ๋ฅผ ํ๊ฒ๋๊ณ , ๋๊ฐ ์ฌ์ ํ ๋ถ์ฐ์ ๋จ์ ๋์ฑ ํ์์ ์ ์งํ๊ฒ ๋์ด์ ์์ผ๋ก 2๋์ ์์ฃผ ๋ชป๋ณด๊ฒ ๋  ๊ฒ ๊ฐ์์ ๋ง์ด ์์ฝ๋ค. ๋๋ถ์ ์ ๋ง ์ฆ๊ฑฐ์ด ๋ํ ์ํ ํ๊ณ  ๋ง์ ์ถ์ต์ ๋จ๊ฒผ์ด! ํญ์ ๊ณ ๋ง์ ๊ณ , ์์ผ ๋ค์ํ๋ฒ ์ถํํด๐',
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
                      child: _buttonText('์ ์์'),
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


