import 'package:authing/authing.dart';
import 'package:bldrs/b_views/z_components/pyramids/pyramids.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObeliskPyramids extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskPyramids({
    @required this.isYellow,
    @required this.mounted,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool isYellow;
  final bool mounted;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Selector<UiProvider, bool>(
          key: const ValueKey<String>('ObeliskPyramids'),
          selector: (_, UiProvider uiProvider) => uiProvider.pyramidsAreExpanded,
          builder: (_, bool expanded, Widget child) {


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

          blog('the userID : ${Authing.getUserID()}');

          final bool isExpanded = UiProvider.proGetPyramidsAreExpanded(
              context: context,
              listen: false,
          );

          /// TO OPEN PYRAMIDS
          if (isExpanded  == null || isExpanded  == false){
            UiProvider.proSetPyramidsAreExpanded(context: context, setTo: true, notify: true);
          }

          /// TO CLOSE PYRAMIDS
          else {
            UiProvider.proSetPyramidsAreExpanded(context: context, setTo: false, notify: true);
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
