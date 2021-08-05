import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/standards.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/footer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/footer_parts/footer_button.dart';
import 'package:flutter/material.dart';

class EditorFooter extends StatelessWidget {
  final double flyerZoneWidth;
  final Function onAddImages;
  final Function onDeleteSlide;
  final Function onCropImage;
  final Function onResetImage;
  final Function onFitImage;
  final BoxFit currentPicFit;
  final int numberOfSlides;
  final SuperFlyer superFlyer;

  EditorFooter({
    @required this.flyerZoneWidth,
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

    double _spacing = FlyerFooter.buttonMargin(
      buttonIsOn: false,
      flyerZoneWidth: flyerZoneWidth,
      context: context,
    );

    double _numberOfButtons = 5;

    double _sumOfSpacings = _spacing * (_numberOfButtons + 1);
    double _sumOfButtons = flyerZoneWidth - _sumOfSpacings;
    double _fittingButtonSize = _sumOfButtons / _numberOfButtons;

    bool _flyerHasNoSlides = numberOfSlides == 0 ? true : false;


    bool _addSlidesButtonInActiveMode = Standards.canAddMoreSlides(superFlyer: superFlyer) == true ? false : true;
    bool _deleteSlideButtonInActiveMode = Standards.canDeleteSlide(superFlyer: superFlyer) == true ? false : true;
    bool _cropButtonInActiveMode = _flyerHasNoSlides;
    bool _resetButtonInActiveMode = _flyerHasNoSlides;
    bool _fitButtonInActiveMode = _flyerHasNoSlides;

    // --- FLYER FOOTER
    return Align(
      alignment: Alignment.bottomCenter,
      // --- FLYER FOOTER BOX
      child: Container(
        width: flyerZoneWidth,
        height: FlyerFooter.boxHeight(context: context, flyerZoneWidth: flyerZoneWidth),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            /// BOTTOM SHADOW
            FlyerFooter.boxShadow(context: context, flyerZoneWidth: flyerZoneWidth),

            /// BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                /// ADD IMAGES
                FooterButton(
                  verse: 'Add',
                  icon: Iconz.Plus,
                  flyerZoneWidth: flyerZoneWidth,
                  onTap: onAddImages,
                  size: _fittingButtonSize,
                  inActiveMode: _addSlidesButtonInActiveMode,
                ),

                /// DELETE SLIDE
                FooterButton(
                  verse: 'Delete',
                  icon: Iconz.XSmall,
                  flyerZoneWidth: flyerZoneWidth,
                  onTap: onDeleteSlide,
                  size: _fittingButtonSize,
                  inActiveMode: _deleteSlideButtonInActiveMode,
                ),

                /// CROP IMAGE
                FooterButton(
                  verse: 'Crop',
                  icon: Iconz.BxDesignsOff,
                  flyerZoneWidth: flyerZoneWidth,
                  onTap: onCropImage,
                  size: _fittingButtonSize,
                  inActiveMode: _cropButtonInActiveMode,
                ),

                /// RESET IMAGE
                FooterButton(
                  verse: 'Reset',
                  icon: Iconz.Clock,
                  flyerZoneWidth: flyerZoneWidth,
                  onTap: onResetImage,
                  size: _fittingButtonSize,
                  inActiveMode: _resetButtonInActiveMode,
                ),

                /// FIT IMAGES
                FooterButton(
                  verse: 'Fit',
                  icon: currentPicFit == BoxFit.fitWidth ? Iconz.ArrowRight : currentPicFit == BoxFit.fitHeight ? Iconz.ArrowUp : Iconz.DashBoard,
                  flyerZoneWidth: flyerZoneWidth,
                  onTap: superFlyer.onFitImage, //onFitImage,
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

