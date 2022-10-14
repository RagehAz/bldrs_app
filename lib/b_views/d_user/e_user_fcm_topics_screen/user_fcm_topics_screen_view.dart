import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/notes/topics_editor/topics_expanding_tile.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class UserFCMTopicsScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserFCMTopicsScreenView({
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSwitch({
    @required BuildContext context,
    @required String topicID,
    @required bool value,
  }) async {

    await UserProtocols.updateUserTopics(
      context: context,
      topicID: topicID,
    );

  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> _map = TopicModel.getTopicsMapByPartyType(PartyType.user);

    return ListView(
      key: const ValueKey<String>('FCMTopicsScreenView'),
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: <Widget>[

        const Stratosphere(),

        ...TopicsExpandingTile.buildTopicsMapTiles(
          map: _map,
          context: context,
          builder: (TopicModel topic, ){

            final bool _isSelected = TopicsExpandingTile.checkIsTopicSelected(
              context: context,
              partyType: PartyType.user,
              topicModel: topic,
            );

            return TileBubble(
              bubbleWidth: PageBubble.clearWidth(context),
              bubbleHeaderVM: BubbleHeaderVM(
                headlineVerse: Verse.plain(topic.description),
                leadingIcon: topic.icon,
                leadingIconSizeFactor: 0.6,
                leadingIconBoxColor: _isSelected == true ? Colorz.green255 : Colorz.white10,
                hasSwitch: true,
                switchValue: _isSelected,
                onSwitchTap: (bool value) => _onSwitch(
                  context: context,
                  value: value,
                  topicID: topic.id,
                ),
              ),
              onTileTap: () => _onSwitch(
                context: context,
                value: !_isSelected,
                topicID: topic.id,
              ),
            );

          },
        ),

        const Horizon(),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
