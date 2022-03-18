import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/unfinished_max_bounce_navigator.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip_with_headline.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BzzManagerScreen extends StatefulWidget {
  const BzzManagerScreen({Key key}) : super(key: key);

  @override
  _BzzManagerScreenState createState() => _BzzManagerScreenState();
}

class _BzzManagerScreenState extends State<BzzManagerScreen> {
  final TextEditingController _searchController = TextEditingController();
  ZoneProvider _zoneProvider;
  // CountryModel _bzCountry;
  // CityModel _bzCity;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future<void> _triggerLoading({Function function}) async {
    if (function == null) {
      setState(() {
        _loading = !_loading;
      });
    } else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true ?
    blog('LOADING--------------------------------------')
        :
    blog('LOADING COMPLETE--------------------------------------');
  }

// -----------------------------------------------------------------------------
  @override
  void initState() {
    _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

    super.initState();
  }

// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _triggerLoading(function: () {}).then((_) async {
        /// ---------------------------------------------------------0

        await _readMoreBzz();

        /// ---------------------------------------------------------0
      });
    }
    _isInit = false;
  }

// -----------------------------------------------------------------------------
  QueryDocumentSnapshot<Object> _lastSnapshot;
  final List<BzModel> _bzzModels = <BzModel>[];
  Future<dynamic> _readMoreBzz() async {
    final List<dynamic> _bzzMaps = await Fire.readCollectionDocs(
      collName: FireColl.bzz,
      orderBy: 'id',
      limit: 100,
      startAfter: _lastSnapshot,
      addDocSnapshotToEachMap: true,
    );

    setState(() {
      _lastSnapshot = _bzzMaps[_bzzMaps.length - 1]['docSnapshot'];
      _bzzModels.addAll(BzModel.decipherBzz(maps: _bzzMaps, fromJSON: false));
      _loading = false;
    });
  }

// -----------------------------------------------------------------------------
  List<BzModel> _searchedBzz = <BzModel>[];
  void _onSearchChanged(String value) {
    final String val = TextMod.removeSpacesFromAString(value);

    final bool _searchValueIsEmpty = val == '';
    final bool _searchResultIsEmpty = _searchedBzz.isEmpty;

    /// A - when field has NO value
    if (_searchValueIsEmpty) {
      /// B - when search result has values
      if (_searchResultIsEmpty == false) {
        setState(() {
          _searchedBzz = <BzModel>[];
        });
      }

      /// B - when search result has No values
      else {}
    }

    /// A - when field has value
    else {
      for (final BzModel tinyBz in _bzzModels) {
        final bool _matchFound = TextChecker.stringContainsSubString(
          string: TextMod.lowerCase(tinyBz.name),
          subString: TextMod.lowerCase(val),
        );

        final bool _alreadyInList = BzModel.bzzContainThisBz(
              bzz: _searchedBzz,
              bzModel: tinyBz,
            ) ==
            true;

        // blog('_alreadyInList : ${tinyBz.bzID} : $_alreadyInList');

        if (_alreadyInList == true) {
          if (_matchFound == true) {
          } else {
            setState(() {
              _searchedBzz.remove(tinyBz);
            });
          }
        } else {
          if (_matchFound == true) {
            setState(() {
              _searchedBzz.add(tinyBz);
            });
          } else {}
        }
      }
    }
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight =
        Scale.superScreenHeightWithoutSafeArea(context);

    const double _bzButtonHeight = 60;
    const double _bzButtonMargin = Ratioz.appBarPadding;

    final double _clearDialogWidth = BottomDialog.clearWidth(context);

    final List<BzModel> _bzz = _searchedBzz.isEmpty ? _bzzModels : _searchedBzz;


    return _bzzModels == null ?
    const LoadingFullScreenLayer()
        :
    MainLayout(
      pyramidsAreOn: true,
      appBarType: AppBarType.search,
      pageTitle: '${_bzzModels.length} Bzz Manager',
      // appBarBackButton: true,
      // loading: _loading,
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      searchController: _searchController,
      onSearchSubmit: (String val) => _onSearchChanged(val),
      historyButtonIsOn: false,
      onSearchChanged: (String val) => _onSearchChanged(val),
      layoutWidget: Container(
        width: _screenWidth,
        height: _screenHeight, color: Colorz.blue80,
        alignment: Alignment.topCenter,
        child: OldMaxBounceNavigator(
          child: ListView.builder(
            controller: ScrollController(),
            physics: const BouncingScrollPhysics(),
            itemExtent: _bzButtonHeight + _bzButtonMargin,
            itemCount: _bzz.length,
            padding: const EdgeInsets.only(
                bottom: Ratioz.stratosphere,
                top: Stratosphere.bigAppBarStratosphere
            ),
            itemBuilder: (BuildContext ctx, int index) {

              final BzModel _bz = _bzz[index];
              final String _bzName =
              _bz.name == null || _bz.name == '' ? '.....' : _bz.name;

              return DreamBox(
                height: _bzButtonHeight,
                width: _screenWidth - Ratioz.appBarMargin * 2,
                color: Colorz.white20,
                verse: _bzName,
                icon: _bz.logo,
                margins: const EdgeInsets.only(top: _bzButtonMargin),
                verseScaleFactor: 0.7,
                verseCentered: false,
                secondLine: _bz.id,
                onTap: () async {

                  final double _dialogHeight = _screenHeight * 0.8;

                  // final CountryModel _bzCountry = await _zoneProvider.fetchCountryByID(
                  //     context: context,
                  //     countryID: _bz.zone.countryID
                  // );

                  // final CityModel _bzCity =
                  // await _zoneProvider.fetchCityByID(
                  //     context: context, cityID: _bz.zone.cityID
                  // );

                  // final SuperFlyer _superFlyer = SuperFlyer.getSuperFlyerFromBzModelOnly(
                  //   onHeaderTap: () {},
                  //   bzModel: _bz,
                  //   bzCountry: _bzCountry,
                  //   bzCity: _bzCity,
                  // );

                  await BottomDialog.showBottomDialog(
                    context: context,
                    title: _bzName,
                    draggable: true,
                    height: _dialogHeight,
                    child: SizedBox(
                      width: _clearDialogWidth,
                      height: BottomDialog.clearHeight(
                          draggable: true,
                          titleIsOn: true,
                          context: context,
                          overridingDialogHeight: _dialogHeight),
                      // color: Colorz.BloodTest,
                      child: OldMaxBounceNavigator(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: <Widget>[

                            SizedBox(
                              width: _clearDialogWidth,
                              height: FlyerBox.headerStripHeight(
                                  headerIsExpanded: false,
                                  flyerBoxWidth: _clearDialogWidth,
                              ),
                              child: Column(
                                children: <Widget>[

                                  Container(),

                                  // MiniHeaderStrip(
                                  //   bzPageIsOn: _superFlyer.nav.bzPageIsOn,
                                  //   flyerBoxWidth: _clearDialogWidth,
                                  //   bzModel: _superFlyer.bz,
                                  //   bzCity: _superFlyer.bzCity,
                                  //   bzCountry: _superFlyer.bzCountry,
                                  //   followIsOn: _superFlyer.rec.followIsOn,
                                  //   onCallTap: _superFlyer.rec.onCallTap,
                                  //   onFollowTap: _superFlyer.rec.onFollowTap,
                                  //   authorID: _superFlyer.authorID,
                                  //   flyerShowsAuthor: _superFlyer.flyerShowsAuthor,
                                  //       ),

                                ],
                              ),
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzName',
                              dataValue: _bz.name,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzLogo',
                              dataValue: _bz.logo,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzID',
                              dataValue: _bz.id,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzType',
                              dataValue: _bz.bzTypes,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzForm',
                              dataValue: _bz.bzForm,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'createdAt',
                              dataValue: _bz.createdAt,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'accountType',
                              dataValue: _bz.accountType,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzScope',
                              dataValue: _bz.scope,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzZone',
                              dataValue: _bz.zone,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzAbout',
                              dataValue: _bz.about,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzPosition',
                              dataValue: _bz.position,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzContacts',
                              dataValue: _bz.contacts,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzAuthors',
                              dataValue: _bz.authors,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzShowsTeam',
                              dataValue: _bz.showsTeam,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzIsVerified',
                              dataValue: _bz.isVerified,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzState',
                              dataValue: _bz.bzState,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzTotalFollowers',
                              dataValue: _bz.totalFollowers,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzTotalSaves',
                              dataValue: _bz.totalSaves,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzTotalShares',
                              dataValue: _bz.totalShares,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzTotalSlides',
                              dataValue: _bz.totalSlides,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzTotalViews',
                              dataValue: _bz.totalViews,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzTotalCalls',
                              dataValue: _bz.totalCalls,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'flyersIDs,',
                              dataValue: _bz.flyersIDs,
                            ),

                            DataStripWithHeadline(
                              dataKey: 'bzTotalFlyers',
                              dataValue: _bz.totalFlyers,
                            ),

                            // Container(
                            //     width: _clearDialogWidth,
                            //     height: 100,
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: <Widget>[
                            //
                            //         DreamBox(
                            //           height: 80,
                            //           width: 80,
                            //           verse: 'Delete User',
                            //           verseMaxLines: 2,
                            //           onTap: () => _deleteUser(_userModel),
                            //         ),
                            //
                            //       ],
                            //     )
                            // )

                          ],
                        ),
                      ),
                    ),
                  );
                  },
              );
              },
          ),
        ),
      ),
    );
  }
}
