import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
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
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:flutter/material.dart';

class UserFCMTopicsScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserFCMTopicsScreenView({
    super.key
  });
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSwitch({
    required BuildContext context,
    required String topicID,
    required bool value,
  }) async {

    await UserProtocols.updateMyUserTopics(
      context: context,
      topicID: topicID,
    );

  }
  // --------------------
  ///
  Future<void> _onSwitchAll({
    required BuildContext context,
    required bool value,
  }) async {

    final UserModel? _userModel = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );

    /// SUBSCRIBE TO ALL USER TOPICS
    if (value == true){

      final List<String> _updatedTopics = Stringer.addStringsToStringsIfDoNotContainThem(
          listToTake: _userModel.fcmTopics,
          listToAdd: TopicModel.getAllPossibleUserTopicsIDs(),
      );

      await UserProtocols.renovate(
          context: context,
          newPic: null,
          oldUser: _userModel,
          newUser: _userModel.copyWith(
            fcmTopics: _updatedTopics,
          ),
        invoker: 'UserFCMTopicsScreenView._onSwitchAll',
      );

    }

    /// UNSUBSCRIBE FROM ALL USER TOPICS
    else {

      final List<String> _updatedTopics = Stringer.removeStringsFromStrings(
        removeFrom: _userModel.fcmTopics,
        removeThis: TopicModel.getAllPossibleUserTopicsIDs(),
      );

      await UserProtocols.renovate(
        context: context,
        newPic: null,
        newUser: _userModel.copyWith(
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
      topics: _userModel.fcmTopics,
    );

    final bool _allIsOn = _thisBzUserSubscribedTopics.isNotEmpty;

    return ListView(
      key: const ValueKey<String>('FCMTopicsScreenView'),
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: <Widget>[

        const Stratosphere(),

        /// ALL SWITCHER
        BldrsTileBubble(
          bubbleWidth: PageBubble.width(context),
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
              context: context,
              value: !_allIsOn,
            ),
          ),
          onTileTap: () => _onSwitchAll(
            context: context,
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
