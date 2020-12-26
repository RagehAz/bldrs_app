import 'dart:ui';
import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';

class AppBarStrip extends StatelessWidget {
  final List<Widget> rowWidgets;

  AppBarStrip({
    @required this.rowWidgets,
  });

  @override
  Widget build(BuildContext context) {

    double abPadding = Ratioz.ddAppBarMargin;
    double abHeight = Ratioz.ddAppBarHeight;

    return SliverPadding(
      padding: EdgeInsets.only(top: 0),
      sliver : SliverAppBar(
        automaticallyImplyLeading: false,
        pinned: true,
        floating: true,
        expandedHeight: abHeight + (abPadding ),
        backgroundColor: Colorz.Nothing,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner))),
        titleSpacing: abPadding * 0,
        toolbarHeight: abHeight + (abPadding * 2),

        title: Padding(
          padding: EdgeInsets.all(abPadding),

          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              Container(
                width: double.infinity,
                height: abHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner)),
                  boxShadow: [
                    CustomBoxShadow(
                        color: Colorz.BlackBlack,
                        offset: Offset(0,0),
                        blurRadius: abHeight * 0.18,
                        blurStyle: BlurStyle.outer
                    ),
                    // CustomBoxShadow(
                    //     color: Colorz.BlackSmoke,
                    //     offset: Offset(0,0),
                    //     blurRadius: abHeight * 0.0,
                    //     blurStyle: BlurStyle.outer
                    // ),

                  ]
                ),
              ),

              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    width: double.infinity,
                    height: abHeight,
                    decoration: BoxDecoration(
                        color: Colorz.WhiteAir,
                        borderRadius: BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner))
                    ),
                  ),

                ),
              ),

              Row(children: rowWidgets)

            ],
          ),
        ),
      ),
    );
  }
}
