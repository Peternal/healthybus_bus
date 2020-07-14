import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app_theme.dart';
import 'package:flutter/services.dart';
import '../../util/toast_util.dart';
import '../../util/server_util.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio/dio.dart';
import '../../util/carInfo_util.dart';


class RebindScreen extends StatefulWidget {
  @override
  _RebindScreenState createState() => _RebindScreenState();
}

class _RebindScreenState extends State<RebindScreen> {

  TextEditingController idController = TextEditingController();

  TextEditingController passController = TextEditingController();


  double distValue = 50.0;

  bool eye = true;

  void _toggle() {
    setState(() {
      eye = !eye;
    });
  }

  void _rebind() async {
    if (idController.text.length < 11) {
      ToastUtil.toast(context, "请输入11位支付账户");
    } else if (passController.text.length == 0) {
      ToastUtil.toast(context, "密码不能为空");
    } else {
      Dio dio = new Dio();
      dio.options.baseUrl = Server.base;
      var cookieJar = CookieJar();
      dio.interceptors..add(LogInterceptor())..add(CookieManager(cookieJar));
      try {
        Response response = await dio.post("/car_login", data: {"phone":carInfo().getPhone(), "password":carInfo().getPassword()});
        print(response.data.toString());
        if (response.data["status"] == "ok") {
          if (response.data["msg"] == "login success") {
            response = await dio.post("/car_associate", data: {"id_pay": idController.text, "password_pay": passController.text});
            if (response.data["status"] == "ok" && response.data["msg"] == "update success") {
              ToastUtil.toast(context, "重新绑定成功");
              carInfo().initget(context);
              Navigator.pop(context);
            }else{
              ToastUtil.toast(context, "重新绑定失败");
            }

          }else{
            ToastUtil.toast(context, "登录失败");
          }
        } else {
          ToastUtil.toast(context, "账号或密码错误");
        }
      } catch (e) {
        // The request was made and the server responded with a status code
        // that falls out of the range of 2xx and is also not 304.
        ToastUtil.toast(context, "网络连接错误");
      } finally {
      }
    }
  }

  void _unbind() async {
    Dio dio = new Dio();
    dio.options.baseUrl = Server.base;
    var cookieJar = CookieJar();
    dio.interceptors..add(LogInterceptor())..add(CookieManager(cookieJar));
    try {
      Response response = await dio.post("/car_login", data: {"phone":carInfo().getPhone(), "password":carInfo().getPassword()});
      print(response.data.toString());
      if (response.data["status"] == "ok") {
        if (response.data["msg"] == "login success") {
          response = await dio.post("/passenger_associate", data: {"id_pay": "", "password_pay": ""});
          if (response.data["status"] == "ok" && response.data["msg"] == "update success") {
            ToastUtil.toast(context, "解除绑定成功");
            carInfo().initget(context);
            Navigator.pop(context);
          }else{
            ToastUtil.toast(context, "解除绑定失败");
          }

        }else{
          ToastUtil.toast(context, "登录失败");
        }
      } else {
        ToastUtil.toast(context, "账号或密码错误");
      }
    } catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      ToastUtil.toast(context, "网络连接错误");
    } finally {
    }

  }

  void _bindAlert(context, status) {
    showDialog(
      // 传入 context
        context: context,
        // 构建 Dialog 的视图
        builder: (_) => Container(
            padding: EdgeInsets.symmetric(
                horizontal: 40, vertical: 160),
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    height: 167,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          '${status == '1' ? 'REBIND' : 'UNBIND'}',
                          style: TextStyle(color: AppTheme.nearlyDarkBlue
                              .withOpacity(0.8), fontSize: 20, fontWeight: FontWeight.w900, decoration: TextDecoration.none),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 21),
                          child: Text(
                            status == '1' ? 'Would you like to Rebind? ' : 'Would you like to Unbind? ',
                            style: TextStyle(color: Color(0XFF333333), fontSize: 14, fontWeight: FontWeight.w500, decoration: TextDecoration.none),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 21),
                                  child: Text(
                                    'Cancel ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0XFF333333),
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: Color(0XFFEEEEEE),
                              width: 2,
                              height: 36,
                            ),
                            Expanded(
                              child: GestureDetector(
                                  onTap: (){
                                    _unbind();
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(horizontal: 21),
                                    child: Text(
                                      '${status == '1' ? 'Rebind' : 'Unbind'}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0XFFF36926),
                                          decoration: TextDecoration.none),
                                    ),
                                  )
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    new SingleChildScrollView(
                      child: new Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Rebind",
                                    style: new TextStyle(color: AppTheme.nearlyDarkBlue
                                        .withOpacity(0.8), fontSize: 45, fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    "Payment account",
                                    style: new TextStyle(color: AppTheme.nearlyDarkBlue
                                        .withOpacity(0.8), fontSize: 40, fontWeight: FontWeight.w800),
                                  ),
                                ]),
                            new SizedBox(
                              height: 40,
                            ),
                            new TextField(
                              controller: idController,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(11),
                              ],
                              keyboardType: TextInputType.number,
                              autocorrect: false,
                              decoration: new InputDecoration(
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 25,
                                    color: AppTheme.nearlyDarkBlue
                                        .withOpacity(0.5)),
                                labelText: "Payment Id\n",
                              ),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30,
                                  color: AppTheme.grey),
                            ),
                            new SizedBox(
                              height: 30,
                            ),
                            new TextField(
                              controller: passController,
                              keyboardType: TextInputType.text,
                              autocorrect: false,
                              decoration: new InputDecoration(
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 25,
                                    color: AppTheme.nearlyDarkBlue
                                        .withOpacity(0.5)),
                                labelText: "Payment Password\n",
                                suffixIcon: new GestureDetector(
                                  child: new Icon(
                                    Icons.remove_red_eye,
                                  ),
                                  onTap: _toggle,
                                ),
                              ),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30,
                                  color: AppTheme.grey),
                              obscureText: eye,
                            ),
                            new SizedBox(
                              height: 250,
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*const Divider(
                      height: 1,
                    ),
                    //popularFilter(),
                    const Divider(
                      height: 1,
                    ),
                    //distanceViewUI(),
                    const Divider(
                      height: 1,
                    ),*/
                    //allAccommodationUI()
                  ],
                ),
              ),
            ),
            const Divider(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16, top: 8),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.nearlyDarkBlue
                      .withOpacity(0.8),
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      blurRadius: 8,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      _bindAlert(context, 1);
                    },
                    child: Center(
                      child: Text(
                        'Unbind',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16, top: 8),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.nearlyDarkBlue
                      .withOpacity(0.8),
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      blurRadius: 8,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      _rebind();
                    },
                    child: Center(
                      child: Text(
                        'Rebind',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.nearlyWhite,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Bind',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }
}
