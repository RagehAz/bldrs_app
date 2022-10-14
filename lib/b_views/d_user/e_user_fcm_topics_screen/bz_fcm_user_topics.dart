import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/b_views/z_components/notes/topics_editor/topics_expanding_tile.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:flutter/material.dart';

class BzFCMTopicsScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzFCMTopicsScreenView({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  Future<void> _onSwitch({
    @required BuildContext context,
    @required String topicID,
    @required bool value,
  }) async {

    final BzModel _activeBz = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: false,
    );

    final String _customTopicID = TopicModel.generateBzTopicID(
      topicID: topicID,
      bzID: _activeBz.id,
    );

    await UserProtocols.updateUserTopics(
      context: context,
      topicID: _customTopicID,
    );

  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> _map = TopicModel.getTopicsMapByPartyType(PartyType.bz);
    final List<String> _keys = _map.keys.toList();

    return ListView(
      key: const ValueKey<String>('FCMTopicsScreenView'),
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: <Widget>[

        const Stratosphere(),

        ...List.generate(_map.keys.length, (index){

          final String _groupName = _keys[index];
          final List<TopicModel> _topics = _map[_groupName];

          return TopicsExpandingTile(
            topics: _topics,
            groupName: _groupName,
            partyType: PartyType.bz,
            onSwitch: (bool value, TopicModel topicModel) => _onSwitch(
                context: context,
                topicID: topicModel.id,
                value: value
            ),
          );

        }),

        const Horizon(),

      ],
    );

  }
/// --------------------------------------------------------------------------
}
