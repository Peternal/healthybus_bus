import 'package:flutter/material.dart';
import 'usermain.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio/dio.dart';
import 'util/toast_util.dart';
import 'util/server_util.dart';
import 'login.dart';
import 'util/Sp_util.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  realRunApp();
}

void realRunApp() async {
  bool success = await SpUtil.getInstance();
  print("init-"+success.toString());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login",
      theme: new ThemeData(
        primaryColor: Colors.grey,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var phone;
  var autoLogin = 0;

  //判断自动登录
  Future _validLogin() async{
    Auto_login().then((value){
      if(value!=null){
        setState(() {
          autoLogin = 1;
          phone = value;
        });
      }else{
        setState(() {
          autoLogin = 2;
        });
      }
    });
  }

  //异步自动登录
  Future<dynamic> Auto_login() async{
    if (SpUtil.preferences.containsKey("phone")&&SpUtil.preferences.containsKey("password")){
      String ph = SpUtil.preferences.getString("phone");
      String pwd = SpUtil.preferences.getString("password");
      if(ph!=null && pwd!=null){
        Dio dio = new Dio();
        dio.options.baseUrl = Server.base;
        var cookieJar = CookieJar();
        dio.interceptors..add(LogInterceptor())..add(CookieManager(cookieJar));
        try {
          Response response = await dio.post("/car_login", data: {"phone":ph, "password":pwd});
          print(response.data["msg"]);
          if (response.data["msg"] == "login success"){
            response = await dio.get("/get_info");
            SpUtil.preferences.setString("username", response.data["info"][1]);
            SpUtil.preferences.setDouble("balance", response.data["info"][2]);
            SpUtil.preferences.setString("carnumber", response.data["info"][3]);
            SpUtil.preferences.setString("id_pay", response.data["info"][4]);


            List<String> trip = [];

            response = await dio.get("/get_trip");
            if (response.data['info'].length>0){
              for (int i = 0; i < response.data['info'].length; i++){
                String combine = response.data['info'][i][2].toString().length.toString()+response.data['info'][i][3].toString().length.toString();
                combine = combine + response.data['info'][i][0].toString() + response.data['info'][i][1].toString() + response.data['info'][i][2].toString() + response.data['info'][i][3].toString();
                trip.add(combine);
              }
              SpUtil.preferences.setStringList("trip", trip);
            }

            return ph;
          }
        } catch (e) {
          // The request was made and the server responded with a status code
          // that falls out of the range of 2xx and is also not 304.
          ToastUtil.toast(context, "网络连接错误");
          return null;
        }
      }
    }
    SpUtil.preferences.clear();
    return null;
  }



  @override
  void initState() {
    super.initState();
    _validLogin();
  }

  @override
  Widget build(BuildContext context) {
    if (autoLogin==1){
      return UserMain(username: phone);//自动登录到用户界面
    }else if(autoLogin==2){//跳转登录界面
      return Login();
    }
    return Scaffold(//等待界面
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,);
  }

}