import 'package:bldrs/a_models/a_user/need_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/census_protocols/protocols/census_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class CensusTestingScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CensusTestingScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _TheStatefulScreenState createState() => _TheStatefulScreenState();
/// --------------------------------------------------------------------------
}

class _TheStatefulScreenState extends State<CensusTestingScreen> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[

        /// ON COMPOSE USER
        WideButton(
          verse: Verse.plain('on Compose User'),
          onTap: () async {

            final UserModel _userModel = UsersProvider.proGetMyUserModel(
                context: context,
                listen: false,
            );

            await CensusProtocols.onComposeUser(_userModel);

          },
        ),

        /// ON RENOVATE USER
        WideButton(
          verse: Verse.plain('on Renovate User'),
          onTap: () async {

            final UserModel _userModel = UsersProvider.proGetMyUserModel(
              context: context,
              listen: false,
            );

            final UserModel _updatedUser = _userModel.copyWith(
              need: _userModel.need.copyWith(
                needType: NeedType.furnish,
              ),
              zone: _userModel.zone.copyWith(
                countryID: 'alb',
                cityID: 'alb_erseke',
              ),
            );

            await CensusProtocols.onUserRenovation(
              oldUser: _userModel,
              updatedUser: _updatedUser,
            );

          },
        ),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
