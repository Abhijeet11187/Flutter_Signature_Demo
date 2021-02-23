import 'dart:io';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:signature_demo/Library/screenshot.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Signature POC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScreenshotController screenshotController = ScreenshotController();
  File _imageFile = null;
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.black,
  );
  takescrshot() async {
    screenshotController.capture().then((File image) {
      setState(() {
        _imageFile = image;
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  Widget _screenShotButton() {
    return RaisedButton(
      onPressed: takescrshot,
      textColor: Colors.white,
      color: Colors.amber,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.amber)),
      padding: EdgeInsets.all(10.0),
      child: Text('Take Screenshot', style: TextStyle(fontSize: 20)),
    );
  }

  Widget __clearButton() {
    return RaisedButton(
      onPressed: () {
        _controller.clear();
      },
      textColor: Colors.white,
      color: Colors.green,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.green)),
      padding: EdgeInsets.all(10.0),
      child: Text('Clear', style: TextStyle(fontSize: 20)),
    );
  }

  Widget _screenShot() {
    return Screenshot(
      controller: screenshotController,
      child: Signature(
        controller: _controller,
        height: 350,
        backgroundColor: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'SIGNATURE  BOARD',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 5),
            ),
            SizedBox(
              height: 20,
            ),
            _screenShot(),
            Padding(
                padding: EdgeInsets.all(40),
                child: Row(
                  children: [
                    _screenShotButton(),
                    SizedBox(
                      width: 10,
                    ),
                    __clearButton(),
                  ],
                )),
            Text(
              'ScreenShot stored at location :-',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '/storage/emulated/0/Android/data/com.example.signature_demo/files/fileName.jpg',
              style: TextStyle(fontSize: 13),
            )
          ],
        ),
      ),
    );
  }
}

// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:signature/signature.dart';
// import 'package:signature/signature.dart';
// import 'package:signature/signature.dart';

// import 'Library/screenshot.dart';

// class SignaturePainter extends CustomPainter {
//   SignaturePainter(this.points);

//   final List<Offset> points;

//   void paint(Canvas canvas, Size size) {
//     Paint paint = new Paint()
//       ..color = Colors.green
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 5.0;
//     for (int i = 0; i < points.length - 1; i++) {
//       if (points[i] != null && points[i + 1] != null)
//         canvas.drawLine(points[i], points[i + 1], paint);
//     }
//   }

//   bool shouldRepaint(SignaturePainter other) => other.points != points;
// }

// class Signature extends StatefulWidget {
//   SignatureState createState() => new SignatureState();
// }

// class SignatureState extends State<Signature> {
//   List<Offset> _points = <Offset>[];
//   static GlobalKey previewContainer = new GlobalKey();
//   ScreenshotController screenshotController = ScreenshotController();
//   File _imageFile;
//   final SignatureController _controller = SignatureController(
//     penStrokeWidth: 5,
//     penColor: Colors.red,
//     exportBackgroundColor: Colors.blue,
//   );
//   takescrshot() async {
//     print("Taking Screenshots . . .");
//     screenshotController.capture().then((File image) {
//       //Capture Done
//       setState(() {
//         _imageFile = image;
//       });
//       print("Succedd $_imageFile");
//     }).catchError((onError) {
//       print(onError);
//     });
//     // RenderRepaintBoundary boundary =
//     //     previewContainer.currentContext.findRenderObject();
//     // print("Repaint Boundry Completed");
//     // var image = await boundary.toImage();
//     // print("Image Completed");
//     // var byteData = await image.toByteData(format: ImageByteFormat.png);
//     // var pngBytes = byteData.buffer.asUint8List();
//     // print(pngBytes);
//   }

//   Widget _returnSignature() {
//     return Signature(
//       controller: _controller,
//       height: 300,
//       backgroundColor: Colors.lightBlueAccent,
//     );
//     // return Stack(
//     //   children: [
//     //     Screenshot(
//     //       controller: screenshotController,
//     //       child: CustomPaint(
//     //         painter: SignaturePainter(_points),
//     //       ),
//     //     ),
//     //     GestureDetector(
//     //       onDoubleTap: () {
//     //         print("tapped");
//     //       },
//     //       onPanUpdate: (DragUpdateDetails details) {
//     //         RenderBox referenceBox = context.findRenderObject();
//     //         Offset localPosition =
//     //             referenceBox.globalToLocal(details.globalPosition);
//     //         Offset offset = Offset(
//     //             250.00 - details.globalPosition.dx, details.globalPosition.dy);
//     //         setState(() {
//     //           _points = new List.from(_points)..add(localPosition);
//     //         });
//     //       },
//     //       onPanEnd: (DragEndDetails details) => _points.add(null),
//     //     ),
//     //     Padding(
//     //       padding: EdgeInsets.all(5),
//     //       child: Align(
//     //         alignment: Alignment.bottomRight,
//     //         child: RaisedButton(
//     //           onPressed: takescrshot,
//     //           child: Text('Task Scrrenshot'),
//     //         ),
//     //       ),
//     //     )
//     //   ],
//     // );
//   }

//   Widget build(BuildContext context) {
//     return Center(
//         child: Container(
//             // height: 150,
//             // width: 150,
//             color: Colors.grey,
//             child: _returnSignature()));
//   }
// }

// class DemoApp extends StatelessWidget {
//   Widget build(BuildContext context) => new Scaffold(body: new Signature());
// }

// void main() => runApp(new MaterialApp(home: new DemoApp()));
