import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/keys_set.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/screens/c2_search_filters_screen.dart';
import 'package:bldrs/views/widgets/browser/browser_pages.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/flyer_browser/keyword_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:bldrs/views/widgets/nav_bar/bar_button.dart';
import 'package:bldrs/views/widgets/nav_bar/nav_bar.dart';
import 'package:bldrs/xxx_LABORATORY/flyer_browser/bldrs_expansion_tile.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // List<FilterModel> _filters = new List();
  // List<KeywordModel> _keywords = new List();
  List<Keyword> _selectedKeywords = new List();
  Keyword _highlightedKeyword;
  bool _browserIsOn = false;
  String _currentFilterID;
  ItemScrollController _scrollController;
  ItemPositionsListener _itemPositionListener;
  CountryProvider _countryPro;
  // FlyersProvider _flyersProvider;
  // FlyerType _currentFlyerType;
  List<GlobalKey<BldrsExpansionTileState>> _expansionKeys = new List();
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    // _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    _countryPro =  Provider.of<CountryProvider>(context, listen: false);

    // BldrsSection _bldrsSection = _flyersProvider.getCurrentSection;
    // _currentFlyerType = FilterModel.getDefaultFlyerTypeBySection(bldrsSection: _bldrsSection);

    // List<FilterModel> _filtersBySection = FilterModel.getFiltersBySectionAndFlyerType(
    //     bldrsSection: _bldrsSection,
    //     flyerType: _currentFlyerType
    // );

    // _filters.addAll(_filtersBySection);
    // _filtersIDs = KeywordModel.getFiltersIDs();

    _scrollController = ItemScrollController();
    _itemPositionListener = ItemPositionsListener.create();

    // generateExpansionKeys();

    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void didChangeDependencies() {
    _addZoneFilters();
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
// -----------------------------------------------------------------------------
//   void generateExpansionKeys(){
//     _filters.forEach((filter) {
//       _expansionKeys.add(new GlobalKey());
//     });
//   }
// -----------------------------------------------------------------------------
  void _addZoneFilters(){

    // String _countryID = _countryPro.currentCountryID;
    // String _countryName = _countryPro.getCountryNameInCurrentLanguageByIso3(context, _countryID);
    // List<Map<String, dynamic>> _citiesMaps = _countryPro.getCitiesNameMapsByIso3(context, _countryID);
    // // String _countryFlag = Flagz.getFlagByIso3(_countryID);
    // List<String> _citiesNames = Mapper.getSecondValuesFromMaps(_citiesMaps);
    //
    // List<KeywordModel> _citiesKeywords = cities.
    //
    //
    // _filters.insert(0 ,
    //
    //   FilterModel(filterID: 'city', canPickMany: false, keywordModels: _citiesNames),
    //
    // );
  }
// -----------------------------------------------------------------------------
  void _triggerBrowser(){
    print('triggering browser');
    setState(() {
      _browserIsOn = !_browserIsOn;
    });
  }
// -----------------------------------------------------------------------------
  List<Widget> _selectedKeywordsWidgets(List<KeysSet> filtersModels){

    return

      <Widget>[

        ClipRRect(
          borderRadius: Borderers.superBorderAll(context, Ratioz.appBarButtonCorner),
          child: Container(
            width: Scale.superScreenWidth(context) - Ratioz.appBarMargin * 2 - Ratioz.appBarPadding * 2,
            height: 40,
            decoration: BoxDecoration(
              color: Colorz.White10,
              // borderRadius: Borderers.superBorderAll(context, Ratioz.appBarButtonCorner),
            ),
            alignment: Alignment.center,
            child:
            _selectedKeywords.length == 0 ? Container() :
            ScrollablePositionedList.builder(
              itemScrollController: _scrollController,
              scrollDirection: Axis.horizontal,
              itemPositionsListener: _itemPositionListener,
              itemCount: _selectedKeywords.length,
              itemBuilder: (ctx, index){

                Keyword _keyword = index >= 0 ? _selectedKeywords[index] : null;

                bool _highlightedMapIsCity =
                _highlightedKeyword == null ? false
                    :
                _highlightedKeyword.flyerType == 'cities' ? true
                    : false;

                bool _isHighlighted =
                _highlightedMapIsCity == true && _keyword.flyerType == 'cities'? true
                    :
                _highlightedMapIsCity == true && _keyword.flyerType == 'area'? true
                    :
                Keyword.KeywordsAreTheSame(_highlightedKeyword, _keyword) == true ? true
                    :
                false;

                print('_keywords.length : ${_selectedKeywords.length}');
                print('index : $index');

                return

                  _keyword == null ?
                  Container(
                    // width: 10,
                    height: 10,
                    color: Colorz.Yellow20,
                    child: SuperVerse(
                      verse : 'keyword is null',
                    ),
                  ) :
                  KeywordBarButton(
                    keywordID: _keyword.keywordID,
                    keywordName: Keyword.translateKeyword(context, _keyword.keywordID),
                    title: '${_keyword.flyerType}, ${_keyword.groupID}, ${_keyword.subGroupID}',
                    xIsOn: true,
                    onTap: () => _removeKeyword(index, filtersModels),
                    color: _isHighlighted == true ? Colorz.Red255 : Colorz.Blue80,
                  );

              },
            ),
          ),
        ),

      ];

    // <Widget>[

    // ...List.generate(_keywords.length, (index){
    //
    //   bool _isHighlighted = Mapper.mapsAreTheSame(_highlightedKeywordMap, _keywords[index]) == true ? true : false;
    //
    //   return
    //     Row(
    //       children: <Widget>[
    //
    //         KeywordButton(
    //           keyword: _keywords[index]['keyword'],
    //           title: _keywords[index]['filterTitle'],
    //           xIsOn: true,
    //           onTap: () => _removeKeyword(index),
    //           color: _isHighlighted == true ? Colorz.BloodRed : Colorz.BabyBlueSmoke,
    //         ),
    //
    //         SizedBox(
    //           width: 5,
    //         ),
    //
    //       ],
    //     );
    // },
    //
    // ),

    // SingleChildScrollView(
    //   scrollDirection: Axis.horizontal,
    //   child:
    //       Row(
    //         children: <Widget>[
    //
    //           ...List.generate(_keywords.length, (index){
    //
    //               bool _isHighlighted = Mapper.mapsAreTheSame(_highlightedKeywordMap, _keywords[index]) == true ? true : false;
    //
    //             return
    //
    //               KeywordButton(
    //                 keyword: _keywords[index]['keyword'],
    //                 title: _keywords[index]['filterTitle'],
    //                 xIsOn: true,
    //                 onTap: () => _removeKeyword(index),
    //                 color: _isHighlighted == true ? Colorz.BloodRed : Colorz.BabyBlueSmoke,
    //               );
    //
    //
    //           }),
    //
    //
    //         ],
    //       ),
    // ),

    // Container(
    //   height: 40,
    //   width: 50,
    // ),

    // ];
  }
// -----------------------------------------------------------------------------
  List<Keyword> _generateFilterKeywords(List<KeysSet> filtersModels){

    KeysSet _currentFilterModel = filtersModels.singleWhere((filterModel) => filterModel.titleID == _currentFilterID, orElse: () => null);

    List<Keyword> _currentFilterKeywords = _currentFilterModel == null ? [] : _currentFilterModel.keywords;

    return _currentFilterKeywords;
  }
// -----------------------------------------------------------------------------
  void _selectFilter(KeysSet _filterModel){

    setState(() {
      _currentFilterID = _filterModel.titleID;
    });

  }
// -----------------------------------------------------------------------------
  Future<void> _removeKeyword(int index, List<KeysSet> filtersModels) async {

    String _groupID = _selectedKeywords[index].groupID;
    // String _keywordID = _selectedKeywords[index].keywordID;

    bool _isCity = false;
    bool _isArea = false;

    Keyword _keywordModel = _selectedKeywords[index];


    if (_isCity == true){


      await _highlightKeyword(_keywordModel, false);

      setState(() {
        _selectedKeywords.removeAt(index+1); // area index
        _selectedKeywords.removeAt(index); // city index still the same
      });
    }

    else if(_isArea == true){

      await _highlightKeyword(_keywordModel, false);

      setState(() {
        _selectedKeywords.removeAt(index-1); // city index
        _selectedKeywords.removeAt(index-1); // area index after change
      });
    }

    else {

      bool _canPickMany = filtersModels.singleWhere((filter) => filter.titleID == _groupID).canPickMany;

      await _highlightKeyword(_keywordModel, _canPickMany);


      setState(() {
        _selectedKeywords.removeAt(index);
      });
    }

  }
// -----------------------------------------------------------------------------
  void _addKeyword(Keyword keyword){
    setState(() {
      _selectedKeywords.add(keyword);
    });
  }
// -----------------------------------------------------------------------------
  Future<void> _selectKeyword(Keyword keyword) async {

    // bool _canPickMany = filtersModels.singleWhere((filterModel) => filterModel.filterID == _currentFilterID).canPickMany;

   bool _canPickMany = KeysSet.getCanKeysSetPickManyByKeyword(keyword);

    bool _isSelected = _selectedKeywords.contains(keyword);

    /// when filter accepts many keywords [Poly]
    if (_canPickMany == true){

      /// when POLY keyword is already selected
      if(_isSelected == true){
        _highlightKeyword(keyword, _canPickMany);
      }

      /// when POLY keyword is not selected
      else {
        _addKeyword(keyword);
        _scrollToEndOfAppBar();
      }

    }

    /// when filter accepts one keyword [SINGULAR]
    else {

      /// check if SINGULAR keyword is selected by filterTitle
      bool _keywordsContainThisFilterID = Keyword.keywordsContainThisFlyerType(keywords : _selectedKeywords, flyerType: keyword.flyerType);

      /// when SINGULAR keyword already selected
      if (_keywordsContainThisFilterID == true){
        _highlightKeyword(keyword, _canPickMany);
      }

      /// when SINGULAR keyword not selected
      else{

        /// when selecting city - area
        if(_currentFilterID == 'city'){
          // then keyword is city

          _showZoneDialog(cityName: keyword.keywordID);

        }

        /// when selecting anything else than zone
        else {
          _addKeyword(keyword);
          _scrollToEndOfAppBar();
        }

      }

    }

  }
// -----------------------------------------------------------------------------
  Future<void> _showZoneDialog({String cityName}) async {

    String _cityID = _countryPro.getCityIDByCityName(context, cityName);
    List<Map<String, dynamic>> _areasMaps = _countryPro.getDistrictsNameMapsByCityID(context, _cityID);

    // await superDialog(
    //   context: context,
    //   title: '$cityName',
    //   body: 'add an Area in $cityName to search words',
    //   height: Scale.superScreenHeight(context) * 0.7,
    //   child: Container(
    //     height: Scale.superScreenHeight(context) * 0.5,
    //     width: Scale.superDialogWidth(context) * 0.9,
    //     decoration: BoxDecoration(
    //       color: Colorz.WhiteAir,
    //       borderRadius: Borderers.superBorderAll(context, Ratioz.appBarButtonCorner),
    //     ),
    //     child: DreamList(
    //       itemHeight: 45,
    //       itemZoneHeight: 50,
    //       itemCount: _areasMaps.length,
    //       itemBuilder: (ctx, index){
    //
    //         String _areaName = _areasMaps[index]['value'];
    //
    //         Map<String, String> _areaMap = {'keyword' : _areaName, 'filterTitle' : 'Area'};
    //         Map<String, String> )cityMap = {'keyword' : cityName, 'filterTitle' : 'City'};
    //
    //         bool _isSelected = Mapper.listOfMapsContainMap(listOfMaps: _keywords, map: _areaMap);
    //
    //         return
    //
    //           DreamBox(
    //             height: 45,
    //             // width: 100,
    //             verse: _areaName,
    //             verseScaleFactor: 0.6,
    //             boxMargins: 2.5,
    //             color: _isSelected ? Colorz.BabyBluePlastic : Colorz.WhiteGlass,
    //             verseColor: _isSelected ? Colorz.White : Colorz.WhiteLingerie,
    //             bubble: false,
    //             boxFunction: (){
    //
    //               _addKeyword(_cityMap);
    //               _addKeyword(_areaMap);
    //
    //               _scrollToEndOfAppBar();
    //
    //               Nav.goBack(context);
    //
    //             },
    //           );
    //
    //
    //       },
    //     ),
    //   ),
    // );

  }
// -----------------------------------------------------------------------------
  void _scrollToEndOfAppBar(){
    // _scrollController.animateTo(_scrollController.position.maxScrollExtent + 100, duration: Ratioz.fadingDuration, curve: Curves.easeInOut);

    if (_selectedKeywords.length <= 2){
      print('no scroll available');
    } else {
      _scrollController.scrollTo(index: _selectedKeywords.length - 1, duration: Ratioz.duration150ms);
    }
  }
// -----------------------------------------------------------------------------
  void _scrollToIndex(int index){

    if (_selectedKeywords.length <= 1){
      print('no scroll available');
    } else {
      _scrollController.scrollTo(index: index, duration: Ratioz.duration150ms);
    }
  }
// -----------------------------------------------------------------------------
  Future<void> _highlightKeyword(Keyword keywordModel, bool canPickMany) async {

    int _index;

    /// if filter allows many keywords, we get index by exact map
    if (canPickMany == true){
      _index = _selectedKeywords.indexWhere((keyword) => Keyword.KeywordsAreTheSame(keyword, keywordModel),);
    }

    /// if filter does not allow many keywords. we get index by the filterTitle only
    else {
      _index = _selectedKeywords.indexWhere((keyword) => keyword.flyerType == keywordModel.flyerType);
    }

    _scrollToIndex(_index);

    Keyword _keyword = _index >= 0 ? _selectedKeywords[_index] : null;

    setState(() {
      _highlightedKeyword = _keyword;
    });

    await Future.delayed(const Duration(milliseconds: 500), (){
      setState(() {
        _highlightedKeyword = null;
      });
    });

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: true);
    List<KeysSet> _filtersBySection = _flyersProvider.getSectionFilters;

    print('rebuilding search screen with section : ${_filtersBySection.length} filters');

    double _buttonPadding = _browserIsOn == true ? Ratioz.appBarPadding * 1.5 : Ratioz.appBarPadding * 1.5;

    double _browserMinZoneHeight = 40 + _buttonPadding * 2 + superVerseRealHeight(context, 0, 0.95, null);
    double _browserMaxZoneHeight = Scale.superScreenHeightWithoutSafeArea(context) - Ratioz.appBarBigHeight - Ratioz.keywordsBarHeight - Ratioz.appBarMargin * 4;

    double _browserMinZoneWidth = 40 + _buttonPadding * 2;
    double _browserMaxZoneWidth = Scale.superScreenWidth(context) - _buttonPadding * 2;

    double _browserZoneHeight = _browserIsOn == true ? _browserMaxZoneHeight : _browserMinZoneHeight;
    double _browserZoneWidth = _browserIsOn == true ? _browserMaxZoneWidth : _browserMinZoneWidth;
    double _browserZoneMargins = _browserIsOn == true ? _buttonPadding : _buttonPadding;
    BorderRadius _browserZoneCorners = Borderers.superBorderAll(context, Ratioz.appBarCorner);

    double _browserScrollZoneWidth = _browserZoneWidth * 0.96;
    double _browserScrollZoneHeight = _browserZoneHeight * 0.94;

    double _filtersZoneWidth = (_browserScrollZoneWidth - _buttonPadding) / 2 ;

    List<Keyword> _currentFilterKeywords = _generateFilterKeywords(_filtersBySection);

    return MainLayout(
      appBarType: AppBarType.Search,
      // appBarBackButton: true,
      pyramids: Iconz.DvBlankSVG,
      loading: _loading,
      layoutWidget: Stack(
        children: <Widget>[

          /// SEARCH RESULT
          Container(
            width: Scale.superScreenWidth(context),
            height: Scale.superScreenHeight(context),
            // color: Colorz.BlackPlastic,
            child: ListView(),
          ),

          /// SEARCH FILTERS
          Container(
            width: Scale.superScreenWidth(context),
            // height: Ratioz.stratosphere * 2,
            // color: Colorz.YellowGlass,
            child: Column(
              children: <Widget>[

                /// TOP MARGIN
                SizedBox(height: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2),

                /// KEYWORDS BAR
                if (_selectedKeywords.isNotEmpty)
                Container(
                  width: Scale.superScreenWidth(context) - Ratioz.appBarMargin * 2,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colorz.BloodTest,
                    borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner),
                    boxShadow: Shadowz.appBarShadow,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ... _selectedKeywordsWidgets(_filtersBySection)
                    ],
                  ),
                ),

              ],
            ),
          ),

          /// BROWSER
          Positioned(
            bottom: 0,
            left: 0,
            child: GestureDetector(
              onTap: _browserIsOn ? null : _triggerBrowser,
              child: AnimatedContainer(
                height: _browserZoneHeight,
                width: _browserZoneWidth,
                duration: Ratioz.duration150ms,
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  borderRadius: _browserZoneCorners,
                  color: Colorz.Black200,
                ),
                margin: EdgeInsets.all(_browserZoneMargins),
                alignment: Aligners.superTopAlignment(context),
                child:
                _browserIsOn ?

                /// browser contents
                BrowserPages(
                  browserZoneHeight: _browserZoneHeight,
                  browserIsOn: _browserIsOn,
                  closeBrowser: _triggerBrowser,
                  filtersModels: _filtersBySection,
                  onKeywordTap: (keywordModel) => _selectKeyword(keywordModel),
                  selectedKeywords: _selectedKeywords,
                )


                // AnimatedContainer(
                //   duration: Ratioz.slidingTransitionDuration,
                //   width: _browserScrollZoneWidth,
                //   height: _browserScrollZoneHeight,
                //   color: Colorz.WhiteAir,
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     shrinkWrap: true,
                //     children: <Widget>[
                //
                //       /// FILTERS
                //       AnimatedContainer(
                //         duration: Ratioz.slidingTransitionDuration,
                //         width: _filtersZoneWidth,
                //         height: _browserScrollZoneHeight,
                //         color: Colorz.BabyBlueSmoke,
                //         child: DreamList(
                //           itemZoneHeight: 50,
                //           itemHeight: 45,
                //           itemCount: _filters.length,
                //           itemBuilder: (context, index) {
                //
                //             FilterModel _filterModel = _filters[index];
                //             String _filterID = _filterModel.filterID;
                //
                //             return
                //               DreamBox(
                //                 height: 45,
                //                 width: _filtersZoneWidth * 0.8,
                //                 verse: _currentFilterID,
                //                 verseScaleFactor: 0.6,
                //                 boxMargins: 2.5,
                //                 color: _currentFilterID == _filterID ? Colorz.Yellow : Colorz.Nothing,
                //                 verseColor: _currentFilterID == _filterID ? Colorz.BlackBlack : Colorz.White,
                //                 boxFunction: () => _selectFilter(_filterModel),
                //               );
                //
                //           },
                //
                //         ),
                //       ),
                //
                //       SizedBox(width: _buttonPadding,),
                //
                //       /// KEYWORDS
                //       AnimatedContainer(
                //         duration: Ratioz.slidingTransitionDuration,
                //         width: _filtersZoneWidth,
                //         height: _browserScrollZoneHeight,
                //         color: Colorz.BabyBlueSmoke,
                //         child:
                //         DreamList(
                //           itemZoneHeight: 50,
                //           itemHeight: 45,
                //           itemCount: _currentFilterKeywords.length,
                //           itemBuilder: (context, index){
                //
                //             KeywordModel _keywordModel = _currentFilterKeywords[index];
                //
                //             bool _isSelected = _keywords.contains(_keywordModel);
                //
                //             return
                //
                //               DreamBox(
                //                 height: 45,
                //                 width: _filtersZoneWidth * 0.8,
                //                 verse: _keywordModel.id,
                //                 verseScaleFactor: 0.6,
                //                 boxMargins: 2.5,
                //                 color: _isSelected ? Colorz.BabyBluePlastic : Colorz.WhiteGlass,
                //                 verseColor: _isSelected ? Colorz.White : Colorz.WhiteLingerie,
                //                 bubble: false,
                //                 boxFunction: () => _selectKeyword(_keywordModel, _isSelected),
                //               );
                //
                //
                //             // SuperVerse(
                //             //     // height: 45,
                //             //     // width: _filtersZoneWidth,
                //             //     verse: _currentFilterKeywords[index],
                //             //     size: 4,
                //             //     // verseScaleFactor: 0.8,
                //             //     margin: 2.5,//EdgeInsets.symmetric(vertical: 2.5),
                //             //     color: _isSelected ? Colorz.White : Colorz.WhiteLingerie,
                //             //     labelColor: _isSelected ? Colorz.BabyBluePlastic : Colorz.WhiteGlass,
                //             //     labelTap: (){
                //             //       print(_currentFilterKeywords[index]);
                //             //
                //             //       setState(() {
                //             //         _keywords.add(_currentFilterKeywords[index]);
                //             //       });
                //             //
                //             //       _scrollController.animateTo(_scrollController.position.maxScrollExtent + 100, duration: Ratioz.fadingDuration, curve: Curves.easeInOut);
                //             //
                //             //
                //             //     },
                //             //   );
                //           },
                //         ),
                //       ),
                //
                //     ],
                //   ),
                // )

                // Container(
                //   width: Scale.superScreenWidth(context) - Ratioz.appBarMargin * 4,
                //   height: _browserZoneHeight - Ratioz.appBarMargin * 2,
                //   color: Colorz.YellowGlass,
                //   child: ListView(
                //     children: <Widget>[
                //
                //       ...List.generate(
                //           _filters.length,
                //               (index){
                //
                //             FilterModel _filterModel = _filters[index];
                //
                //             return
                //               BldrsExpansionTile(
                //                 height: Scale.superScreenHeight(context) * 0.5,
                //                 key: _expansionKeys[index],
                //                 // icon: KeywordModel.getImagePath(_filterID),
                //                 iconSizeFactor: 0.5,
                //                 filterModel: _filterModel,
                //                 selectedKeywords: _selectedKeywords,
                //                 onKeywordTap: (KeywordModel selectedKeyword){
                //
                //                   if (_selectedKeywords.contains(selectedKeyword)){
                //                     setState(() {
                //                       print('a77a');
                //                       _selectedKeywords.remove(selectedKeyword);
                //                     });
                //                   }
                //
                //                   else {
                //                     setState(() {
                //                       _selectedKeywords.add(selectedKeyword);
                //                     });
                //                   }
                //
                //                 },
                //
                //                 onGroupTap: (String groupID){
                //
                //                 },
                //               );
                //
                //           }),
                //
                //     ],
                //   ),
                // )

                    :

                /// the icon
                BarButton(
                  width: _browserMinZoneWidth,
                  text: 'Browse',
                  iconSizeFactor: 0.7,
                  icon: Iconz.FlyerGrid,
                  onTap: _triggerBrowser,
                  barType: BarType.minWithText,
                  corners: Ratioz.appBarButtonCorner,
                ),

              ),
            ),
          ),

          if (!_browserIsOn)
          Positioned(
            bottom: 0,
            right: 0,
            child: DreamBox(
              height: _browserZoneHeight,
              width: _browserZoneWidth,
              margins: EdgeInsets.all(_browserZoneMargins),
              icon: Iconz.More,
              iconSizeFactor: 0.6,
              onTap: () => Nav.goToNewScreen(context, SearchFiltersScreen()),

            ),
          ),

        ],
      ),
    );
  }
}
