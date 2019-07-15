import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_formatter/time_formatter.dart';

class SymptomsTimelineScreen extends StatefulWidget {
  @override
  State < StatefulWidget > createState() {
    // TODO: implement createState
    return _SymptomsTimelineSceenState();
  }




}

class _SymptomsTimelineSceenState extends State < SymptomsTimelineScreen > {
        List < TimelineModel > list = new List < TimelineModel > ();

@override
  void initState() {
    super.initState();
            _getData();

  }

 void _getData(){
var now = new DateTime.now();
var lastMidnight = new DateTime(now.year, now.month, now.day - 7);

    Firestore.instance
    .collection('Patient').document('Hammadi').collection('Symptom')
    .where("time", isGreaterThanOrEqualTo: lastMidnight)
    .snapshots()
    .listen((data) =>
        data.documents.forEach((doc) => _addSymptomToList(doc)));
  }


  void _addSymptomToList(doc){
        setState(() {

    list.add(
      TimelineModel(Padding(padding: const EdgeInsets.all(20.00),
        child: Center(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(doc["name"]),
            Text(formatTime(doc["time"].seconds*1000)),
            Text(doc["level"].toString()),
          ],
        )), ),
      position: TimelineItemPosition.left,
      iconBackground: Colors.transparent,
      icon: Icon(Icons.blur_circular)),
    );
    });
      

    
  }






  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return         Timeline(children: list, position: TimelinePosition.Center);


  }
}