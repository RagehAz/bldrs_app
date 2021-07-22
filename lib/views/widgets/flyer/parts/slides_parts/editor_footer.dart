import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/footer.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/footer_button.dart';
import 'package:flutter/material.dart';

class EditorFooter extends StatelessWidget {
  final double flyerZoneWidth;
  final Function onAddImages;
  final Function onDeleteSlide;
  final Function onCropImage;
  final Function onResetImage;
  final Function onFitImage;
  final BoxFit currentPicFit;

  EditorFooter({
    @required this.flyerZoneWidth,
    @required this.onAddImages,
    @required this.onDeleteSlide,
    @required this.onCropImage,
    @required this.onResetImage,
    @required this.onFitImage,
    @required this.currentPicFit,
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
                ),

                /// CROP IMAGE
                FooterButton(
                  verse: 'Crop',
                  icon: Iconz.BxDesignsOff,
                  flyerZoneWidth: flyerZoneWidth,
                  isOn: false,
                  onTap: onCropImage,
                  size: _fittingButtonSize,
                ),

                /// RESET IMAGE
                FooterButton(
                  verse: 'Reset',
                  icon: Iconz.Clock,
                  flyerZoneWidth: flyerZoneWidth,
                  isOn: false,
                  onTap: onResetImage,
                  size: _fittingButtonSize,
                ),

                /// FIT IMAGES
                FooterButton(
                  verse: 'Fit',
                  icon: currentPicFit == BoxFit.fitWidth ? Iconz.ArrowRight : currentPicFit == BoxFit.fitHeight ? Iconz.ArrowUp : Iconz.DashBoard,
                  flyerZoneWidth: flyerZoneWidth,
                  isOn: false,
                  onTap: onFitImage,
                  size: _fittingButtonSize,
                ),


              ],
            ),

          ],
        ),
      ),
    );
  }
}

