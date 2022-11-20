// ignore_for_file: avoid_print

import 'package:bldrs/a_models/a_user/need_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/census_protocols/protocols/census_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
import 'package:bldrs/x_dashboard/zzz_exotic_methods/exotic_methods.dart';
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

        // -----------------------------------

        /// ON COMPOSE USER
        WideButton(
          verse: Verse.plain('1 - on Compose User'),
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
          verse: Verse.plain('2 - on Renovate User'),
          onTap: () async {

            final UserModel _oldUser = UsersProvider.proGetMyUserModel(
              context: context,
              listen: false,
            );

            final UserModel _newUser = _oldUser.copyWith(
              need: _oldUser.need.copyWith(
                needType: NeedType.furnish,
              ),
              zone: _oldUser.zone.copyWith(
                countryID: 'alb',
                cityID: 'alb_erseke',
              ),
            );

            await CensusProtocols.onRenovateUser(
              oldUser: _oldUser,
              newUser: _newUser,
            );

          },
        ),

        /// ON WIPE USER
        WideButton(
          verse: Verse.plain('3 - on Wipe User'),
          onTap: () async {

            final bool _go = await Dialogs.confirmProceed(
              titleVerse: Verse.plain('This wipes the renovated UserModel'),
              bodyVerse: Verse.plain('Did you renovate the user?, if yes ? proceed with this wipe'),
              context: context, invertButtons: true,
            );

            if (_go == true){

              final UserModel _oldUser = UsersProvider.proGetMyUserModel(
                context: context,
                listen: false,
              );

              final UserModel _newUser = _oldUser.copyWith(
                need: _oldUser.need.copyWith(
                  needType: NeedType.furnish,
                ),
                zone: _oldUser.zone.copyWith(
                  countryID: 'alb',
                  cityID: 'alb_erseke',
                ),
              );

              await CensusProtocols.onWipeUser(_newUser);


            }

          },
        ),

        /// SEPARATOR
        const DotSeparator(),

        // -----------------------------------

        /// ON COMPOSE BZ
        WideButton(
          verse: Verse.plain('1 - on Compose Bz'),
          onTap: () async {

            final UserModel _userModel = UsersProvider.proGetMyUserModel(
              context: context,
              listen: false,
            );

            final BzModel _bzModel = await BzProtocols.fetchBz(
              context: context,
              bzID: _userModel.myBzzIDs.first,
            );

            if (_bzModel != null){
              await CensusProtocols.onComposeBz(_bzModel);
            }

          },
        ),

        /// ON RENOVATE BZ
        WideButton(
          verse: Verse.plain('2 - on Renovate Bz'),
          onTap: () async {

            final UserModel _userModel = UsersProvider.proGetMyUserModel(
              context: context,
              listen: false,
            );

            final BzModel _bzModel = await BzProtocols.fetchBz(
              context: context,
              bzID: _userModel.myBzzIDs.first,
            );

            if (_bzModel != null){
              await CensusProtocols.onRenovateBz(
                oldBz: _bzModel,
                newBz: _bzModel.copyWith(
                  bzTypes: <BzType>[
                    BzType.broker,
                  ],
                  bzForm: BzForm.individual,
                  accountType: BzAccountType.master,
                  zone: _bzModel.zone.copyWith(
                    countryID: 'alb',
                    cityID: 'alb_erseke',
                  ),
                ),
              );
            }

          },
        ),

        /// ON WIPE BZ
        WideButton(
          verse: Verse.plain('3 - on Wipe Bz'),
          onTap: () async {

            final bool _go = await Dialogs.confirmProceed(
              titleVerse: Verse.plain('This wipes the renovated BzModel'),
              bodyVerse: Verse.plain('Did you renovate the Bz?, if yes ? proceed with this wipe'),
              context: context,
              invertButtons: true
            );

            if (_go == true){

              final UserModel _userModel = UsersProvider.proGetMyUserModel(
                context: context,
                listen: false,
              );

              final BzModel _bzModel = await BzProtocols.fetchBz(
                context: context,
                bzID: _userModel.myBzzIDs.first,
              );

              if (_bzModel != null){
                await CensusProtocols.onWipeBz(_bzModel.copyWith(
                  bzTypes: <BzType>[
                    BzType.broker,
                  ],
                  bzForm: BzForm.individual,
                  accountType: BzAccountType.master,
                  zone: _bzModel.zone.copyWith(
                    countryID: 'alb',
                    cityID: 'alb_erseke',
                  ),
                ));
              }

            }

          },
        ),

        /// SEPARATOR
        const DotSeparator(),

        // -----------------------------------

        /// ON COMPOSE FLYER
        WideButton(
          verse: Verse.plain('1 - on Compose Flyer'),
          onTap: () async {

            final UserModel _userModel = UsersProvider.proGetMyUserModel(
              context: context,
              listen: false,
            );
            final BzModel _bzModel = await BzProtocols.fetchBz(
              context: context,
              bzID: _userModel.myBzzIDs.first,
            );
            final FlyerModel _flyerModel = await FlyerProtocols.fetchFlyer(
              context: context,
              flyerID: _bzModel.flyersIDs.first,
            );

            if (_flyerModel != null){
              await CensusProtocols.onComposeFlyer(_flyerModel);
            }

          },
        ),

        /// ON RENOVATE FLYER
        WideButton(
          verse: Verse.plain('2 - on Renovate Flyer'),
          onTap: () async {

            final UserModel _userModel = UsersProvider.proGetMyUserModel(
              context: context,
              listen: false,
            );
            final BzModel _bzModel = await BzProtocols.fetchBz(
              context: context,
              bzID: _userModel.myBzzIDs.first,
            );
            final FlyerModel _flyerModel = await FlyerProtocols.fetchFlyer(
              context: context,
              flyerID: _bzModel.flyersIDs.first,
            );

            if (_flyerModel != null){

              await CensusProtocols.onRenovateFlyer(
                oldFlyer: _flyerModel,
                newFlyer: _flyerModel.copyWith(
                  zone: _flyerModel.zone.copyWith(
                    countryID: 'alb',
                    cityID: 'alb_erseke',
                  ),
                  slides: [_flyerModel.slides[0], _flyerModel.slides[1]],
                  flyerType: FlyerType.property,
                ),
              );
            }

          },
        ),

        /// ON WIPE FLYER
        WideButton(
          verse: Verse.plain('3 - on Wipe Flyer'),
          onTap: () async {

            final bool _go = await Dialogs.confirmProceed(
                titleVerse: Verse.plain('This wipes the renovated Flyer'),
                bodyVerse: Verse.plain('Did you renovate the Flyer?, if yes ? proceed with this wipe'),
                context: context,
                invertButtons: true
            );

            if (_go == true){

              final UserModel _userModel = UsersProvider.proGetMyUserModel(
                context: context,
                listen: false,
              );
              final BzModel _bzModel = await BzProtocols.fetchBz(
                context: context,
                bzID: _userModel.myBzzIDs.first,
              );
              final FlyerModel _flyerModel = await FlyerProtocols.fetchFlyer(
                context: context,
                flyerID: _bzModel.flyersIDs.first,
              );

              if (_flyerModel != null){
                await CensusProtocols.onWipeFlyer(_flyerModel.copyWith(
                  zone: _flyerModel.zone.copyWith(
                    countryID: 'alb',
                    cityID: 'alb_erseke',
                  ),
                  slides: [_flyerModel.slides[0], _flyerModel.slides[1]],
                  flyerType: FlyerType.property,
                ));
              }

            }

          },
        ),

        /// SEPARATOR
        const DotSeparator(),

        // -----------------------------------

        /// CREATE INITIAL CENSUS
        WideButton(
          verse: Verse.plain('X - Create Initial Census'),
          color: Colorz.bloodTest,
          onTap: () async {

            final bool _go = await Dialogs.confirmProceed(
              context: context,
              titleVerse: Verse.plain('This is Dangerous !'),
              bodyVerse: Verse.plain('This will read all Users - All Bzz - All Flyers and create a Census for each of them'),
              invertButtons: true,
            );

            if (_go == true){

              /// ALL USERS
              await ExoticMethods.readAllUserModels(
                limit: 900,
                onRead: (int index, UserModel _userModel) async {

                  await CensusProtocols.onComposeUser(_userModel);
                  blog('DONE : $index : UserModel: ${_userModel.name}');

                },
              );

              /// ALL BZZ
              await ExoticMethods.readAllBzzModels(
                limit: 900,
                onRead: (int i, BzModel _bzModel) async {

                  blog('DONE : $i : BzModel: ${_bzModel.name}');
                  await CensusProtocols.onComposeBz(_bzModel);

                },
              );

              /// ALL FLYERS
              await ExoticMethods.readAllFlyers(
                limit: 1000,
                onRead: (int index, FlyerModel _flyerModel) async {

                  blog('DONE : $index : FlyerModel: ${_flyerModel.id}');
                  await CensusProtocols.onComposeFlyer(_flyerModel);

                },
              );

            }

          },
        ),


      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
