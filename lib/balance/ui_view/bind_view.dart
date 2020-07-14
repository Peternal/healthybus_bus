import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app_theme.dart';
import 'package:flutter/services.dart';
import '../moneyinput.dart';
import '../../util/toast_util.dart';
import '../../util/server_util.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio/dio.dart';
import '../../util/carInfo_util.dart';


class BindScreen extends StatefulWidget {
  @override
  _BindScreenState createState() => _BindScreenState();
}

class _BindScreenState extends State<BindScreen> {

  TextEditingController idController = TextEditingController();

  TextEditingController passController = TextEditingController();


  double distValue = 50.0;

  bool eye = true;

  void _toggle() {
    setState(() {
      eye = !eye;
    });
  }

  void _bind() async {
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
              ToastUtil.toast(context, "绑定成功");
              carInfo().initget(context);
              Navigator.pop(context);
            }else{
              ToastUtil.toast(context, "绑定失败");
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
                                    "Bind",
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
                      _bind();
                    },
                    child: Center(
                      child: Text(
                        'Bind',
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
