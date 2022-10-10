import 'package:bldrs/a_models/b_bz/target/target_progress.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/static_progress_bar.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/tile_bubble.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class NoteProgressCreatorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteProgressCreatorBubble({
    @required this.progress,
    @required this.nootProgressIsLoading,
    @required this.onSwitch,
    @required this.onTriggerLoading,
    @required this.onIncrement,
    @required this.onDecrement,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Progress progress;
  final bool nootProgressIsLoading;
  final ValueChanged<bool> onSwitch;
  final Function onTriggerLoading;
  final Function onIncrement;
  final Function onDecrement;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = Bubble.bubbleWidth(context);
    final double _bubbleChildWidth = TileBubble.childWidth(
      context: context,
      bubbleWidthOverride: _bubbleWidth,
    );
    // --------------------
    return TileBubble(
      bubbleHeaderVM: BubbleHeaderVM(
        leadingIcon: Iconz.reload,
        leadingIconSizeFactor: 0.5,
        leadingIconBoxColor: progress != null ? Colorz.green255 : Colorz.grey50,
        headlineVerse: Verse.plain(
            progress == null ? 'Progress'
                :
            'Progress : ( ${((progress.current / progress.objective) * 100).toInt()} % )'
        ),
        hasSwitch: true,
        switchValue: progress != null,
        onSwitchTap: onSwitch,
      ),
      child: Column(
        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[

              /// LOADING
              DreamBox(
                height: 35,
                isDeactivated: progress == null,
                icon: Iconz.reload,
                iconColor: Colorz.white200,
                iconSizeFactor: 0.4,
                onTap: onTriggerLoading,
              ),

              const SizedBox(
                width: 5,
                height: 5,
              ),

              /// MINUS
              DreamBox(
                height: 35,
                isDeactivated: nootProgressIsLoading == true || progress == null,
                icon: Iconz.arrowLeft,
                iconColor: Colorz.white200,
                iconSizeFactor: 0.4,
                onTap: onDecrement,
              ),

              const SizedBox(
                width: 5,
                height: 5,
              ),

              /// PLUS
              DreamBox(
                height: 35,
                icon: Iconz.arrowRight,
                isDeactivated: nootProgressIsLoading == true || progress == null,
                iconColor: Colorz.white200,
                iconSizeFactor: 0.4,
                onTap: onIncrement,
              ),

              const SizedBox(
                width: 20,
                height: 20,
              ),

            ],
          ),

          StaticProgressBar(
            numberOfSlides: progress == null ? 1 : progress.objective,
            index: progress == null ? 0 : progress.current - 1,
            opacity: progress == null ? 0.2 : 1,
            flyerBoxWidth: _bubbleChildWidth,
            swipeDirection: SwipeDirection.freeze,
            loading: nootProgressIsLoading,
            stripThicknessFactor: 2,
            margins: const EdgeInsets.only(top: 10),
          ),

        ],
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
