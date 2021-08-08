import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/views/widgets/keywords/one_page_expansion_tile.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/xxx_LABORATORY/flyer_browser/bldrs_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/models/keywords/keys_set.dart';

class SelectKeywordsScreen extends StatefulWidget {
  final List<Keyword> selectedKeywords;
  final FlyerType flyerType;

  SelectKeywordsScreen({
    @required this.selectedKeywords,
    @required this.flyerType,
});

  @override
  _SelectKeywordsScreenState createState() => _SelectKeywordsScreenState();
}

class _SelectKeywordsScreenState extends State<SelectKeywordsScreen> {
  bool _isExpanded = false;
  List<GlobalKey<BldrsExpansionTileState>> _expansionKeys = new List();
  List<Keyword> _selectedKeywords = new List();

  List<KeysSet> _keySets;
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
    _keySets = KeysSet.getKeysSetsByFlyerType(flyerType: widget.flyerType);

    print('_keysets.length = ${_keySets.length} ,, and _keySets[0].groupID is : ${_keySets[0].groupID}');

    _selectedKeywords = widget.selectedKeywords;
    generateExpansionKeys();
    super.initState();
  }
// -----------------------------------------------------------------------------
  void generateExpansionKeys(){
    _keySets.forEach((x) {
      _expansionKeys.add(new GlobalKey());
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

  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    double _selectedKeywordsZoneHeight = 80;
    double _keywordsZoneHeight =  _screenHeight - Ratioz.stratosphere - _selectedKeywordsZoneHeight;

    return MainLayout(
      pageTitle: 'Select Keywords',
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
          ),

          /// keywords zone
          Container(
            width: _screenWidth,
            height: _keywordsZoneHeight,
            alignment: Alignment.topCenter,
            // color: Colorz.Yellow200,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),

                itemCount: _keySets.length,
                itemBuilder: (ctx, index){
                  return

                    OnePageExpansionTile(
                      tileWidth: _screenWidth - (2 * Ratioz.appBarMargin),
                      tileMaxHeight: _keywordsZoneHeight * 0.7,
                      keysSet:  _keySets[index],
                      selectedKeywords: _selectedKeywords,
                      onKeywordTap: null,
                      onGroupTap: null,
                    );
                }
                ),
          ),

          // BldrsExpansionTile(
          //   height: Scale.superScreenHeight(context) * 0.5,
          //   key: _expansionKeys[0],
          //   // icon: KeywordModel.getImagePath(_filterID),
          //   iconSizeFactor: 0.5,
          //   keysSet: KeysSet.architecturalStylesKeysSet,
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
          //           keysSet: null,
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
