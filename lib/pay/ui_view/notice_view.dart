import 'package:healthybus_bus/util/toast_util.dart';
import '../../app_theme.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio/dio.dart';
import '../../util/server_util.dart';
import '../../util/carInfo_util.dart';

class NoticeView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const NoticeView(
      {Key key,
        this.animationController,
        this.animation,
      })
      : super(key: key);

  Future scan(context) async {
    Dio dio = new Dio();
    dio.options.baseUrl = Server.base;
    var cookieJar = CookieJar();
    dio.interceptors..add(LogInterceptor())..add(CookieManager(cookieJar));
    try {
      ScanResult barcode = await BarcodeScanner.scan();
      print(barcode.toString());
      try{
        Response response = await dio.post("/car_login", data: {"phone":carInfo().getPhone(), "password":carInfo().getPassword()});
        if (response.data["status"] == "ok" && response.data["msg"] == "login success" ){
          List<String> str = barcode.rawContent.split(",");
          response = await dio.post("/finish_pay",data: {"time":str[0], "token":str[1],"id":str[2], "amount":2, "turn":1});
          if (response.data["status"] == "ok" && response.data["msg"] == "pay succeed" ) {
            ToastUtil.toast(context, "支付成功");
          }
          else{
            ToastUtil.toast(context, "支付失败");
          }
        }
        else{
          ToastUtil.toast(context, "登录失败");
        }
      }catch (e) {
        // The request was made and the server responded with a status code
        // that falls out of the range of 2xx and is also not 304.
        //ToastUtil.toast(context, "网络连接错误");
      } finally {
      }

    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        ToastUtil.toast(context, 'The user did not grant the camera permission!');
      } else {
        ToastUtil.toast(context, 'Unknown error!');
      }
    } on FormatException{
//     this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)';
    } catch (e) {
      ToastUtil.toast(context, 'Unknown error!');
    }
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
                              scan(context);
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
                    height: 80,
                    width: 500,
                    child: Text(
                      "             Please Show\n             Your QRcode",
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
