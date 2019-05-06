import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  double _sliderValue = 0;


  void _navigateToPostDetail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainScreen()));
  }


  void _changeQuestions(context) {
    setState(() {


    });
  }

  Widget _emojisList(context) {
    List < Widget > list = new List < Widget > ();

    for (var i = 0; i < icons.length; i++) {
      list.add(new Padding(padding: EdgeInsets.all(30),
        child:
        Column(
          children: <Widget>[
   InkWell(
          onTap: () => _changeQuestions(context),
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
                child: _emojisList(context)
              ))
           
            





          ], )



      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}