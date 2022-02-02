import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_button.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class InfoButton extends StatefulWidget {

  const InfoButton({
    @required this.flyerBoxWidth,

    Key key
  }) : super(key: key);
 final double flyerBoxWidth;

  @override
  _InfoButtonState createState() => _InfoButtonState();
}

class _InfoButtonState extends State<InfoButton> {
// -----------------------------------------------------------------------------
  ValueNotifier<bool> infoButtonExpanded = ValueNotifier(false);
// ----------------------------------------
  void onPriceButtonTap(){
    infoButtonExpanded.value = ! infoButtonExpanded.value;
  }
// -----------------------------------------------------------------------------
  double _calculateWidth(bool buttonIsExpanded){

    double _width;

    if (buttonIsExpanded == true){
      _width = widget.flyerBoxWidth;
    }

    else {

      final double _footerButtonSize = FooterButton.buttonSize(
          context: context,
          flyerBoxWidth: widget.flyerBoxWidth,
          tinyMode: false
      );

      final double _footerButtonMargin = FooterButton.buttonMargin(
          context: context,
          flyerBoxWidth: widget.flyerBoxWidth,
          tinyMode: false
      );

      final double _infoButtonMargin = _infoButtonMinMargin();

      _width = widget.flyerBoxWidth
          -
          (3 * _footerButtonMargin)
          -
          (3 * _footerButtonSize)
          -
          (2 * _infoButtonMargin);

    }

    return _width;
  }
// -----------------------------------------------------------------------------
//   double _calculateHeight(bool buttonIsExpanded){
//     double _height;
//
//
//     if (buttonIsExpanded == true){
//       _height = 50;
//     }
//
//     else {
//
//       final double _buttonMinMargin = _infoButtonMinMargin();
//       final double _footerMinHeight = FooterBox.boxHeight(
//         context: context,
//         flyerBoxWidth: widget.flyerBoxWidth,
//         tinyMode: false,
//       );
//
//       _height = _footerMinHeight - (_buttonMinMargin * 2);
//     }
//
//     return _height * 1.2;
//   }
// -----------------------------------------------------------------------------
  double _infoButtonMinHeight(){

    final double _footerButtonSize = FooterButton.buttonSize(
        context: context,
        flyerBoxWidth: widget.flyerBoxWidth,
        tinyMode: false
    );

    return _footerButtonSize * 0.7;
  }
// -----------------------------------------------------------------------------
  double _infoButtonMinMargin(){

    final double _buttonMinHeight = _infoButtonMinHeight();
    final double _footerMinHeight = FooterBox.boxHeight(
      context: context,
      flyerBoxWidth: widget.flyerBoxWidth,
      tinyMode: false,
    );

    final double _minMargin = (_footerMinHeight - _buttonMinHeight) / 2;

    return _minMargin;
  }
// -----------------------------------------------------------------------------
  BorderRadius _calculateBorders(){
    final double _footerBottomCorners = FooterBox.boxCornersValue(widget.flyerBoxWidth);

    final double _infoButtonMargin = _infoButtonMinMargin();

    final double _buttonCorners = _footerBottomCorners - _infoButtonMargin;

    final BorderRadius _intoButtonBorder = superBorderAll(context, _buttonCorners);
    return _intoButtonBorder;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: superCenterAlignment(context),
      child: GestureDetector(
        onTap: onPriceButtonTap,
        child: ValueListenableBuilder(
          valueListenable: infoButtonExpanded,
          builder: (_, bool buttonExpanded, Widget child){

            final double _width = _calculateWidth(buttonExpanded);
            final double _height = _infoButtonMinHeight();

            final double _marginValue = _infoButtonMinMargin();
            final EdgeInsets _margins = EdgeInsets.all(_marginValue);

            blog('a77aaaaaaaaaaa');

            return AnimatedContainer(
              width: _width,
              height: _height,
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                color: Colorz.bloodTest,
                borderRadius: _calculateBorders(),
              ),
              margin: _margins,
            );

          },


        ),
      ),
    );
  }
}
