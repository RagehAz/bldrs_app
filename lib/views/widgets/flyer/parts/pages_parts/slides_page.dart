import 'package:bldrs/controllers/drafters/tracers.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/editor_footer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/footer_parts/ankh_button.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/slides_parts/slides.dart';
import 'package:flutter/material.dart';

class SlidesPage extends StatelessWidget {
  final SuperFlyer superFlyer;
  final double flyerZoneWidth;

  const SlidesPage({
    @required this.superFlyer,
    @required this.flyerZoneWidth,
  });

  @override
  Widget build(BuildContext context) {

    Tracer.traceWidgetBuild(widgetName: 'SlidesPage', varName: 'numberOfSlides', varValue: superFlyer.numberOfSlides);

    return Stack(
      children: <Widget>[

        /// SLIDES
        if(superFlyer.currentSlideIndex != null)
          Slides(
            superFlyer: superFlyer,
            flyerZoneWidth: flyerZoneWidth,
          ),

        /// ANKH
        if(superFlyer.currentSlideIndex != null && superFlyer.numberOfSlides != 0 && superFlyer.editMode != true)
          AnkhButton(
            bzPageIsOn: superFlyer.bzPageIsOn,
            flyerZoneWidth: flyerZoneWidth,
            listenToSwipe: superFlyer.listenToSwipe,
            ankhIsOn: superFlyer.ankhIsOn,
            onAnkhTap: superFlyer.onAnkhTap,
          ),

        /// EDITOR FOOTER
        if (superFlyer.editMode == true)
          EditorFooter(
            flyerZoneWidth: flyerZoneWidth,
            currentPicFit: superFlyer.currentPicFit,
            onAddImages: superFlyer.onAddImages,
            onDeleteSlide: superFlyer.onDeleteSlide,
            onCropImage: superFlyer.onCropImage,
            onResetImage: superFlyer.onResetImage,
            onFitImage: superFlyer.onFitImage,
            numberOfSlides: superFlyer.numberOfSlides,
            superFlyer: superFlyer,
          ),

      ],
    );
  }
}
