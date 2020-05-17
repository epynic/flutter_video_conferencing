import 'dart:io';

import 'package:objectdb/objectdb.dart';
import 'package:path_provider/path_provider.dart';

class MeetingsDB {
  getPath() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = documentDirectory.path + '/meetings.db';
    return path;
  }

  add(item) async {
    final db = ObjectDB(await getPath());
    db.open();
    db.insert(item);
    db.tidy();
    await db.close();
  }

  remove(map) async {
    final db = ObjectDB(await getPath());
    db.open();
    db.remove(map);
    db.tidy();
    await db.close();
  }

  listAll() async {
    final db = ObjectDB(await getPath());
    db.open();
    List<Map> val = await db.find({});
    db.tidy();
    await db.close();
    return val;
  }
}
