import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/author_bubble/author_label.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/mini_bz_label.dart';
import 'package:flutter/material.dart';

class HeaderLabels extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeaderLabels({
    @required this.superFlyer,
    @required this.flyerBoxWidth,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final SuperFlyer superFlyer;
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  static double getHeaderLabelWidth(double flyerBoxWidth){
    return flyerBoxWidth * (Ratioz.xxflyerAuthorPicWidth + Ratioz.xxflyerAuthorNameWidth);
  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final bool _tinyMode = FlyerBox.isTinyMode(context, flyerBoxWidth);
// -----------------------------------------------------------------------------
    final double labelsWidth = getHeaderLabelWidth(flyerBoxWidth);
    final double labelsHeight = flyerBoxWidth * (Ratioz.xxflyerHeaderMiniHeight - (2*Ratioz.xxflyerHeaderMainPadding));
// -----------------------------------------------------------------------------
    return
      _tinyMode == true ? Container() :
      SizedBox(
          width: labelsWidth,
          height: labelsHeight,
          // color: Colorz.Bl,
          child: Column(
            mainAxisAlignment: superFlyer.flyerShowsAuthor == true ? MainAxisAlignment.end : MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// BUSINESS LABEL : BZ.NAME & BZ.LOCALE
              BzLabel(
                superFlyer: superFlyer,
                flyerBoxWidth: flyerBoxWidth,
              ),

              /// middle expander ,, will delete i don't like it
              if (superFlyer.flyerShowsAuthor == false)
              const Expander(),

              /// AUTHOR LABEL : AUTHOR.IMAGE, AUTHOR.NAME, AUTHOR.TITLE, BZ.FOLLOWERS
              if (superFlyer.flyerShowsAuthor == true)
              AuthorLabel(
                flyerBoxWidth: flyerBoxWidth,
                authorID: superFlyer.authorID,
                bzModel: superFlyer.bz,
                showLabel: superFlyer.nav.bzPageIsOn,
                authorGalleryCount: 0, // is not needed here
                labelIsOn: true,
                onTap: null,
              ),

            ],
          )
      )
    ;
  }
}
