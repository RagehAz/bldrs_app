import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/static_progress_bar.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/tile_bubble.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class NoteProgressCreatorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteProgressCreatorBubble({
    // @required this.progress,
    // @required this.nootProgressIsLoading,
    // @required this.onSwitch,
    // @required this.onTriggerLoading,
    // @required this.onIncrement,
    // @required this.onDecrement,
    @required this.note,
    @required this.noteNotifier,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  // final Progress progress;
  // final bool nootProgressIsLoading;
  // final ValueChanged<bool> onSwitch;
  // final Function onTriggerLoading;
  // final Function onIncrement;
  // final Function onDecrement;
  final NoteModel note;
  final ValueNotifier<NoteModel> noteNotifier;
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
    final bool isDeactivated = note.poster != null;
    // --------------------
    return WidgetFader(
      fadeType: isDeactivated == true ? FadeType.stillAtMin : FadeType.stillAtMax,
      min: 0.2,
      absorbPointer: isDeactivated,
      child: TileBubble(
        bubbleHeaderVM: BubbleHeaderVM(
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
          onSwitchTap: (bool value){

            blog('value : $value : ${noteNotifier.value.progress}');

            /// SWITCH ON
            if (value == true){

              noteNotifier.value = noteNotifier.value.copyWith(
                progress: 0,
              );

            }

            /// SWITCH OFF
            else {

              noteNotifier.value = noteNotifier.value.nullifyField(
                progress: true,
              );

            }

          },
        ),
        child: Column(
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                /// LOADING
                DreamBox(
                  height: 35,
                  isDeactivated: note?.progress == null,
                  icon: Iconz.reload,
                  iconColor: Colorz.white200,
                  iconSizeFactor: 0.4,
                  onTap: (){

                    /// IF IS LOADING
                    if (noteNotifier.value.progress == -1){
                      noteNotifier.value = noteNotifier.value.copyWith(
                        progress: 0,
                      );
                    }

                    /// IF IS NOT LOADING
                    else {
                      noteNotifier.value = noteNotifier.value.copyWith(
                        progress: -1
                      );
                    }

                  },
                ),

                const SizedBox(
                  width: 5,
                  height: 5,
                ),

                /// MINUS
                DreamBox(
                  height: 35,
                  isDeactivated: note.progress == -1 || note.progress == null,
                  icon: Iconz.arrowLeft,
                  iconColor: Colorz.white200,
                  iconSizeFactor: 0.4,
                  onTap: (){
                    if (note.progress > -1){
                      noteNotifier.value = noteNotifier.value.copyWith(
                          progress: note.progress - 1
                      );
                    }
                  },
                  onDoubleTap: (){
                    if (note.progress > 10){
                      noteNotifier.value = noteNotifier.value.copyWith(
                          progress: note.progress - 10,
                      );
                    }
                  },
                ),

                const SizedBox(
                  width: 5,
                  height: 5,
                ),

                /// PLUS
                DreamBox(
                  height: 35,
                  icon: Iconz.arrowRight,
                  isDeactivated: note.progress == -1 || note.progress == null,
                  iconColor: Colorz.white200,
                  iconSizeFactor: 0.4,
                  onTap: (){

                    if (note.progress < 100){
                      noteNotifier.value = noteNotifier.value.copyWith(
                          progress: note.progress + 1,
                      );
                    }

                  },
                  onDoubleTap: (){

                    if (note.progress < 90){
                      noteNotifier.value = noteNotifier.value.copyWith(
                        progress: note.progress + 10,
                      );
                    }

                  },
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
