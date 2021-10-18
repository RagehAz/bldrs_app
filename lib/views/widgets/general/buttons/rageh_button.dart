import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:flutter/material.dart';

class Rageh extends StatelessWidget {
  final Function tappingRageh;
  final Function doubleTappingRageh;

  const Rageh({
    @required this.tappingRageh,
    @required this.doubleTappingRageh,
  });

  @override
  Widget build(BuildContext context) {

    return Positioned(
      bottom: 0,
      left: 0,
      child:
      InkWell(
        // onTap: (){
        //   tappingOnMyFace();
        // },
        onDoubleTap: doubleTappingRageh,
        splashColor: Colorz.black80, // don't work yet,, will come back later
        splashFactory: InkSplash.splashFactory, // to you too bitch
        child:
          Padding(
            padding: const EdgeInsets.all(15),
            child: Transform.scale(
              scale: 1.5,
              child: DreamBox(
                color: Colorz.nothing,
                width: 30,
                height: 30,
                iconSizeFactor: 1,
                corners: Ratioz.boxCorner8,
                icon: Iconz.DvRageh,
                onTap: tappingRageh,
              ),
            ),
          ),

      ),
    );
  }
}
