import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/providers/streamers/bz_streamer.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/bz_logo.dart';
import 'package:bldrs/views/widgets/general/nav_bar/nav_bar.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BzzButton extends StatelessWidget {
  final BarType barType;
  final Function onTap;
  final double width;
  final double circleWidth;
  final List<dynamic> bzzIDs;

  const BzzButton({
    this.barType = BarType.maxWithText,
    this.onTap,
    @required this.width,
    @required this.circleWidth,
    @required this.bzzIDs,
  });

Widget _nanoBzLogo(BuildContext context, String bzID){
  return Container(
    height: circleWidth * 0.47,
    width: circleWidth * 0.47,
    child: tinyBzModelStreamBuilder(
        bzID: bzID,
        context: context,
        builder: (ctx, _tinyBz){
          return
            DreamBox(
              height: circleWidth * 0.47,
              width: circleWidth * 0.47,
              corners: circleWidth * 0.47 * 0.25,
              icon: _tinyBz.bzLogo,
              bubble: true,
              onTap: onTap,
            );
        }),
  );
}

  @override
  Widget build(BuildContext context) {

    final double _circleWidth = circleWidth;
    final double _buttonCircleCorner = _circleWidth * 0.5;
    const double _paddings = Ratioz.appBarPadding * 1.5;

    const double _textScaleFactor = 0.95;
    const int _textSize = 1;

    final double _textBoxHeight =
    barType == BarType.maxWithText || barType == BarType.minWithText ?
    superVerseRealHeight(context, _textSize, _textScaleFactor, null)
        :
    0
    ;

    final double _buttonHeight = _circleWidth + ( 2 * _paddings ) + _textBoxHeight;
    final double _buttonWidth = width;

    // Color _designModeColor = Colorz.BloodTest;
    const bool _designMode = false;

    const bool _shadowIsOn = true;

    return
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: _buttonHeight,
          width: _buttonWidth,
          color: Colorz.Nothing,
          // padding: EdgeInsets.symmetric(horizontal: _paddings * 0.25),
          // alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              /// --- TOP MARGIN
              const SizedBox(
                height: _paddings,
              ),

              /// --- BZZ LOGOS
              bzzIDs.length == 0 ? Container(width: _circleWidth, height: _circleWidth,) :
              Container(
                width: _circleWidth,
                height: _circleWidth,
                alignment: Alignment.center,
                child:

                bzzIDs.length == 1 ?
                tinyBzModelStreamBuilder(
                    bzID: bzzIDs[0],
                    context: context,
                    builder: (ctx, _tinyBz){
                      return
                        DreamBox(
                          width: _circleWidth,
                          height: _circleWidth,
                          icon: _tinyBz.bzLogo,
                          iconSizeFactor: 1,
                          bubble: true,
                          color: Colorz.Nothing,
                          corners: _buttonCircleCorner,
                          designMode: _designMode,
                          onTap: onTap,
                        );
                    })

                    :

                bzzIDs.length == 2 ?
                Stack(
                  children: <Widget>[

                    tinyBzModelStreamBuilder(
                        bzID: bzzIDs[0],
                        context: context,
                        builder: (ctx, _tinyBz){
                          return
                            Positioned(
                              top: 0,
                              left: 0,
                              child: BzLogo(
                                width: _circleWidth * 0.7,
                                image: _tinyBz.bzLogo,
                                shadowIsOn: _shadowIsOn,
                                onTap: onTap,
                              ),
                            );
                        }),

                    tinyBzModelStreamBuilder(
                        bzID: bzzIDs[1],
                        context: context,
                        builder: (ctx, _tinyBz){
                          return
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: BzLogo(
                                width: _circleWidth * 0.7,
                                image: _tinyBz.bzLogo,
                                shadowIsOn: _shadowIsOn,
                                onTap: onTap,
                              ),
                            );
                        }),

                  ],
                )
                    :
                bzzIDs.length == 3 ?
                Container(
                  width: _circleWidth,
                  height: _circleWidth,
                  // color: Colorz.Grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          _nanoBzLogo(context, bzzIDs[0]),

                          _nanoBzLogo(context, bzzIDs[1]),

                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          _nanoBzLogo(context, bzzIDs[2]),

                          Container(
                            width: _circleWidth * 0.47,
                            height: _circleWidth * 0.47,
                            color: Colorz.Nothing,
                          ),

                        ],
                      ),

                    ],
                  ),
                )
                    :
                bzzIDs.length == 4 ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        _nanoBzLogo(context, bzzIDs[0]),

                        _nanoBzLogo(context, bzzIDs[1]),

                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        _nanoBzLogo(context, bzzIDs[2]),

                        _nanoBzLogo(context, bzzIDs[3]),

                      ],
                    ),

                  ],
                )
                    :
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        _nanoBzLogo(context, bzzIDs[0]),

                        _nanoBzLogo(context, bzzIDs[1]),

                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        _nanoBzLogo(context, bzzIDs[2]),

                        DreamBox(
                          height: _circleWidth * 0.47,
                          width: _circleWidth * 0.47,
                          verse: '+${(bzzIDs.length - 3)}',
                          verseWeight: VerseWeight.thin,
                          verseScaleFactor: 0.35,
                          bubble: false,
                          onTap: onTap,
                        ),

                      ],
                    ),

                  ],
                )

              ),

              /// --- BUTTON TEXT
              if (barType == BarType.maxWithText || barType == BarType.minWithText)
                Container(
                  width: _buttonWidth,
                  height: _textBoxHeight,
                  // color: Colorz.YellowLingerie,
                  alignment: Alignment.center,
                  child: const SuperVerse(
                    verse: 'Accounts',
                    maxLines: 2,
                    size: _textSize,
                    weight: VerseWeight.thin,
                    shadow: true,
                    scaleFactor: _textScaleFactor,
                    designMode: _designMode,
                  ),
                ),

            ],
          ),
        ),
      );
  }
}
