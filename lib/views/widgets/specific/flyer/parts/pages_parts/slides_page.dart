import 'package:bldrs/controllers/drafters/tracers.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/flyer_methods.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/editor_footer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/footer_parts/ankh_button.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/price_tag.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/slides_parts/slides.dart';
import 'package:flutter/material.dart';

class SlidesPage extends StatelessWidget {
  final SuperFlyer superFlyer;
  final double flyerBoxWidth;

  const SlidesPage({
    @required this.superFlyer,
    @required this.flyerBoxWidth,
    Key key,
  }) : super(key: key);
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    Tracer.traceWidgetBuild(widgetName: 'SlidesPage', varName: 'numberOfSlides', varValue: superFlyer.numberOfSlides, tracerIsOn: false);
    return Stack(
      children: <Widget>[

        /// SLIDES
        if(superFlyer.currentSlideIndex != null)
          Slides(
            superFlyer: superFlyer,
            flyerBoxWidth: flyerBoxWidth,
          ),

        /// PRICE TAG
        if(superFlyer.priceTagIsOn == true)
        PriceTag(
          flyerBoxWidth: flyerBoxWidth,
          superFlyer: superFlyer,
        ),

        /// ANKH
        if(superFlyer.currentSlideIndex != null && superFlyer.numberOfSlides != 0 && superFlyer.edit.editMode != true)
          AnkhButton(
            bzPageIsOn: superFlyer.nav.bzPageIsOn,
            flyerBoxWidth: flyerBoxWidth,
            listenToSwipe: superFlyer.nav.listenToSwipe,
            ankhIsOn: superFlyer.rec.ankhIsOn,
            onAnkhTap: superFlyer.rec.onAnkhTap,
          ),

        /// EDITOR FOOTER
        if (superFlyer.edit.editMode == true)
          EditorFooter(
            flyerBoxWidth: flyerBoxWidth,
            currentPicFit: FlyerMethod.getCurrentBoxFitFromSuperFlyer(superFlyer: superFlyer),
            onAddImages: superFlyer.edit.onAddImages,
            onDeleteSlide: superFlyer.edit.onDeleteSlide,
            onCropImage: superFlyer.edit.onCropImage,
            onResetImage: superFlyer.edit.onResetImage,
            onFitImage: superFlyer.edit.onFitImage,
            numberOfSlides: superFlyer.numberOfSlides,
            superFlyer: superFlyer,
          ),

      ],
    );
  }
}
