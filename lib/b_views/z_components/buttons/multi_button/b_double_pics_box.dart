import 'package:bldrs/b_views/z_components/buttons/multi_button/d_micro_pic.dart';
import 'package:flutter/material.dart';

class DoublePicsBox extends StatelessWidget {
  // --------------------------------------------------------------------------
  const DoublePicsBox({
    required this.pics,
    required this.size,
    super.key
  });
  // --------------------------------------------------------------------------
  final double size;
  final List<dynamic>? pics;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (pics != null && pics!.length >= 2){
      return SizedBox(
        width: size,
        height: size,
        child: Stack(
          children: <Widget>[

            Positioned(
              top: 0,
              left: 0,
              child: MicroPic(
                size: size * 0.7,
                pic: pics![0],
              ),
            ),

            Positioned(
              bottom: 0,
              right: 0,
              child: MicroPic(
                size: size * 0.7,
                pic: pics![1],
              ),
            ),

          ],
        ),
      );
    }

    else {
      return const SizedBox();
    }

  }
  // --------------------------------------------------------------------------
}
