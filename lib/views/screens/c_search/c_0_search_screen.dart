import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/db/fire/search_ops.dart';
import 'package:bldrs/db/ldb/ldb_ops.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/kw/chain_crafts.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/views/screens/c_search/search_result_wall.dart';
import 'package:bldrs/views/widgets/general/dialogs/nav_dialog/nav_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {

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
  @override
  void initState() {
    super.initState();
    // _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    // _countryPro =  Provider.of<CountryProvider>(context, listen: false);

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
    // TODO: implement dispose
    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _onSearchSubmit() async {

    _triggerLoading();

    await _searchKeywords();
    await _searchBzz();
    await _searchAuthors();
    await _searchFlyers();

    _triggerLoading();
  }
// -----------------------------------------------------------------------------
  List<KW> _foundKeywords = <KW>[];
  Future<void> _searchKeywords() async {

    List<Map<String, dynamic>> _maps = await LDBOps.searchTrigram(
        searchValue: _searchController.text,
        docName: LDBDoc.keywords,
        lingoCode: Wordz.languageCode(context),
    );

    if (Mapper.canLoopList(_maps)){

      List<KW> _keywords = KW.decipherKeywordsLDBMaps(maps: _maps);

      _keywords.forEach((kw) {
        _logs.add('KW : ${kw.id}');
      });


    }

  }
// -----------------------------------------------------------------------------
  List<BzModel> _foundBzz = <BzModel>[];
  Future<void> _searchBzz() async {

    print('_onSearchBzz : _searchController.text : ${_searchController.text}');

    List<BzModel> _result = await FireSearch.bzzByBzName(
      context: context,
      bzName: _searchController.text,
    );

    if (Mapper.canLoopList(_result)){

      _result.forEach((bz) {
        _logs.add('BZ : ${bz.name}');
      });

      setState(() {
        _foundBzz = _result;
      });

    }

    else {

      setState(() {
        _foundBzz = [];
      });

      await NavDialog.showNavDialog(
        context: context,
        color: Colorz.black255,
        firstLine: 'No result found',
        secondLine: 'Try again with different words',
      );

    }
  }
// -----------------------------------------------------------------------------
  List<AuthorModel> _foundAuthors = <AuthorModel>[];
  Future<void> _searchAuthors() async {

  }
// -----------------------------------------------------------------------------
  List<FlyerModel> _foundFlyers = <FlyerModel>[];
  Future<void> _searchFlyers() async {

  }
// -----------------------------------------------------------------------------
  List<String> _logs = <String>[];
  void _addLog(String log){
    setState(() {
      _logs.add(log);
    });
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
//     final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: true);
    // final List<GroupModel> _groupsBySection = _generalProvider.sectionGroups;
// -----------------------------------------------------------------------------
    final double _screenHeight = Scale.superScreenHeight(context);
    final double _screenWidth = Scale.superScreenWidth(context);
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
      onSearchChanged: (String val) => print('search value changed to ${val}'),
      layoutWidget: Stack(
        children: <Widget>[

          /// SEARCH RESULT
          MaxBounceNavigator(
            boxDistance: _screenHeight,
            child: Container(
              width: _screenWidth,
              height: _screenHeight,
              // color: Colorz.BlackPlastic,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: <Widget>[

                  const Stratosphere(heightFactor: 1.65,),

                  Column(
                    children: [

                      ...List.generate(_logs.length,
                              (index){

                        return

                          SuperVerse(
                            verse: _logs[index],
                            size: 1,
                            weight: VerseWeight.thin,
                            labelColor: Colorz.bloodTest,
                          );

                      }),

                    ],
                  ),

                  Container(
                    width: _screenWidth,
                    height: 700,
                    // color: Colorz.yellow50,
                    child: SearchResultWall(
                      // keywords: _foundKeywords,
                      // bzz: _foundBzz,
                      // authors: _foundAuthors,
                      // flyers: _foundFlyers,
                      keywords: KW.getKeywordsFromChain(ChainCrafts.chain),
                      bzz: [BzModel.dummyBz('x'), BzModel.dummyBz('y'), BzModel.dummyBz('z')],
                      authors: [AuthorModel.dummyAuthor(), AuthorModel.dummyAuthor()],
                      flyers: FlyerModel.dummyFlyers(),
                    ),
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
