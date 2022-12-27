import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/j_poster/poster_type.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/poster/note_poster_builder.dart';


import 'package:bldrs/x_dashboard/notes_creator/z_components/buttons/note_poster_button.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class PosterCreatorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PosterCreatorBubble({
    @required this.note,
    @required this.onSwitchPoster,
    @required this.onSelectPosterType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NoteModel note;
  final ValueChanged<bool> onSwitchPoster;
  final ValueChanged<PosterType> onSelectPosterType;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleClearWidth = Bubble.clearWidth(context);
    final double _bubbleChildWidth = TileBubble.childWidth(context: context);
    // --------------------
    final bool _posterHasValue = note?.poster?.type != null;
    // --------------------
    final bool isDeactivated = note?.progress != null;
    // --------------------
    return WidgetFader(
      fadeType: isDeactivated == true ? FadeType.stillAtMin : FadeType.stillAtMax,
      min: 0.2,
      ignorePointer: isDeactivated == true,
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
          onSwitchTap: onSwitchPoster,

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
                      posterType: PosterType.flyer,
                      onTap: onSelectPosterType,
                    ),

                    /// BZ
                    PosterTypeButton(
                      note: note,
                      posterType: PosterType.bz,
                      onTap: onSelectPosterType,
                    ),

                    /// CAMERA
                    PosterTypeButton(
                      note: note,
                      posterType: PosterType.cameraImage,
                      onTap: onSelectPosterType,
                    ),

                    /// GALLERY
                    PosterTypeButton(
                      note: note,
                      posterType: PosterType.galleryImage,
                      onTap: onSelectPosterType,
                    ),

                    /// URL
                    PosterTypeButton(
                      note: note,
                      posterType: PosterType.url,
                      onTap: onSelectPosterType,
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
