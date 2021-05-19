import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/flyer_keyz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/dream_list.dart';
import 'package:bldrs/views/widgets/nav_bar/bar_button.dart';
import 'package:bldrs/views/widgets/nav_bar/nav_bar.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
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


    _filters.add(
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

              bool _isHighlighted = Mapper.mapsAreTheSame(_highlightedKeywordMap, _keywords[index]) == true ? true : false;

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
  List<String> _generateFilterList(){

    Map<String, dynamic> _currentFilterMap = _filters.singleWhere((filterMap) => filterMap['title'] == _filterTitle, orElse: () => null);

    List<String> _currentFilterKeywordsList = _currentFilterMap == null ? [] : _currentFilterMap['list'];

    return _currentFilterKeywordsList;
  }
// -----------------------------------------------------------------------------
  void _selectFilter(Map<String, dynamic> _filter){

      setState(() {
        _filterTitle = _filter['title'];
      });

  }
// -----------------------------------------------------------------------------
  void _removeKeyword(int index){
    setState(() {
      _keywords.removeAt(index);
    });
  }
// -----------------------------------------------------------------------------
  Future<void> _selectKeyword(String keyword, bool isSelected) async {

    bool _canPickMany = _filters.singleWhere((filterMap) => filterMap['title'] == _filterTitle)['canPickMany'];

    Map<String, String> _keywordMap = {'keyword' : keyword, 'filterTitle' : _filterTitle};
    int _keywordMapIndex = Mapper.indexOfMapInListOfMaps(_keywords, _keywordMap);

    /// when this filter accepts many keywords
    if (_canPickMany == true){

      /// when this keyword is already selected
      if(isSelected == true){

        // superDialog(
        //   context: context,
        //   title: 'obbaaa',
        //   body: 'this has already been selected $keyword : $_filterTitle baby',
        // );

        _highlightKeyword(_keywordMap, _canPickMany);

      }

      /// when the keyword is not selected
      else {
        setState(() {
          _keywords.add(_keywordMap);
        });
        _scrollToEndOfAppBar();
      }

    }

    /// when this filter only accepts one keyword
    else {

      bool _keywordsContainThisTitle = Mapper.listOfMapsContainValue(
        listOfMaps: _keywords,
        field: 'filterTitle',
        value: _filterTitle,
      );

      /// if keywords list contain a keyword of same title that accepts only one keyword
      if (_keywordsContainThisTitle == true){

        _highlightKeyword(_keywordMap, _canPickMany);

      }

      /// if no keyword of this title was chosen
      else{
        setState(() {
          _keywords.add(_keywordMap);
        });
        _scrollToEndOfAppBar();
      }

    }



  }
// -----------------------------------------------------------------------------
  void _scrollToEndOfAppBar(){
    // _scrollController.animateTo(_scrollController.position.maxScrollExtent + 100, duration: Ratioz.fadingDuration, curve: Curves.easeInOut);

    if (_keywords.length <= 1){
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

    print('_browserScrollZoneHeight/_browserZoneHeight : ${_browserScrollZoneHeight/_browserZoneHeight}');

    // print('_buttonPadding is : ${_buttonPadding}');
    // print('_browserZoneWidth is : $_browserZoneWidth');
    // print('_buttonPadding/_browserZoneWidth is : ${_buttonPadding/_browserZoneWidth}');

    double _filtersZoneWidth = (_browserScrollZoneWidth - _buttonPadding) / 2 ;

    // print('_filtersZoneWidth : $_filtersZoneWidth');

    List<String> _currentFilterKeywordsList = _generateFilterList();

    // print('_currentFilterKeywordsList.length = ${_currentFilterKeywordsList.length} : _currentFilterKeywordsList is : $_currentFilterKeywordsList');

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
                            itemCount: _currentFilterKeywordsList.length,
                            itemBuilder: (context, index){

                              String _keyword = _currentFilterKeywordsList[index];

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
                              //     verse: _currentFilterKeywordsList[index],
                              //     size: 4,
                              //     // verseScaleFactor: 0.8,
                              //     margin: 2.5,//EdgeInsets.symmetric(vertical: 2.5),
                              //     color: _isSelected ? Colorz.White : Colorz.WhiteLingerie,
                              //     labelColor: _isSelected ? Colorz.BabyBluePlastic : Colorz.WhiteGlass,
                              //     labelTap: (){
                              //       print(_currentFilterKeywordsList[index]);
                              //
                              //       setState(() {
                              //         _keywords.add(_currentFilterKeywordsList[index]);
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
