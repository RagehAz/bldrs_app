import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart' as FlyerTypeClass;
import 'package:bldrs/b_views/z_components/chains_drawer/chain_expander_by_flyer_type.dart';
import 'package:bldrs/b_views/z_components/keywords/selected_keywords_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class KeywordsPickerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const KeywordsPickerScreen({
    @required this.selectedKeywordsIDs,
    @required this.flyerType,
    // @required this.onKeywordTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<String> selectedKeywordsIDs;
  final FlyerTypeClass.FlyerType flyerType;
  // final Function onKeywordTap;
  /// --------------------------------------------------------------------------
  @override
  _KeywordsPickerScreenState createState() => _KeywordsPickerScreenState();
  /// --------------------------------------------------------------------------
}

class _KeywordsPickerScreenState extends State<KeywordsPickerScreen> {
  ValueNotifier<List<String>> _selectedKeywordsIDs;
  ChainsProvider _chainsProvider;
  final TextEditingController _searchController = TextEditingController();
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _scrollController = ItemScrollController();
    // _itemPositionListener = ItemPositionsListener.create();

    _selectedKeywordsIDs = ValueNotifier(<String>[...widget.selectedKeywordsIDs]);
    // generateExpansionKeys();
  }
// -----------------------------------------------------------------------------
//   List<GlobalKey<GroupTileState>> _expansionKeys = <GlobalKey<GroupTileState>>[];
//   void generateExpansionKeys(){
//     _chains.forEach((x) {
//       _expansionKeys.add(new GlobalKey());
//     });
//   }
// -----------------------------------------------------------------------------
//   String _currentGroupID;
//   void _selectGroup({bool isExpanded, GroupModel group}){
//
//     print('selecting group : ${group.groupID} : isExpanded : $isExpanded');
//
//     setState(() {
//       _currentGroupID = group.groupID;
//     });
//
//   }
// -----------------------------------------------------------------------------
//   Future<void> _onKeywordTap(BuildContext ctx, Keyword keyword) async {
//
//     // bool _canPickMany = filtersModels.singleWhere((filterModel) => filterModel.filterID == _currentFilterID).canPickMany;
//
//     final bool _canPickMany = GroupModel.getCanGroupPickManyByKeyword(keyword);
//
//     final bool _isSelected = _selectedKeywords.contains(keyword);
//
//     print('_onKeywordTap : keyword : ${keyword.keywordID} : groupID : ${keyword.groupID} : subGroupID : ${keyword.subGroupID} : _canPickMany : $_canPickMany : _isSelected : $_isSelected');
//
//     /// when filter accepts many keywords [Poly]
//     if (_canPickMany == true){
//
//       /// when POLY keyword is already selected
//       if(_isSelected == true){
//
//         NavDialog.showNavDialog(
//             context: ctx,
//             firstLine: 'Already selected',
//             secondLine: '${Keyword.getKeywordNameByKeywordID(context, keyword.keywordID)} ${Keyword.getGroupNameInCurrentLingoByGroupID(ctx, keyword.groupID)} can not be added multiple times',
//             isBig: true
//         );
//
//         await _highlightKeyword(keyword, _canPickMany);
//       }
//
//       /// when POLY keyword is not selected
//       else {
//         _addKeyword(keyword);
//         _scrollToEndOfAppBar();
//       }
//
//     }
//
//     /// when filter accepts one keyword [SINGULAR]
//     else {
//
//       /// check if SINGULAR keyword is selected by filterTitle
//       final bool _selectedKeywordsHaveThisGroupID = Keyword.keywordsContainThisGroupID(keywords : _selectedKeywords, groupID: keyword.groupID);
//
//       print('_selectedKeywordsHaveThisGroupID : $_selectedKeywordsHaveThisGroupID');
//
//       /// when SINGULAR keyword already selected
//       if (_isSelected == true){
//         NavDialog.showNavDialog(
//             context: ctx,
//             firstLine: 'Already selected',
//             secondLine: '${Keyword.getKeywordNameByKeywordID(context, keyword.keywordID)} ${Keyword.getGroupNameInCurrentLingoByGroupID(ctx, keyword.groupID)} can not be added multiple times',
//             isBig: true
//         );
//         await _highlightKeyword(keyword, _canPickMany);
//       }
//
//       /// when SINGULAR keyword of same group is selected
//       else if (_selectedKeywordsHaveThisGroupID == true){
//         NavDialog.showNavDialog(
//           context: ctx,
//           firstLine: 'Can\'t add keyword',
//           secondLine: 'only one ${Keyword.getGroupNameInCurrentLingoByGroupID(ctx, keyword.groupID)} can be added',
//           isBig: true
//         );
//         await _highlightKeyword(keyword, _canPickMany);
//       }
//
//       /// when SINGULAR keyword not selected
//       else{
//
//         /// when selecting city - area
//         if(_currentGroupID == 'city'){
//           // then keyword is city
//
//           await _showZoneDialog(cityName: keyword.keywordID);
//
//         }
//
//         /// when selecting anything else than zone
//         else {
//           _addKeyword(keyword);
//           _scrollToEndOfAppBar();
//         }
//
//       }
//
//     }
//
//   }
// -----------------------------------------------------------------------------
  String _highlightedKeywordID;
  Future<void> _highlightKeyword(String keywordID, bool canPickMany) async {

    int _index;

    /// if filter allows many keywords, we get index by exact map
    if (canPickMany == true){
      _index = _selectedKeywordsIDs.value.indexWhere((id) => id == keywordID,);
    }

    /// if filter does not allow many keywords. we get index by the groupID only
    else {
      // _index = _selectedKeywordsIDs.indexWhere((id) => keyword.groupID == keywordModel.groupID);
    }

    await _scrollToIndex(_index);

    final String _keywordID = _index >= 0 ? _selectedKeywordsIDs.value[_index] : null;

    setState(() {
      _highlightedKeywordID = _keywordID;
    });

    await Future.delayed(const Duration(milliseconds: 500), (){
      setState(() {
        _highlightedKeywordID = null;
      });
    });

  }
// -----------------------------------------------------------------------------
  ItemScrollController _scrollController;
  ItemPositionsListener _itemPositionListener;
  Future _scrollToEndOfAppBar() async {
    // _scrollController.animateTo(_scrollController.position.maxScrollExtent + 100, duration: Ratioz.fadingDuration, curve: Curves.easeInOut);

    if (_selectedKeywordsIDs.value.length <= 2 || _scrollController == null){
      blog('no scroll available');
    } else {
      await _scrollController?.scrollTo(
        index: _selectedKeywordsIDs.value.length - 1,
        duration: Ratioz.duration150ms,
        curve: Curves.easeOut,
      );


    }
  }
// -----------------------------------------------------------------------------
  Future<void> _scrollToIndex(int index) async {

    if (_selectedKeywordsIDs.value.length <= 1){
      blog('no scroll available');
    } else {
      await _scrollController.scrollTo(
        index: index,
        duration: Ratioz.duration150ms,
        curve: Curves.easeOut,
      );
    }
  }
// -----------------------------------------------------------------------------
  Future<void> _onSelectKeyword(String keywordID) async {

    /// WHEN ALREADY SELECTED
    if (_selectedKeywordsIDs.value.contains(keywordID) == true){
      final List<String> _list = <String>[..._selectedKeywordsIDs.value];
      final int index = _list.indexOf(keywordID);
      await _scrollToIndex(index);

      await Future.delayed(Ratioz.duration150ms, (){
        _list.remove(keywordID);
        _selectedKeywordsIDs.value = _list;
      });

    }
    /// WHEN NOT SELECTED
    else {
      final List<String> _list = <String>[..._selectedKeywordsIDs.value, keywordID];
      _selectedKeywordsIDs.value = _list;
      await _scrollToEndOfAppBar();
    }

  }
// -----------------------------------------------------------------------------
  Future<void> _onSearchChain(String text) async {
    blog('text to search is : $text');
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    final double _selectedKeywordsBubbleHeight = SelectedKeywordsBar.getBubbleHeight(
      context: context,
      includeMargins: true,
    );
    final double _keywordsZoneHeight =  _screenHeight - Ratioz.exosphere - _selectedKeywordsBubbleHeight;

    return MainLayout(
      pageTitle: 'Select Flyer keywords',
      appBarType: AppBarType.search,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      pyramidsAreOn: true,
      skyType: SkyType.black,
      onBack: () {
        Nav.goBack(context, argument: _selectedKeywordsIDs.value);
        // await null
      },
      onSearchChanged: _onSearchChain,
      onSearchSubmit: _onSearchChain,
      searchController: _searchController,
      layoutWidget: ValueListenableBuilder(
        valueListenable: _selectedKeywordsIDs,
        builder: (_, List<String> selectedIDs, Widget child){

          return Column(
            children: <Widget>[

              const Stratosphere(bigAppBar: true),

              /// selected keywords zone
              SelectedKeywordsBar(
                selectedKeywordsIDs: selectedIDs,
                scrollController: _scrollController,
                itemPositionListener: _itemPositionListener,
                highlightedKeywordID: _highlightedKeywordID,
                removeKeyword: (String keywordID) => _onSelectKeyword(keywordID)
              ),

              /// keywords zone
              SizedBox(
                width: _screenWidth,
                height: _keywordsZoneHeight,
                child: ListView(
                  padding: const EdgeInsets.only(
                    top: Ratioz.appBarMargin,
                    bottom: Ratioz.horizon,
                  ),
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[

                    ChainExpanderByFlyerType(
                      flyerType: widget.flyerType,
                      bubbleWidth: _screenWidth,
                      deactivated: false,
                      onKeywordTap: (String id) => _onSelectKeyword(id),
                      selectedKeywordsIDs: selectedIDs,
                    ),

                  ],
                ),
              ),
            ],
          );

        },
      ),
    );
  }
}
