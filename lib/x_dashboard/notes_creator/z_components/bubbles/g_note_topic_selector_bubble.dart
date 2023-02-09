import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/b_expanding_tile.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/multi_button/a_multi_button.dart';
import 'package:bldrs/b_views/z_components/notes/topics_editor/topics_expanding_tile.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bldrs/lib/bubbles.dart';
import 'package:flutter/material.dart';

class NoteTopicSelectorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteTopicSelectorBubble({
    @required this.onSelectTopic,
    @required this.noteModel,
    @required this.receiversModels,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<TopicModel> onSelectTopic;
  final NoteModel noteModel;
  final ValueNotifier<List<dynamic>> receiversModels;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = Bubble.bubbleWidth(context: context);
    final double _clearWidth = Bubble.clearWidth(context: context);
    // --------------------
    final Map<String, dynamic> _topicsMap = TopicModel.getTopicsMapByPartyType(noteModel.parties.receiverType);
    // --------------------
    const double _buttonHeight = 70;
    final double _clearTopicZoneWidth = _bubbleWidth - 40;
    final double _topicButtonWidth = _clearTopicZoneWidth - 75;
    final double _subscribersButtonWidth = _clearTopicZoneWidth - _topicButtonWidth - 5;
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
            width: _clearWidth,
            builder: (TopicModel topicModel){

              final bool _isSelected = noteModel.topic == topicModel.id;

              return SizedBox(
                width: _clearTopicZoneWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    DreamBox(
                      height: _buttonHeight,
                      width: _topicButtonWidth,
                      margins: const EdgeInsets.only(bottom: 3),
                      verse: Verse.plain(topicModel.id),
                      secondVerseMaxLines: 2,
                      secondLine: Verse.plain(topicModel.description),
                      verseScaleFactor: 0.6,
                      secondLineScaleFactor: 1.2,
                      bubble: false,
                      color: _isSelected == true ? Colorz.yellow255 : Colorz.white20,
                      verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                      secondLineColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                      onTap: () => onSelectTopic(topicModel),
                    ),

                    ValueListenableBuilder(
                        valueListenable: receiversModels,
                        builder: (_, List<dynamic> receivers, Widget child){

                          return FutureBuilder(
                            future: TopicModel.getTopicSubscribersPics(
                              context: context,
                              topicID: topicModel.id,
                              receiversModels: receivers,
                              receiversType: noteModel.parties.receiverType,
                            ),
                            initialData: const <String>[],
                            builder: (_, AsyncSnapshot<List<String>> snap){

                              final List<String> _pics = snap.data;

                              return MultiButton(
                                height: _buttonHeight,
                                width: _subscribersButtonWidth,
                                pics: _pics,
                                color: Colorz.white10,

                              );

                            },

                          );

                        }
                    ),

                  ],
                ),
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
