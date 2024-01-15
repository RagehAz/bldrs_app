import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/b_expanding_tile.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class TopicsExpandingTile extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TopicsExpandingTile({
    required this.groupName,
    required this.topics,
    required this.builder,
    required this.width,
    super.key
  });
  
  /// --------------------------------------------------------------------------
  final List<TopicModel> topics;
  final String groupName;
  final Widget Function(TopicModel topic) builder;
  final double? width;
  // -----------------------------------------------------------------------------
  static List<Widget> buildTopicsMapTiles({
    required Map<String, dynamic> map,
    required BuildContext context,
    required Widget Function(TopicModel topic) builder,
    double? width,
  }){
    final List<Widget> _output = <Widget>[];

    final List<String> _groups = map.keys.toList();
    if (Lister.checkCanLoop(_groups) == true){

      for (final String group in _groups){

        final List<TopicModel> _topics = map[group];
        final Widget _widget = TopicsExpandingTile(
          topics: _topics,
          groupName: group,
          builder: builder,
          width: width,
        );

        _output.add(_widget);
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
 /// TESTED : WORKS PERFECT
  static bool checkIsTopicSelected({
    required PartyType partyType,
    required BuildContext context,
    required TopicModel topicModel,
  }){

    String? _bzID;
    if (partyType == PartyType.bz){
      final BzModel? _activeBz = HomeProvider.proGetActiveBzModel(
        context: context,
        listen: true,
      );
      _bzID = _activeBz?.id;
    }

    final UserModel? _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );

    return TopicModel.checkUserIsSubscribedToThisTopic(
      topicID: topicModel.id,
      partyType: partyType,
      bzID: _bzID,
      userModel: _userModel,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsExpandingButton(
      width: width ?? PageBubble.width(context),
      firstHeadline: Verse(
        id: groupName,
        translate: true,
        // casing: Casing.upperCase,
      ),
      // secondHeadline: const Verse(
      //   text: 'phid_notifications',
      //   translate: true,
      // ),
      initiallyExpanded: true,
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          const BldrsText(
            verse: Verse(
              id: 'phid_i_want_to_be_notified_when',
              translate: true,
            ),
            centered: false,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            italic: true,
            weight: VerseWeight.thin,
          ),

          ...List.generate(topics.length, (index){

            final TopicModel _topicModel = topics[index];

            return builder(_topicModel);

          }),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
