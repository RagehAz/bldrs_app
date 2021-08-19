import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/secondary_models/namez_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class KeywordsManager extends StatefulWidget {

  @override
  _KeywordsManagerState createState() => _KeywordsManagerState();
}

class _KeywordsManagerState extends State<KeywordsManager> {
  List<Keyword> _selectedKeywords = new List();
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
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    List<Keyword> _allKeywords = Keyword.bldrsKeywords();

    double _screenWidth  = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);

    double _keywordButtonHeight = 90;
    double _buttonWidth = _screenWidth * 0.8;
    const double _spacing = Ratioz.appBarPadding;

    return MainLayout(
      pageTitle: 'All Keywords',
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidsYellow,
      loading: _loading,
      sky: Sky.Night,
      layoutWidget: Container(
        width: Scale.superScreenWidth(context) - Ratioz.appBarMargin * 2, // this dictates overall width
        child: Scrollbar(
          isAlwaysShown: false,
          radius: Radius.circular(Ratioz.appBarPadding * 0.5),
          thickness: Ratioz.appBarPadding,
          // controller: ,
          // key: ,
          child: ListView.builder(
            itemCount: _allKeywords.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.stratosphere),
            itemExtent: _keywordButtonHeight + _spacing,
            itemBuilder: (ctx, index){

              Keyword _keyword = _allKeywords[index];
              String _keywordID = _allKeywords[index].keywordID;
              String _icon = Keyword.getImagePath(_keyword);
              String _keywordName = Keyword.getKeywordNameByKeywordID(context, _keywordID);
              String _groupID = _keyword.groupID;
              String _subGroupID = _keyword.subGroupID == '' ? '...' : _keyword.subGroupID;
              int _uses = _keyword.uses;
              FlyerType _keywordFlyerType = _keyword.flyerType;
              List<Name> _keywordNames = _keyword.names;
              String _arabicName = Keyword.getKeywordArabicName(_keyword);

              return
                  Container(
                    width: _buttonWidth,
                    height: _keywordButtonHeight,
                    margin: const EdgeInsets.only(bottom: _spacing),
                    decoration: BoxDecoration(
                      borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner),
                      color: Colorz.BloodTest,
                    ),
                    child: Row(
                      children: <Widget>[

                        DreamBox(
                          height: _keywordButtonHeight,
                          width: _keywordButtonHeight,
                          icon: _icon,
                          bubble: false,
                        ),

                        SizedBox(
                          width: _spacing,
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            /// index - ID
                            SuperVerse(
                              verse: '$index : ID : $_keywordID',
                              size: 1,
                            ),

                            /// name
                            SuperVerse(
                              verse: _keywordName,
                              size: 2,
                            ),

                            /// GroupID
                            SuperVerse(
                              verse: _groupID,
                              size: 1,
                              weight: VerseWeight.thin,
                            ),


                            /// subGroupID
                            SuperVerse(
                              verse: _subGroupID,
                              size: 1,
                              weight: VerseWeight.thin,
                            ),

                            SuperVerse(
                              verse: _arabicName,
                            ),

                          ],
                        ),
                      ],
                    ),
                  );
            },

          ),
        ),
      ),
    );
  }
}
