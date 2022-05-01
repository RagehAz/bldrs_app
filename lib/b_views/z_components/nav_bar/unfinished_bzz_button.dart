import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/nav_bar/nav_bar.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/bz_logo.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BzzButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzzButton({
    @required this.width,
    @required this.circleWidth,
    this.barType = BarType.maxWithText,
    this.onTap,
    // @required this.bzzIDs,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BarType barType;
  final Function onTap;
  final double width;
  final double circleWidth;
  // final List<dynamic> bzzIDs;
  /// --------------------------------------------------------------------------
  Widget _nanoBzLogo(BuildContext context, BzModel bzModel) {
    return SizedBox(
      height: circleWidth * 0.47,
      width: circleWidth * 0.47,
      child: DreamBox(
        height: circleWidth * 0.47,
        width: circleWidth * 0.47,
        corners: circleWidth * 0.47 * 0.25,
        icon: bzModel.logo,
        onTap: onTap,
      ),
    );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: true);
    final List<BzModel> _myBzz = _bzzProvider.myBzz;

    final double _circleWidth = circleWidth;
    final double _buttonCircleCorner = _circleWidth * 0.5;
    const double _paddings = Ratioz.appBarPadding * 1.5;

    const double _textScaleFactor = 0.95;
    const int _textSize = 1;

    final double _textBoxHeight =
        barType == BarType.maxWithText || barType == BarType.minWithText ?
        SuperVerse.superVerseRealHeight(
            context: context,
            size: _textSize,
            sizeFactor: _textScaleFactor,
            hasLabelBox: false,
        )
            :
        0;

    final double _buttonHeight = _circleWidth + (2 * _paddings) + _textBoxHeight;
    final double _buttonWidth = width;

    const bool _shadowIsOn = true;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: _buttonHeight,
        width: _buttonWidth,
        color: Colorz.nothing,
        // padding: EdgeInsets.symmetric(horizontal: _paddings * 0.25),
        // alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[

            /// --- TOP MARGIN
            const SizedBox(
              height: _paddings,
            ),

            /// --- BZZ LOGOS
            if (_myBzz.isEmpty)
              SizedBox(
                width: _circleWidth,
                height: _circleWidth,
              ),

            if (_myBzz.isNotEmpty)
              Container(
                  width: _circleWidth,
                  height: _circleWidth,
                  alignment: Alignment.center,
                  child: _myBzz.length == 1 ?

                  DreamBox(
                    width: _circleWidth,
                    height: _circleWidth,
                    icon: _myBzz[0].logo,
                    corners: _buttonCircleCorner,
                    onTap: onTap,
                  )

                      :

                  _myBzz.length == 2 ?
                  Stack(
                    children: <Widget>[

                      Positioned(
                        top: 0,
                        left: 0,
                        child: BzLogo(
                          width: _circleWidth * 0.7,
                          image: _myBzz[0].logo,
                          shadowIsOn: _shadowIsOn,
                          onTap: onTap,
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: BzLogo(
                          width: _circleWidth * 0.7,
                          image: _myBzz[1].logo,
                          shadowIsOn: _shadowIsOn,
                          onTap: onTap,
                        ),
                      ),

                    ],
                  )

                      :

                  _myBzz.length == 3 ?
                  SizedBox(
                    width: _circleWidth,
                    height: _circleWidth,
                    // color: Colorz.Grey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            _nanoBzLogo(context, _myBzz[0]),
                            _nanoBzLogo(context, _myBzz[1]),
                          ],
                        ),


                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            _nanoBzLogo(context, _myBzz[2]),

                            Container(
                              width: _circleWidth * 0.47,
                              height: _circleWidth * 0.47,
                              color: Colorz.nothing,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )

                      :

                  _myBzz.length == 4 ?
                  Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          _nanoBzLogo(context, _myBzz[0]),
                          _nanoBzLogo(context, _myBzz[1]),

                        ],
                                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _nanoBzLogo(context, _myBzz[2]),
                          _nanoBzLogo(context, _myBzz[3]),
                        ],
                      ),
                    ],
                  )

                      :

                  Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: <Widget>[

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _nanoBzLogo(context, _myBzz[0]),
                          _nanoBzLogo(context, _myBzz[1]),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          _nanoBzLogo(context, _myBzz[2]),
                          DreamBox(
                            height: _circleWidth * 0.47,
                            width: _circleWidth * 0.47,
                            verse: '+${_myBzz.length - 3}',
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
            if (barType == BarType.maxWithText ||
                barType == BarType.minWithText)
              Container(
                width: _buttonWidth,
                height: _textBoxHeight,
                // color: Colorz.YellowLingerie,
                alignment: Alignment.center,
                child: SuperVerse(
                  verse: superPhrase(context, 'phid_my_bz_accounts'),
                  maxLines: 2,
                  size: _textSize,
                  weight: VerseWeight.thin,
                  shadow: true,
                  scaleFactor: _textScaleFactor,
                ),
              ),

          ],
        ),
      ),
    );
  }
}
