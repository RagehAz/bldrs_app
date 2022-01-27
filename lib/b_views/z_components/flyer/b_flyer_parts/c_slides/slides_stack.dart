import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/widgets/general/images/super_image.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/slides_part.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class SlidesStack extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlidesStack({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.tinyMode,
    @required this.currentSlideIndex,
    @required this.flyerModel,
    @required this.horizontalController,
    @required this.onSwipeSlide,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final bool tinyMode;
  final ValueNotifier<int> currentSlideIndex;
  final FlyerModel flyerModel;
  final PageController horizontalController;
  final ValueChanged<int> onSwipeSlide;
  /// --------------------------------------------------------------------------
  bool _canShowSaveButton(){
    bool _canShow = false;

    if (
    currentSlideIndex?.value != null &&
    canLoopList(flyerModel?.slides) == true
    ){
      _canShow = true;
    }

    return _canShow;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    return Stack(
      children: <Widget>[

        /// SLIDES
        if (currentSlideIndex?.value != null)
          FlyerSlides(
            flyerModel: flyerModel,
            flyerBoxWidth: flyerBoxWidth,
            flyerBoxHeight: flyerBoxHeight,
            tinyMode: tinyMode,
            horizontalController: horizontalController,
            onSwipeSlide: onSwipeSlide,
          ),



        /// PRICE TAG
        // if (superFlyer.priceTagIsOn == true)
        //   OldPriceTag(
        //     flyerBoxWidth: flyerBoxWidth,
        //     superFlyer: superFlyer,
        //   ),

        /// SAVE BUTTON
        if (_canShowSaveButton() == true)
          Container(),
        //   SaveButton(
        //     bzPageIsOn: superFlyer.nav.bzPageIsOn,
        //     flyerBoxWidth: flyerBoxWidth,
        //     listenToSwipe: superFlyer.nav.listenToSwipe,
        //     ankhIsOn: superFlyer.rec.ankhIsOn,
        //     onAnkhTap: superFlyer.rec.onAnkhTap,
        //   ),


      ],

    );
  }
}
