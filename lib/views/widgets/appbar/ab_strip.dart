import 'dart:ui';
import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';

class ABStrip extends StatelessWidget {
  final List<Widget> rowWidgets;
  final double abHeight;
  final bool scrollable;
  final AppBarType appBarType;
  final bool loading;

  ABStrip({
    this.rowWidgets,
    this.abHeight = Ratioz.ddAppBarHeight,
    this.scrollable = false,
    this.appBarType,
    this.loading,
  });
  @override
  Widget build(BuildContext context) {

    double _screenWidth = superScreenWidth(context);
    double _abWidth = _screenWidth - (2 * Ratioz.ddAppBarMargin);
    double _blurValue = appBarType == AppBarType.Localizer || appBarType == AppBarType.Sections? Ratioz.blur2 : Ratioz.blur1;

    return Container(
      width: _abWidth,
      height: abHeight,
      alignment: Alignment.center,
      margin: EdgeInsets.all(Ratioz.ddAppBarMargin),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner)),
          color: appBarType == AppBarType.InPyramids ? Colorz.WhiteGlass : null,
          boxShadow: Shadowz.appBarShadow,
      ),
      child: Stack(
        alignment: Aligners.superCenterAlignment(context),
        children: <Widget>[

          // --- APPBAR SHADOW
          // Container(
          //   width: double.infinity,
          //   height: abHeight,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner)),
          //       boxShadow: Shadowz.appBarShadow,
          //   ),
          // ),

          // --- APPBAR BLUR
          // if (appBarType != AppBarType.InPyramids)
          BlurLayer(
            width: _abWidth,
            height: abHeight,
            blur: _blurValue,
            borders: BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner)),
          ),

          Container(
            width: _abWidth,
            height: abHeight,
            alignment: Aligners.superInverseCenterAlignment(context),
            child: Loading(loading: loading),
          ),


          // --- CONTENTS INSIDE THE APP BAR
          scrollable ?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(Ratioz.ddAppBarCorner),
                child: Container(
                  width: _screenWidth - (2 * Ratioz.ddAppBarMargin),
                  height: 50,
                  alignment: Alignment.center,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: rowWidgets,
                  ),
                ),
              )
            ],
          )
              :
          appBarType == AppBarType.Localizer ?
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowWidgets,
          )
              :
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowWidgets,
          ),
        ],
      ),
    );
  }
}
