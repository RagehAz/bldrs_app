import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:provider/provider.dart';

class ObeliskPyramids extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskPyramids({
    @required this.isExpanded,
    @required this.isYellow,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> isExpanded;
  final bool isYellow;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      key: const ValueKey<String>('ObeliskPyramids'),
      valueListenable: isExpanded,
      builder: (_, bool expanded, Widget child){

        return Positioned(
          bottom: Pyramids.verticalPositionFix,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(right: 17 * 0.7),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 500),
              curve: expanded == true ?  Curves.easeOutQuart : Curves.easeOutQuart,
              scale: expanded == true ? 0.95 : 1,
              alignment: Alignment.bottomRight,
              child: child,
            ),
          ),
        );

        },

      child: GestureDetector(
        onTap: (){

          blog('the userID : ${AuthFireOps.superUserID()}');

          /// TO OPEN PYRAMIDS
          if (isExpanded.value == null || isExpanded.value == false){
            isExpanded.value = true;
          }

          /// TO CLOSE PYRAMIDS
          else {
            isExpanded.value = false;
          }

          /// STOP FLASHING
          NotesProvider.proSetIsFlashing(
              context: context,
              setTo: false,
              notify: true
          );


        },
        child: Stack(
          children: <Widget>[

            /// FLASHING PYRAMIDS BLACK FOOTPRINT
            const SuperImage(
              width: 256 * 0.7,
              height: 80 * 0.7,
              iconColor: Colorz.black255,
              pic: Iconz.pyramidsWhiteClean,
              boxFit: BoxFit.fitWidth,
            ),

            /// PYRAMIDS GRAPHIC
            Selector<NotesProvider, bool>(
              selector: (_,NotesProvider notesProvider) => notesProvider.isFlashing,
              builder: (_, bool isFlashing, Widget child){

                return WidgetFader(
                  fadeType: isFlashing ? FadeType.repeatAndReverse : FadeType.stillAtMax,
                  duration: const Duration(milliseconds: 1000),
                  min: 0.3,
                  child: child,
                );

              },
              child: SuperImage(
                width: 256 * 0.7,
                height: 80 * 0.7,
                pic: isYellow ? Iconz.pyramidsYellowClean : Iconz.pyramidsWhiteClean,
                boxFit: BoxFit.fitWidth,
              ),
            ),

          ],
        ),
      ),

    );

  }
/// --------------------------------------------------------------------------
}
