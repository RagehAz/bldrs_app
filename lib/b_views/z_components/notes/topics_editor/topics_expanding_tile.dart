import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/b_expanding_tile.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class TopicsExpandingTile extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TopicsExpandingTile({
    @required this.groupName,
    @required this.topics,
    @required this.onSwitch,
    @required this.partyType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<TopicModel> topics;
  final String groupName;
  final Function(bool value, TopicModel topic) onSwitch;
  final PartyType partyType;
  // -----------------------------------------------------------------------------
 /// TESTED : WORKS PERFECT
  bool _checkIsTopicSelected({
    @required PartyType partyType,
    @required BuildContext context,
    @required TopicModel topicModel,
  }){

    String _bzID;
    if (partyType == PartyType.bz){
      final BzModel _activeBz = BzzProvider.proGetActiveBzModel(
        context: context,
        listen: true,
      );
      _bzID = _activeBz?.id;
    }

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );

    return TopicModel.checkUserIsListeningToTopic(
      context: context,
      topicID: topicModel.id,
      partyType: partyType,
      bzID: _bzID,
      userModel: _userModel,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ExpandingTile(
      width: PageBubble.width(context),
      firstHeadline: Verse(
        text: groupName,
        translate: false,
        // casing: Casing.upperCase,
      ),
      secondHeadline: const Verse(
        text: 'phid_notifications',
        translate: true,
      ),
      initiallyExpanded: true,
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          const SuperVerse(
            verse: Verse(
              text: 'phid_i_want_to_be_notified_when',
              translate: true,
            ),
            centered: false,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            italic: true,
            weight: VerseWeight.thin,
          ),

          ...List.generate(topics.length, (index){

            final TopicModel _topicModel = topics[index];

            final bool _isSelected = _checkIsTopicSelected(
              context: context,
              partyType: partyType,
              topicModel: _topicModel,
            );

            return TileBubble(
              bubbleWidth: PageBubble.clearWidth(context),
              bubbleHeaderVM: BubbleHeaderVM(
                headlineVerse: Verse.plain(_topicModel.description),
                leadingIcon: _topicModel.icon,
                leadingIconSizeFactor: 0.6,
                leadingIconBoxColor: _isSelected == true ? Colorz.green255 : Colorz.white10,
                hasSwitch: true,
                switchValue: _isSelected,
                onSwitchTap: (bool value) => onSwitch(value, _topicModel)
              ),
              onTileTap: () => onSwitch(!_isSelected, _topicModel)
            );

          }),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
