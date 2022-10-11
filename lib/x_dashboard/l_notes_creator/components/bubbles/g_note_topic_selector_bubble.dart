import 'package:bldrs/a_models/e_notes/noot_event.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/b_expanding_tile.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class NoteTopicSelectorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteTopicSelectorBubble({
    @required this.nootEvent,
    @required this.onSelectTopic,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NootEvent nootEvent;
  final ValueChanged<NootEvent> onSelectTopic;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = Bubble.bubbleWidth(context);
    // --------------------
    return ExpandingTile(
      width: _bubbleWidth,
      firstHeadline: Verse.plain('Topic'),
      secondHeadline: Verse.plain(nootEvent?.id),
      icon: Iconz.keywords,
      iconSizeFactor: 0.4,
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          ...List<Widget>.generate(NootEvent.allEvent.length, (int index) {

            final NootEvent _event = NootEvent.allEvent[index];
            final bool _isSelected = nootEvent?.id == _event.id;

            return DreamBox(
              height: 40,
              margins: const EdgeInsets.only(bottom: 3, left: 10),
              verse: Verse.plain(_event.id),
              secondLine: Verse.plain(_event.description),
              verseScaleFactor: 0.6,
              verseCentered: false,
              bubble: false,
              color: _isSelected == true ? Colorz.yellow255 : Colorz.white20,
              verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
              secondLineColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
              onTap: () => onSelectTopic(_event),
            );

          }),

        ],
      ),
    );

  }

}
