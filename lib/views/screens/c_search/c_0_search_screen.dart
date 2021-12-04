import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/db/fire/ops/search_ops.dart';
import 'package:bldrs/db/ldb/ldb_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/bzz_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/providers/keywords_provider.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/widgets/general/dialogs/nav_dialog/nav_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/specific/flyer/stacks/flyers_shelf.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {

  const SearchScreen({
    Key key
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // List<KW> _selectedKeywords = <KW>[];
  // KW _highlightedKeyword;
  // bool _browserIsOn = false;
  // String _currentGroupID;
  // ItemScrollController _scrollController;
  // ItemPositionsListener _itemPositionListener;
  // FlyersProvider _flyersProvider;
  // FlyerType _currentFlyerType;
  // List<GlobalKey<BldrsExpansionTileState>> _expansionKeys = [];

  TextEditingController _searchController = TextEditingController();
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if(mounted){

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

    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  KeywordsProvider _keywordsProvider;
  FlyersProvider _flyersProvider;
  ZoneProvider _zoneProvider;
  BzzProvider _bzzProvider;

  @override
  void initState() {
    super.initState();
    _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);
    _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

    // BldrsSection _bldrsSection = _flyersProvider.getCurrentSection;
    // _currentFlyerType = FilterModel.getDefaultFlyerTypeBySection(bldrsSection: _bldrsSection);

    // List<FilterModel> _filtersBySection = FilterModel.getFiltersBySectionAndFlyerType(
    //     bldrsSection: _bldrsSection,
    //     flyerType: _currentFlyerType
    // );

    // _filters.addAll(_filtersBySection);
    // _filtersIDs = KeywordModel.getFiltersIDs();

    // _scrollController = ItemScrollController();
    // _itemPositionListener = ItemPositionsListener.create();

    // generateExpansionKeys();

  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      // _triggerLoading().then((_) async{
      //
      //
      //   _triggerLoading(
      //       function: (){
      //         /// set new values here
      //       }
      //   );
      // });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
    TextChecker.disposeControllerIfNotEmpty(_searchController);
  }
// -----------------------------------------------------------------------------
  List<SearchResult> _allResults = <SearchResult>[];
  /// TAMAM
  Future<void> _onSearchSubmit() async {

    _triggerLoading();

    final List<SearchResult> _keywordsResults = await _searchKeywords();
    final List<SearchResult> _bzzResults = await _searchBzz();
    final List<SearchResult> _authorsResults = await _searchAuthors();
    final List<SearchResult> _flyersResults = await _searchFlyersByTitle();

    final List<SearchResult> _all = <SearchResult>[..._keywordsResults, ..._bzzResults, ..._authorsResults, ..._flyersResults];

    if (_all.length > 0){

      setState(() {
        _allResults = _all;
      });

    }

    else {

      setState(() {
        _allResults = <SearchResult>[];
      });

      await NavDialog.showNavDialog(
        context: context,
        color: Colorz.black255,
        firstLine: 'No result found',
        secondLine: 'Try again with different words',
      );

    }

    _triggerLoading();
  }
// -------------------------------------------------------
  /// TAMAM
  Future<List<SearchResult>> _searchKeywords() async {

    final List<SearchResult> _results = <SearchResult>[];

    final List<Map<String, dynamic>> _maps = await LDBOps.searchTrigram(
        searchValue: _searchController.text,
        docName: LDBDoc.keywords,
        lingoCode: Wordz.languageCode(context),
    );

    if (Mapper.canLoopList(_maps)){

      final List<KW> _keywords = KW.decipherKeywordsLDBMaps(maps: _maps);

      for (KW kw in _keywords){

        final List<FlyerModel> _flyersByKeyword = await _flyersProvider.fetchFlyersByCurrentZoneAndKeyword(
          context: context,
          kw: kw,
          limit: 3,
        );

        if (_flyersByKeyword.length > 0){
          _results.add(
              SearchResult(
                title: Name.getNameByCurrentLingoFromNames(context, kw.names),
                icon: _keywordsProvider.getIcon(context: context, son: kw),
                flyers: _flyersByKeyword,
              )
          );
        }

      }

    }

    return _results;
  }
// -------------------------------------------------------
  /// TAMAM
  Future<List<SearchResult>> _searchBzz() async {

    final List<SearchResult> _results = <SearchResult>[];

    print('_onSearchBzz : _searchController.text : ${_searchController.text}');

    final List<BzModel> _bzz = await FireSearchOps.bzzByBzName(
      context: context,
      bzName: _searchController.text,
    );

    if (Mapper.canLoopList(_bzz)){

      for (BzModel bz in _bzz){

        final List<FlyerModel> _bzFlyers = await _flyersProvider.fetchFirstFlyersByBzModel(
          context: context,
          bz: bz,
          limit: 3
        );

        if (Mapper.canLoopList(_bzFlyers)){
          _results.add(
              SearchResult(
                title: 'Flyers by ${bz.name}',
                icon: bz.logo,
                flyers: _bzFlyers,
              )
          );
        }

      }

    }

    return _results;
  }
// -------------------------------------------------------
  Future<List<SearchResult>> _searchAuthors() async {
    final List<SearchResult> _results = <SearchResult>[];

    List<UserModel> _users = await FireSearchOps.usersByNameAndIsAuthor(
        context: context,
        name: _searchController.text,
    );

    if (Mapper.canLoopList(_users)){

      for (UserModel user in _users){

        /// task should get only bzz showing teams
        final List<BzModel> _bzz = await _bzzProvider.fetchUserBzz(context: context, userModel: user);

        if (Mapper.canLoopList(_bzz)){

          for (BzModel bz in _bzz){

            /// task should get only flyers showing authors
            final List<FlyerModel> _bzFlyers = await _flyersProvider.fetchFirstFlyersByBzModel(
                context: context,
                bz: bz,
                limit: 3
            );

            if (Mapper.canLoopList(_bzFlyers)){
              _results.add(
                  SearchResult(
                    title: 'Flyers from ${bz.name} published by ${user.name}',
                    icon: user.pic,
                    flyers: _bzFlyers,
                  )
              );
            }

          }

        }

      }


      // _results.add(
      //     SearchResult(
      //       title: 'Flyers by ${bz.name}',
      //       icon: bz.logo,
      //       flyers: _bzFlyers,
      //     )
      // );
    }

    return _results;
  }
// -------------------------------------------------------
  /// TAMAM
  Future<List<SearchResult>> _searchFlyersByTitle() async {
    final List<SearchResult> _results = <SearchResult>[];

    List<FlyerModel> _flyers = await FireSearchOps.flyersByZoneAndTitle(
      context: context,
      zone: _zoneProvider.currentZone,
      title: _searchController.text,
      limit: 3,
    );

    if (_flyers.length > 0){
      _results.add(
          SearchResult(
            title: 'Matching titles',
            icon: null,
            flyers: _flyers,
          )
      );
    }


    return _results;
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
//     final double _buttonPadding = _browserIsOn == true ? Ratioz.appBarPadding * 1.5 : Ratioz.appBarPadding * 1.5;
// -----------------------------------------------------------------------------
    /// BROWSER STUFF
    // final double _browserMinZoneHeight = 40 + _buttonPadding * 2 + SuperVerse.superVerseRealHeight(context, 0, 0.95, null);
    // final double _browserMaxZoneHeight = Scale.superScreenHeightWithoutSafeArea(context) - Ratioz.appBarBigHeight - Ratioz.keywordsBarHeight - Ratioz.appBarMargin * 4;
    // final double _browserMinZoneWidth = 40 + _buttonPadding * 2;
    // final double _browserMaxZoneWidth = Scale.superScreenWidth(context) - _buttonPadding * 2;
    // final double _browserZoneHeight = _browserIsOn == true ? _browserMaxZoneHeight : _browserMinZoneHeight;
    // final double _browserZoneWidth = _browserIsOn == true ? _browserMaxZoneWidth : _browserMinZoneWidth;
    // final double _browserZoneMargins = _browserIsOn == true ? _buttonPadding : _buttonPadding;
    // final BorderRadius _browserZoneCorners = Borderers.superBorderAll(context, Ratioz.appBarCorner);
    // double _browserScrollZoneWidth = _browserZoneWidth * 0.96;
    // double _browserScrollZoneHeight = _browserZoneHeight * 0.94;
    // double _filtersZoneWidth = (_browserScrollZoneWidth - _buttonPadding) / 2 ;
    // List<Keyword> _currentFilterKeywords = _generateFilterKeywords(_groupsBySection);


    return MainLayout(
      appBarType: AppBarType.Search,
      // appBarBackButton: true,
      pyramids: Iconz.DvBlankSVG,
      searchController: _searchController,
      onSearchSubmit: (String value) => _onSearchSubmit(),
      onSearchChanged: (String val){

        print('search value changed to ${val}');

        if (val.length == 0){
          setState(() {
            _allResults = <SearchResult>[];
          });
        }

      },
      layoutWidget: Stack(
        children: <Widget>[

          /// SEARCH RESULT
          MaxBounceNavigator(
            boxDistance: _screenHeight,
            child: Container(
              width: _screenWidth,
              height: _screenHeight,
              // color: Colorz.BlackPlastic,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: _allResults.length,
                padding: const EdgeInsets.only(top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2),

                itemBuilder: (BuildContext ctx, int index){

                  final SearchResult _result = _allResults[index];

                  return

                    FlyersShelf(
                      title: _result.title,
                      flyerSizeFactor: 0.3,
                      titleIcon: _result.icon,
                      flyerOnTap: (){print('flyer tapped');},
                      onScrollEnd: (){print('scroll ended');},
                      flyers: _result.flyers,
                    );

                  // DreamBox(
                  //   height: _buttonHeight,
                  //   width: _buttonWidth,
                  //   color: Colorz.white20,
                  //   verse: _bz.name,
                  //   secondLine: TextGenerator.bzTypeSingleStringer(context, _bz.bzType),
                  //   icon: _bz.logo,
                  //   margins: const EdgeInsets.only(top: _bzButtonMargin),
                  //   verseScaleFactor: 0.7,
                  //   verseCentered: false,
                  //   onTap: () async {
                  //
                  //     final double _dialogHeight = _screenHeight * 0.8;
                  //
                  //     final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
                  //     final CountryModel _bzCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: _bz.zone.countryID);
                  //     final CityModel _bzCity = await _zoneProvider.fetchCityByID(context: context, cityID: _bz.zone.cityID);
                  //
                  //     await BottomDialog.showBottomDialog(
                  //       context: context,
                  //       title: _bz.name,
                  //       draggable: true,
                  //       height: _dialogHeight,
                  //       child: Container(
                  //         width: _clearDialogWidth,
                  //         height: BottomDialog.dialogClearHeight(draggable: true, titleIsOn: true, context: context, overridingDialogHeight: _dialogHeight),
                  //         // color: Colorz.BloodTest,
                  //         child: MaxBounceNavigator(
                  //           child: ListView(
                  //             physics: const BouncingScrollPhysics(),
                  //             children: <Widget>[
                  //
                  //               Container(
                  //                 width: _clearDialogWidth,
                  //                 height: FlyerBox.headerStripHeight(false, _clearDialogWidth),
                  //                 child: Column(
                  //
                  //                   children: <Widget>[
                  //
                  //                     MiniHeaderStrip(
                  //                       superFlyer: SuperFlyer.getSuperFlyerFromBzModelOnly(
                  //                         onHeaderTap: (){},
                  //                         bzModel: _bz,
                  //                         bzCountry: _bzCountry,
                  //                         bzCity: _bzCity,
                  //                       ),
                  //                       flyerBoxWidth: _clearDialogWidth,
                  //                     ),
                  //
                  //                   ],
                  //
                  //                 ),
                  //               ),
                  //
                  //
                  //
                  //               // DataStrip(dataKey: 'bzName', dataValue: _bz.name, ),
                  //               // DataStrip(dataKey: 'bzLogo', dataValue: _bz.logo, ),
                  //               // DataStrip(dataKey: 'bzID', dataValue: _bz.bzID, ),
                  //               // DataStrip(dataKey: 'bzType', dataValue: _bz.bzType, ),
                  //               // DataStrip(dataKey: 'bzForm', dataValue: _bz.bzForm, ),
                  //               // DataStrip(dataKey: 'createdAt', dataValue: _bz.createdAt, ),
                  //               // DataStrip(dataKey: 'accountType', dataValue: _bz.accountType, ),
                  //               // DataStrip(dataKey: 'bzScope', dataValue: _bz.scope, ),
                  //               // DataStrip(dataKey: 'bzZone', dataValue: _bz.zone, ),
                  //               // DataStrip(dataKey: 'bzAbout', dataValue: _bz.about, ),
                  //               // DataStrip(dataKey: 'bzPosition', dataValue: _bz.position, ),
                  //               // DataStrip(dataKey: 'bzContacts', dataValue: _bz.contacts, ),
                  //               // DataStrip(dataKey: 'bzAuthors', dataValue: _bz.authors, ),
                  //               // DataStrip(dataKey: 'bzShowsTeam', dataValue: _bz.showsTeam, ),
                  //               // DataStrip(dataKey: 'bzIsVerified', dataValue: _bz.isVerified, ),
                  //               // DataStrip(dataKey: 'bzState', dataValue: _bz.bzState, ),
                  //               // DataStrip(dataKey: 'bzTotalFollowers', dataValue: _bz.totalFollowers, ),
                  //               // DataStrip(dataKey: 'bzTotalSaves', dataValue: _bz.totalSaves, ),
                  //               // DataStrip(dataKey: 'bzTotalShares', dataValue: _bz.totalShares, ),
                  //               // DataStrip(dataKey: 'bzTotalSlides', dataValue: _bz.totalSlides, ),
                  //               // DataStrip(dataKey: 'bzTotalViews', dataValue: _bz.totalViews, ),
                  //               // DataStrip(dataKey: 'bzTotalCalls', dataValue: _bz.totalCalls, ),
                  //               // DataStrip(dataKey: 'flyersIDs,', dataValue: _bz.flyersIDs, ),
                  //               // DataStrip(dataKey: 'bzTotalFlyers', dataValue: _bz.totalFlyers, ),
                  //
                  //
                  //               // Container(
                  //               //     width: _clearDialogWidth,
                  //               //     height: 100,
                  //               //     child: Row(
                  //               //       mainAxisAlignment: MainAxisAlignment.center,
                  //               //       crossAxisAlignment: CrossAxisAlignment.center,
                  //               //       children: <Widget>[
                  //               //
                  //               //         DreamBox(
                  //               //           height: 80,
                  //               //           width: 80,
                  //               //           verse: 'Delete User',
                  //               //           verseMaxLines: 2,
                  //               //           onTap: () => _deleteUser(_userModel),
                  //               //         ),
                  //               //
                  //               //       ],
                  //               //     )
                  //               // )
                  //
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //
                  //   },
                  // );

                },
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class SearchResult {
  final String title;
  // final SearchSource source;
  final String icon;
  final List<FlyerModel> flyers;

  const SearchResult({
    @required this.title,
    // @required this.source,
    @required this.icon,
    @required this.flyers,
});


}

enum SearchSource{
  bzz,
  authors,
  flyerTitles,
  keywords,
}