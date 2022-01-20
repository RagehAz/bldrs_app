import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/header_right_spacer_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/mini_header_strip_box_part.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_logo.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_pg_headline.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_follow_and_call_bts.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_header_labels.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/old_flyer_zone_box.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/follow_and_call_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/header_left_spacer_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/header_middle_spacer_part.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/active_flyer_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/animators.dart' as Animators;
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MiniHeaderStripPart extends StatelessWidget {

  const MiniHeaderStripPart({
    @required this.flyerBoxWidth,
    @required this.minHeaderHeight,
    @required this.logoSizeRatioTween,
    @required this.headerLeftSpacerTween,
    @required this.tinyMode,
    @required this.headerBorders,
    @required this.logoMinWidth,
    @required this.logoBorders,
    @required this.headerIsExpanded,
    @required this.headerMiddleSpacerWidthTween,
    @required this.headerLabelsWidthTween,
    @required this.followCallButtonsScaleTween,
    @required this.followIsOn,
    @required this.onFollowTap,
    @required this.onCallTap,
    @required this.headerRightSpacerTween,
    @required this.flyerModel,
    @required this.bzModel,
    @required this.bzCountry,
    @required this.bzCity,
    Key key
  }) : super(key: key);

  final double flyerBoxWidth;
  final double minHeaderHeight;
  final Animation<double> logoSizeRatioTween;
  final Animation<double> headerLeftSpacerTween;
  final bool tinyMode;
  final BorderRadius headerBorders;
  final double logoMinWidth;
  final BorderRadius logoBorders;
  final bool headerIsExpanded;
  final Animation<double> headerMiddleSpacerWidthTween;
  final Animation<double> headerLabelsWidthTween;
  final Animation<double> followCallButtonsScaleTween;
  final bool followIsOn;
  final Function onFollowTap;
  final Function onCallTap;
  final Animation<double> headerRightSpacerTween;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final CountryModel bzCountry;
  final CityModel bzCity;

  @override
  Widget build(BuildContext context) {

    return MiniHeaderStripBoxPart(
      flyerBoxWidth: flyerBoxWidth,
      minHeaderHeight: minHeaderHeight,
      logoSizeRatioTween: logoSizeRatioTween,
      headerLeftSpacerTween: headerLeftSpacerTween,
      tinyMode: tinyMode,
      headerBorders: headerBorders,
      children: <Widget>[

        /// HEADER LEFT SPACER
        HeaderLeftSpacerPart(
          headerLeftSpacerTween: headerLeftSpacerTween,
          logoMinWidth: logoMinWidth,
          logoSizeRationTween: logoSizeRatioTween,
        ),

        /// LOGO
        BzLogo(
          width: logoMinWidth * logoSizeRatioTween.value,
          image: bzModel?.logo,
          tinyMode: FlyerBox.isTinyMode(context, flyerBoxWidth),
          corners: logoBorders,
          bzPageIsOn: headerIsExpanded,
          zeroCornerIsOn: flyerModel.showsAuthor,
          // onTap:
          //superFlyer.onHeaderTap,
          // (){
          //   setState(() {
          //     _statelessFadeMaxHeader();
          //   });
          // }
        ),

        /// MIDDLE SPACER
        HeaderMiddleSpacerPart(
          logoMinWidth: logoMinWidth,
          headerMiddleSpacerWidthTween: headerMiddleSpacerWidthTween,
          logoSizeRatioTween: logoSizeRatioTween,
        ),

        /// HEADER LABELS
        AnimatedOpacity(
          opacity: tinyMode == true ? 0 : 1,
          duration: Ratioz.duration150ms,
          child: Center(
            child: SizedBox(
              width: headerLabelsWidthTween.value,
              height: logoMinWidth * logoSizeRatioTween.value,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: <Widget>[

                  HeaderLabels(
                    flyerBoxWidth: flyerBoxWidth  * logoSizeRatioTween.value,
                    authorID: flyerModel.authorID,
                    bzCity: bzCity,
                    bzCountry: bzCountry,
                    bzModel: bzModel,
                    headerIsExpanded: false, //_headerIsExpanded,
                    flyerShowsAuthor: flyerModel.showsAuthor,
                  ),

                ],
              ),
            ),
          ),
        ),

        /// FOLLOW AND CALL
        FollowAndCallPart(
          tinyMode: tinyMode,
          logoSizeRatioTween: logoSizeRatioTween,
          flyerBoxWidth: flyerBoxWidth,
          followCallButtonsScaleTween: followCallButtonsScaleTween,
          followIsOn: followIsOn,
          onCallTap: onCallTap,
          onFollowTap: onFollowTap,
          logoMinWidth: logoMinWidth,
        ),

        /// HEADER RIGHT SPACER
        HeaderRightSpacerPart(
          logoMinWidth: logoMinWidth,
          logoSizeRatioTween: logoSizeRatioTween,
          headerRightSpacerTween: headerRightSpacerTween,
        ),


      ],
    );

    return Container(
      width: flyerBoxWidth,
      height: (minHeaderHeight * logoSizeRatioTween.value) + (headerLeftSpacerTween.value),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: headerLeftSpacerTween.value),
      decoration: BoxDecoration(
        color: tinyMode == true ? Colorz.white50 : Colorz.black80,
        borderRadius: Borderers.superBorderOnly(
          context: context,
          enTopRight: headerBorders.topRight.x,
          enTopLeft: headerBorders.topRight.x,
          enBottomRight: 0,
          enBottomLeft: 0,
        ),
      ),

      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        key: const PageStorageKey<String>('miniHeaderStrip'),
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[


        ],
      ),
    );
  }
}
