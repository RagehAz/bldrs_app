import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/bz_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/mini_header_strip.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog_row.dart';

class BzzManagerScreen extends StatefulWidget {

  @override
  _BzzManagerScreenState createState() => _BzzManagerScreenState();
}

class _BzzManagerScreenState extends State<BzzManagerScreen> {
  TextEditingController _searchController = TextEditingController();
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
  QueryDocumentSnapshot _lastSnapshot;
  List<TinyBz> _tinyBzz = <TinyBz>[];
  Future<dynamic> _readMoreBzz() async {

    final List<dynamic> _bzzMaps = await Fire.readCollectionDocs(
      collectionName: FireCollection.tinyBzz,
      orderBy: 'bzID',
      limit: 100,
      startAfter: _lastSnapshot,
      addDocSnapshotToEachMap: true,

    );

    setState(() {
      _lastSnapshot = _bzzMaps[_bzzMaps.length - 1]['docSnapshot'];
      _tinyBzz.addAll(TinyBz.decipherTinyBzzMaps(_bzzMaps));
      _loading = false;
    });

  }
// -----------------------------------------------------------------------------
  List<TinyBz> _searchedTinyBzz = [];
  void _onSearchChanged(String value){

    final String val = TextMod.removeSpacesFromAString(value);

    final bool _searchValueIsEmpty =  val == '';
    final bool _searchResultIsEmpty = _searchedTinyBzz.length == 0;

    /// A - when field has NO value
    if (_searchValueIsEmpty){

      /// B - when search result has values
      if (_searchResultIsEmpty == false){
        setState(() {
          _searchedTinyBzz = [];
        });
      }

      /// B - when search result has No values
      else {}


    }

    /// A - when field has value
    else {

      for (var tinyBz in _tinyBzz){

        final bool _matchFound = TextChecker.stringContainsSubString(
          caseSensitive: false,
          string: TextMod.lowerCase(tinyBz.bzName),
          subString: TextMod.lowerCase(val),
          multiLine: false,
        );

        final bool _alreadyInList = TinyBz.tinyBzzContainThisTinyBz(
          tinyBzz: _searchedTinyBzz,
          tinyBz: tinyBz,
        ) == true;

        // print('_alreadyInList : ${tinyBz.bzID} : $_alreadyInList');

        if (_alreadyInList == true){

          if (_matchFound == true){

          }

          else {
            setState(() {
              _searchedTinyBzz.remove(tinyBz);
            });
          }

        }

        else {

          if (_matchFound == true){
            setState(() {
              _searchedTinyBzz.add(tinyBz);
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

    final List<TinyBz> _bzz = _searchedTinyBzz.length == 0 ? _tinyBzz : _searchedTinyBzz;

    return

    _tinyBzz == null ?
    LoadingFullScreenLayer()
        :
      MainLayout(
        pyramids: Iconz.PyramidsYellow,
        appBarType: AppBarType.Search,
        pageTitle: '${_tinyBzz.length} Bzz Manager',
        // appBarBackButton: true,
        loading: _loading,
        sectionButtonIsOn: false,
        sky: Sky.Black,
        searchController: _searchController,
        onSearchSubmit: (val) => _onSearchChanged(val),
        historyButtonIsOn: false,
        onSearchChanged: (val) => _onSearchChanged(val),
        layoutWidget: Container(
          width: _screenWidth,
          height: _screenHeight,
          color: Colorz.Blue80,
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
              itemBuilder: (ctx, index){

                final TinyBz _tinyBz = _bzz[index];
                final String _bzName = _tinyBz.bzName == null || _tinyBz.bzName == '' ? '.....' : _tinyBz.bzName;

                return

                  DreamBox(
                    height: _bzButtonHeight,
                    width: _screenWidth - Ratioz.appBarMargin * 2,
                    color: Colorz.White20,
                    verse: _bzName,
                    icon: _tinyBz.bzLogo,
                    margins: EdgeInsets.only(top: _bzButtonMargin),
                    verseScaleFactor: 0.7,
                    verseCentered: false,
                    secondLine: _tinyBz.bzID,
                    onTap: () async {

                      final BzModel _bz = await BzOps.readBzOps(
                        context: context,
                        bzID: _tinyBz.bzID,
                      );

                      final double _dialogHeight = _screenHeight * 0.8;

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
                                        ),
                                        flyerBoxWidth: _clearDialogWidth,
                                      ),

                                    ],

                                  ),
                                ),



                                DataStrip(dataKey: 'bzName', dataValue: _bz.bzName, ),
                                DataStrip(dataKey: 'bzLogo', dataValue: _bz.bzLogo, ),
                                DataStrip(dataKey: 'bzID', dataValue: _bz.bzID, ),
                                DataStrip(dataKey: 'bzType', dataValue: _bz.bzType, ),
                                DataStrip(dataKey: 'bzForm', dataValue: _bz.bzForm, ),
                                DataStrip(dataKey: 'createdAt', dataValue: _bz.createdAt, ),
                                DataStrip(dataKey: 'accountType', dataValue: _bz.accountType, ),
                                DataStrip(dataKey: 'bzScope', dataValue: _bz.bzScope, ),
                                DataStrip(dataKey: 'bzZone', dataValue: _bz.bzZone, ),
                                DataStrip(dataKey: 'bzAbout', dataValue: _bz.bzAbout, ),
                                DataStrip(dataKey: 'bzPosition', dataValue: _bz.bzPosition, ),
                                DataStrip(dataKey: 'bzContacts', dataValue: _bz.bzContacts, ),
                                DataStrip(dataKey: 'bzAuthors', dataValue: _bz.bzAuthors, ),
                                DataStrip(dataKey: 'bzShowsTeam', dataValue: _bz.bzShowsTeam, ),
                                DataStrip(dataKey: 'bzIsVerified', dataValue: _bz.bzIsVerified, ),
                                DataStrip(dataKey: 'bzAccountIsDeactivated', dataValue: _bz.bzAccountIsDeactivated, ),
                                DataStrip(dataKey: 'bzAccountIsBanned', dataValue: _bz.bzAccountIsBanned, ),
                                DataStrip(dataKey: 'bzTotalFollowers', dataValue: _bz.bzTotalFollowers, ),
                                DataStrip(dataKey: 'bzTotalSaves', dataValue: _bz.bzTotalSaves, ),
                                DataStrip(dataKey: 'bzTotalShares', dataValue: _bz.bzTotalShares, ),
                                DataStrip(dataKey: 'bzTotalSlides', dataValue: _bz.bzTotalSlides, ),
                                DataStrip(dataKey: 'bzTotalViews', dataValue: _bz.bzTotalViews, ),
                                DataStrip(dataKey: 'bzTotalCalls', dataValue: _bz.bzTotalCalls, ),
                                DataStrip(dataKey: 'flyersIDs,', dataValue: _bz.flyersIDs, ),
                                DataStrip(dataKey: 'bzTotalFlyers', dataValue: _bz.bzTotalFlyers, ),
                                DataStrip(dataKey: 'authorsIDs', dataValue: _bz.authorsIDs, ),


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
