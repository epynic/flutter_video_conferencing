import 'package:flutter/material.dart';
import 'package:near/database_meetings.dart';
import 'package:uuid/uuid.dart';

class MeetingsProvider extends ChangeNotifier {
  var db = MeetingsDB();
  List _all_meetings = [];

  List get listMeetings {
    return [..._all_meetings];
  }

  addMeeting(name) async {
    var uuid = Uuid();
    var meetid = uuid.v1();
    await db.add({'name': name, 'meeting': meetid.split('-')[0]});
    await getAll();
    notifyListeners();
  }

  getAll() async {
    List meet;
    meet = await db.listAll();
    _all_meetings = meet;
    notifyListeners();
  }

  removeMeeting(meetingid) async {
    print(meetingid);
    await db.remove({'meeting': meetingid});
    await getAll();
  }
}
