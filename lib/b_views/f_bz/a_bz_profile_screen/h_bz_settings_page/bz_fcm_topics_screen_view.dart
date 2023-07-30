import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/notes/topics_editor/topics_expanding_tile.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:flutter/material.dart';

class BzFCMTopicsScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzFCMTopicsScreenView({
    super.key
  });
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSwitchAuthorSubscriptionToTopic({
    required String? topicID,
    required bool value,
  }) async {

    final BzModel? _activeBz = BzzProvider.proGetActiveBzModel(
      context: getMainContext(),
      listen: false,
    );

    final String? _customTopicID = TopicModel.bakeTopicID(
      topicID: topicID,
      bzID: _activeBz?.id,
      receiverPartyType: PartyType.bz,
    );

    await Future.wait(<Future>[

      UserProtocols.updateMyUserTopics(
        topicID: _customTopicID,
      ),

      if (value == true)
        FCM.subscribeToTopic(
          topicID: _customTopicID,
        ),

      if (value == false)
        FCM.unsubscribeFromTopic(
          topicID: _customTopicID,
        ),

    ]);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSwitchAll({
    required bool value,
  }) async {

    final BzModel? _bzModel = BzzProvider.proGetActiveBzModel(
      context: getMainContext(),
      listen: false,
    );

    /// SUBSCRIBE TO ALL BZ TOPICS
    if (value == true){

      await NoteProtocols.unsubscribeFromAllBzTopics(
          bzID: _bzModel?.id,
          renovateUser: false
      );

      await NoteProtocols.subscribeToAllBzTopics(
          bzID: _bzModel?.id,
          renovateUser: true,
      );
    }

    /// UNSUBSCRIBE FROM ALL BZ TOPICS
    else {

      await NoteProtocols.unsubscribeFromAllBzTopics(
          bzID: _bzModel?.id,
          renovateUser: true,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _allTopicsSwitchIsOn(BuildContext context){

    final UserModel? _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );

    final BzModel? _bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: true,
    );

    final List<String> _thisBzUserSubscribedTopics = TopicModel.getTopicsIncludingBzIDFromTopics(
      topics: _userModel?.fcmTopics,
      bzID: _bzModel?.id,
    );

    return _thisBzUserSubscribedTopics.isNotEmpty;

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> _map = TopicModel.getTopicsMapByPartyType(PartyType.bz);

    final bool _allIsOn = _allTopicsSwitchIsOn(context);

    return ListView(
      key: const ValueKey<String>('FCMTopicsScreenView'),
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: <Widget>[

        const Stratosphere(),

        /// ALL SWITCHER
        BldrsTileBubble(
          bubbleWidth: PageBubble.clearWidth(context),
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            headlineVerse: const Verse(
              id: 'phid_all_notifications',
              translate: true,
            ),
            leadingIcon: Iconz.notification,
            leadingIconSizeFactor: 0.6,
            leadingIconBoxColor: _allIsOn == true ? Colorz.green255 : Colorz.white10,
            hasSwitch: true,
            switchValue: _allIsOn,
            onSwitchTap: (bool value) => _onSwitchAll(
              value: !_allIsOn,
            ),
          ),
          onTileTap: () => _onSwitchAll(
            value: !_allIsOn,
          ),
        ),

        ...TopicsExpandingTile.buildTopicsMapTiles(
            map: _map,
            context: context,
            builder: (TopicModel topic, ){

              final bool _isSelected = TopicsExpandingTile.checkIsTopicSelected(
                context: context,
                partyType: PartyType.bz,
                topicModel: topic,
              );

              return BldrsTileBubble(
                bubbleWidth: PageBubble.clearWidth(context),
                bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                  context: context,
                  headlineVerse: Verse(
                    id: 'phid_${topic.id}',
                    translate: true,
                  ),
                  leadingIcon: topic.icon,
                  leadingIconSizeFactor: 0.6,
                  leadingIconBoxColor: _isSelected == true ? Colorz.green255 : Colorz.white10,
                  hasSwitch: true,
                  switchValue: _isSelected,
                  onSwitchTap: (bool value) => _onSwitchAuthorSubscriptionToTopic(
                    value: value,
                    topicID: topic.id,
                  ),
                ),
                onTileTap: () => _onSwitchAuthorSubscriptionToTopic(
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
