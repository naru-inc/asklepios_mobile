import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
   List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('0-1', 5),
      new OrdinalSales('1-2', 25),
      new OrdinalSales('2-3', 100),
      new OrdinalSales('3-4', 75),
    ];

    final tableSalesData = [
      new OrdinalSales('0-1', 25),
      new OrdinalSales('1-2', 50),
      new OrdinalSales('2-3', 10),
      new OrdinalSales('3-4', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('0-1', 10),
      new OrdinalSales('1-2', 15),
      new OrdinalSales('2-3', 50),
      new OrdinalSales('3-4', 45),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Fatigue',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Nausée',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Vomissement',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
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
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}