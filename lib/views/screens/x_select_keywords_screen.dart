import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/keywords/one_page_expansion_tile.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/flyer_browser/bldrs_expansion_tile.dart';
import 'package:bldrs/xxx_LABORATORY/flyer_browser/keyword_button.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/models/keywords/groups.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SelectKeywordsScreen extends StatefulWidget {
  final List<Keyword> selectedKeywords;
  final FlyerType flyerType;
  // final Function onKeywordTap;

  SelectKeywordsScreen({
    @required this.selectedKeywords,
    @required this.flyerType,
    // @required this.onKeywordTap,
});

  @override
  _SelectKeywordsScreenState createState() => _SelectKeywordsScreenState();
}

class _SelectKeywordsScreenState extends State<SelectKeywordsScreen> {
  List<Keyword> _selectedKeywords = new List();

  List<Group> _groups;
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
    _groups = Group.getGroupsByFlyerType(flyerType: widget.flyerType);

    print('_groups.length = ${_groups.length} ,, and _groups[0].groupID is : ${_groups[0].groupID}');

    _scrollController = ItemScrollController();
    _itemPositionListener = ItemPositionsListener.create();

    _selectedKeywords.addAll(widget.selectedKeywords);
    generateExpansionKeys();
    super.initState();
  }
// -----------------------------------------------------------------------------
  List<GlobalKey<BldrsExpansionTileState>> _expansionKeys = new List();
  void generateExpansionKeys(){
    _groups.forEach((x) {
      _expansionKeys.add(new GlobalKey());
    });
  }
// -----------------------------------------------------------------------------
  bool _isExpanded = false;
  void _triggerExpansion(GlobalKey<BldrsExpansionTileState> key){
    if(_isExpanded){
      key.currentState.collapse();
    } else {
      key.currentState.expand();
    }

    setState(() {
      _isExpanded =! _isExpanded;
    });

  }
// -----------------------------------------------------------------------------
  String _currentGroupID;
  void _selectGroup({bool isExpanded, Group group}){

    print('selecting group : ${group.groupID} : isExpanded : $isExpanded');

    setState(() {
      _currentGroupID = group.groupID;
    });

  }
// -----------------------------------------------------------------------------
  List<String> getKeywordIDs(List<Keyword> _keywordModels){
    List<String> _keywordIDs = new List();

    _keywordModels.forEach((key) {
      _keywordIDs.add(key.keywordID);
    });

    return _keywordIDs;
  }
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
  Future<void> _onKeywordTap(Keyword keyword) async {

    // bool _canPickMany = filtersModels.singleWhere((filterModel) => filterModel.filterID == _currentFilterID).canPickMany;

    bool _canPickMany = Group.getCanGroupPickManyByKeyword(keyword);

    bool _isSelected = _selectedKeywords.contains(keyword);

    print('_onKeywordTap : keyword : ${keyword.keywordID} : groupID : ${keyword.groupID} : _canPickMany : $_canPickMany : _isSelected : $_isSelected');

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
      bool _selectedKeywordsHaveThisGroupID = Keyword.keywordsContainThisGroupID(keywords : _selectedKeywords, groupID: keyword.groupID);

      print('_selectedKeywordsHaveThisGroupID : $_selectedKeywordsHaveThisGroupID');

      /// when SINGULAR keyword already selected
      if (_selectedKeywordsHaveThisGroupID == true){
        _highlightKeyword(keyword, _canPickMany);
      }

      /// when SINGULAR keyword not selected
      else{

        /// when selecting city - area
        if(_currentGroupID == 'city'){
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
  Keyword _highlightedKeyword;
  Future<void> _highlightKeyword(Keyword keywordModel, bool canPickMany) async {

    int _index;

    /// if filter allows many keywords, we get index by exact map
    if (canPickMany == true){
      _index = _selectedKeywords.indexWhere((keyword) => Keyword.KeywordsAreTheSame(keyword, keywordModel),);
    }

    /// if filter does not allow many keywords. we get index by the groupID only
    else {
      _index = _selectedKeywords.indexWhere((keyword) => keyword.groupID == keywordModel.groupID);
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
  ItemScrollController _scrollController;
  ItemPositionsListener _itemPositionListener;
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
  void _addKeyword(Keyword keyword){
    setState(() {
      _selectedKeywords.add(keyword);
    });
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
  Future<void> _removeKeyword(int index) async {

    bool _isCity = false;
    bool _isArea = false;

    Keyword _keyword = _selectedKeywords[index];
    // String _groupID = _keyword.groupID;

    if (_isCity == true){

      await _highlightKeyword(_keyword, false);

      setState(() {
        _selectedKeywords.removeAt(index+1); // area index
        _selectedKeywords.removeAt(index); // city index still the same
      });
    }

    else if(_isArea == true){

      await _highlightKeyword(_keyword, false);

      setState(() {
        _selectedKeywords.removeAt(index-1); // city index
        _selectedKeywords.removeAt(index-1); // area index after change
      });
    }

    else {

      Group _group = Group.getGroupByKeyword(_keyword);

      await _highlightKeyword(_keyword, _group.canPickMany);

      setState(() {
        _selectedKeywords.removeAt(index);
      });
    }

  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    double _selectedKeywordsZoneHeight = 80;
    double _keywordsZoneHeight =  _screenHeight - Ratioz.stratosphere - _selectedKeywordsZoneHeight;

    String _screenTitle =
    _selectedKeywords.length == 0 ? 'Select keywords' :
    _selectedKeywords.length == 1 ? '1 Selected keyword' :
    '${_selectedKeywords.length} Selected keywords';

    Tracer.traceWidgetBuild(widgetName: 'SelectKeywordsScreen', varName: '_selectedKeywords.length', varValue: _selectedKeywords.length);
    return MainLayout(
      pageTitle: 'Select Flyer keywords',
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidsYellow,
      loading: _loading,
      layoutWidget: Column(
        children: <Widget>[

          Stratosphere(),

          /// selected keywords zone
          Container(
            width: _screenWidth,
            height: _selectedKeywordsZoneHeight,
            color: Colorz.BloodTest,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                /// Selected keywords Title
                Container(
                  width: _screenHeight,
                  height: _selectedKeywordsZoneHeight * 0.3,
                  padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
                  child: SuperVerse(
                    verse: _screenTitle,
                    size: 1,
                    weight: VerseWeight.bold,
                    centered: false,
                  ),
                ),

                /// Selected keywords
                Container(
                  width: _screenWidth,
                  height: _selectedKeywordsZoneHeight * 0.7,

                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[

                      Container(
                        width: _screenWidth,//Scale.superScreenWidth(context) - Ratioz.appBarMargin * 2 - Ratioz.appBarPadding * 2,
                        height: 40,
                        // padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
                        decoration: BoxDecoration(
                          color: Colorz.White10,
                          // borderRadius: Borderers.superBorderAll(context, Ratioz.appBarButtonCorner),
                        ),
                        alignment: Alignment.center,
                        child:
                        _selectedKeywords.length == 0 ? Container() :
                        ScrollablePositionedList.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemScrollController: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemPositionsListener: _itemPositionListener,
                          itemCount: _selectedKeywords.length,
                          padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
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
                              )
                                  :
                              KeywordBarButton(
                                keyword: _keyword,
                                xIsOn: true,
                                onTap: () => _removeKeyword(index),
                                color: _isHighlighted == true ? Colorz.Red255 : Colorz.Blue80,
                              );

                          },
                        ),
                      ),
                      // ..._selectedKeywordsWidgets(_groups),

                    ],
                  ),
                ),

              ],
            ),
          ),

          /// keywords zone
          Container(
            width: _screenWidth,
            height: _keywordsZoneHeight,
            alignment: Alignment.topCenter,
            // color: Colorz.Yellow200,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),

                itemCount: _groups.length,
                itemBuilder: (ctx, index){
                  return

                    OnePageExpansionTile(
                      tileWidth: _screenWidth - (2 * Ratioz.appBarMargin),
                      tileMaxHeight: _keywordsZoneHeight * 0.7,
                      group: _groups[index],
                      selectedKeywords: _selectedKeywords,
                      onKeywordTap: (keyword) async {await _onKeywordTap(keyword);},
                      // onGroupTap: (group) => _selectGroup(group),
                      onExpansionChanged: (bool isExpanded) => _selectGroup(isExpanded: isExpanded, group: _groups[index]),
                    );
                }
                ),
          ),

          // BldrsExpansionTile(
          //   height: Scale.superScreenHeight(context) * 0.5,
          //   key: _expansionKeys[0],
          //   // icon: KeywordModel.getImagePath(_filterID),
          //   iconSizeFactor: 0.5,
          //   group: Group.architecturalStylesGroup,
          //   selectedKeywords: _selectedKeywords,
          //   onKeywordTap: (Keyword selectedKeyword){
          //
          //     if (_selectedKeywords.contains(selectedKeyword)){
          //       setState(() {
          //         print('a77a');
          //         _selectedKeywords.remove(selectedKeyword);
          //       });
          //     }
          //
          //     else {
          //       setState(() {
          //         _selectedKeywords.add(selectedKeyword);
          //       });
          //     }
          //
          //   },
          //
          //   onGroupTap: (String groupID){
          //
          //   },
          // ),


          // ...List.generate(
          //     _filtersIDs.length,
          //         (index){
          //
          //       String _filterID = _filtersIDs[index];
          //
          //       return
          //         BldrsExpansionTile(
          //           height: Scale.superScreenHeight(context) * 0.5,
          //           key: _expansionKeys[index],
          //           // icon: KeywordModel.getImagePath(_filterID),
          //           iconSizeFactor: 0.5,
          //           group: null,
          //           selectedKeywords: _selectedKeywords,
          //           onKeywordTap: (Keyword selectedKeyword){
          //
          //             if (_selectedKeywords.contains(selectedKeyword)){
          //               setState(() {
          //                 print('a77a');
          //               _selectedKeywords.remove(selectedKeyword);
          //               });
          //             }
          //
          //             else {
          //               setState(() {
          //                 _selectedKeywords.add(selectedKeyword);
          //               });
          //             }
          //
          //           },
          //
          //           onGroupTap: (String groupID){
          //
          //           },
          //         );
          //
          // }),

        ],
      ),
    );
  }
}
