import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/flyer_browser/bldrs_expansion_tile.dart';
import 'package:bldrs/xxx_LABORATORY/flyer_browser/flyer_keyz.dart';
import 'package:bldrs/xxx_LABORATORY/flyer_browser/keyword_model.dart';
import 'package:flutter/material.dart';

class KeywordsManager extends StatefulWidget {
  @override
  _KeywordsManagerState createState() => _KeywordsManagerState();
}

class _KeywordsManagerState extends State<KeywordsManager> {
  bool _isExpanded = false;
  List<GlobalKey<BldrsExpansionTileState>> _expansionKeys = new List();
  String _subtitle;
  List<KeywordModel> _keywords = KeywordModel.bldrsKeywords;
  List<String> _filtersIDs = new List();
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
    arrangeFilters();
    generateExpansionKeys();
    super.initState();
  }
// -----------------------------------------------------------------------------
  void arrangeFilters(){
    _keywords.forEach((keyword) {
      if (!_filtersIDs.contains(keyword.filterID)){
        _filtersIDs.add(keyword.filterID);
      }
    });
    print('${_filtersIDs.length} Filters arranged : $_filtersIDs');
  }
// -----------------------------------------------------------------------------
  void generateExpansionKeys(){
    _filtersIDs.forEach((id) {
      _expansionKeys.add(new GlobalKey());
    });
  }
// -----------------------------------------------------------------------------
  List<KeywordModel> getKeywordModels(String filterID){
    List<KeywordModel> _keywordModels = new List();

    _keywords.forEach((key) {
      if(key.filterID == filterID){
        _keywordModels.add(key);
      }
    });

    print('keywords of $filterID : $_keywordModels');

    return _keywordModels;
  }
// -----------------------------------------------------------------------------
  List<String> getKeywordIDs(List<KeywordModel> _keywordModels){
    List<String> _keywordIDs = new List();

    _keywordModels.forEach((key) {
      _keywordIDs.add(key.id);
    });

    return _keywordIDs;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    String _filterName = 'property Type';
    String _subTitle = 'propertyType';
    String _icon = Iconz.Plus;
    double _iconSizeFactor = 0.6;




    return MainLayout(
      pageTitle: 'Keywords And Filters Manager',
      appBarBackButton: true,
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidsYellow,
      loading: _loading,
      sky: Sky.Night,
      tappingRageh: (){
        // if(_isExpanded){
        //   _expansionTileKey.currentState.collapse();
        // } else {
        //   _expansionTileKey.currentState.expand();
        // }

        setState(() {
          _isExpanded =! _isExpanded;
        });

      },
      layoutWidget: Container(
        width: Scale.superScreenWidth(context), // this dictates overall width
        child: ListView(
          children: [

            Stratosphere(),

            ...List.generate(
                _filtersIDs.length,
                    (index){
                  String _filterID = _filtersIDs[index];
                  List<KeywordModel> _keywordModels = getKeywordModels(_filterID);
                  List<String> _keywordsIDs = getKeywordIDs(_keywordModels);

                  return
                    BldrsExpansionTile(
                      height: 500,
                      key: _expansionKeys[index],
                      title: _filterID,
                      subTitle: 'subtitle',
                      // icon: KeywordModel.getImagePath(_filterID),
                      iconSizeFactor: 0.5,
                      keywords: _keywordsIDs,
                      onKeywordTap: (String selectedKeyword){
                        setState(() {
                          _subtitle = selectedKeyword;
                        });
                      },
                    );

            }),

            // BldrsExpansionTile(
            //   height: 500,
            //   key: _expansionTileKey,
            //   title: 'Property type',
            //   subTitle: _subtitle,
            //   icon: Iconz.XLarge,
            //   iconSizeFactor: 0.5,
            //   keywords: _keywords,
            //   onKeywordTap: (String selectedKeyword){
            //     setState(() {
            //       _subtitle = selectedKeyword;
            //     });
            //     },
            // ),
            //
            // BldrsExpansionTile(
            //   height: 500,
            //   key: _expansionTileKey2,
            //   title: 'Property type',
            //   subTitle: _subtitle,
            //   icon: Iconz.XLarge,
            //   iconSizeFactor: 0.5,
            //   keywords: _keywords,
            //   onKeywordTap: (String selectedKeyword){
            //     setState(() {
            //       _subtitle = selectedKeyword;
            //     });
            //   },
            // ),

            PyramidsHorizon(heightFactor: 5,),

          ],
        ),
      ),
    );
  }
}
