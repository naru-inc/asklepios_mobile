import 'dart:io';

import 'package:asklepios/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  @override
  State < StatefulWidget > createState() {
    // TODO: implement createState
    return _HomeScreenState();
  }

}

class _HomeScreenState extends State < HomeScreen > {


  void getPatientInformations(docref){
    Firestore.instance.collection('Patient').document(docref).get().then((DocumentSnapshot ds){
    });
  }

  _saveToPref() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('patientKey', this.docref);
  }

  _saveToLocal() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    try {
    await Directory(databasesPath).create(recursive: true);
    } catch (_) {}

    // open the database
    Database database = await openDatabase(path, version: 1,
    onCreate: (Database db, int version) async {
  // When creating the db, create the table
    await db.execute(
      'CREATE TABLE Symptoms (id INTEGER PRIMARY KEY, type TEXT, value INTEGER, date INTEGER)');
});
  }


  void _navigateToPostDetail(BuildContext context,docref) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainScreen()));
    getPatientInformations(docref);
    _saveToPref();
    _saveToLocal();

  }

  final _formKey = GlobalKey < FormState > ();
  String docref = "";


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: < Widget > [
              Padding(
                padding: EdgeInsets.all(100),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: < Widget > [
                      TextFormField(
                        decoration: const InputDecoration(
                            icon: Icon(Icons.lock_outline),
                            hintText: 'Quel est votre code d\'accés',
                            labelText: 'Code d\'accés',
                          ),

                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Prière d\'indiquer votre code';
                            }else{
                              this.docref=value;

                            }
                          },
                      ),
                      Center(
                          child: RaisedButton(
                            onPressed: () {
                              // Validate will return true if the form is valid, or false if
                              // the form is invalid.
                              if (_formKey.currentState.validate()) {
                                // If the form is valid, we want to show a Snackbar
                                _navigateToPostDetail(context,this.docref);
                              }
                            },
                            child: Text('Acceder'),
                          ),
                      ),
                    ],
                  ),
                )
              )


            ], )

        )

        ,
      )
    );
  }

}