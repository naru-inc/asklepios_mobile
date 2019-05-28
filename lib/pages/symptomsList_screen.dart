import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:asklepios/pages/symptom_screen.dart';

class SymptomsListScreen extends StatefulWidget {
  @override
  State < StatefulWidget > createState() {
    // TODO: implement createState
    return _SymptomsListScreenState();
  }

}

class _SymptomsListScreenState extends State < SymptomsListScreen > {

    var icons = ['images/pain.png', 'images/tired.png', 'images/headache.png'];
  var titles =['Douleur', 'Fatigue', 'Mal de tête'];
  var symptoms=['pain','tiredness','headache'];
  var question = "Comment vous-sentez ce matin ?";

    void _navigateToPostDetail (BuildContext context, String symptomName, String symptomImage, String symptomId){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SymptomScreen(symptomName: symptomName, symptomImageUrl: symptomImage,symptomId:symptomId ,)));
      }

  Widget _symptomsList(context) {
    List < Widget > list = new List < Widget > ();

    for (var i = 0; i < icons.length; i++) {
      list.add(new Padding(padding: EdgeInsets.all(30),
        child:
        Column(
          children: <Widget>[
   InkWell(
          onTap: () => _navigateToPostDetail(context,titles[i], icons[i],symptoms[i]),
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
    return Column(
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
           
            





          ]);
  }
}