import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/dream_list.dart';
import 'package:bldrs/views/widgets/nav_bar/bar_button.dart';
import 'package:bldrs/views/widgets/nav_bar/nav_bar.dart';
import 'package:bldrs/xxx_LABORATORY/flyer_browser/flyer_keyz.dart';
import 'package:bldrs/xxx_LABORATORY/flyer_browser/keyword_button.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class FlyerBrowserScreen extends StatefulWidget {
  const FlyerBrowserScreen({Key key}) : super(key: key);

  @override
  _FlyerBrowserScreenState createState() => _FlyerBrowserScreenState();
}

class _FlyerBrowserScreenState extends State<FlyerBrowserScreen> {
  List<Map<String, dynamic>> _filters = new List();
/// _keywords = {'filterTitle' : _filterTitle, 'keyword', _keyword};
  List<Map<String, String>> _keywords = new List();
  Map<String, dynamic> _highlightedKeywordMap;
  bool _browserIsOn = false;
  String _filterTitle;
  ItemScrollController _scrollController;
  ItemPositionsListener _itemPositionListener;
  CountryProvider _countryPro;
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
  _countryPro =  Provider.of<CountryProvider>(context, listen: false);

  _filters.addAll(Filterz.propertyFilters);

  _scrollController = ItemScrollController();
  _itemPositionListener = ItemPositionsListener.create();


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
  void _addZoneFilters(){

    String _countryID = _countryPro.currentCountryID;
    String _countryName = _countryPro.getCountryNameInCurrentLanguageByIso3(context, _countryID);
    List<Map<String, dynamic>> _provincesMaps = _countryPro.getProvincesNameMapsByIso3(context, _countryID);
    // String _countryFlag = Flagz.getFlagByIso3(_countryID);
    List<String> _provincesNames = Mapper.getSecondValuesFromMaps(_provincesMaps);


    _filters.insert(0 ,
      {'title' : 'Province', 'list' : _provincesNames, 'canPickMany' : false },
    );
  }
// -----------------------------------------------------------------------------
  void _triggerBrowser(){
    setState(() {
      _browserIsOn = !_browserIsOn;
    });
  }
// -----------------------------------------------------------------------------
  List<Widget> _appBarKeywords(){

    return

      <Widget>[

        Container(
          width: Scale.appBarScrollWidth(context),
          height: 40,
          decoration: BoxDecoration(
            color: Colorz.WhiteAir,
            borderRadius: Borderers.superBorderAll(context, Ratioz.ddAppBarButtonCorner),
          ),
          child:
          _keywords.length == 0 ? Container() :
          ScrollablePositionedList.builder(
            itemScrollController: _scrollController,
            scrollDirection: Axis.horizontal,
            itemPositionsListener: _itemPositionListener,
            itemCount: _keywords.length,
            itemBuilder: (ctx, index){

              bool _highlightedMapIsProvince =
              _highlightedKeywordMap == null ? false
                  :
              _highlightedKeywordMap['filterTitle'] == 'Province' ? true
                  : false;

              bool _isHighlighted =
                  _highlightedMapIsProvince == true && _keywords[index]['filterTitle'] == 'Province'? true
                      :
                  _highlightedMapIsProvince == true && _keywords[index]['filterTitle'] == 'Area'? true
                      :
                  Mapper.mapsAreTheSame(_highlightedKeywordMap, _keywords[index]) == true ? true
                      :
                  false;

              print('_keywords : $_keywords');
              print('_keywords.length : ${_keywords.length}');
              print('index : $index');

              return

                KeywordButton(
                  keyword: _keywords[index]['keyword'],
                  title: _keywords[index]['filterTitle'],
                  xIsOn: true,
                  onTap: () => _removeKeyword(index),
                  color: _isHighlighted == true ? Colorz.BloodRed : Colorz.BabyBlueSmoke,
                );

            },
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
  List<String> _generateFilterKeywords(){

    Map<String, dynamic> _currentFilterMap = _filters.singleWhere((filterMap) => filterMap['title'] == _filterTitle, orElse: () => null);

    List<String> _currentFilterKeywords = _currentFilterMap == null ? [] : _currentFilterMap['list'];

    return _currentFilterKeywords;
  }
// -----------------------------------------------------------------------------
  void _selectFilter(Map<String, dynamic> _filter){

      setState(() {
        _filterTitle = _filter['title'];
      });

  }
// -----------------------------------------------------------------------------
  Future<void> _removeKeyword(int index) async {

    String _filterTitle = _keywords[index]['filterTitle'];
    String _keyword = _keywords[index]['keyword'];

    bool _isProvince = _filterTitle == 'Province' ? true : false;
    bool _isArea = _filterTitle == 'Area' ? true : false;

    Map<String, dynamic> _keywordMap = {'filterTitle' : _filterTitle, 'keyword': _keyword};


    if (_isProvince == true){


      await _highlightKeyword(_keywordMap, false);

      setState(() {
        _keywords.removeAt(index+1); // area index
        _keywords.removeAt(index); // province index still the same
      });
    }

    else if(_isArea == true){


      await _highlightKeyword(_keywordMap, false);

      setState(() {
        _keywords.removeAt(index-1); // province index
        _keywords.removeAt(index-1); // area index after change
      });
    }

    else {

      bool _canPickMany = _filters.singleWhere((filter) => filter['title'] == _filterTitle)['canPickMany'];

      await _highlightKeyword(_keywordMap, _canPickMany);


      setState(() {
        _keywords.removeAt(index);
      });
    }

  }
// -----------------------------------------------------------------------------
  void _addKeyword(Map<String, dynamic> map){
    setState(() {
      _keywords.add(map);
    });
  }
// -----------------------------------------------------------------------------
  Future<void> _selectKeyword(String keyword, bool isSelected) async {

    bool _canPickMany = _filters.singleWhere((filterMap) => filterMap['title'] == _filterTitle)['canPickMany'];
    Map<String, String> _keywordMap = {'keyword' : keyword, 'filterTitle' : _filterTitle};

    /// when filter accepts many keywords [Poly]
    if (_canPickMany == true){

      /// when POLY keyword is already selected
      if(isSelected == true){
        _highlightKeyword(_keywordMap, _canPickMany);
      }

      /// when POLY keyword is not selected
      else {
        _addKeyword(_keywordMap);
        _scrollToEndOfAppBar();
      }

    }

    /// when filter accepts one keyword [SINGULAR]
    else {

      /// check if SINGULAR keyword is selected by filterTitle
      bool _keywordsContainThisTitle = Mapper.listOfMapsContainValue(
        listOfMaps: _keywords,
        field: 'filterTitle',
        value: _filterTitle,
      );

      /// when SINGULAR keyword already selected
      if (_keywordsContainThisTitle == true){
        _highlightKeyword(_keywordMap, _canPickMany);
      }

      /// when SINGULAR keyword not selected
      else{

        /// when selecting province - area
        if(_filterTitle == 'Province'){
          // then keyword is province

          _showZoneDialog(provinceName: keyword);

        }

        /// when selecting anything else than zone
        else {
        _addKeyword(_keywordMap);
        _scrollToEndOfAppBar();
        }

      }

    }

  }
// -----------------------------------------------------------------------------
  Future<void> _showZoneDialog({String provinceName}) async {

    String provinceID = _countryPro.getProvinceIDByProvinceName(context, provinceName);
    List<Map<String, dynamic>> _areasMaps = _countryPro.getAreasNameMapsByProvinceID(context, provinceID);


    await superDialog(
      context: context,
      title: '$provinceName',
      body: 'add an Area in $provinceName to search words',
      height: Scale.superScreenHeight(context) * 0.7,
      child: Container(
        height: Scale.superScreenHeight(context) * 0.5,
        width: Scale.superDialogWidth(context) * 0.9,
        decoration: BoxDecoration(
          color: Colorz.WhiteAir,
          borderRadius: Borderers.superBorderAll(context, Ratioz.ddAppBarButtonCorner),
        ),
        child: DreamList(
          itemHeight: 45,
          itemZoneHeight: 50,
          itemCount: _areasMaps.length,
          itemBuilder: (ctx, index){

            String _areaName = _areasMaps[index]['value'];

            Map<String, String> _areaMap = {'keyword' : _areaName, 'filterTitle' : 'Area'};
            Map<String, String> _provinceMap = {'keyword' : provinceName, 'filterTitle' : 'Province'};

            bool _isSelected = Mapper.listOfMapsContainMap(listOfMaps: _keywords, map: _areaMap);

            return

              DreamBox(
                height: 45,
                // width: 100,
                verse: _areaName,
                verseScaleFactor: 0.6,
                boxMargins: 2.5,
                color: _isSelected ? Colorz.BabyBluePlastic : Colorz.WhiteGlass,
                verseColor: _isSelected ? Colorz.White : Colorz.WhiteLingerie,
                bubble: false,
                boxFunction: (){

                  _addKeyword(_provinceMap);
                  _addKeyword(_areaMap);

                  _scrollToEndOfAppBar();

                  Nav.goBack(context);

                },
              );


          },
        ),
      ),
    );

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
  Future<void> _highlightKeyword(Map<String, dynamic> map, bool canPickMany) async {

    int _keywordMapIndex;

    /// if filter allows many keywords, we get index by exact map
    if (canPickMany == true){
      _keywordMapIndex = Mapper.indexOfMapInListOfMaps(_keywords, map);
    }

    /// if filter does not allow many keywords. we get index by the filterTitle only
    else {
      _keywordMapIndex = Mapper.indexOfMapByValueInListOfMaps(
        listOfMaps: _keywords,
        key: 'filterTitle',
        value: map['filterTitle'],
      );
    }

    _scrollToIndex(_keywordMapIndex);

    setState(() {
      _highlightedKeywordMap = _keywords[_keywordMapIndex];
    });

    await Future.delayed(const Duration(milliseconds: 500), (){
      setState(() {
        _highlightedKeywordMap = null;
      });
    });

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _buttonPadding = _browserIsOn == true ? Ratioz.ddAppBarPadding * 1.5 : Ratioz.ddAppBarPadding * 1.5;

    double _browserMinZoneHeight = 40 + _buttonPadding * 2 + superVerseRealHeight(context, 0, 0.95, null);
    double _browserMaxZoneHeight = Scale.superScreenHeight(context) * 0.38;

    double _browserMinZoneWidth = 40 + _buttonPadding * 2;
    double _browserMaxZoneWidth = Scale.superScreenWidth(context) - _buttonPadding * 2;

    double _browserZoneHeight = _browserIsOn == true ? _browserMaxZoneHeight : _browserMinZoneHeight;
    double _browserZoneWidth = _browserIsOn == true ? _browserMaxZoneWidth : _browserMinZoneWidth;
    double _browserZoneMargins = _browserIsOn == true ? _buttonPadding : _buttonPadding;
    BorderRadius _browserZoneCorners = Borderers.superBorderAll(context, Ratioz.ddAppBarCorner);

    double _browserScrollZoneWidth = _browserZoneWidth * 0.96;
    double _browserScrollZoneHeight = _browserZoneHeight * 0.94;

    double _filtersZoneWidth = (_browserScrollZoneWidth - _buttonPadding) / 2 ;

    List<String> _currentFilterKeywords = _generateFilterKeywords();


    return MainLayout(
      pyramids: _browserIsOn == true ? Iconz.DvBlankSVG : null,
      appBarType: _browserIsOn == true ? AppBarType.Scrollable : AppBarType.Main,
      loading: _loading,
      appBarBackButton: false,
      appBarRowWidgets: _browserIsOn == true ? _appBarKeywords() : null,
      // appBarScrollController: _scrollController,
      layoutWidget: Stack(
        children: <Widget>[

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
                    color: Colorz.BloodRedZircon,
                  ),
                  margin: EdgeInsets.all(_browserZoneMargins),
                  alignment: Alignment.center,
                  child:
                  _browserZoneWidth == _browserMaxZoneWidth ?

                  /// browser contents
                  AnimatedContainer(
                    duration: Ratioz.slidingTransitionDuration,
                    width: _browserScrollZoneWidth,
                    height: _browserScrollZoneHeight,
                    color: Colorz.WhiteAir,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[

                        /// FILTERS
                        AnimatedContainer(
                          duration: Ratioz.slidingTransitionDuration,
                          width: _filtersZoneWidth,
                          height: _browserScrollZoneHeight,
                          color: Colorz.BabyBlueSmoke,
                          child: DreamList(
                            itemZoneHeight: 50,
                            itemHeight: 45,
                            itemCount: _filters.length,
                            itemBuilder: (context, index) =>

                                DreamBox(
                                  height: 45,
                                  width: _filtersZoneWidth * 0.8,
                                  verse: _filters[index]['title'],
                                  verseScaleFactor: 0.6,
                                  boxMargins: 2.5,
                                  color: _filterTitle == _filters[index]['title'] ? Colorz.Yellow : Colorz.Nothing,
                                  verseColor: _filterTitle == _filters[index]['title'] ? Colorz.BlackBlack : Colorz.White,
                                  boxFunction: () => _selectFilter(_filters[index]),
                                ),

                          ),
                        ),

                        SizedBox(width: _buttonPadding,),

                        /// KEYWORDS
                        AnimatedContainer(
                          duration: Ratioz.slidingTransitionDuration,
                          width: _filtersZoneWidth,
                          height: _browserScrollZoneHeight,
                          color: Colorz.BabyBlueSmoke,
                          child:
                          DreamList(
                            itemZoneHeight: 50,
                            itemHeight: 45,
                            itemCount: _currentFilterKeywords.length,
                            itemBuilder: (context, index){

                              String _keyword = _currentFilterKeywords[index];

                              Map<String, String> _keywordMap = {'keyword' : _keyword, 'filterTitle' : _filterTitle};

                              bool _isSelected = Mapper.listOfMapsContainMap(listOfMaps: _keywords, map: _keywordMap);

                              return

                                DreamBox(
                                  height: 45,
                                  width: _filtersZoneWidth * 0.8,
                                  verse: _keyword,
                                  verseScaleFactor: 0.6,
                                  boxMargins: 2.5,
                                  color: _isSelected ? Colorz.BabyBluePlastic : Colorz.WhiteGlass,
                                  verseColor: _isSelected ? Colorz.White : Colorz.WhiteLingerie,
                                  bubble: false,
                                  boxFunction: () => _selectKeyword(_keyword, _isSelected),
                                );


                              // SuperVerse(
                              //     // height: 45,
                              //     // width: _filtersZoneWidth,
                              //     verse: _currentFilterKeywords[index],
                              //     size: 4,
                              //     // verseScaleFactor: 0.8,
                              //     margin: 2.5,//EdgeInsets.symmetric(vertical: 2.5),
                              //     color: _isSelected ? Colorz.White : Colorz.WhiteLingerie,
                              //     labelColor: _isSelected ? Colorz.BabyBluePlastic : Colorz.WhiteGlass,
                              //     labelTap: (){
                              //       print(_currentFilterKeywords[index]);
                              //
                              //       setState(() {
                              //         _keywords.add(_currentFilterKeywords[index]);
                              //       });
                              //
                              //       _scrollController.animateTo(_scrollController.position.maxScrollExtent + 100, duration: Ratioz.fadingDuration, curve: Curves.easeInOut);
                              //
                              //
                              //     },
                              //   );
                            },
                          ),
                        ),

                      ],
                    ),
                  )

                      :

                  /// the icon

                  BarButton(
                    width: _browserMinZoneWidth,
                    text: 'Browse',
                    iconSizeFactor: 0.7,
                    icon: Iconz.FlyerGrid,
                    onTap: _triggerBrowser,
                    barType: BarType.minWithText,
                    corners: Ratioz.ddAppBarButtonCorner,
                  ),

                ),
              ),
          )

        ],
      ),
    );
  }
}
