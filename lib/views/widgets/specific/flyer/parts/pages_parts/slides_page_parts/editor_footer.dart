import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/standards.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/footer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/footer_parts/footer_button.dart';
import 'package:flutter/material.dart';

class EditorFooter extends StatelessWidget {
  final double flyerBoxWidth;
  final Function onAddImages;
  final Function onDeleteSlide;
  final Function onCropImage;
  final Function onResetImage;
  final Function onFitImage;
  final BoxFit currentPicFit;
  final int numberOfSlides;
  final SuperFlyer superFlyer;

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
  });

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

    final bool _flyerHasNoSlides = numberOfSlides == 0 ? true : false;


    final bool _addSlidesButtonInActiveMode = Standards.canAddMoreSlides(superFlyer: superFlyer) == true ? false : true;
    final bool _deleteSlideButtonInActiveMode = Standards.canDeleteSlide(superFlyer: superFlyer) == true ? false : true;
    final bool _cropButtonInActiveMode = _flyerHasNoSlides;
    final bool _resetButtonInActiveMode = _flyerHasNoSlides;
    final bool _fitButtonInActiveMode = _flyerHasNoSlides;

    /// FLYER FOOTER
    return Align(
      alignment: Alignment.bottomCenter,
      // --- FLYER FOOTER BOX
      child: Container(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                /// ADD IMAGES
                FooterButton(
                  verse: 'Add',
                  icon: Iconz.Plus,
                  flyerBoxWidth: flyerBoxWidth,
                  onTap: onAddImages,
                  size: _fittingButtonSize,
                  inActiveMode: _addSlidesButtonInActiveMode,
                ),

                /// DELETE SLIDE
                FooterButton(
                  verse: 'Delete',
                  icon: Iconz.XSmall,
                  flyerBoxWidth: flyerBoxWidth,
                  onTap: onDeleteSlide,
                  size: _fittingButtonSize,
                  inActiveMode: _deleteSlideButtonInActiveMode,
                ),

                /// CROP IMAGE
                FooterButton(
                  verse: 'Crop',
                  icon: Iconz.BxDesignsOff,
                  flyerBoxWidth: flyerBoxWidth,
                  onTap: onCropImage,
                  size: _fittingButtonSize,
                  inActiveMode: _cropButtonInActiveMode,
                ),

                /// RESET IMAGE
                FooterButton(
                  verse: 'Reset',
                  icon: Iconz.Clock,
                  flyerBoxWidth: flyerBoxWidth,
                  onTap: onResetImage,
                  size: _fittingButtonSize,
                  inActiveMode: _resetButtonInActiveMode,
                ),

                /// FIT IMAGES
                FooterButton(
                  verse: 'Fit',
                  icon: currentPicFit == BoxFit.fitWidth ? Iconz.ArrowRight : currentPicFit == BoxFit.fitHeight ? Iconz.ArrowUp : Iconz.DashBoard,
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

