import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/b_expanding_tile.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/notes/topics_editor/topics_expanding_tile.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class NoteTopicSelectorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteTopicSelectorBubble({
    @required this.onSelectTopic,
    @required this.noteModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<TopicModel> onSelectTopic;
  final NoteModel noteModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = Bubble.bubbleWidth(context);
    // --------------------
    final Map<String, dynamic> _topicsMap = TopicModel.getTopicsMapByPartyType(noteModel.parties.receiverType);
    // --------------------
    return ExpandingTile(
      width: _bubbleWidth,
      firstHeadline: Verse.plain(noteModel.topic),
      secondHeadline: Verse.plain('Topic'),
      icon: Iconz.keywords,
      iconSizeFactor: 0.4,
      margin: const EdgeInsets.only(bottom: 10),
      initialColor: noteModel.topic == null ? Colorz.errorColor : Colorz.white10,
      expansionColor: noteModel.topic == null ? Colorz.errorColor : Colorz.white10,
      child: Column(
        children: <Widget>[

          if (noteModel.parties.receiverType == null)
          SuperVerse(
            verse: Verse.plain('Select a receiver to see The topics !'),
            labelColor: Colorz.black200,
            color: Colorz.red255,
            italic: true,
            weight: VerseWeight.thin,
            margin: 10,
          ),

          ...TopicsExpandingTile.buildTopicsMapTiles(
            map: _topicsMap,
            context: context,
            width: Bubble.clearWidth(context),
            builder: (TopicModel topic){

              final bool _isSelected = noteModel.topic == topic.id;

              return DreamBox(
                height: 50,
                width: Bubble.clearWidth(context) - 20,
                margins: const EdgeInsets.only(bottom: 3, left: 10),
                verse: Verse.plain(topic.id),
                secondVerseMaxLines: 3,
                secondLine: Verse.plain(topic.description),
                verseScaleFactor: 0.6,
                verseCentered: true,
                secondLineScaleFactor: 1.2,
                bubble: false,
                color: _isSelected == true ? Colorz.yellow255 : Colorz.white20,
                verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                secondLineColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                onTap: () => onSelectTopic(topic),
              );

            },

          ),

        ],
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
