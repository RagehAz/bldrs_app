import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BldrsSliverAppBarSmall extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsSliverAppBarSmall({
    @required this.content,
    /// if given,, overrides default height
    this.contentHeight,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget content;
  final double contentHeight;
  // -----------------------------------------------------------------------------
  static double getCollapsedSliverHeight({
    double givenContentHeight,
  }){
    return
      (Ratioz.appBarSmallHeight)
          +
          (Ratioz.appBarMargin * 2)
          +
          getContentHeight(
            givenContentHeight: givenContentHeight,
          );
  }
  // --------------------
  static double getContentHeight({
    double givenContentHeight,
  }){
    return (givenContentHeight ?? Ratioz.appBarSmallHeight) + _separatorLineThickness;
  }
  // --------------------
  static const double _separatorLineThickness = 0.25;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _collapsedHeight = getCollapsedSliverHeight(
      givenContentHeight: contentHeight,
    );
    // --------------------
    final double _contentHeight = getContentHeight(
      givenContentHeight: contentHeight,
    );
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    // --------------------
    return SliverAppBar(
      collapsedHeight: _collapsedHeight,
      // expandedHeight: ,
      backgroundColor: Colorz.blackSemi230,
      leadingWidth: 0,
      leading: Container(),
      floating: true,
      flexibleSpace: FlexibleSpaceBar(

        /// ENTIRE BOX BEHIND BLDRS STATIC APP BAR
        background: Container(
          width: _screenWidth,
          height: _collapsedHeight,
          alignment: Alignment.bottomCenter,
          /// ONLY THE BOX TO SHOW BENEATH BLDRS STATIC APPBAR
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[

              SizedBox(
                  width: _screenWidth,
                  height: _contentHeight,
                  child: content
              ),

              Container(
                width: _screenWidth - 20,
                height: _separatorLineThickness,
                color: Colorz.yellow200,
              ),

            ],

          ),

        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
