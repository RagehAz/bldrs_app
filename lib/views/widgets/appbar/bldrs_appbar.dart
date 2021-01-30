import 'dart:ui';
import 'package:bldrs/view_brains/drafters/aligners.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/appbar/ab_localizer.dart';
import 'package:bldrs/views/widgets/appbar/ab_main.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BldrsAppBar extends StatefulWidget {
  final AppBarType appBarType;
  final List<Widget> appBarRowWidgets;
  final String pageTitle;

  BldrsAppBar({
    this.appBarType = AppBarType.Main,
    this.appBarRowWidgets,
    this.pageTitle,
});

  @override
  _BldrsAppBarState createState() => _BldrsAppBarState();
}

class _BldrsAppBarState extends State<BldrsAppBar> {
  AppBarType _appBarType;
// ---------------------------------------------------------------------------
  @override
  void initState() {
    _appBarType = widget.appBarType;
    super.initState();
  }
// ---------------------------------------------------------------------------
  void _tappingLocalizer(){
    setState(() {
      _appBarType == AppBarType.Localizer ?
      _appBarType = widget.appBarType
          :
      _appBarType = AppBarType.Localizer;
    });
    print('tapping localizer button, appbar is : $_appBarType');
  }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return

      _appBarType == AppBarType.Main
          || _appBarType == AppBarType.Intro?
          ABMain(
            tappingLocalizer: _tappingLocalizer,
            sectionsAreOn:  _appBarType == AppBarType.Intro? false : true,
            searchButtonOn: _appBarType == AppBarType.Intro? false : true,
          )

      :

      _appBarType == AppBarType.Basic
          || _appBarType == AppBarType.Scrollable?
      ABStrip(
        scrollable: _appBarType == AppBarType.Scrollable ? true : false,
        rowWidgets: (_appBarType == null && widget.pageTitle == null) ? [Container()] :
        <Widget>[
          widget.pageTitle == null ? Container() :
          Center(
            child: SuperVerse(
              verse: widget.pageTitle,
              size: 3,
              margin: 10,
              shadow: true,
            ),),
          ... widget.appBarRowWidgets == null ? [Container()] : widget.appBarRowWidgets,
        ],
      )

          :

      _appBarType == AppBarType.Localizer ?
          ABLocalizer(
            tappingLocalizer: _tappingLocalizer,
          )

          :

      Container()

    ;
  }
}

class ABStrip extends StatelessWidget {
  final List<Widget> rowWidgets;
  final double abHeight;
  final bool scrollable;
  final AppBarType appBarType;

  ABStrip({
    this.rowWidgets,
    this.abHeight = Ratioz.ddAppBarHeight,
    this.scrollable = false,
    this.appBarType,
  });
  @override
  Widget build(BuildContext context) {

    double screenWidth = superScreenWidth(context);
    double abWidth = screenWidth - (2 * Ratioz.ddAppBarMargin);
    double _blurValue = appBarType == AppBarType.Localizer ? 10 : 5;

    return Container(
      width: abWidth,
      height: abHeight,
      alignment: Alignment.center,
      margin: EdgeInsets.all(Ratioz.ddAppBarMargin),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner)),
          boxShadow: [
            CustomBoxShadow(
                color: Colorz.BlackSmoke,
                offset: Offset(0, 0),
                blurRadius: abHeight * 0.18,
                blurStyle: BlurStyle.outer),
          ]),
      child: Stack(
        alignment: superCenterAlignment(context),
        children: <Widget>[

          // APPBAR SHADOW
          Container(
            width: double.infinity,
            height: abHeight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner)),
                boxShadow: [
                  CustomBoxShadow(
                      color: Colorz.BlackBlack,
                      offset: Offset(0, 0),
                      blurRadius: 10,
                      blurStyle: BlurStyle.outer),
                ]),
          ),

          // APPBAR BLUR
          ClipRRect(
            borderRadius:
            BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: _blurValue, sigmaY: _blurValue),
              child: Container(
                width: double.infinity,
                height: abHeight,
                decoration: BoxDecoration(
                    color: Colorz.WhiteAir,
                    borderRadius: BorderRadius.all(
                        Radius.circular(Ratioz.ddAppBarCorner))),
              ),
            ),
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
                  width: screenWidth - (2 * Ratioz.ddAppBarMargin),
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

