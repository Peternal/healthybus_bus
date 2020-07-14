import 'package:flutter/material.dart';
import '../../app_theme.dart';

class NoTripView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const NoTripView({Key key, this.animationController, this.animation})
      : super(key: key);

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
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 0, bottom: 0),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: AppTheme.grey.withOpacity(0.4),
                                  offset: Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                              splashColor: AppTheme.nearlyDarkBlue.withOpacity(0.2),
                              onTap: () {},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 25,
                                          right: 16,
                                          top: 16,
                                        ),
                                        child: Text(
                                          " ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily:
                                            AppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25,
                                            letterSpacing: 0.0,
                                            color:
                                            AppTheme.nearlyDarkBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 25,
                                      bottom: 12,
                                      top: 8,
                                      right: 16,
                                    ),
                                    child: Text(
                                      "There's no history...",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 26,
                                        letterSpacing: 0.0,
                                        color: AppTheme.grey
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 25,
                                      bottom: 12,
                                      top: 4,
                                      right: 16,
                                    ),
                                    child: Text(
                                      "",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        letterSpacing: 0.0,
                                        color: AppTheme.grey
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -16,
                        left: 0,
                        child: SizedBox(
                          width: 110,
                          height: 110,
                          //child: Image.asset(".png"),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
