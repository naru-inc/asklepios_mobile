import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientHistoricScreen extends StatefulWidget {


  @override
  _PatientHistoricScreenState createState() => new _PatientHistoricScreenState();
}

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _PatientHistoricScreenState extends State<PatientHistoricScreen> {
  

 @override
  void initState() {
    super.initState();
     _getData();
  }


  void _getData(){
var now = new DateTime.now();
var lastMidnight = new DateTime(now.year, now.month, now.day - 1);

    Firestore.instance
    .collection('Patient').document('Hammadi').collection('Symptom')
    .where("time", isGreaterThanOrEqualTo: lastMidnight)
    .snapshots()
    .listen((data) =>
        data.documents.forEach((doc) => print(doc["name"])));
  }

  void _formatData(doc){
    
  }

  @override
  Widget build(BuildContext context) {
   List<charts.Series<OrdinalSales, String>> _createSampleData() {

    final fatigueData = [
      new OrdinalSales('0-1', 5),
      new OrdinalSales('1-2', 2),
      new OrdinalSales('2-3', 10),
      new OrdinalSales('3-4', 7),
    ];

    final nauseaData = [
      new OrdinalSales('0-1', 2),
      new OrdinalSales('1-2', 5),
      new OrdinalSales('2-3', 1),
      new OrdinalSales('3-4', 2),
    ];

    final throwUpData = [
      new OrdinalSales('0-1', 10),
      new OrdinalSales('1-2', 1),
      new OrdinalSales('2-3', 5),
      new OrdinalSales('3-4', 4),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Fatigue',
        domainFn: (OrdinalSales sales, _) => sales.hour,
        measureFn: (OrdinalSales sales, _) => sales.level,
        data: fatigueData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Nausée',
        domainFn: (OrdinalSales sales, _) => sales.hour,
        measureFn: (OrdinalSales sales, _) => sales.level,
        data: nauseaData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Vomissement',
        domainFn: (OrdinalSales sales, _) => sales.hour,
        measureFn: (OrdinalSales sales, _) => sales.level,
        data: throwUpData,
      ),
    ];
  }

    var chart = new charts.BarChart(
       _createSampleData(),
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
            behaviors: [new charts.SeriesLegend()],

    );
    var chartWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

    return new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Historiques des signes cliniques',
            ),
        
            chartWidget,
          ],
  
 
    );
  }
}
class OrdinalSales {
  final String hour;
  final int level;

  OrdinalSales(this.hour, this.level);
}