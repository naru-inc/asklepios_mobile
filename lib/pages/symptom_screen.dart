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



  

  double _value = 1;
  void _setvalue(double value) => setState(() => _value = value);


  void updateValue() {
    var now = new DateTime.now();
    var id = new DateTime.now().millisecondsSinceEpoch;
    
    
    Firestore.instance.collection('Patient').document('Hammadi').collection('Symptom').document(id.toString())
    .setData({ 'name' : widget.symptomId, 'level' : _value, 'time': now});
   Navigator.pop(context);

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
            Padding(padding: EdgeInsets.all(30),
              child:
              Image(image: AssetImage(widget.symptomImageUrl),
                width: 60,
                height: 60, ),
            ),
            Text('Quel est votre niveau de ' + widget.symptomName, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 22)),

            if (widget.isLevel == true)
             Container(padding: EdgeInsets.all(20),
              child: new Center(
                child: new Column(
                  children: < Widget > [
                    new Slider(value: _value, onChanged: _setvalue, divisions: 9, min: 1, max: 10, ),
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