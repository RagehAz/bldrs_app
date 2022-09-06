import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/user_profile/user_status/status_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:flutter/material.dart';

class UserStatusPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserStatusPage({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  ///
  // -----------------------------------------------------------------------------
  void _switchUserStatus(UserStatus type) {
    // setState(() {
    //   _currentUserStatus = type;
    // });

    blog('type is $type');

  }
  // -----------------------------------------------------------------------------
  static const List<Map<String, dynamic>> _status = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'Property Status',
      'buttons': <Map<String, dynamic>>[
        <String, dynamic>{
          'state': 'Looking for a\nnew property',
          'userStatus': UserStatus.searching
        },
        <String, dynamic>{
          'state': 'Constructing\nan existing\nproperty',
          'userStatus': UserStatus.finishing
        },
        <String, dynamic>{
          'state': 'Want to\nSell / Rent\nmy property',
          'userStatus': UserStatus.selling
        }
      ],
    },
    <String, dynamic>{
      'title': 'Construction Status',
      'buttons': <Map<String, dynamic>>[
        <String, dynamic>{
          'state': 'Planning Construction',
          'userStatus': UserStatus.planning
        },
        <String, dynamic>{
          'state': 'Under Construction',
          'userStatus': UserStatus.building
        }
      ],
    },
  ];
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: Stratosphere.stratosphereSandwich,
      children: <Widget>[

        StatusBubble(
          status: _status,
          switchUserStatus: (UserStatus type) => _switchUserStatus(type),
          userStatus: _userModel?.status,
          currentUserStatus: null,
          // openEnumLister: widget.openEnumLister,
        ),

      ],
    );

  }
// -----------------------------------------------------------------------------
}
