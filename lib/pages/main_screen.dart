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

  var icons = ['images/Good.png', 'images/Ok.png', 'images/Normal.png', 'images/Bad.png'];
  var question = "Quelle est votre niveau de douleur ?";
    double _sliderValue = 0;


  void _navigateToPostDetail (BuildContext context){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainScreen()));
      }


  void _changeQuestions(context){
setState(() {
       icons = ['images/Normal.png'];
       question = "Are you Sure ?";

});
  }

  Widget _emojisList(context) {
    List < Widget > list = new List < Widget > ();

    for (var i = 0; i < icons.length; i++) {
      list.add(new Padding(padding: EdgeInsets.all(10),
        child:
        InkWell( 
          onTap: () => _changeQuestions(context),
          child: Image(image: AssetImage(icons[i]),
          width: 60,
          height: 60, )), )
        );
        
        
    }

    return Row(
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

            Padding(
              padding: EdgeInsets.all(20),
              child: Slider(
                  activeColor: Colors.blue,
                  min: 0,
                  max: 10,
                  onChanged: (newRating) {
                    setState(() => _sliderValue = newRating);
                  },
                  value: _sliderValue,
                ),

            ),
            Text('${_sliderValue.toInt()}',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 35)),

              RaisedButton(
      onPressed: () => print('pressed!'),
      child: Text('Suivant'),
      textColor: Colors.white,
      color: Colors.blue,
    ),


          ], )



      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}