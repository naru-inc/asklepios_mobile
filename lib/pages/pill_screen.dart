// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:asklepios/utils/scanner_utils.dart';
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'detector_painters.dart';
import 'package:flutter_html/flutter_html.dart';

class CameraPreviewScanner extends StatefulWidget {
  @override
  State < StatefulWidget > createState() => _CameraPreviewScannerState();
}

class _CameraPreviewScannerState extends State < CameraPreviewScanner > {
  dynamic _scanResults;
  CameraController _camera;
  Detector _currentDetector = Detector.text;
  bool _isDetecting = false;
  CameraLensDirection _direction = CameraLensDirection.back;
  bool _isActivated = false;
  var medocs = ["agriflash", "eco-plast", "efferalgan", "ercefuryl", "fumafer", "maxilase", "pectolyse", "pivalon", "rinathiol", "spasfon", "voltarene"];
  var medocsImages=['','images/medocs/eco-plast.jpg','images/medocs/efferalgan.png','images/medocs/ercefutyl.jpg','','images/medocs/maxilase.jpg'];
  var posologies=['','','Les comprimés sont à avaler tels quels avec une boisson (par exemple : eau, lait, jus de fruit).','Adulte : 1 gélule 4 fois par jour en 2 à 4 prises.','','Adulte : 1 comprimé ou 1 cuillère à soupe de sirop, 3 fois par jour'];
  var counter = 0;

  final TextRecognizer _recognizer = FirebaseVision.instance.textRecognizer();
  @override
  void initState() {
    super.initState();
  }

  void _initializeCamera() async {
    final CameraDescription description =
      await ScannerUtils.getCamera(_direction);

    _camera = CameraController(
      description,
      defaultTargetPlatform == TargetPlatform.iOS ?
      ResolutionPreset.low :
      ResolutionPreset.medium,
    );
    await _camera.initialize();

    _camera.startImageStream((CameraImage image) {
      if (_isDetecting) return;

      _isDetecting = true;

      ScannerUtils.detect(
        image: image,
        detectInImage: _getDetectionMethod(),
        imageRotation: description.sensorOrientation,
      ).then(
        (dynamic results) {
          if (_currentDetector == null) return;
          setState(() {
            _scanResults = results;
          });
        },
      ).whenComplete(() => _isDetecting = false);
    });
  }

  Future < dynamic > Function(FirebaseVisionImage image) _getDetectionMethod() {
    return _recognizer.processImage;
  }

  Widget _buildResults() {
    const Text noResultsText = Text('No results!');

    if (_scanResults == null ||
      _camera == null ||
      !_camera.value.isInitialized) {
      return noResultsText;
    }

    CustomPainter painter;

    final Size imageSize = Size(
      _camera.value.previewSize.height,
      _camera.value.previewSize.width,
    );

    if (_scanResults is!VisionText) return noResultsText;
    painter = TextDetectorPainter(imageSize, _scanResults);


    for (var block in _scanResults.blocks) {
      debugPrint(block.text);
      for (var i=0;i<medocs.length;i++) {
        if (block.text.toString().toLowerCase().contains(medocs[i].toLowerCase())) {
          counter = counter + 1;
          if (counter > 3) {
            counter = 0;
            _stopCamera();
            return
            ListView(
              shrinkWrap: true,
              children: < Widget > [
                Center(child: Text(medocs[i].toLowerCase(), style: TextStyle(fontSize: 35,), )),
                Padding(padding: EdgeInsets.all(50),
                  child: 
                Image(image: AssetImage(medocsImages[i]),)),
                Padding(padding: EdgeInsets.all(35),
                  child: Column( children: <Widget>[
                      Text("Posologie",style: TextStyle(fontSize: 20),),

                    Text(posologies[i], textAlign: TextAlign.justify,)
                  ],
                  
              

                  )
                     ,

                )
              
                 ],
            );
            break;

          }

        }
      }
    }

    return CustomPaint(
      painter: painter,
    );
  }

  Widget _buildImage() {
    return Container(
      constraints: const BoxConstraints.expand(),
        child: _camera == null ?
        const Center(
          child: Text(
            '',
            style: TextStyle(
              color: Colors.green,
              fontSize: 30.0,
            ),
          ),
        ): Stack(
          fit: StackFit.expand,
          children: < Widget > [
            CameraPreview(_camera),
            _buildResults(),
          ],
        ),
    );
  }

  void _activateCamera() {
    counter = 0;
    if (_isDetecting) {
      _stopCamera();

    } else {
      _initializeCamera();

    }

  }

  void _stopCamera() async {
    counter = 0;
    await _camera.stopImageStream();
    await _camera.dispose();
  }

  void _toggleCameraDirection() async {
    if (_direction == CameraLensDirection.back) {
      _direction = CameraLensDirection.front;
    } else {
      _direction = CameraLensDirection.back;
    }

    await _camera.stopImageStream();
    await _camera.dispose();

    setState(() {
      _camera = null;
    });

    _initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detection de medicaments'),
          actions: < Widget > [
            PopupMenuButton < Detector > (
              onSelected: (Detector result) {
                _currentDetector = result;
              },
              itemBuilder: (BuildContext context) => < PopupMenuEntry < Detector >> [

                const PopupMenuItem < Detector > (
                  child: Text('Detect Text'),
                  value: Detector.text,
                ),

              ],
            ),
          ],
      ),
      body: _buildImage(),
      floatingActionButton: FloatingActionButton(
        onPressed: _activateCamera,
        child: const Icon(Icons.camera_front)
      ),
    );
  }

  @override
  void dispose() {
    _camera.dispose().then((_) {
      _recognizer.close();
    });

    _currentDetector = null;
    super.dispose();
  }
}