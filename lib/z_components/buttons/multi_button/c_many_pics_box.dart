import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/buttons/multi_button/d_micro_pic.dart';
import 'package:flutter/material.dart';

class ManyPicsBox extends StatelessWidget {
  // --------------------------------------------------------------------------
  const ManyPicsBox({
    required this.pics,
    required this.size,
    this.textColor = Colorz.white255,
    super.key
  });
  // -----------------------
  final List<dynamic>? pics;
  final double size;
  final Color textColor;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (pics != null && pics!.length >= 3){

      final double _innerSize = size * 0.88;
      final double _picSize = _innerSize * 0.45;

      return Container(
        width: size,
        height: size,
        // decoration: BoxDecoration(
          color: Colorz.nothing,
        //   borderRadius: SuperBoxController.boxCorners(
        //     context: context,
        //     cornersOverride: null,
        //   ),
        // ),
        alignment: Alignment.center,
        child: Container(
          width: _innerSize,
          height: _innerSize,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Container(
                width: _innerSize,
                height: _innerSize * 0.5,
                color: Colorz.nothing,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    MicroPic(
                      size: _picSize,
                      pic: pics![0],
                    ),

                    // const Expander(),

                    MicroPic(
                      size: _picSize,
                      pic: pics![1],
                    ),

                  ],
                ),
              ),

              Container(
                width: _innerSize,
                height: _innerSize * 0.5,
                color: Colorz.nothing,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    MicroPic(
                      size: _picSize,
                      pic: pics![2],
                    ),

                    if (pics!.length == 3)
                      Container(
                        width: _picSize,
                        height: _picSize,
                        color: Colorz.nothing,
                      ),

                    if (pics!.length == 4)
                      MicroPic(
                        size: _picSize,
                        pic: pics![3],
                      ),

                    if (pics!.length > 4)
                      BldrsBox(
                        height: _picSize,
                        width: _picSize,
                        icon: '+${pics!.length - 3}',
                        iconColor: textColor,
                        bubble: false,
                        iconSizeFactor: 0.7,
                        color: textColor == Colorz.white255 ? Colorz.white20 : Colorz.black80,
                        corners: _picSize/2,
                      ),

                  ],
                ),
              ),

            ],
          ),
        ),
      );

    }

    else {
      return const SizedBox();
    }

  }
  // --------------------------------------------------------------------------
}
