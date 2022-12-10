// ignore_for_file: avoid_print
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/pages_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/texting/customs/super_headline.dart';
import 'package:bldrs/c_protocols/zone_protocols/census_protocols/real/census_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/a_models/a_user/sub/need_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/census_protocols/protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';

class CensusLabScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CensusLabScreen({
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<CensusLabScreen> createState() => _CensusLabScreenState();
/// --------------------------------------------------------------------------
}

class _CensusLabScreenState extends State<CensusLabScreen> {
  // -----------------------------------------------------------------------------

  ZoneModel _bubbleZone;

  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeightWithoutSafeArea = Scale.superScreenHeightWithoutSafeArea(context);
    const AppBarType _appBarType = AppBarType.basic;

    return PagesLayout(
      title: Verse.plain('Census Lab'),
      pageBubbles: <Widget>[

        /// READ CENSUSES
        PageBubble(
          screenHeightWithoutSafeArea: _screenHeightWithoutSafeArea,
          appBarType: _appBarType,
          color: Colorz.white20,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              /// HEADLINE
              SuperHeadline(
                verse: Verse.plain('Read Censuses'),
              ),

              /// READ PLANET CENSUS
              WideButton(
                verse: Verse.plain('Read Planet Census'),
                onTap: () async {

                  final CensusModel _countryCensus = await CensusRealOps.readPlanetCensus();
                  _countryCensus.blogCensus();

                },
              ),

              /// READ COUNTRY CENSUS
              WideButton(
                verse: Verse.plain('READ ALL COUNTRIES CENSUSES'),
                onTap: () async {

                  final List<CensusModel> _censuses = await CensusRealOps.readAllCountriesCensuses();
                  CensusModel.blogCensuses(censuses: _censuses);

                },
              ),

              /// READ COUNTRY CENSUS
              WideButton(
                verse: Verse.plain('Read Country Census'),
                onTap: () async {

                  final CensusModel _countryCensus = await CensusRealOps.readCountryCensus(countryID: 'egy');

                  _countryCensus.blogCensus();

                },
              ),

              /// READ CITIES CENSUSES
              WideButton(
                verse: Verse.plain('READ CITIES CENSUSES'),
                onTap: () async {

                  final List<CensusModel> _censuses = await CensusRealOps.readCitiesOfCountryCensus(countryID: 'egy');
                  CensusModel.blogCensuses(censuses: _censuses);

                },
              ),

              /// READ CITY CENSUS
              WideButton(
                verse: Verse.plain('Read City Census'),
                onTap: () async {

                  final CensusModel _cityCensus = await CensusRealOps.readCityCensus(cityID: 'egy+cairo');
                  _cityCensus.blogCensus();

                },
              ),

              /// READ DISTRICTS CENSUSES
              WideButton(
                verse: Verse.plain('READ DISTRICTS CENSUSES'),
                onTap: () async {

                  final List<CensusModel> _censuses = await CensusRealOps.readDistrictsOfCityCensus(
                    cityID: 'egy+cairo',
                  );
                  CensusModel.blogCensuses(censuses: _censuses);

                },
              ),

              /// READ DISTRICT CENSUS
              WideButton(
                verse: Verse.plain('Read District Census'),
                onTap: () async {

                  final CensusModel _districtCensus = await CensusRealOps.readDistrictCensus(districtID: 'egy+cairo+nasr_city');
                  _districtCensus?.blogCensus();

                  if (_districtCensus == null){
                    blog('NULL');
                  }

                },
              ),

              /// SEPARATOR
              const SeparatorLine(),

            ],
          ),
        ),


        /// CENSUS TESTING
        PageBubble(
          screenHeightWithoutSafeArea: _screenHeightWithoutSafeArea,
          appBarType: _appBarType,
          color: Colorz.white20,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              /// HEADLINE
              SuperHeadline(
                verse: Verse.plain('Census testing'),
              ),

              // -----------------------------------

              /// ON COMPOSE USER
              WideButton(
                verse: Verse.plain('1 - on Compose User'),
                onTap: () async {

                  final UserModel _userModel = UsersProvider.proGetMyUserModel(
                    context: context,
                    listen: false,
                  );

                  await CensusListener.onComposeUser(_userModel);

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
                      cityID: 'alb+erseke',
                    ),
                  );

                  await CensusListener.onRenovateUser(
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
                        cityID: 'alb+erseke',
                      ),
                    );

                    await CensusListener.onWipeUser(_newUser);


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
                    await CensusListener.onComposeBz(_bzModel);
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
                    await CensusListener.onRenovateBz(
                      oldBz: _bzModel,
                      newBz: _bzModel.copyWith(
                        bzTypes: <BzType>[
                          BzType.broker,
                        ],
                        bzForm: BzForm.individual,
                        accountType: BzAccountType.master,
                        zone: _bzModel.zone.copyWith(
                          countryID: 'alb',
                          cityID: 'alb+erseke',
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
                      await CensusListener.onWipeBz(_bzModel.copyWith(
                        bzTypes: <BzType>[
                          BzType.broker,
                        ],
                        bzForm: BzForm.individual,
                        accountType: BzAccountType.master,
                        zone: _bzModel.zone.copyWith(
                          countryID: 'alb',
                          cityID: 'alb+erseke',
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
                    await CensusListener.onComposeFlyer(_flyerModel);
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

                    await CensusListener.onRenovateFlyer(
                      oldFlyer: _flyerModel,
                      newFlyer: _flyerModel.copyWith(
                        zone: _flyerModel.zone.copyWith(
                          countryID: 'alb',
                          cityID: 'alb+erseke',
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
                      await CensusListener.onWipeFlyer(_flyerModel.copyWith(
                        zone: _flyerModel.zone.copyWith(
                          countryID: 'alb',
                          cityID: 'alb+erseke',
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

                  await CensusListener.scanAllDBAndCreateInitialCensuses(
                    context: context,
                  );

                },
              ),

              // -----------------------------------

              /// SEPARATOR
              const SeparatorLine(),

            ],
          ),
        ),



      ],
    );

  }
// -----------------------------------------------------------------------------
}