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
  List<KeywordModel> _selectedKeywords = new List();
  List<String> _filtersIDs;
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
    _filtersIDs = KeywordModel.getFiltersIDs();
    generateExpansionKeys();
    super.initState();
  }
// -----------------------------------------------------------------------------
  void generateExpansionKeys(){
    _filtersIDs.forEach((id) {
      _expansionKeys.add(new GlobalKey());
    });
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

    return MainLayout(
      pageTitle: 'Keywords And Filters Manager',
      appBarBackButton: true,
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidsYellow,
      loading: _loading,
      sky: Sky.Night,
      // tappingRageh: (){
      //   // if(_isExpanded){
      //   //   _expansionTileKey.currentState.collapse();
      //   // } else {
      //   //   _expansionTileKey.currentState.expand();
      //   // }
      //
      //   setState(() {
      //     _isExpanded =! _isExpanded;
      //   });
      //
      // },
      layoutWidget: Container(
        width: Scale.superScreenWidth(context) - Ratioz.appBarMargin * 2, // this dictates overall width
        child: ListView(
          children: <Widget>[

            Stratosphere(),

            ...List.generate(
                _filtersIDs.length,
                    (index){

                  String _filterID = _filtersIDs[index];

                  return
                    BldrsExpansionTile(
                      height: Scale.superScreenHeight(context) * 0.5,
                      key: _expansionKeys[index],
                      // icon: KeywordModel.getImagePath(_filterID),
                      iconSizeFactor: 0.5,
                      filterID: _filterID,
                      selectedKeywords: _selectedKeywords,
                      onKeywordTap: (KeywordModel selectedKeyword){

                        if (_selectedKeywords.contains(selectedKeyword)){
                          setState(() {
                            print('a77a');
                          _selectedKeywords.remove(selectedKeyword);
                          });
                        }

                        else {
                          setState(() {
                            _selectedKeywords.add(selectedKeyword);
                          });
                        }

                      },

                      onGroupTap: (String groupID){

                      },
                    );

            }),

            PyramidsHorizon(heightFactor: 5,),

          ],
        ),
      ),
    );
  }
}
