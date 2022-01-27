import 'package:flutter/material.dart';

class EduPageView extends StatefulWidget {
  const EduPageView({Key? key}) : super(key: key);

  @override
  _EduPageViewState createState() => _EduPageViewState();
}

class _EduPageViewState extends State<EduPageView> {
  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Padding(padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _resultText('선택한 과목 5개: ${_showSelected()}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _button('자연과학',context),
                        _button('검술',context),
                        _button('마법',context),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _button('시문학',context),
                        _button('예법',context),
                        _button('무용',context),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _button('미술',context),
                        _button('음악',context),
                        _button('쉬기',context),
                      ],
                    ),
                  ],
                ),
              ),
              selected.length == 5 ? Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: _completeButton(context, selected),
              ):Container(),
              Positioned(
                top: 30,
                left: 0,
                right: 0,
                child: _backButton(context),
              )
            ],
          ),
        ),
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

  _button(text, context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 80,
        height: 80,
        child: TextButton(
          child: _buttonText(text),
          onPressed: (){
            if(selected.length < 5){
              selected.add(text);
              setState(() {});
            }
          },
        ),
        color: Colors.black12,
      ),
    );
  }

  _buttonText(text){
    return Text(text,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.black
      ),
      textAlign: TextAlign.center,
    );
  }

  _completeButton(context, result){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 80,
        height: 80,
        child: TextButton(
          child: const Text(
            '선택 완료',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
          onPressed: (){
            Navigator.pop(context,result);
          },
        ),
        color: Colors.black12,
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

  _showSelected(){
    String current = "";
    for (var value in selected) {
      current += "${value}  ";
    }
    return current;
  }
}

