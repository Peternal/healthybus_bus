import '../../app_theme.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class NoticeView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const NoticeView(
      {Key key,
        this.animationController,
        this.animation,
      })
      : super(key: key);

  Future scan() async {
    try {
      ScanResult barcode = await BarcodeScanner.scan();
      print(barcode.toString());
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
//          this.barcode.= 'The user did not grant the camera permission!';
      } else {
//        this.barcode.toString() = 'Unknown error: $e';
      }
    } on FormatException{
//     this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)';
    } catch (e) {
//      this.barcode = 'Unknown error: $e';
    }
//    print(barcode);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                    width: 50,
                  ),
                  SizedBox(
                  height: 200,
                  width: 200,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Container(
                        // alignment: Alignment.center,s
                        decoration: BoxDecoration(
                          color: AppTheme.nearlyDarkBlue,
                          gradient: LinearGradient(
                              colors: [
                                AppTheme.nearlyDarkBlue,
                                Color.fromARGB(255, 106, 136, 229),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: AppTheme.nearlyDarkBlue
                                    .withOpacity(0.4),
                                offset: const Offset(4.0, 4.0),
                                blurRadius: 10.0),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.white.withOpacity(0.1),
                            highlightColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            onTap: () {
                              scan();
                            },
                            child: Icon(
                              Icons.crop_free,
                              color: AppTheme.white.withOpacity(0.8),
                              size: 90,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ),
                ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: Text(
                      "  Tap to scan",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        letterSpacing: 0.5,
                        color: AppTheme.nearlyDarkBlue.withOpacity(0.8),
                      ),
                    ),
                  ),
                ]
            )
          ),
        );
      },
    );
  }
}
