import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'Sp_util.dart';
import 'server_util.dart';
import 'toast_util.dart';
class carInfo{
  String phone = "";
  String username = "";
  String password = "";
  double balance = 0.0;
  String carnumber = "";
  String id_pay = "";
  List<String> trip = [];

  void initget(context) async{
    if (SpUtil.preferences.containsKey("phone")&&SpUtil.preferences.containsKey("password")){
      this.phone = SpUtil.preferences.getString("phone");
      this.password = SpUtil.preferences.getString("password");

      var dio = Dio();
      dio.options.baseUrl = Server.base;
      var cookieJar = CookieJar();
      dio.interceptors..add(LogInterceptor())..add(CookieManager(cookieJar));
      try {
        Response response = await dio.post("/car_login", data: {"phone":this.phone, "password":this.password});
        if (response.data["msg"] == "login success"){
          response = await dio.get("/get_info");
          this.phone = response.data["info"][0];
          this.username = response.data["info"][1];
          this.balance = response.data["info"][2];
          this.carnumber = response.data["info"][3];
          this.id_pay = response.data["info"][4];
          print("phone: "+this.phone );
          print("username: "+this.username);
          print("balance: "+this.balance.toString());
          print("carnumber: "+this.carnumber);
          print("id_pay: " + this.id_pay);

          SpUtil.preferences.setString("phone", this.phone);
          SpUtil.preferences.setString("username", this.username);
          SpUtil.preferences.setDouble("balance", this.balance);
          SpUtil.preferences.setString("carnumber", this.carnumber);
          SpUtil.preferences.setString("id_pay", this.id_pay);


          response = await dio.get("/get_trip");
          if (response.data['info'].length>0){
            for (int i = 0; i < response.data['info'].length; i++){
              String combine = response.data['info'][i][2].toString().length.toString()+response.data['info'][i][3].toString().length.toString();
              combine = combine + response.data['info'][i][0].toString() + response.data['info'][i][1].toString() + response.data['info'][i][2].toString() + response.data['info'][i][3].toString();
              this.trip.add(combine);
            }
            SpUtil.preferences.setStringList("trip", this.trip);
          }



        }
      } catch (e) {
        ToastUtil.toast(context, "网络连接错误");
      }
    }
  }

  String getPhone() {
    if (SpUtil.preferences.containsKey("phone")){
      return SpUtil.preferences.getString("phone");
    }
    return this.phone;
  }

  String getPassword(){
    if (SpUtil.preferences.containsKey("password")){
      return SpUtil.preferences.getString("password");
    }
    return this.password;
  }

  String getUsername(){
    if (SpUtil.preferences.containsKey("username")){
      return SpUtil.preferences.getString("username");
    }
    return this.username;
  }

  double getBalance(){
    if (SpUtil.preferences.containsKey("balance")){
      return SpUtil.preferences.getDouble("balance");
    }
    return this.balance;
  }

  String getCarnumber(){
    if (SpUtil.preferences.containsKey("carnumber")){
      return SpUtil.preferences.getString("carnumber");
    }
    return this.carnumber;
  }

  String getIdpay(){
    if (SpUtil.preferences.containsKey("id_pay")){
      return SpUtil.preferences.getString("id_pay");
    }
    return this.id_pay;
  }

  List<String> getTrip(){
    if (SpUtil.preferences.containsKey("trip")){
      return SpUtil.preferences.getStringList("trip");
    }
    return this.trip;
  }
}