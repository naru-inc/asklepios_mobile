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

  TextEditingController controller = TextEditingController();

  void gettingId() {
    controller.addListener(() {
      // Do something here
    });
  }


  void _navigateToPostDetail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainScreen()));
  }

  final _formKey = GlobalKey < FormState > ();



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
                                _navigateToPostDetail(context);
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