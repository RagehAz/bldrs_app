import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/z_components/notes/topics_editor/topics_expanding_tile.dart';
import 'package:bldrs/z_components/sizing/horizon.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class UserFCMTopicsScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserFCMTopicsScreenView({
    super.key
  });
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSwitch({
    required String? topicID,
    required bool value,
  }) async {

    await UserProtocols.updateMyUserTopics(
      topicID: topicID,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSwitchAll({
    required bool value,
  }) async {

    final UserModel? _userModel = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );

    /// SUBSCRIBE TO ALL USER TOPICS
    if (value == true){

      final List<String> _updatedTopics = Stringer.addStringsToStringsIfDoNotContainThem(
          listToTake: _userModel?.fcmTopics,
          listToAdd: TopicModel.getAllPossibleUserTopicsIDs(),
      );

      await UserProtocols.renovate(
          oldUser: _userModel,
          newUser: _userModel?.copyWith(
            fcmTopics: _updatedTopics,
          ),
        invoker: 'UserFCMTopicsScreenView._onSwitchAll',
      );

    }

    /// UNSUBSCRIBE FROM ALL USER TOPICS
    else {

      final List<String> _updatedTopics = Stringer.removeStringsFromStrings(
        removeFrom: _userModel?.fcmTopics,
        removeThis: TopicModel.getAllPossibleUserTopicsIDs(),
      );

      await UserProtocols.renovate(
        newUser: _userModel?.copyWith(
          fcmTopics: _updatedTopics,
        ),
        oldUser: _userModel,
        invoker: 'UserFCMTopicsScreenView._onSwitchAll',
      );

    }

  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> _map = TopicModel.getTopicsMapByPartyType(PartyType.user);

    final UserModel? _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );

    final List<String> _thisBzUserSubscribedTopics = TopicModel.getUserTopicsFromTopics(
      topics: _userModel?.fcmTopics,
    );

    final bool _allIsOn = _thisBzUserSubscribedTopics.isNotEmpty;

    final double _bubbleWidth = PageBubble.width(context);
    final double _bubbleClearWidth = PageBubble.clearWidth(context);

    return ListView(
      key: const ValueKey<String>('FCMTopicsScreenView'),
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: <Widget>[

        const Stratosphere(),

        /// ALL SWITCHER
        BldrsTileBubble(
          bubbleWidth: _bubbleWidth,
          bubbleColor: Colorz.yellow20,
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
              partyType: PartyType.user,
              topicModel: topic,
            );

            return BldrsTileBubble(
              bubbleWidth: _bubbleClearWidth,
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
                onSwitchTap: (bool value) => _onSwitch(
                  value: value,
                  topicID: topic.id,
                ),
              ),
              onTileTap: () => _onSwitch(
                value: !_isSelected,
                topicID: topic.id,
              ),
            );

          },
        ),

        /// ADMIN
        if (Mapper.boolIsTrue(_userModel?.isAdmin) == true)
          TopicsExpandingTile(
            width: _bubbleWidth,
            groupVerse: Verse.plain('Admins Only'),
            topics: const [
              TopicModel(id: TopicModel.newAnonymousUser, description: 'New Anonymous Users', icon: Iconz.anonymousUser),
              TopicModel(id: TopicModel.newUserSignUp, description: 'New User Signups', icon: Iconz.normalUser),
            ],
            builder: (TopicModel topic){

              final bool _isSelected = TopicsExpandingTile.checkIsTopicSelected(
                context: context,
                partyType: PartyType.user,
                topicModel: topic,
              );

              return BldrsTileBubble(
                bubbleWidth: _bubbleClearWidth,
                bubbleColor: Colorz.black80,
                bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                  context: context,
                  headlineVerse: Verse(
                    id: topic.description,
                    translate: false,
                  ),
                  leadingIcon: topic.icon,
                  leadingIconSizeFactor: 0.6,
                  leadingIconBoxColor: _isSelected == true ? Colorz.green255 : Colorz.white10,
                  hasSwitch: true,
                  switchValue: _isSelected,
                  onSwitchTap: (bool value) => _onSwitch(
                    value: value,
                    topicID: topic.id,
                  ),
                ),
                onTileTap: () => _onSwitch(
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
