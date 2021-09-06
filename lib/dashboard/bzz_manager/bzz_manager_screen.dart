import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/bz_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_header.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_header_strip.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/dashboard/widgets/dashboard_data_row.dart';

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
  List<TinyBz> _tinyBzz = [];
  Future<dynamic> _readMoreBzz() async {

    List<dynamic> _bzzMaps = await Fire.readCollectionDocs(
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

    String val = TextMod.removeSpacesFromAString(value);

    bool _searchValueIsEmpty =  val == '';
    bool _searchResultIsEmpty = _searchedTinyBzz.length == 0;

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

        bool _matchFound = TextChecker.stringContainsSubString(
          caseSensitive: false,
          string: TextMod.lowerCase(tinyBz.bzName),
          subString: TextMod.lowerCase(val),
          multiLine: false,
        );

        bool _alreadyInList = TinyBz.tinyBzzContainThisTinyBz(
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

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    double _bzButtonHeight = 60;
    double _bzButtonMargin = Ratioz.appBarPadding;

    double _clearDialogWidth = BottomDialog.dialogClearWidth(context);

    List<TinyBz> _bzz = _searchedTinyBzz.length == 0 ? _tinyBzz : _searchedTinyBzz;

    return

    _tinyBzz == null ?
    LoadingFullScreenLayer()
        :
      MainLayout(
        pyramids: Iconz.PyramidsYellow,
        appBarType: AppBarType.Search,
        pageTitle: 'Bzz Manager',
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
          child: GoHomeOnMaxBounce(
            child: ListView.builder(
              controller: ScrollController(),
              physics: const BouncingScrollPhysics(),
              itemExtent: _bzButtonHeight + _bzButtonMargin,
              itemCount: _bzz.length,
              shrinkWrap: false,
              addAutomaticKeepAlives: true,
              padding: const EdgeInsets.only(bottom: Ratioz.stratosphere, top: Stratosphere.bigAppBarStratosphere),
              itemBuilder: (ctx, index){

                TinyBz _tinyBz = _bzz[index];
                String _bzName = _tinyBz.bzName == null || _tinyBz.bzName == '' ? '.....' : _tinyBz.bzName;

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

                      BzModel _bz = await BzOps.readBzOps(
                        context: context,
                        bzID: _tinyBz.bzID,
                      );

                      double _dialogHeight = _screenHeight * 0.8;

                      await BottomDialog.slideBottomDialog(
                        context: context,
                        title: _bzName,
                        draggable: true,
                        height: _dialogHeight,
                        child: Container(
                          width: _clearDialogWidth,
                          height: BottomDialog.dialogClearHeight(draggable: true, title: 'x', context: context, overridingDialogHeight: _dialogHeight),
                          // color: Colorz.BloodTest,
                          child: GoHomeOnMaxBounce(
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: <Widget>[

                                Container(
                                  width: _clearDialogWidth,
                                  height: Scale.superHeaderStripHeight(false, _clearDialogWidth),
                                  child: Column(

                                    children: <Widget>[

                                      MiniHeaderStrip(
                                        superFlyer: SuperFlyer.getSuperFlyerFromBzModelOnly(
                                            onHeaderTap: (){},
                                            bzModel: _bz,
                                        ),
                                        flyerZoneWidth: _clearDialogWidth,
                                      ),

                                    ],

                                  ),
                                ),



                                BottomDialogRow(dataKey: 'bzName', value: _bz.bzName, ),
                                BottomDialogRow(dataKey: 'bzLogo', value: _bz.bzLogo, ),
                                BottomDialogRow(dataKey: 'bzID', value: _bz.bzID, ),
                                BottomDialogRow(dataKey: 'bzType', value: _bz.bzType, ),
                                BottomDialogRow(dataKey: 'bzForm', value: _bz.bzForm, ),
                                BottomDialogRow(dataKey: 'bldrBirth', value: _bz.bldrBirth, ),
                                BottomDialogRow(dataKey: 'accountType', value: _bz.accountType, ),
                                BottomDialogRow(dataKey: 'bzURL', value: _bz.bzURL, ),
                                BottomDialogRow(dataKey: 'bzScope', value: _bz.bzScope, ),
                                BottomDialogRow(dataKey: 'bzZone', value: _bz.bzZone, ),
                                BottomDialogRow(dataKey: 'bzAbout', value: _bz.bzAbout, ),
                                BottomDialogRow(dataKey: 'bzPosition', value: _bz.bzPosition, ),
                                BottomDialogRow(dataKey: 'bzContacts', value: _bz.bzContacts, ),
                                BottomDialogRow(dataKey: 'bzAuthors', value: _bz.bzAuthors, ),
                                BottomDialogRow(dataKey: 'bzShowsTeam', value: _bz.bzShowsTeam, ),
                                BottomDialogRow(dataKey: 'bzIsVerified', value: _bz.bzIsVerified, ),
                                BottomDialogRow(dataKey: 'bzAccountIsDeactivated', value: _bz.bzAccountIsDeactivated, ),
                                BottomDialogRow(dataKey: 'bzAccountIsBanned', value: _bz.bzAccountIsBanned, ),
                                BottomDialogRow(dataKey: 'bzTotalFollowers', value: _bz.bzTotalFollowers, ),
                                BottomDialogRow(dataKey: 'bzTotalSaves', value: _bz.bzTotalSaves, ),
                                BottomDialogRow(dataKey: 'bzTotalShares', value: _bz.bzTotalShares, ),
                                BottomDialogRow(dataKey: 'bzTotalSlides', value: _bz.bzTotalSlides, ),
                                BottomDialogRow(dataKey: 'bzTotalViews', value: _bz.bzTotalViews, ),
                                BottomDialogRow(dataKey: 'bzTotalCalls', value: _bz.bzTotalCalls, ),
                                BottomDialogRow(dataKey: 'nanoFlyers,', value: _bz.nanoFlyers, ),
                                BottomDialogRow(dataKey: 'bzTotalFlyers', value: _bz.bzTotalFlyers, ),
                                BottomDialogRow(dataKey: 'authorsIDs', value: _bz.authorsIDs, ),


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
