import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'detector_painters.dart';

class PictureScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PictureScannerState();
}

class _PictureScannerState extends State<PictureScanner> {
  File _imageFile;
  Size _imageSize;
  dynamic _scanResults;
  Detector _currentDetector = Detector.text;

  final ImageLabeler _imageLabeler = FirebaseVision.instance.imageLabeler();
  final ImageLabeler _cloudImageLabeler =
      FirebaseVision.instance.cloudImageLabeler();
  final TextRecognizer _recognizer = FirebaseVision.instance.textRecognizer();

  Future<void> _getAndScanImage() async {
    setState(() {
      _imageFile = null;
      _imageSize = null;
    });

    final File imageFile =
        await ImagePicker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      _getImageSize(imageFile);
      _scanImage(imageFile);
    }

    setState(() {
      _imageFile = imageFile;
    });
  }

  Future<void> _getImageSize(File imageFile) async {
    final Completer<Size> completer = Completer<Size>();

    final Image image = Image.file(imageFile);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    final Size imageSize = await completer.future;
    setState(() {
      _imageSize = imageSize;
    });
  }

  Future<void> _scanImage(File imageFile) async {
    setState(() {
      _scanResults = null;
    });

    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);

    dynamic results;
    switch (_currentDetector) {

      case Detector.label:
        results = await _imageLabeler.processImage(visionImage);
        break;
      case Detector.cloudLabel:
        results = await _cloudImageLabeler.processImage(visionImage);
        break;
      case Detector.text:
        results = await _recognizer.processImage(visionImage);
        break;
      default:
        return;
    }

    setState(() {
      _scanResults = results;
    });
  }

  CustomPaint _buildResults(Size imageSize, dynamic results) {
    print("here are the results");
     for (TextBlock block in results.blocks) {
       print(block.text);
      
    }
    CustomPainter painter;

    switch (_currentDetector) {
      
      case Detector.label:
        painter = LabelDetectorPainter(_imageSize, results);
        break;
     
      case Detector.text:
        painter = TextDetectorPainter(_imageSize, results);
        break;
    
      default:
        break;
    }

    return CustomPaint(
      painter: painter,
    );
  }

  Widget _buildImage() {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.file(_imageFile).image,
          fit: BoxFit.fill,
        ),
      ),
      child: _imageSize == null || _scanResults == null
          ? const Center(
              child: Text(
                'Scanning...',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30.0,
                ),
              ),
            )
          : _buildResults(_imageSize, _scanResults),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picture Scanner'),
        actions: <Widget>[
          PopupMenuButton<Detector>(
            onSelected: (Detector result) {
              _currentDetector = result;
              if (_imageFile != null) _scanImage(_imageFile);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Detector>>[
              
            
              const PopupMenuItem<Detector>(
                child: Text('Detect Text'),
                value: Detector.text,
              ),
          
            ],
          ),
        ],
      ),
      body: _imageFile == null
          ? const Center(child: Text('No image selected.'))
          : _buildImage(),
      floatingActionButton: FloatingActionButton(
        onPressed: _getAndScanImage,
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  @override
  void dispose() {
    _imageLabeler.close();
    _cloudImageLabeler.close();
    _recognizer.close();
    super.dispose();
  }
}