import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import 'package:path_provider/path_provider.dart';
import 'package:project2implement/screens/detect_tabs.dart';

class DetectionTabs extends StatefulWidget {
  static const routeName = 'detect';

  DetectionTabs({Key? key}) : super(key: key);

  @override
  State<DetectionTabs> createState() => _DetectionTabsState();
}

class _DetectionTabsState extends State<DetectionTabs> {
  bool moneyClick = false;
  FlutterTts flutterTts = FlutterTts();
  late ImageLabeler _imageLabeler;
  late final modelPath;
  @override
  void initState() {
    super.initState();

    loadModel();
  }

  bool imageLabelChecking = false;

  XFile? imageFile;

  String imageLabel = "";
  List? result;
  List<IconData> icons = [
    Icons.storefront,
    Icons.document_scanner,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Object detection",
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              color: Colors.white),
        ),
        // backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (imageLabelChecking) const CircularProgressIndicator(),
            if (!imageLabelChecking && imageFile == null)
              Container(
                width: 300,
                height: 300,
                color: Colors.grey[350],
              ),
            if (imageFile != null)
              Image.file(
                io.File(imageFile!.path),
                width: 450,
                height: 450,
              ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: const Text(
                'Choose categories',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Divider(
                height: 2,
                thickness: 1,
                color: Colors.grey[200],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              height: 40,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (_, size) {
                  return DetectTabs(
                    iconData: Icons.storefront,
                    getImage: getImage,
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: Text(
                "${result?[0]["label"] ?? ""}",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            )
          ],
        )),
      ),
    );
  }

  void _speak() async {
    await flutterTts.speak("${result?[0]["label"]}");
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "ml/model_unquant.tflite",
      labels: "ml/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        imageLabelChecking = true;
        imageFile = pickedImage;
        setState(() {
          imageLabelChecking = true;
          imageFile = pickedImage;
        });
        classifyImage(pickedImage);
      }
    } catch (e) {
      imageLabelChecking = false;
      imageFile = null;
      imageLabel = "Error occurred while getting image Label";
      setState(() {});
    }
  }

  classifyImage(XFile image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 127.5, // defaults to 117.0
      imageStd: 127.5, // defaults to 1.0
      numResults: 2, // defaults to 5
      threshold: 0.5, // defaults to 0.1
      asynch: true,
    );
    setState(() {
      imageLabelChecking = false;
      result = output;
      _speak();
    });
  }
}
