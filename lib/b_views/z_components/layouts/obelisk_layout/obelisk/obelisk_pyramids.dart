import 'package:bldrs/b_views/z_components/pyramids/pyramids.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrscolors/bldrscolors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObeliskPyramids extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskPyramids({
    @required this.isExpanded,
    @required this.isYellow,
    @required this.mounted,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> isExpanded;
  final bool isYellow;
  final bool mounted;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      key: const ValueKey<String>('ObeliskPyramids'),
      valueListenable: isExpanded,
      builder: (_, bool expanded, Widget child){


        return Positioned(
          bottom: Pyramids.verticalPositionFix,
          right: 17 * 0.7,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 500),
            curve: expanded == true ?  Curves.easeOutQuart : Curves.easeOutQuart,
            scale: expanded == true ? 0.95 : 1,
            alignment: Alignment.bottomRight,
            child: child,
          ),
        );

        },

      child: GestureDetector(
        onTap: (){

          blog('the userID : ${AuthFireOps.superUserID()}');

          /// TO OPEN PYRAMIDS
          if (isExpanded.value  == null || isExpanded.value  == false){
            setNotifier(notifier: isExpanded, mounted: mounted, value: true);
          }

          /// TO CLOSE PYRAMIDS
          else {
            setNotifier(notifier: isExpanded, mounted: mounted, value: false);
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

            /// BLACK FOOTPRINT
            const Pyramids(
              pyramidType: PyramidType.white,
              color: Colorz.black255,
              putInCorner: false,
            ),

            /// PYRAMIDS GRAPHIC
            Selector<NotesProvider, bool>(
              selector: (_,NotesProvider notesProvider) => notesProvider.isFlashing,
              builder: (_, bool isFlashing, Widget child){

                // blog('PYRAMIDS ARE FLASHING : $isFlashing');

                return Pyramids(
                  pyramidType: isYellow ? PyramidType.yellow : PyramidType.white,
                  loading: isFlashing,
                  putInCorner: false,
                );

              },
            ),

          ],
        ),
      ),

    );

  }
/// --------------------------------------------------------------------------
}
