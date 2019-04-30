import 'package:asklepios/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  State < StatefulWidget > createState() {
    // TODO: implement createState
    return _HomeScreenState();
  }

}

class _HomeScreenState extends State < HomeScreen > {
 


     void _navigateToPostDetail (BuildContext context){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainScreen()));
      }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
       
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: < Widget > [
              new Container(
                 child: InkWell(
          onTap: () => _navigateToPostDetail(context),
                
                child: new CircleAvatar(
                  backgroundImage: AssetImage('images/per1.jpg')
                )),
                width: 150,
                height: 150,
                padding: const EdgeInsets.all(4.0), // borde width
                  decoration: new BoxDecoration(
                    color: Colors.white, // border color
                    shape: BoxShape.circle,
                  )
              )
            ],

          ),
        ),
    );
  }

}