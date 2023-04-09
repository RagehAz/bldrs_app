import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/static_progress_bar.dart';
import 'package:devicer/devicer.dart';
import 'package:animators/animators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:widget_fader/widget_fader.dart';

class NoteProgressCreatorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteProgressCreatorBubble({
    @required this.onSwitch,
    @required this.onTriggerLoading,
    @required this.onIncrement,
    @required this.onDecrement,
    @required this.note,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<bool> onSwitch;
  final Function onTriggerLoading;
  final ValueChanged<int> onIncrement;
  final ValueChanged<int> onDecrement;
  final NoteModel note;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = Bubble.bubbleWidth(context: context);
    final double _bubbleChildWidth = TileBubble.childWidth(
      context: context,
      bubbleWidthOverride: _bubbleWidth,
    );
    // --------------------
    final bool isDeactivated = note.poster != null || DeviceChecker.deviceIsIOS();
    // --------------------
    return WidgetFader(
      fadeType: isDeactivated == true ? FadeType.stillAtMin : FadeType.stillAtMax,
      min: 0.2,
      ignorePointer: isDeactivated,
      child: BldrsTileBubble(
        bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
          leadingIcon: Iconz.reload,
          leadingIconSizeFactor: 0.5,
          leadingIconBoxColor: note?.progress != null ? Colorz.green255 : Colorz.grey50,
          headlineVerse: Verse.plain(
              note?.progress == null ? 'Progress'
                  :
              'Progress : ( ${note?.progress} % )'
          ),
          hasSwitch: true,
          switchValue: note?.progress != null,
          onSwitchTap: onSwitch,
        ),
        child: Column(
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                /// LOADING
                BldrsBox(
                  height: 35,
                  isDisabled: note?.progress == null,
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
                BldrsBox(
                  height: 35,
                  isDisabled: note.progress == -1 || note.progress == null,
                  icon: Iconz.arrowLeft,
                  iconColor: Colorz.white200,
                  iconSizeFactor: 0.4,
                  onTap: () => onDecrement(1),
                  onDoubleTap: () => onDecrement(10),
                ),

                const SizedBox(
                  width: 5,
                  height: 5,
                ),

                /// PLUS
                BldrsBox(
                  height: 35,
                  icon: Iconz.arrowRight,
                  isDisabled: note.progress == -1 || note.progress == null,
                  iconColor: Colorz.white200,
                  iconSizeFactor: 0.4,
                  onTap: () => onIncrement(1),
                  onDoubleTap: () => onIncrement(10),
                ),

                const SizedBox(
                  width: 20,
                  height: 20,
                ),

              ],
            ),

            StaticProgressBar(
              numberOfSlides: note.progress == null ? 1 : 20,
              index: note.progress == null ? 0 : (note.progress - 1) ~/ 5,
              opacity: note.progress == null ? 0.2 : 1,
              flyerBoxWidth: _bubbleChildWidth,
              swipeDirection: SwipeDirection.freeze,
              loading: note.progress == -1,
              stripThicknessFactor: 2,
              margins: const EdgeInsets.only(top: 10),
            ),

          ],
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
