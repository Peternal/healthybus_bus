import 'package:flutter/material.dart';
import 'user/user.dart';
import 'trip/trip.dart';
import 'pay/pay.dart';
import 'balance/balance.dart';
import 'util/carInfo_util.dart';

class UserMain extends StatefulWidget {
  final String username;
  const UserMain({
    Key key,
    @required this.username,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<UserMain> with TickerProviderStateMixin{
  AnimationController animationController;
  final _bottomNavigationColor = Color.fromARGB(255, 78, 70, 216);
  int _currentIndex = 0;
  List<int> list = List();
  Widget tabBody = Container(
    color: Colors.white,
  );

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    tabBody = UserScreen(animationController: animationController);
    list = [0,1,2,3];
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Stack(
              children: <Widget>[
                tabBody,
              ],
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _bottomNavigationColor,
              ),
              title: Text(
                'User',
                style: TextStyle(color: _bottomNavigationColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.payment,
                color: _bottomNavigationColor,
              ),
              title: Text(
                'Scan',
                style: TextStyle(color: _bottomNavigationColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_balance_wallet,
                color: _bottomNavigationColor,
              ),
              title: Text(
                'Balance',
                style: TextStyle(color: _bottomNavigationColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.trip_origin,
                color: _bottomNavigationColor,
              ),
              title: Text(
                'Trip',
                style: TextStyle(color: _bottomNavigationColor),
              )),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          animationController.reverse().then<dynamic>((data) {
            if (!mounted) {
              return;
            }
            setState(() {
              _currentIndex = index;
              if (index == 0){
                carInfo().initget(context);
                tabBody = UserScreen(animationController: animationController);
              }else if(index == 1){
                carInfo().initget(context);
                tabBody = PayScreen(animationController: animationController);
              }else if(index == 2){
                carInfo().initget(context);
                tabBody = BalanceScreen(animationController: animationController);
              }else{
                carInfo().initget(context);
                tabBody = TripScreen(animationController: animationController);
              }
            });
          });
        },
        type: BottomNavigationBarType.shifting,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 600));
    return true;
  }
}