import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/secondary_models/draft_flyer_model.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/editor_footer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/footer_parts/ankh_button.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/slides_parts/slides_new.dart';
import 'package:flutter/material.dart';

class SlidesPage extends StatelessWidget {
  final SuperFlyer superFlyer;

  // final PageController horizontalController;
  // final DraftFlyerModel draft;
  // final Function onPageChanged;
  // final double flyerZoneWidth;
  // final Function triggerKeywordsView;
  // final bool bzPageIsOn;
  // final bool slidingIsOn;
  // final bool ankhIsOn;
  // final Function tappingAnkh;
  // final Function onAddImages;
  // final Function onDeleteSlide;
  // final Function onCropImage;
  // final Function onResetImage;
  // final Function onFitImage;
  // final BoxFit currentPicFit;

  const SlidesPage({
    @required this.superFlyer,
    // @required this.horizontalController,
    // @required this.draft,
    // @required this.onPageChanged,
    // @required this.flyerZoneWidth,
    // @required this.triggerKeywordsView,
    // @required this.bzPageIsOn,
    // @required this.slidingIsOn,
    // @required this.ankhIsOn,
    // @required this.tappingAnkh,
    // @required this.onAddImages,
    // @required this.onDeleteSlide,
    // @required this.onCropImage,
    // @required this.onResetImage,
    // @required this.onFitImage,
    // @required this.currentPicFit,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        /// SLIDES
        if(superFlyer.currentSlideIndex != null)
          SlidesNew(
            superFlyer: superFlyer,
            // horizontalController: superFlyer..horizontalController,
            // draft: draft,
            // onPageChanged: onPageChanged,
            // flyerZoneWidth: flyerZoneWidth,
            // triggerKeywordsView: triggerKeywordsView,
          ),

        /// ANKH
        if(superFlyer.currentSlideIndex != null && superFlyer.numberOfSlides != 0 && superFlyer.flyerState != FlyerState.Draft)
          AnkhButton(
            bzPageIsOn: superFlyer.bzPageIsOn,
            flyerZoneWidth: superFlyer.flyerZoneWidth,
            listenToSwipe: superFlyer.listenToSwipe,
            ankhIsOn: superFlyer.ankhIsOn,
            onAnkhTap: superFlyer.onAnkhTap,
          ),

        /// EDITOR FOOTER
        if (superFlyer.flyerState == FlyerState.Draft)
          EditorFooter(
            flyerZoneWidth: superFlyer.flyerZoneWidth,
            currentPicFit: superFlyer.currentPicFit,
            onAddImages: superFlyer.onAddImages,
            onDeleteSlide: superFlyer.onDeleteSlide,
            onCropImage: superFlyer.onCropImage,
            onResetImage: superFlyer.onResetImage,
            onFitImage: superFlyer.onFitImage,
            numberOdSlides: superFlyer.numberOfSlides,
          ),

      ],
    );
  }
}
