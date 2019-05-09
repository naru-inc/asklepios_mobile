import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class MainScreen extends StatefulWidget {
  @override
  State < StatefulWidget > createState() {
    // TODO: implement createState
    return _MainScreenState();
  }

}

class _MainScreenState extends State < MainScreen > {

  var icons = ['images/pain.png', 'images/tired.png', 'images/headache.png'];
  var titles =['Douleur', 'Fatigue', 'Mal de tête'];
  var question = "Comment vous-sentez ce matin ?";




  void _updateValue(context) {
    Firestore.instance.collection('Patient').document('kkNY768ExgzqffbhUKmu')
  .updateData({ 'name': 'Ferid Ferida'});
 
  }

  Widget _symptomsList(context) {
    List < Widget > list = new List < Widget > ();

    for (var i = 0; i < icons.length; i++) {
      list.add(new Padding(padding: EdgeInsets.all(30),
        child:
        Column(
          children: <Widget>[
   InkWell(
          onTap: () => _updateValue(context),
          child: Image(image: AssetImage(icons[i]),
            width: 60,
            height: 60, )),
            Text(titles[i],
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25)),


            
          ],
        )
      ));


    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: list
    );

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: < Widget > [
            Text("Bonjour",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 35)),
            Text(question,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 22)),
              Padding(padding: EdgeInsets.all(50),
              child: 
                 Container(
                child: _symptomsList(context)
              ))
           
            





          ], )



      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}