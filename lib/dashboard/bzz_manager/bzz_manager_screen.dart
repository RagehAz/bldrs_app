import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/db/fire/methods/firestore.dart';
import 'package:bldrs/db/fire/methods/paths.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/views/widgets/general/textings/data_strip.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/mini_header_strip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BzzManagerScreen extends StatefulWidget {
  const BzzManagerScreen({Key key}) : super(key: key);

  @override
  _BzzManagerScreenState createState() => _BzzManagerScreenState();
}

class _BzzManagerScreenState extends State<BzzManagerScreen> {
  TextEditingController _searchController = TextEditingController();
  ZoneProvider _zoneProvider;
  // CountryModel _bzCountry;
  // CityModel _bzCity;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if (function == null){
      setState(() {
        _loading = !_loading;
      });
    }

    else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
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

      _triggerLoading(function: (){}).then((_) async {
        /// ---------------------------------------------------------0

        _readMoreBzz();

        /// ---------------------------------------------------------0
      });

    }
    _isInit = false;
  }
// -----------------------------------------------------------------------------
  QueryDocumentSnapshot<Object> _lastSnapshot;
  List<BzModel> _bzzModels = <BzModel>[];
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
  void _onSearchChanged(String value){

    final String val = TextMod.removeSpacesFromAString(value);

    final bool _searchValueIsEmpty =  val == '';
    final bool _searchResultIsEmpty = _searchedBzz.length == 0;

    /// A - when field has NO value
    if (_searchValueIsEmpty){

      /// B - when search result has values
      if (_searchResultIsEmpty == false){
        setState(() {
          _searchedBzz = <BzModel>[];
        });
      }

      /// B - when search result has No values
      else {}


    }

    /// A - when field has value
    else {

      for (BzModel tinyBz in _bzzModels){

        final bool _matchFound = TextChecker.stringContainsSubString(
          caseSensitive: false,
          string: TextMod.lowerCase(tinyBz.name),
          subString: TextMod.lowerCase(val),
          multiLine: false,
        );

        final bool _alreadyInList = BzModel.BzzContainThisBz(
          bzz: _searchedBzz,
          bzModel: tinyBz,
        ) == true;

        // print('_alreadyInList : ${tinyBz.bzID} : $_alreadyInList');

        if (_alreadyInList == true){

          if (_matchFound == true){

          }

          else {
            setState(() {
              _searchedBzz.remove(tinyBz);
            });
          }

        }

        else {

          if (_matchFound == true){
            setState(() {
              _searchedBzz.add(tinyBz);
            });
          }

          else {

          }

        }

      }

    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    const double _bzButtonHeight = 60;
    const double _bzButtonMargin = Ratioz.appBarPadding;

    final double _clearDialogWidth = BottomDialog.dialogClearWidth(context);

    final List<BzModel> _bzz = _searchedBzz.length == 0 ? _bzzModels : _searchedBzz;

    return

    _bzzModels == null ?
    const LoadingFullScreenLayer()
        :
      MainLayout(
        pyramids: Iconz.PyramidsYellow,
        appBarType: AppBarType.Search,
        pageTitle: '${_bzzModels.length} Bzz Manager',
        // appBarBackButton: true,
        loading: _loading,
        sectionButtonIsOn: false,
        skyType: SkyType.Black,
        searchController: _searchController,
        onSearchSubmit: (String val) => _onSearchChanged(val),
        historyButtonIsOn: false,
        onSearchChanged: (String val) => _onSearchChanged(val),
        layoutWidget: Container(
          width: _screenWidth,
          height: _screenHeight,
          color: Colorz.blue80,
          alignment: Alignment.topCenter,
          child: MaxBounceNavigator(
            child: ListView.builder(
              controller: ScrollController(),
              physics: const BouncingScrollPhysics(),
              itemExtent: _bzButtonHeight + _bzButtonMargin,
              itemCount: _bzz.length,
              shrinkWrap: false,
              addAutomaticKeepAlives: true,
              padding: const EdgeInsets.only(bottom: Ratioz.stratosphere, top: Stratosphere.bigAppBarStratosphere),
              itemBuilder: (BuildContext ctx, int index){

                final BzModel _bz = _bzz[index];
                final String _bzName = _bz.name == null || _bz.name == '' ? '.....' : _bz.name;

                return

                  DreamBox(
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

                      final CountryModel _bzCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: _bz.zone.countryID);
                      final CityModel _bzCity = await _zoneProvider.fetchCityByID(context: context, cityID: _bz.zone.cityID);

                      await BottomDialog.showBottomDialog(
                        context: context,
                        title: _bzName,
                        draggable: true,
                        height: _dialogHeight,
                        child: Container(
                          width: _clearDialogWidth,
                          height: BottomDialog.dialogClearHeight(draggable: true, titleIsOn: true, context: context, overridingDialogHeight: _dialogHeight),
                          // color: Colorz.BloodTest,
                          child: MaxBounceNavigator(
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: <Widget>[

                                Container(
                                  width: _clearDialogWidth,
                                  height: FlyerBox.headerStripHeight(false, _clearDialogWidth),
                                  child: Column(

                                    children: <Widget>[

                                      MiniHeaderStrip(
                                        superFlyer: SuperFlyer.getSuperFlyerFromBzModelOnly(
                                          onHeaderTap: (){},
                                          bzModel: _bz,
                                          bzCountry: _bzCountry,
                                          bzCity: _bzCity,
                                        ),
                                        flyerBoxWidth: _clearDialogWidth,
                                      ),

                                    ],

                                  ),
                                ),



                                DataStrip(dataKey: 'bzName', dataValue: _bz.name, ),
                                DataStrip(dataKey: 'bzLogo', dataValue: _bz.logo, ),
                                DataStrip(dataKey: 'bzID', dataValue: _bz.id, ),
                                DataStrip(dataKey: 'bzType', dataValue: _bz.bzType, ),
                                DataStrip(dataKey: 'bzForm', dataValue: _bz.bzForm, ),
                                DataStrip(dataKey: 'createdAt', dataValue: _bz.createdAt, ),
                                DataStrip(dataKey: 'accountType', dataValue: _bz.accountType, ),
                                DataStrip(dataKey: 'bzScope', dataValue: _bz.scope, ),
                                DataStrip(dataKey: 'bzZone', dataValue: _bz.zone, ),
                                DataStrip(dataKey: 'bzAbout', dataValue: _bz.about, ),
                                DataStrip(dataKey: 'bzPosition', dataValue: _bz.position, ),
                                DataStrip(dataKey: 'bzContacts', dataValue: _bz.contacts, ),
                                DataStrip(dataKey: 'bzAuthors', dataValue: _bz.authors, ),
                                DataStrip(dataKey: 'bzShowsTeam', dataValue: _bz.showsTeam, ),
                                DataStrip(dataKey: 'bzIsVerified', dataValue: _bz.isVerified, ),
                                DataStrip(dataKey: 'bzState', dataValue: _bz.bzState, ),
                                DataStrip(dataKey: 'bzTotalFollowers', dataValue: _bz.totalFollowers, ),
                                DataStrip(dataKey: 'bzTotalSaves', dataValue: _bz.totalSaves, ),
                                DataStrip(dataKey: 'bzTotalShares', dataValue: _bz.totalShares, ),
                                DataStrip(dataKey: 'bzTotalSlides', dataValue: _bz.totalSlides, ),
                                DataStrip(dataKey: 'bzTotalViews', dataValue: _bz.totalViews, ),
                                DataStrip(dataKey: 'bzTotalCalls', dataValue: _bz.totalCalls, ),
                                DataStrip(dataKey: 'flyersIDs,', dataValue: _bz.flyersIDs, ),
                                DataStrip(dataKey: 'bzTotalFlyers', dataValue: _bz.totalFlyers, ),


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
