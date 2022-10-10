import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poster_model.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/poster/a_old_note_poster.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/x_notes_creator_controller.dart';
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
    // --------------------
    return WidgetFader(
      fadeType: isDeactivated == true ? FadeType.stillAtMin : FadeType.stillAtMax,
      min: 0.2,
      absorbPointer: isDeactivated == true,
      child: TileBubble(
        bubbleHeaderVM: const BubbleHeaderVM(
          headlineVerse: Verse(
            text: 'Poster',
            translate: false,
          ),
          leadingIcon: Iconz.phoneGallery,
          leadingIconSizeFactor: 0.5,
          leadingIconBoxColor: Colorz.grey50,

        ),
        child: SizedBox(
          width: _bubbleClearWidth,
          child: Column(
            children: <Widget>[

              /// POSTER TYPES
              SizedBox(
                width: TileBubble.childWidth(context: context),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    ...List.generate(PosterModel.posterTypes.length, (index){

                      final PosterType _posterType = PosterModel.posterTypes[index];
                      final bool _isSelected = note?.poster?.type == _posterType;
                      final String _attachmentTypeString = PosterModel.cipherPosterType(_posterType);

                      return DreamBox(
                        height: 40,
                        width: Scale.getUniformRowItemWidth(
                          context: context,
                          numberOfItems: PosterModel.posterTypes.length,
                          boxWidth: TileBubble.childWidth(context: context),
                        ),
                        verse: Verse(
                          text: _attachmentTypeString,
                          translate: false,
                          casing: Casing.upperCase,
                        ),
                        verseScaleFactor: 0.5,
                        color: _isSelected == true ? Colorz.yellow255 : null,
                        verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                        verseWeight: _isSelected == true ? VerseWeight.black : VerseWeight.thin,
                        onTap: () => onSelectPosterType(
                          context: context,
                          note: noteNotifier,
                          posterType: _posterType,
                        ),
                      );

                    }),

                  ],
                ),
              ),

              /// NOTE POSTER
              OLDNotePoster(
                noteModel: note,
                boxWidth: _bubbleClearWidth,
                canOpenFlyer: false,
              ),

            ],
          ),
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
