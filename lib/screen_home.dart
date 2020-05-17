import 'package:flutter/material.dart';
import 'package:near/provider_meeting.dart';
import 'package:provider/provider.dart';

import 'package:share/share.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  String _formMeetingName = '';
  bool _isLoading = true;

  @override
  void initState() {
    Provider.of<MeetingsProvider>(context, listen: false).getAll();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MeetingsProvider>(
      builder: (BuildContext context, meetingProvider, Widget child) {
        print(meetingProvider.listMeetings);

        return Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                padding:
                    EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                onPressed: () => _meetingForm(context),
                child: Text(
                  'New Conference',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: meetingProvider.listMeetings.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(meetingProvider.listMeetings[index]['name']),
                      subtitle:
                          Text(meetingProvider.listMeetings[index]['meeting']),
                      trailing: Wrap(
                        children: <Widget>[
                          FlatButton(
                            onPressed: () => meetingProvider.removeMeeting(
                                meetingProvider.listMeetings[index]['meeting']),
                            child: Text('Delete'),
                          ),
                          FlatButton(
                              onPressed: () => {
                                    Share.share(
                                        'Join me MeetingID: ' +
                                            meetingProvider.listMeetings[index]
                                                ['meeting'])
                                  },
                              child: Text('Share')),
                          FlatButton(
                              onPressed: () => _joinMeeting(meetingProvider
                                  .listMeetings[index]['meeting']),
                              child: Text('Join'))
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _joinMeeting(meetingid) async {
    try {
      var options = JitsiMeetingOptions()..room = meetingid;

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  _meetingForm(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Wrap(
                  children: <Widget>[
                    TextFormField(
                      onSaved: (value) => _formMeetingName = value,
                      decoration: InputDecoration(labelText: "Meeting Name"),
                      validator: (value) {
                        if (value.isEmpty) return "Enter Meeting Name";
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              RaisedButton(
                onPressed: () => _createMeeting(context),
                child: Text('Create Meeting'),
              )
            ],
          ),
        ),
      ),
    );
  }

  _createMeeting(context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      Provider.of<MeetingsProvider>(context, listen: false)
          .addMeeting(_formMeetingName);
      Navigator.pop(context);
    }
  }
}
