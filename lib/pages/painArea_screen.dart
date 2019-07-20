import 'dart:async';

import 'package:asklepios/pages/home_screen.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'main_screen.dart';

enum AnimationToPlay {
  Idle,
  Head,
  Chest,
  Stomach,
  Palv,
  LeftArm,
  RightArm,
  LeftHand,
  RightHand,
  LeftLeg,
  RightLeg,
  LeftFoot,
  RightFoot
}

class PainAreaScreen extends StatefulWidget {
  final String symptomId;

  const PainAreaScreen({
    Key key,
    this.symptomId
  }): super(key: key);

  @override
  State < StatefulWidget > createState() {
    // TODO: implement createState
    return _PainAreaScreenState();
  }

}

class _PainAreaScreenState extends State < PainAreaScreen > {
  static
  const double AnimationWidth = 187.5 * 1.5;
  static
  const double AnimationHeight = 384 * 1.5;
  AnimationToPlay _animationToPlay = AnimationToPlay.Idle;
  AnimationToPlay _lastPlayedAnimation;

  // Flare animation controls
  final FlareControls animationControls = FlareControls();
  bool isHead = false;
  Timer _timer;


  void updateValue(area) {
    var now = new DateTime.now();
    var id = new DateTime.now().millisecondsSinceEpoch;


    Firestore.instance.collection('Patient').document('Hammadi').collection('Symptom').document(widget.symptomId)
      .updateData({
        'area': area
      });

      _timer = new Timer(const Duration(milliseconds: 500), () {
Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));


    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:
      Center(
        child:
        Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(50)),
            Text("Indiquez où est-ce que vous avez mal"),
GestureDetector(
          onTapUp: (tapInfo) {
            var localTouchPosition = (context.findRenderObject() as RenderBox)
              .globalToLocal(tapInfo.globalPosition);

            var headTouched = localTouchPosition.dy < AnimationHeight / 3.2;

            var chestTouched = (localTouchPosition.dy < AnimationHeight / 2.1) && (localTouchPosition.dy > AnimationHeight / 3.2);

            var stomachTouched =
              (localTouchPosition.dy < (AnimationHeight / 1.7)) && (localTouchPosition.dy > (AnimationHeight / 2));

            var palvTouched =
              (localTouchPosition.dy < (AnimationHeight / 1.4)) && (localTouchPosition.dy > (AnimationHeight / 1.7));

            var legTouched =
              (localTouchPosition.dy < (AnimationHeight / 1.88)) && (localTouchPosition.dy > (AnimationHeight / 1.2));
            var footTouched =

              (localTouchPosition.dy > (AnimationHeight / 1.2));

            // Call our animation in our conditional checks
            if (headTouched) {
              _setAnimationToPlay(AnimationToPlay.Head);
              updateValue('head');
            } else if (stomachTouched) {
              _setAnimationToPlay(AnimationToPlay.Stomach);
              updateValue('stomach');
            } else if (chestTouched) {
              _setAnimationToPlay(AnimationToPlay.Chest);
              updateValue('chest');

            } else if (palvTouched) {
              _setAnimationToPlay(AnimationToPlay.Palv);
              updateValue('palv');

            }
          },
          child:
          Container(
            width: AnimationWidth,
            height: AnimationHeight,

            child: FlareActor('flare/bodypainFront.flr',
              controller: animationControls, animation: 'Idle')),
        )
          ],
        )
        
      )

    );

  }


  String _getAnimationName(AnimationToPlay animationToPlay) {
    switch (animationToPlay) {
      case AnimationToPlay.Head:
        return 'head_tapped';
      case AnimationToPlay.Chest:
        return 'chest_tapped';
      case AnimationToPlay.Stomach:
        return 'stomach_tapped';
      case AnimationToPlay.Palv:
        return 'palv';
      default:
        return 'Idle';
    }
  }

  void _setAnimationToPlay(AnimationToPlay animation) {
    animationControls.play(_getAnimationName(animation));

  }

}