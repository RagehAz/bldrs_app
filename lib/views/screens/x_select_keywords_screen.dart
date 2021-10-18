import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/views/widgets/general/dialogs/nav_dialog/nav_dialog.dart';
import 'package:bldrs/views/widgets/specific/keywords/group_expansion_tile.dart';
import 'package:bldrs/views/widgets/specific/keywords/selected_keywords_bar.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/models/keywords/group_model.dart';
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
  List<Keyword> _selectedKeywords = <Keyword>[];
  List<GroupModel> _groups;
  // CountryProvider _countryPro;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    // _countryPro =  Provider.of<CountryProvider>(context, listen: false);
    _groups = GroupModel.getGroupsByFlyerType(flyerType: widget.flyerType);

    print('_groups.length = ${_groups?.length} ,, and _groups[0].groupID is : ${_groups[0].groupID}');

    _scrollController = ItemScrollController();
    _itemPositionListener = ItemPositionsListener.create();

    _selectedKeywords.addAll(widget.selectedKeywords);
    generateExpansionKeys();
  }
// -----------------------------------------------------------------------------
  List<GlobalKey<GroupTileState>> _expansionKeys = <GlobalKey<GroupTileState>>[];
  void generateExpansionKeys(){
    _groups.forEach((x) {
      _expansionKeys.add(new GlobalKey());
    });
  }
// -----------------------------------------------------------------------------
  String _currentGroupID;
  void _selectGroup({bool isExpanded, GroupModel group}){

    print('selecting group : ${group.groupID} : isExpanded : $isExpanded');

    setState(() {
      _currentGroupID = group.groupID;
    });

  }
// -----------------------------------------------------------------------------
  List<String> getKeywordIDs(List<Keyword> _keywordModels){
    final List<String> _keywordIDs = <String>[];

    _keywordModels.forEach((key) {
      _keywordIDs.add(key.keywordID);
    });

    return _keywordIDs;
  }
// -----------------------------------------------------------------------------
  Future<void> _onKeywordTap(BuildContext ctx, Keyword keyword) async {

    // bool _canPickMany = filtersModels.singleWhere((filterModel) => filterModel.filterID == _currentFilterID).canPickMany;

    final bool _canPickMany = GroupModel.getCanGroupPickManyByKeyword(keyword);

    final bool _isSelected = _selectedKeywords.contains(keyword);

    print('_onKeywordTap : keyword : ${keyword.keywordID} : groupID : ${keyword.groupID} : subGroupID : ${keyword.subGroupID} : _canPickMany : $_canPickMany : _isSelected : $_isSelected');

    /// when filter accepts many keywords [Poly]
    if (_canPickMany == true){

      /// when POLY keyword is already selected
      if(_isSelected == true){

        NavDialog.showNavDialog(
            context: ctx,
            firstLine: 'Already selected',
            secondLine: '${Keyword.getKeywordNameByKeywordID(context, keyword.keywordID)} ${Keyword.getGroupNameInCurrentLingoByGroupID(ctx, keyword.groupID)} can not be added multiple times',
            isBig: true
        );

        await _highlightKeyword(keyword, _canPickMany);
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
      final bool _selectedKeywordsHaveThisGroupID = Keyword.keywordsContainThisGroupID(keywords : _selectedKeywords, groupID: keyword.groupID);

      print('_selectedKeywordsHaveThisGroupID : $_selectedKeywordsHaveThisGroupID');

      /// when SINGULAR keyword already selected
      if (_isSelected == true){
        NavDialog.showNavDialog(
            context: ctx,
            firstLine: 'Already selected',
            secondLine: '${Keyword.getKeywordNameByKeywordID(context, keyword.keywordID)} ${Keyword.getGroupNameInCurrentLingoByGroupID(ctx, keyword.groupID)} can not be added multiple times',
            isBig: true
        );
        await _highlightKeyword(keyword, _canPickMany);
      }

      /// when SINGULAR keyword of same group is selected
      else if (_selectedKeywordsHaveThisGroupID == true){
        NavDialog.showNavDialog(
          context: ctx,
          firstLine: 'Can\'t add keyword',
          secondLine: 'only one ${Keyword.getGroupNameInCurrentLingoByGroupID(ctx, keyword.groupID)} can be added',
          isBig: true
        );
        await _highlightKeyword(keyword, _canPickMany);
      }

      /// when SINGULAR keyword not selected
      else{

        /// when selecting city - area
        if(_currentGroupID == 'city'){
          // then keyword is city

          await _showZoneDialog(cityName: keyword.keywordID);

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

    final Keyword _keyword = _index >= 0 ? _selectedKeywords[_index] : null;

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

    if (_selectedKeywords.length <= 2 || _scrollController == null){
      print('no scroll available');
    } else {
      _scrollController?.scrollTo(index: _selectedKeywords.length - 1, duration: Ratioz.duration150ms);
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

    // String _cityID = _countryPro.getCityIDByCityName(context, cityName);
    // List<Map<String, dynamic>> _areasMaps = _countryPro.getDistrictsNameMapsByCityID(context, _cityID);

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

    final Keyword _keyword = _selectedKeywords[index];
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

      final GroupModel _group = GroupModel.getGroupByKeyword(_keyword);

      await _highlightKeyword(_keyword, _group.canPickMany);

      setState(() {
        _selectedKeywords.removeAt(index);
      });
    }

  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    const double _selectedKeywordsZoneHeight = 80;
    final double _keywordsZoneHeight =  _screenHeight - Ratioz.stratosphere - _selectedKeywordsZoneHeight;

    Tracer.traceWidgetBuild(widgetName: 'SelectKeywordsScreen', varName: '_selectedKeywords.length', varValue: _selectedKeywords.length);
    return MainLayout(
      pageTitle: 'Select Flyer keywords',
      appBarType: AppBarType.Basic,
      pyramids: Iconz.DvBlankSVG,
      onBack: () async {
        await Nav.goBack(context, argument: _selectedKeywords);
      },
      layoutWidget: Column(
        children: <Widget>[

          const Stratosphere(),

          /// selected keywords zone
          SelectedKeywordsBar(
              selectedKeywords: _selectedKeywords,
              scrollController: _scrollController,
              itemPositionListener: _itemPositionListener,
              highlightedKeyword: _highlightedKeyword,
              removeKeyword: (index) => _removeKeyword(index)
          ),

          /// keywords zone
          Container(
            width: _screenWidth,
            height: _keywordsZoneHeight,
            alignment: Alignment.topCenter,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: false,
                itemCount: _groups.length,
                padding: const EdgeInsets.only(top: Ratioz.appBarPadding),
                itemBuilder: (ctx, index){
                  return

                    GroupTile(
                      tileWidth: _screenWidth - (2 * Ratioz.appBarMargin),
                      scrollable: false,
                      group: _groups[index],
                      selectedKeywords: _selectedKeywords,
                      onKeywordTap: (keyword) async {await _onKeywordTap(ctx, keyword);},
                      onGroupTap: (bool isExpanded) => _selectGroup(isExpanded: isExpanded, group: _groups[index]),
                      // tileMaxHeight: _keywordsZoneHeight * 0.7,
                    );
                }
                ),
          ),

        ],
      ),
    );
  }
}
