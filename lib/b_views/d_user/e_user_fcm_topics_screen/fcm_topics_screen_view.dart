import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/noot_event.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/b_expanding_tile.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class FCMTopicsScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FCMTopicsScreenView({
    @required this.partyType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PartyType partyType;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
        context: context,
        listen: true,
    );

    final List<String> _userTopics = _userModel.fcmTopics;

    final Map<String, dynamic> _map = NootEvent.getEventsMapByPartyType(partyType);
    final List<String> _keys = _map.keys.toList();

    return ListView(
      key: const ValueKey<String>('FCMTopicsScreenView'),
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: <Widget>[

        const Stratosphere(),

        ...List.generate(_map.keys.length, (index){

          final String _key = _keys[index];
          final List<NootEvent> _events = _map[_key];

          return ExpandingTile(
              firstHeadline: Verse.plain(_map[_map.keys.toString()[index]]),
              secondHeadline: Verse.plain(''),
              child: Column(
                children: <Widget>[

                  ...List.generate(_events.length, (index){

                    final NootEvent _event = _events[index];

                    final bool _isSelected = Stringer.checkStringsContainString(
                      strings: _userTopics,
                      string: _event.id,
                    );

                    return TileBubble(
                      bubbleWidth: PageBubble.clearWidth(context),
                      bubbleHeaderVM: BubbleHeaderVM(
                          headlineVerse: Verse.plain(_event.description),
                          leadingIcon: Iconz.notification,
                          leadingIconSizeFactor: 0.6,
                          leadingIconBoxColor: _isSelected == true ? Colorz.green255 : Colorz.white10,
                          hasSwitch: true,
                          switchValue: _isSelected,
                          onSwitchTap: (bool value) async {

                            final UserModel updated = _userModel.copyWith(
                              fcmTopics: Stringer.addOrRemoveStringToStrings(
                                strings: _userTopics,
                                string: _event.id,
                              ),
                            );

                            await UserProtocols.updateLocally(
                              context: context,
                              newUserModel: updated,
                            );

                          }
                      ),

                    );

                  }),

                ],
              ),
          );



        }),

        const Horizon(),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
