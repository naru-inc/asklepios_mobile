import 'package:asklepios/pages/painArea_screen.dart';
import 'package:asklepios/pages/patientHistoric_screen.dart';
import 'package:asklepios/pages/pill_screen.dart';
import 'package:asklepios/pages/symptom_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:asklepios/pages/symptomsList_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'symptomsTimeline_screen.dart';
class MainScreen extends StatefulWidget {
  @override
  State < StatefulWidget > createState() {
    // TODO: implement createState
    return _MainScreenState();
  }

}

class _MainScreenState extends State < MainScreen > {

  int _selectedIndex = 0;

     void _navigateToPostDetail (BuildContext context, String symptomName, String symptomImage, String symptomId){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SymptomScreen(symptomName: symptomName, symptomImageUrl: symptomImage,symptomId:symptomId ,)));
      }

       static  List<Widget> _widgetOptions = <Widget>[
    SymptomsListScreen(),
  SymptomsTimelineScreen(),
  PillScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions[_selectedIndex],



      ), 
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart),
            title: Text('Symptomes'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            title: Text('Historique'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            title: Text('Pills'),
          )
        
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}