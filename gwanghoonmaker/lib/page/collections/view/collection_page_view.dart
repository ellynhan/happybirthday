import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gwanghoonmaker/DB/collection_data.dart';
import 'package:gwanghoonmaker/DB/db.dart';
import 'package:gwanghoonmaker/model/collections.dart';

class CollectionPageView extends StatefulWidget {
  const CollectionPageView({Key? key}) : super(key: key);

  @override
  _CollectionPageViewState createState() => _CollectionPageViewState();
}

class _CollectionPageViewState extends State<CollectionPageView> {
  List<String> items = ["ai.jpeg","badend.jpeg","fighter.jpeg","fire.jpeg","genius.jpeg", "guitar.jpeg", "harrypoter.png",
    "idol.jpeg", "noyeah.jpeg", "painter.jpeg", "pang1.jpeg", "sokpang.png", "sunbi.jpeg", "water.jpeg", "what.jpeg",
    "die.jpeg", "handsome.jpeg", "talker.jpeg",
  ];
  List<String> eggs = ["제작자가 남긴 긴 편지", "숨겨진 진실", "HE IS A MODEL", "HAPPY BIRTHDAY", "IT GROWS!"];
  String locked = "secret.jpeg";
  List<bool> unlockeds = [];
  List<bool> findEggs = [];
  String result = "";
  String result2 = "";
  int collected = 0;
  int findings = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top:100, left: 20, right: 20),
                  child:Column(
                    children: [
                      FutureBuilder(
                          future: _getUnlocked(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData == false) {
                              return CircularProgressIndicator();
                            }
                            else if (snapshot.hasError) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Error: ${snapshot.error}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              );
                            }
                            else {
                              result = snapshot.data[0].toString();
                              result2 = snapshot.data[1].toString();
                              collected = 0;
                              findings = 0;
                              for(int i=0; i<items.length; i++){
                                if(result[i]=='0'){
                                  unlockeds.add(false);
                                }else{
                                  unlockeds.add(true);
                                  collected += 1;
                                }
                              }
                              for(int i=0; i<5; i++){
                                if(result2[i]=='0'){
                                  findEggs.add(false);
                                }else{
                                  findEggs.add(true);
                                  findings += 1;
                                }
                              }
                              return Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: Text("✅ 지금까지 모은 엔딩 수: ${collected}/18개",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                    ),
                                    _CollectionsRow(0),
                                    _CollectionsRow(3),
                                    _CollectionsRow(6),
                                    _CollectionsRow(9),
                                    _CollectionsRow(12),
                                    _CollectionsRow(15),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Text("✅ 지금까지 찾은 이스터에그: ${findings}/5개",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Column(
                                        mainAxisAlignment:MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          _FindingItem(0),
                                          _FindingItem(1),
                                          _FindingItem(2),
                                          _FindingItem(3),
                                          _FindingItem(4),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                          }),
                    ],
                  )
                ),
              ),
              Positioned(
                top:10,
                right: 10,
                child: _backButton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _collectionItem(String name){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height:200,
        width: 100,
        child: Image.asset('assets/${name}',fit: BoxFit.contain),
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

  _getUnlocked() async {
    List<String> unlocked = await getDB();
    return unlocked;
  }

  _CollectionsRow(int index){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _collectionItem(unlockeds[index] ? items[index] : locked),
        _collectionItem(unlockeds[index+1] ? items[index+1] : locked),
        _collectionItem(unlockeds[index+2] ? items[index+2] : locked),
      ],
    );
  }

  _FindingItem(int index){
    return Text(
      '${index+1}. ${findEggs[index] ? eggs[index] : "?"}',
      style: TextStyle(fontSize: 20),
    );
  }
}