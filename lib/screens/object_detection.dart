// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_tflite/flutter_tflite.dart';

// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'dart:io' as io;

// import 'package:path_provider/path_provider.dart';

// class DetectionTabs extends StatefulWidget {
//   static const routeName = 'detect';

//   DetectionTabs({Key? key}) : super(key: key);

//   @override
//   State<DetectionTabs> createState() => _DetectionTabsState();
// }

// class _DetectionTabsState extends State<DetectionTabs> {
//   bool moneyClick = false;
//   FlutterTts flutterTts = FlutterTts();
//   late ImageLabeler _imageLabeler;
//   late final modelPath;
//   @override
//   void initState() {
//     super.initState();

//     loadModel();
//   }

//   bool imageLabelChecking = false;

//   XFile? imageFile;

//   String imageLabel = "";
//   List? result;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text(
//           "Object detection",
//           style: TextStyle(color: Colors.white),
//         ),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(25),
//                   bottomRight: Radius.circular(25)),
//               color: Color(0xff375079)),
//         ),
//         // backgroundColor: Colors.grey[100],
//         elevation: 0,
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//             child: Column(
//           // crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             if (imageLabelChecking) CircularProgressIndicator(),
//             if (!imageLabelChecking && imageFile == null)
//               Container(
//                 width: 300,
//                 height: 300,
//                 color: Colors.grey[350],
//               ),
//             if (imageFile != null) Image.file(io.File(imageFile!.path)),
//             Container(
//               margin: EdgeInsets.only(top: 30),
//               child: Text(
//                 'Choose categories',
//                 style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 10),
//               child: Divider(
//                 height: 2,
//                 thickness: 1,
//                 color: Colors.grey[200],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: Colors.grey[400],
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0)),
//                       ),
//                       onPressed: () => getImage(ImageSource.gallery),
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(
//                           vertical: 5,
//                           horizontal: 5,
//                         ),
//                         child: Column(
//                           children: [
//                             Icon(
//                               Icons.money_rounded,
//                               size: 30,
//                               color: Color(0xff375079),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 15),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: Colors.grey[400],
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0)),
//                       ),
//                       onPressed: () {},
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(
//                           vertical: 5,
//                           horizontal: 5,
//                         ),
//                         child: Column(
//                           children: [
//                             Icon(
//                               Icons.document_scanner,
//                               size: 30,
//                               color: Color(0xff375079),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 50),
//               child: Expanded(
//                 child: Text(
//                   "${result?[0]["label"]}",
//                   style: TextStyle(fontSize: 20, color: Colors.white),
//                 ),
//               ),
//             )
//           ],
//         )),
//       ),
//     );
//   }

//   void _speak() async {
//     await flutterTts.speak(imageLabel);
//   }

//   loadModel() async {
//     await Tflite.loadModel(
//       model: "ml/model_unquant.tflite",
//       labels: "ml/labels.txt",
//     );
//   }

//   @override
//   void dispose() {
//     Tflite.close();
//     super.dispose();
//   }

//   // void _initializeLabeler() async {
//   //   // uncomment next line if you want to use the default model
//   //   // _imageLabeler = ImageLabeler(options: ImageLabelerOptions());

//   //   // uncomment next lines if you want to use a local model
//   //   // make sure to add tflite model to assets/ml
//   //   // final path = 'assets/ml/lite-model_aiy_vision_classifier_birds_V1_3.tflite';
//   //   final path = 'ml/model_unquant.tflite';
//   //   modelPath = await _getModel(path);

//   //   // uncomment next lines if you want to use a remote model
//   //   // make sure to add model to firebase
//   //   // final modelName = 'bird-classifier';
//   //   // final response =
//   //   //     await FirebaseImageLabelerModelManager().downloadModel(modelName);
//   //   // print('Downloaded: $response');
//   //   // final options =
//   //   //     FirebaseLabelerOption(confidenceThreshold: 0.5, modelName: modelName);
//   //   // _imageLabeler = ImageLabeler(options: options);
//   // }

//   // Future<String> _getModel(String assetPath) async {
//   //   if (io.Platform.isAndroid) {
//   //     return 'flutter_assets/$assetPath';
//   //   }
//   //   final path = '${(await getApplicationSupportDirectory()).path}/$assetPath';
//   //   await io.Directory(dirname(path)).create(recursive: true);
//   //   final file = io.File(path);
//   //   if (!await file.exists()) {
//   //     final byteData = await rootBundle.load(assetPath);
//   //     await file.writeAsBytes(byteData.buffer
//   //         .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
//   //   }
//   //   return file.path;
//   // }

//   void getImage(ImageSource source) async {
//     try {
//       final pickedImage = await ImagePicker().pickImage(source: source);
//       if (pickedImage != null) {
//         imageLabelChecking = true;
//         imageFile = pickedImage;
//         setState(() {});
//         classifyImage(pickedImage);
//       }
//     } catch (e) {
//       imageLabelChecking = false;
//       imageFile = null;
//       imageLabel = "Error occurred while getting image Label";
//       setState(() {});
//     }
//   }

//   classifyImage(XFile image) async {
//     var output = await Tflite.runModelOnImage(
//       path: image.path,
//       imageMean: 127.5, // defaults to 117.0
//       imageStd: 127.5, // defaults to 1.0
//       numResults: 2, // defaults to 5
//       threshold: 0.5, // defaults to 0.1
//       asynch: true,
//     );
//     setState(() {
//       imageLabelChecking = false;
//       result = output;
//     });
//   }

//   // void getImageLabels(XFile image) async {
//   //   final inputImage = InputImage.fromFilePath(image.path);
//   //   final options =
//   //       LocalLabelerOptions(confidenceThreshold: 0.75, modelPath: modelPath);
//   //   _imageLabeler = ImageLabeler(options: options);
//   //   // ImageLabeler imageLabeler =
//   //   //     ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.75));
//   //   List<ImageLabel> labels = await _imageLabeler.processImage(inputImage);
//   //   StringBuffer sb = StringBuffer();
//   //   for (ImageLabel imgLabel in labels) {
//   //     String lblText = imgLabel.label;
//   //     double confidence = imgLabel.confidence;
//   //     sb.write(lblText);
//   //     sb.write(" : ");
//   //     sb.write((confidence * 100).toStringAsFixed(2));
//   //     sb.write("%\n");
//   //   }
//   //   _imageLabeler.close();
//   //   imageLabel = sb.toString();
//   //   _speak();
//   //   imageLabelChecking = false;
//   //   setState(() {});
//   // }
// }
