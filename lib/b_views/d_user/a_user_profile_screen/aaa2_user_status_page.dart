import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/user_profile/user_status/status_bubble.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:flutter/material.dart';

class UserStatusPage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const UserStatusPage({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<UserStatusPage> createState() => _UserStatusPageState();
  /// --------------------------------------------------------------------------
}

class _UserStatusPageState extends State<UserStatusPage> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<UserStatus> _currentUserStatus = ValueNotifier(null);
  // -----------------------------------------------------------------------------
  /*
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'TestingTemplate',);
    }
  }
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
        context: context,
        listen: false,
    );

    _currentUserStatus.value = _userModel.status;

  }
  // --------------------
  /*
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        /// FUCK

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
   */
  // --------------------
  @override
  void dispose() {
    _currentUserStatus.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  static const List<Map<String, dynamic>> _status = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'Property Status',
      'buttons': <Map<String, dynamic>>[
        <String, dynamic>{
          'state': 'Looking for a new property',
          'userStatus': UserStatus.searching
        },
        <String, dynamic>{
          'state': 'Constructing an existing property',
          'userStatus': UserStatus.finishing
        },
        <String, dynamic>{
          'state': 'Want to Sell / Rent my property',
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
  // --------------------
  void _switchUserStatus(UserStatus type) {
    _currentUserStatus.value = type;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final UserModel _userModel = UsersProvider.proGetMyUserModel(
    //   context: context,
    //   listen: true,
    // );

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: Stratosphere.stratosphereSandwich,
      children: <Widget>[

        ValueListenableBuilder(
          valueListenable: _currentUserStatus,
          builder: (_, UserStatus userStatus, Widget child){

            return StatusBubble(
              status: _status,
              currentStatus: userStatus,
              onSelectStatus: (UserStatus type) => _switchUserStatus(type),
            );

            },
        ),


      ],
    );

  }
  // -----------------------------------------------------------------------------
}
