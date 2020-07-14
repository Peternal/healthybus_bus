import 'package:flutter/material.dart';
import '../../app_theme.dart';
import '../../util/carInfo_util.dart';
import 'withdraw_view.dart';
import '../../util/toast_util.dart';

class BalanceCardView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const BalanceCardView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(0.0, 30 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: AppTheme.grey.withOpacity(0.2), offset: const Offset(1.1, 1.1), blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4, bottom: 3),
                                      child: Text(
                                        "¥"+carInfo().getBalance().toString()+"0",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 45,
                                          color: AppTheme.nearlyDarkBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4, top: 2, bottom: 14),
                                  child: Text(
                                    'Available in your balance',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: AppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      letterSpacing: 0.0,
                                      color: AppTheme.darkText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 16),
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                  color: AppTheme.background,
                                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  /*
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Icon(
                                          Icons.access_time,
                                          color: AppTheme.grey.withOpacity(0.5),
                                          size: 16,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          'Linkcount: 13131465139',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: AppTheme.grey.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  */
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Icon(
                                            carInfo().getBalance()<10?Icons.error_outline:Icons.check_circle_outline,
                                            color: carInfo().getBalance()<10?Color.fromARGB(255, 246, 82, 131):Colors.green,
                                            size: 20,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            carInfo().getBalance()<10?"Insufficient Balance!":"Sufficient Balance!",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontFamily: AppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              letterSpacing: 0.0,
                                              color: carInfo().getBalance()<10?Color.fromARGB(255, 246, 82, 131):Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "    ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: AppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              letterSpacing: 0.5,
                                              color: AppTheme.nearlyDarkBlue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 38 * 2.0,
                                      height: 1 * 1.0,
                                      /*child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ScaleTransition(
                                          alignment: Alignment.center,
                                          scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                                              CurvedAnimation(
                                                  parent: animationController,
                                                  curve: Curves.fastOutSlowIn)),
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
                                                  if (carInfo().getIdpay()==""){
                                                    ToastUtil.toast(context, "请先绑定支付账户");
                                                  }
                                                  else{
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => TopUpScreen()),
                                                    );
                                                  }
                                                  //Navigator.push(context, PopRoute(child: TopupWidget()));
                                                },
                                                child: Icon(
                                                  Icons.add,
                                                  color: AppTheme.white,
                                                  size: 32,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),*/
                                    ),
                                  ]
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "    ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: AppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              letterSpacing: 0.5,
                                              color: AppTheme.nearlyDarkBlue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 38 * 2.0,
                                      height: 38 * 2.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ScaleTransition(
                                          alignment: Alignment.center,
                                          scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                                              CurvedAnimation(
                                                  parent: animationController,
                                                  curve: Curves.fastOutSlowIn)),
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
                                                  if (carInfo().getIdpay()==""){
                                                    ToastUtil.toast(context, "请先绑定支付账户");
                                                  } else {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => WithDrawScreen()),
                                                    );
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.remove,
                                                  color: AppTheme.white,
                                                  size: 32,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
