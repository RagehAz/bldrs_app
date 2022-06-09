import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/nav_bar/bzz_button/b_smart_bz_nav_bar_logos.dart';
import 'package:bldrs/b_views/z_components/nav_bar/nav_bar.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/c_controllers/a_starters_controllers/nav_bar_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class MyBzzNavButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MyBzzNavButton({
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<BzModel> _myBzz = BzzProvider.proGetMyBzz(context: context, listen: true);

    const double _circleWidth = NavBar.circleWidth;
    const double _paddings = Ratioz.appBarPadding * 1.5;
    const double _textScaleFactor = 0.95;
    const int _textSize = 1;
    const BarType _barType = NavBar.barType;

    final double _textBoxHeight = _barType == BarType.maxWithText || _barType == BarType.minWithText ?
        SuperVerse.superVerseRealHeight(
            context: context,
            size: _textSize,
            sizeFactor: _textScaleFactor,
            hasLabelBox: false,
        )
            :
        0;

    final double _buttonHeight = _circleWidth + (2 * _paddings) + _textBoxHeight;
    const double _buttonWidth = NavBar.navBarButtonWidth;

    return GestureDetector(
      onTap: () => onNavBarBzzButtonTap(
        context: context,
        myBzz: _myBzz,
      ),
      child: Container(
        height: _buttonHeight,
        width: _buttonWidth,
        color: Colorz.nothing,
        child: Column(
          children: <Widget>[

            /// --- TOP MARGIN
            const SizedBox(
              height: _paddings,
            ),

            /// --- BZZ LOGOS
            if (_myBzz.isNotEmpty)
              const SmartBzNavBarLogos(),

            /// --- BUTTON TEXT
            if (_barType == BarType.maxWithText ||
                _barType == BarType.minWithText)
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
