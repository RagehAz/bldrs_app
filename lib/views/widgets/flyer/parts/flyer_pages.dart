import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/models/secondary_models/draft_flyer_model.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/info_page_parts/info_page.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/slides_page.dart';
import 'package:flutter/material.dart';

class FlyerPages extends StatelessWidget {
  final SuperFlyer superFlyer;
  // final PageController horizontalController;
  // final DraftFlyerModel draft;
  // final Function onHorizontalSwipe;
  // final double flyerZoneWidth;
  // final Function onVerticalSwipe;
  // final bool bzPageIsOn;
  // final bool listenToSwipe;
  // final bool ankhIsOn;
  // final Function tappingAnkh;
  // final Function onAddImages;
  // final Function onDeleteSlide;
  // final Function onCropImage;
  // final Function onResetImage;
  // final Function onFitImage;
  // final BoxFit currentPicFit;
  // final Function onVerticalBack;
  // final Function onFlyerTypeTap;
  // final Function onZoneTap;
  // final Function onAboutTap;
  // final Function onKeywordsTap;
  // final ScrollController infoScrollController;
  // final PageController verticalController;
  // final Function onVerticalIndexChanged;

  const FlyerPages({
    @required this.superFlyer,
    // @required this.horizontalController,
    // @required this.draft,
    // @required this.onHorizontalSwipe,
    // @required this.flyerZoneWidth,
    // @required this.onVerticalSwipe,
    // @required this.bzPageIsOn,
    // @required this.listenToSwipe,
    // @required this.ankhIsOn,
    // @required this.tappingAnkh,
    // @required this.onAddImages,
    // @required this.onDeleteSlide,
    // @required this.onCropImage,
    // @required this.onResetImage,
    // @required this.onFitImage,
    // @required this.currentPicFit,
    // @required this.onVerticalBack,
    // @required this.onFlyerTypeTap,
    // @required this.onZoneTap,
    // @required this.onAboutTap,
    // @required this.onKeywordsTap,
    // @required this.infoScrollController,
    // @required this.verticalController,
    // @required this.onVerticalIndexChanged,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return PageView(
      pageSnapping: true,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      allowImplicitScrolling: true,
      onPageChanged: superFlyer.listenToSwipe ? (i) => superFlyer.onVerticalPageSwipe(i) : (i) => Sliders.zombie(i),
      controller: superFlyer.verticalController,
      children: <Widget>[

        /// SLIDES PAGE
        SlidesPage(
          superFlyer: superFlyer,
          ///// flyerZoneWidth: superFlyer.flyerZoneWidth,
          ///// horizontalController: superFlyer.horizontalController,
          ///// draft: draft,
          ///// onPageChanged: onHorizontalSwipe,
          ///// triggerKeywordsView: onVerticalSwipe,
          ///// bzPageIsOn: bzPageIsOn,
          ///// slidingIsOn: listenToSwipe,
          ///// ankhIsOn: ankhIsOn,
          ///// tappingAnkh: tappingAnkh,
          ///// currentPicFit: currentPicFit,
          ///// onAddImages: onAddImages,
          ///// onDeleteSlide: onDeleteSlide,
          ///// onCropImage: onCropImage,
          ///// onResetImage: onResetImage,
          ///// onFitImage: onFitImage,
        ),

        /// INFO PAGE
        InfoPage(
          superFlyer : superFlyer,
          // flyerZoneWidth: flyerZoneWidth,
          // draft: draft,
          // onVerticalBack: onVerticalBack,
          // onFlyerTypeTap: onFlyerTypeTap,
          // onZoneTap: onZoneTap,
          // onAboutTap: onAboutTap,
          // onKeywordsTap: onKeywordsTap,
          // verticalController: verticalController,
          // infoScrollController: infoScrollController,
        ),

      ],
    );
  }
}
