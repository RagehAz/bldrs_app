import 'package:bldrs/models/secondary_models/draft_flyer_model.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/editor_footer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/footer_parts/ankh_button.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/slides_parts/slides_new.dart';
import 'package:flutter/material.dart';

class SlidesPage extends StatelessWidget {
  final PageController horizontalController;
  final DraftFlyerModel draft;
  final Function onPageChanged;
  final double flyerZoneWidth;
  final Function triggerKeywordsView;
  final bool bzPageIsOn;
  final bool slidingIsOn;
  final bool ankhIsOn;
  final Function tappingAnkh;
  final Function onAddImages;
  final Function onDeleteSlide;
  final Function onCropImage;
  final Function onResetImage;
  final Function onFitImage;
  final BoxFit currentPicFit;

  const SlidesPage({
    @required this.horizontalController,
    @required this.draft,
    @required this.onPageChanged,
    @required this.flyerZoneWidth,
    @required this.triggerKeywordsView,
    @required this.bzPageIsOn,
    @required this.slidingIsOn,
    @required this.ankhIsOn,
    @required this.tappingAnkh,
    @required this.onAddImages,
    @required this.onDeleteSlide,
    @required this.onCropImage,
    @required this.onResetImage,
    @required this.onFitImage,
    @required this.currentPicFit,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        /// SLIDES
        if(draft.currentSlideIndex != null)
          SlidesNew(
            horizontalController: horizontalController,
            draft: draft,
            onPageChanged: onPageChanged,
            flyerZoneWidth: flyerZoneWidth,
            triggerKeywordsView: triggerKeywordsView,
          ),

        /// ANKH
        if(draft.currentSlideIndex != null && draft.numberOfSlides != 0 && draft.editMode == false)
          AnkhButton(
            bzPageIsOn: bzPageIsOn,
            flyerZoneWidth: flyerZoneWidth,
            slidingIsOn: slidingIsOn,
            ankhIsOn: ankhIsOn,
            tappingAnkh: tappingAnkh,
          ),

        /// EDITOR FOOTER
        if (draft.editMode == true)
          EditorFooter(
            flyerZoneWidth: flyerZoneWidth,
            currentPicFit: currentPicFit,
            onAddImages: onAddImages,
            onDeleteSlide: onDeleteSlide,
            onCropImage: onCropImage,
            onResetImage: onResetImage,
            onFitImage: onFitImage,
            numberOdSlides: draft.numberOfSlides,
          ),

      ],
    );
  }
}
