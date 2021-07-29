import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/super_flyer.dart';
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
  final int numberOdSlides;
  final SuperFlyer superFlyer;

  EditorFooter({
    @required this.flyerZoneWidth,
    @required this.onAddImages,
    @required this.onDeleteSlide,
    @required this.onCropImage,
    @required this.onResetImage,
    @required this.onFitImage,
    @required this.currentPicFit,
    @required this.numberOdSlides,
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

    bool _buttonInActive = numberOdSlides == 0 ? true : false;


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
                  isOn: false,
                  onTap: onAddImages,
                  size: _fittingButtonSize,
                ),

                /// DELETE SLIDE
                FooterButton(
                  verse: 'Delete',
                  icon: Iconz.XSmall,
                  flyerZoneWidth: flyerZoneWidth,
                  isOn: false,
                  onTap: onDeleteSlide,
                  size: _fittingButtonSize,
                  inActive: _buttonInActive,
                ),

                /// CROP IMAGE
                FooterButton(
                  verse: 'Crop',
                  icon: Iconz.BxDesignsOff,
                  flyerZoneWidth: flyerZoneWidth,
                  isOn: false,
                  onTap: onCropImage,
                  size: _fittingButtonSize,
                  inActive: _buttonInActive,
                ),

                /// RESET IMAGE
                FooterButton(
                  verse: 'Reset',
                  icon: Iconz.Clock,
                  flyerZoneWidth: flyerZoneWidth,
                  isOn: false,
                  onTap: onResetImage,
                  size: _fittingButtonSize,
                  inActive: _buttonInActive,
                ),

                /// FIT IMAGES
                FooterButton(
                  verse: 'Fit',
                  icon: currentPicFit == BoxFit.fitWidth ? Iconz.ArrowRight : currentPicFit == BoxFit.fitHeight ? Iconz.ArrowUp : Iconz.DashBoard,
                  flyerZoneWidth: flyerZoneWidth,
                  isOn: false,
                  onTap: superFlyer.onFitImage, //onFitImage,
                  size: _fittingButtonSize,
                  inActive: _buttonInActive,
                ),


              ],
            ),

          ],
        ),
      ),
    );
  }
}

