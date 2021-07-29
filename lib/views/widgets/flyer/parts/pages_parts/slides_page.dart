import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/editor_footer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/footer_parts/ankh_button.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/slides_parts/slides.dart';
import 'package:flutter/material.dart';

class SlidesPage extends StatelessWidget {
  final SuperFlyer superFlyer;

  const SlidesPage({
    @required this.superFlyer,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        /// SLIDES
        if(superFlyer.currentSlideIndex != null)
          Slides(
            superFlyer: superFlyer,
          ),

        /// ANKH
        if(superFlyer.currentSlideIndex != null && superFlyer.numberOfSlides != 0 && superFlyer.editMode == false)
          AnkhButton(
            bzPageIsOn: superFlyer.bzPageIsOn,
            flyerZoneWidth: superFlyer.flyerZoneWidth,
            listenToSwipe: superFlyer.listenToSwipe,
            ankhIsOn: superFlyer.ankhIsOn,
            onAnkhTap: superFlyer.onAnkhTap,
          ),

        /// EDITOR FOOTER
        if (superFlyer.editMode == true)
          EditorFooter(
            flyerZoneWidth: superFlyer.flyerZoneWidth,
            currentPicFit: superFlyer.currentPicFit,
            onAddImages: superFlyer.onAddImages,
            onDeleteSlide: superFlyer.onDeleteSlide,
            onCropImage: superFlyer.onCropImage,
            onResetImage: superFlyer.onResetImage,
            onFitImage: superFlyer.onFitImage,
            numberOdSlides: superFlyer.numberOfSlides,
            superFlyer: superFlyer,
          ),

      ],
    );
  }
}
