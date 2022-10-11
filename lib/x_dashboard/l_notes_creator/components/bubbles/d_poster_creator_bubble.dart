import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poster_model.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/poster/a_note_poster_builder.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/tile_bubble.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/buttons/note_poster_button.dart';
import 'package:flutter/material.dart';

class PosterCreatorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PosterCreatorBubble({
    @required this.note,
    @required this.noteNotifier,
    @required this.isDeactivated,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NoteModel note;
  final ValueNotifier<NoteModel> noteNotifier;
  final bool isDeactivated;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleClearWidth = Bubble.clearWidth(context);
    final double _bubbleChildWidth = TileBubble.childWidth(context: context);
    // --------------------
    final bool _posterHasValue = note?.poster?.type != null;
    // --------------------
    return WidgetFader(
      fadeType: isDeactivated == true ? FadeType.stillAtMin : FadeType.stillAtMax,
      min: 0.2,
      absorbPointer: isDeactivated == true,
      child: TileBubble(
        bubbleHeaderVM: BubbleHeaderVM(
          headlineVerse: const Verse(
            text: 'Poster',
            translate: false,
          ),
          leadingIcon: Iconz.phoneGallery,
          leadingIconSizeFactor: 0.5,
          leadingIconBoxColor: _posterHasValue == true ? Colorz.green255 : Colorz.grey50,

          switchValue: note.poster != null,
          hasSwitch: true,
          onSwitchTap: (bool value){

            /// WAS OFF => NOW IS TRUE
            if (value == true){

              noteNotifier.value = note.copyWith(
                poster: const PosterModel(
                  modelID: null,
                  url: null,
                  type: null,
                  // file: null,
                ),
              );

            }

            /// WAS TRUE => NOW IS OFF
            else {
              noteNotifier.value = note.nullifyField(
                poster: true,
              );
            }

          }

        ),
        child: SizedBox(
          width: _bubbleClearWidth,
          child: Column(
            children: <Widget>[

              /// POSTER TYPES
              SizedBox(
                width: _bubbleChildWidth,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    /// FLYER
                    PosterTypeButton(
                      note: note,
                      noteNotifier: noteNotifier,
                      icon: Iconz.flyer,
                      posterType: PosterType.flyer,
                    ),

                    /// BZ
                    PosterTypeButton(
                      note: note,
                      noteNotifier: noteNotifier,
                      icon: Iconz.bz,
                      posterType: PosterType.bz,
                    ),

                    /// CAMERA
                    PosterTypeButton(
                      note: note,
                      noteNotifier: noteNotifier,
                      icon: Iconz.camera,
                      posterType: PosterType.cameraImage,
                    ),

                    /// GALLERY
                    PosterTypeButton(
                      note: note,
                      noteNotifier: noteNotifier,
                      icon: Iconz.phoneGallery,
                      posterType: PosterType.galleryImage,
                    ),

                    /// URL
                    PosterTypeButton(
                      note: note,
                      noteNotifier: noteNotifier,
                      icon: Iconz.comWebsite,
                      posterType: PosterType.url,
                    ),

                  ],
                ),
              ),

              /// POSTER
              if (note.poster != null)
                NotePosterBuilder(
                  width: _bubbleChildWidth,
                  noteModel: note,
              ),

            ],
          ),
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
