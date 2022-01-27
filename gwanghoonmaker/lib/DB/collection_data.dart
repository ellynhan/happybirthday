import 'package:sqflite/sqflite.dart';

import 'db.dart';

Future<List<String>> getDB() async {
  final Database? _db = await DB.instance.database;
  final List<Map<String, dynamic>> _maps = await _db!.query('collection');
  List<String> result = [];
  String unlocked = "";
  String eggs = "";
  List.generate(_maps.length, (i) {
    unlocked = _maps[i]['unlocked'];
    eggs = _maps[i]['easter'];
    result.add(unlocked);
    result.add(eggs);
    print("getDB result1: ${unlocked}");
    print("getDB result2: ${eggs}");
    return "result";
  });
  return result;
}

Future<void> updateCollection(int index, int index2) async {
  final Database? _db = await DB.instance.database;
  List<String> unlockeds = await getDB();
  String unlocked = unlockeds[0];
  String egg = unlockeds[1];
  String updated = "";
  String updated2 = "";
  if(index != -1){
    for(int i=0; i<unlocked.length; i++){
      if(i==index){
        updated += '1';
      }else{
        updated += unlocked[i];
      }
    }
    await _db!.insert('collection', {'uid':'1', 'unlocked':updated, 'easter':egg}, conflictAlgorithm: ConflictAlgorithm.replace);
  }else{
    for(int i=0; i<5; i++){
      if(i==index2){
        updated2 += '1';
      }else{
        updated2 += egg[i];
      }
    }
    await _db!.insert('collection', {'uid':'1', 'unlocked':unlocked, 'easter':updated2}, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}