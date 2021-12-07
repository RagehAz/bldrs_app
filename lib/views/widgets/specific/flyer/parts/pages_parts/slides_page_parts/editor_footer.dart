import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/standards.dart' as Standards;
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/footer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/footer_parts/footer_button.dart';
import 'package:flutter/material.dart';

class EditorFooter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const EditorFooter({
    @required this.flyerBoxWidth,
    @required this.onAddImages,
    @required this.onDeleteSlide,
    @required this.onCropImage,
    @required this.onResetImage,
    @required this.onFitImage,
    @required this.currentPicFit,
    @required this.numberOfSlides,
    @required this.superFlyer,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Function onAddImages;
  final Function onDeleteSlide;
  final Function onCropImage;
  final Function onResetImage;
  final Function onFitImage;
  final BoxFit currentPicFit;
  final int numberOfSlides;
  final SuperFlyer superFlyer;
  /// --------------------------------------------------------------------------
  bool _flyerHasNoSlidesCheck(){
    bool _hasNoSlides;

    if (numberOfSlides == 0){
      _hasNoSlides = true;
    }
    else {
      _hasNoSlides = false;
    }

    return _hasNoSlides;
  }
// -----------------------------------------------------------------------------
  bool _addSlidesButtonInActiveModeCheck(){
    bool _inActiveMode;

    if (Standards.canAddMoreSlides(superFlyer: superFlyer) == true){
      _inActiveMode = false;
    }
    else {
      _inActiveMode = true;
    }

    return _inActiveMode;
  }
// -----------------------------------------------------------------------------
  bool _deleteSlideButtonInActiveModeCheck(){
    bool _inActiveMode;

    if (Standards.canDeleteSlide(superFlyer: superFlyer) == true){
      _inActiveMode = false;
    }
    else {
      _inActiveMode = true;
    }

    return _inActiveMode;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _spacing = FlyerFooter.buttonMargin(
      buttonIsOn: false,
      flyerBoxWidth: flyerBoxWidth,
      context: context,
    );

    const double _numberOfButtons = 5;

    final double _sumOfSpacings = _spacing * (_numberOfButtons + 1);
    final double _sumOfButtons = flyerBoxWidth - _sumOfSpacings;
    final double _fittingButtonSize = _sumOfButtons / _numberOfButtons;

    final bool _flyerHasNoSlides = _flyerHasNoSlidesCheck();


    final bool _addSlidesButtonInActiveMode = _addSlidesButtonInActiveModeCheck();
    final bool _deleteSlideButtonInActiveMode = _deleteSlideButtonInActiveModeCheck();
    final bool _cropButtonInActiveMode = _flyerHasNoSlides;
    final bool _resetButtonInActiveMode = _flyerHasNoSlides;
    final bool _fitButtonInActiveMode = _flyerHasNoSlides;

    /// FLYER FOOTER
    return Align(
      alignment: Alignment.bottomCenter,

      /// --- FLYER FOOTER BOX
      child: SizedBox(
        width: flyerBoxWidth,
        height: FlyerFooter.boxHeight(context: context, flyerBoxWidth: flyerBoxWidth),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            /// BOTTOM SHADOW
            FlyerFooter.boxShadow(context: context, flyerBoxWidth: flyerBoxWidth),

            /// BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                /// ADD IMAGES
                FooterButton(
                  verse: 'Add',
                  icon: Iconz.plus,
                  flyerBoxWidth: flyerBoxWidth,
                  onTap: onAddImages,
                  size: _fittingButtonSize,
                  inActiveMode: _addSlidesButtonInActiveMode,
                ),

                /// DELETE SLIDE
                FooterButton(
                  verse: 'Delete',
                  icon: Iconz.xSmall,
                  flyerBoxWidth: flyerBoxWidth,
                  onTap: onDeleteSlide,
                  size: _fittingButtonSize,
                  inActiveMode: _deleteSlideButtonInActiveMode,
                ),

                /// CROP IMAGE
                FooterButton(
                  verse: 'Crop',
                  icon: Iconz.bxDesignsOff,
                  flyerBoxWidth: flyerBoxWidth,
                  onTap: onCropImage,
                  size: _fittingButtonSize,
                  inActiveMode: _cropButtonInActiveMode,
                ),

                /// RESET IMAGE
                FooterButton(
                  verse: 'Reset',
                  icon: Iconz.clock,
                  flyerBoxWidth: flyerBoxWidth,
                  onTap: onResetImage,
                  size: _fittingButtonSize,
                  inActiveMode: _resetButtonInActiveMode,
                ),

                /// FIT IMAGES
                FooterButton(
                  verse: 'Fit',
                  icon: currentPicFit == BoxFit.fitWidth ? Iconz.arrowRight : currentPicFit == BoxFit.fitHeight ? Iconz.arrowUp : Iconz.dashBoard,
                  flyerBoxWidth: flyerBoxWidth,
                  onTap: superFlyer.edit.onFitImage, //onFitImage,
                  size: _fittingButtonSize,
                  inActiveMode: _fitButtonInActiveMode,
                ),


              ],
            ),

          ],
        ),
      ),
    );
  }
}
