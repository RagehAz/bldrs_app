import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/keywords/filter_model.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/browser/browser_pages.dart';
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
  List<KeywordModel> _keywords = new List();
  List<KeywordModel> _selectedKeywords = new List();
  KeywordModel _highlightedKeyword;
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
    // List<Map<String, dynamic>> _provincesMaps = _countryPro.getProvincesNameMapsByIso3(context, _countryID);
    // // String _countryFlag = Flagz.getFlagByIso3(_countryID);
    // List<String> _provincesNames = Mapper.getSecondValuesFromMaps(_provincesMaps);
    //
    // List<KeywordModel> _provincesKeywords = Province.
    //
    //
    // _filters.insert(0 ,
    //
    //   FilterModel(filterID: 'Province', canPickMany: false, keywordModels: _provincesNames),
    //
    // );
  }
// -----------------------------------------------------------------------------
  void _triggerBrowser(){
    setState(() {
      _browserIsOn = !_browserIsOn;
    });
  }
// -----------------------------------------------------------------------------
  List<Widget> _filterKeywords(List<FilterModel> filtersModels){

    return

      <Widget>[

        ClipRRect(
          borderRadius: Borderers.superBorderAll(context, Ratioz.appBarButtonCorner),
          child: Container(
            width: Scale.superScreenWidth(context) - Ratioz.appBarMargin * 2 - Ratioz.appBarPadding * 2,
            height: 40,
            decoration: BoxDecoration(
              color: Colorz.WhiteAir,
              // borderRadius: Borderers.superBorderAll(context, Ratioz.appBarButtonCorner),
            ),
            alignment: Alignment.center,
            child:
            _keywords.length == 0 ? Container() :
            ScrollablePositionedList.builder(
              itemScrollController: _scrollController,
              scrollDirection: Axis.horizontal,
              itemPositionsListener: _itemPositionListener,
              itemCount: _keywords.length,
              itemBuilder: (ctx, index){

                KeywordModel _keyword = index >= 0 ? _keywords[index] : null;

                bool _highlightedMapIsProvince =
                _highlightedKeyword == null ? false
                    :
                _highlightedKeyword.filterID == 'provinces' ? true
                    : false;

                bool _isHighlighted =
                _highlightedMapIsProvince == true && _keyword.filterID == 'provinces'? true
                    :
                _highlightedMapIsProvince == true && _keyword.filterID == 'area'? true
                    :
                KeywordModel.KeywordsAreTheSame(_highlightedKeyword, _keyword) == true ? true
                    :
                false;

                print('_keywords : $_keywords');
                print('_keywords.length : ${_keywords.length}');
                print('index : $index');

                return

                  _keyword == null ?
                  Container(
                    // width: 10,
                    height: 10,
                    color: Colorz.YellowGlass,
                    child: SuperVerse(
                      verse : 'keyword is null',
                    ),
                  ) :
                  KeywordButton(
                    keyword: _keyword.id,
                    title: '${_keyword.filterID}, ${_keyword.groupID}, ${_keyword.subGroupID}',
                    xIsOn: true,
                    onTap: () => _removeKeyword(index, filtersModels),
                    color: _isHighlighted == true ? Colorz.BloodRed : Colorz.BabyBlueSmoke,
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
  List<KeywordModel> _generateFilterKeywords(List<FilterModel> filtersModels){

    FilterModel _currentFilterModel = filtersModels.singleWhere((filterModel) => filterModel.filterID == _currentFilterID, orElse: () => null);

    List<KeywordModel> _currentFilterKeywords = _currentFilterModel == null ? [] : _currentFilterModel.keywordModels;

    return _currentFilterKeywords;
  }
// -----------------------------------------------------------------------------
  void _selectFilter(FilterModel _filterModel){

    setState(() {
      _currentFilterID = _filterModel.filterID;
    });

  }
// -----------------------------------------------------------------------------
  Future<void> _removeKeyword(int index, List<FilterModel> filtersModels) async {

    String _filterID = _keywords[index].filterID;
    String _keywordID = _keywords[index].id;

    bool _isProvince = _filterID == 'province' ? true : false;
    bool _isArea = _filterID == 'area' ? true : false;

    KeywordModel _keywordModel = _keywords[index];


    if (_isProvince == true){


      await _highlightKeyword(_keywordModel, false);

      setState(() {
        _keywords.removeAt(index+1); // area index
        _keywords.removeAt(index); // province index still the same
      });
    }

    else if(_isArea == true){

      await _highlightKeyword(_keywordModel, false);

      setState(() {
        _keywords.removeAt(index-1); // province index
        _keywords.removeAt(index-1); // area index after change
      });
    }

    else {

      bool _canPickMany = filtersModels.singleWhere((filter) => filter.filterID == _filterID).canPickMany;

      await _highlightKeyword(_keywordModel, _canPickMany);


      setState(() {
        _keywords.removeAt(index);
      });
    }

  }
// -----------------------------------------------------------------------------
  void _addKeyword(KeywordModel keyword){
    setState(() {
      _keywords.add(keyword);
    });
  }
// -----------------------------------------------------------------------------
  Future<void> _selectKeyword({KeywordModel keyword, bool isSelected, List<FilterModel> filtersModels}) async {

    bool _canPickMany = filtersModels.singleWhere((filterModel) => filterModel.filterID == _currentFilterID).canPickMany;

    /// when filter accepts many keywords [Poly]
    if (_canPickMany == true){

      /// when POLY keyword is already selected
      if(isSelected == true){
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
      bool _keywordsContainThisTitle = Mapper.listOfMapsContainValue(
        listOfMaps: _keywords,
        field: 'filterTitle',
        value: _currentFilterID,
      );

      /// when SINGULAR keyword already selected
      if (_keywordsContainThisTitle == true){
        _highlightKeyword(keyword, _canPickMany);
      }

      /// when SINGULAR keyword not selected
      else{

        /// when selecting province - area
        if(_currentFilterID == 'Province'){
          // then keyword is province

          _showZoneDialog(provinceName: keyword.id);

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
  Future<void> _showZoneDialog({String provinceName}) async {

    String provinceID = _countryPro.getProvinceIDByProvinceName(context, provinceName);
    List<Map<String, dynamic>> _areasMaps = _countryPro.getAreasNameMapsByProvinceID(context, provinceID);

    // await superDialog(
    //   context: context,
    //   title: '$provinceName',
    //   body: 'add an Area in $provinceName to search words',
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
    //         Map<String, String> _provinceMap = {'keyword' : provinceName, 'filterTitle' : 'Province'};
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
    //               _addKeyword(_provinceMap);
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

    if (_keywords.length <= 2){
      print('no scroll available');
    } else {
      _scrollController.scrollTo(index: _keywords.length - 1, duration: Ratioz.fadingDuration);
    }
  }
// -----------------------------------------------------------------------------
  void _scrollToIndex(int index){

    if (_keywords.length <= 1){
      print('no scroll available');
    } else {
      _scrollController.scrollTo(index: index, duration: Ratioz.fadingDuration);
    }
  }
// -----------------------------------------------------------------------------
  Future<void> _highlightKeyword(KeywordModel keywordModel, bool canPickMany) async {

    int _index;

    /// if filter allows many keywords, we get index by exact map
    if (canPickMany == true){
      _index = _keywords.indexWhere((keyword) => KeywordModel.KeywordsAreTheSame(keyword, keywordModel),);
    }

    /// if filter does not allow many keywords. we get index by the filterTitle only
    else {
      _index = _keywords.indexWhere((keyword) => keyword.filterID == keywordModel.filterID);
    }

    _scrollToIndex(_index);

    KeywordModel _keyword = _index >= 0 ? _keywords[_index] : null;

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
    List<FilterModel> _filtersBySection = _flyersProvider.getSectionFilters;

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

    List<KeywordModel> _currentFilterKeywords = _generateFilterKeywords(_filtersBySection);

    return MainLayout(
      appBarType: AppBarType.Search,
      appBarBackButton: true,
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
                      ... _filterKeywords(_filtersBySection)
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
              onTap: _triggerBrowser,
              child: AnimatedContainer(
                height: _browserZoneHeight,
                width: _browserZoneWidth,
                duration: Ratioz.fadingDuration,
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  borderRadius: _browserZoneCorners,
                  color: Colorz.BlackLingerie,
                ),
                margin: EdgeInsets.all(_browserZoneMargins),
                alignment: Aligners.superTopAlignment(context),
                child:
                _browserZoneWidth == _browserMaxZoneWidth ?

                /// browser contents
                BrowserPages(
                  browserZoneHeight: _browserZoneHeight,
                  browserIsOn: _browserIsOn,
                  closeBrowser: _triggerBrowser,
                  filtersModels: _filtersBySection,
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

        ],
      ),
    );
  }
}
