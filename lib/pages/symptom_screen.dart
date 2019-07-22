import 'package:asklepios/pages/painArea_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SymptomScreen extends StatefulWidget {
  final String symptomName;
  final String symptomImageUrl;
  final String symptomId;
  final bool isLevel;

  const SymptomScreen({
    Key key,
    this.symptomName,
    this.symptomImageUrl,
    this.symptomId
  }): isLevel=true, super(key: key);




  @override
  State < StatefulWidget > createState() {

    return _SymptomScreenState();
  }
}

class _SymptomScreenState extends State < SymptomScreen > {



  

  double _value = 0;
  void _setvalue(double value) => setState(() => _value = value);


  void updateValue() {
    var now = new DateTime.now();
    var id = new DateTime.now().millisecondsSinceEpoch;
    
    
    Firestore.instance.collection('Patient').document('Hammadi').collection('Symptom').document(id.toString())
    .setData({ 'name' : widget.symptomId, 'level' : _value, 'time': now});
    if (widget.symptomId=='pain' && _value>0)
    {
    _navigateToPainScreen(context, id.toString());

    }else{
   Navigator.pop(context);

    }

  }


  void _navigateToPainScreen(BuildContext context, String symptomId) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PainAreaScreen(symptomId: symptomId )));
  }

  String updateSymptomPicture(value){

  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: < Widget > [
            Container(padding: EdgeInsets.all(10),
              child: new Center( child :         
            Text('Quel est votre niveau de ' + widget.symptomName.toLowerCase() + ' ?', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25))
              )),
              Padding(padding: EdgeInsets.all(80),
           ),
              Image(image: AssetImage("images/Emojis/"+'${(_value).round()}'+".png"),
                width: 100,
                height: 100, ),
            

            if (widget.isLevel == true)
             Container(padding: EdgeInsets.all(20),
              child: new Center(
                child: new Column(
                  children: < Widget > [
                    new Slider(value: _value, onChanged: _setvalue, divisions: 10, min: 0, max: 10, ),
                    new Text('${(_value).round()}',style: TextStyle(fontWeight: FontWeight.w300, fontSize: 22)),

                  ],
                ),
              ), ),

               Container(padding: EdgeInsets.all(20),
              child: new Center(
                child: 
                new RaisedButton(
                child: new Text("Envoyer au docteur", style: new TextStyle(fontWeight: FontWeight.w300, fontSize: 22, color: Colors.white)),
                color: Colors.blue,
                onPressed: updateValue
              )
              
              ), )


          ], )
      )
    );
  }
}