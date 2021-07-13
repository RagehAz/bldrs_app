import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/xxx_LABORATORY/flyer_browser/bldrs_expansion_tile.dart';
import 'package:flutter/material.dart';

class KeywordsManager extends StatefulWidget {
  @override
  _KeywordsManagerState createState() => _KeywordsManagerState();
}

class _KeywordsManagerState extends State<KeywordsManager> {
  bool _isExpanded = false;
  List<GlobalKey<BldrsExpansionTileState>> _expansionKeys = new List();
  List<Keyword> _selectedKeywords = new List();
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
    _filtersIDs = <String>[];
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
  List<String> getKeywordIDs(List<Keyword> _keywordModels){
    List<String> _keywordIDs = new List();

    _keywordModels.forEach((key) {
      _keywordIDs.add(key.keywordID);
    });

    return _keywordIDs;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pageTitle: 'Keywords And Filters Manager',
      // appBarBackButton: true,
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidsYellow,
      loading: _loading,
      tappingRageh: (){

        List<Keyword> _result = Keyword.getKeywordsBySection(Section.Products);
        //

        _result.forEach((key) {
          print('KeywordModel(id: \'${key.keywordID}\', filterID: \'${key.flyerType}\', groupID: \'${key.groupID}\', subGroupID: \'${key.subGroupID}\', uses: 0),');
        });


      },
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
                      filterModel: null,
                      selectedKeywords: _selectedKeywords,
                      onKeywordTap: (Keyword selectedKeyword){

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
