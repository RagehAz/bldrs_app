import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'dream_box.dart';

class Rageh extends StatelessWidget {
  final Function tappingRageh;
  final Function doubleTappingRageh;

  Rageh({
    @required this.tappingRageh,
    @required this.doubleTappingRageh,
  });

  void tappingOnMyFace(){
    tappingRageh();
  }

  void doubleTappingOnMyFace(){
    doubleTappingRageh();
  }

  @override
  Widget build(BuildContext context) {
  // final double sideSize = 50;

    return Positioned(
      bottom: 0,
      left: 0,
      child:
      InkWell(
        // onTap: (){
        //   tappingOnMyFace();
        // },
        onDoubleTap: (){
          doubleTappingOnMyFace();
        },
        splashColor: Colorz.BlackSmoke, // don't work yet,, will come back later
        splashFactory: InkSplash.splashFactory, // to you too bitch
        child:
          Padding(
            padding: const EdgeInsets.all(15),
            child: Transform.scale(
              scale: 1.5,
              child: DreamBox(
                color: Colorz.Nothing,
                width: 30,
                height: 30,
                iconSizeFactor: 1,
                corners: Ratioz.boxCorner8,
                icon: Iconz.DvRageh,
                onTap: (){
                  tappingOnMyFace();
                },
              ),
            ),
          ),

      ),
    );
  }
}
