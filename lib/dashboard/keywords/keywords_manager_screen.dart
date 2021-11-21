import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:flutter/material.dart';

class KeywordsManager extends StatefulWidget {

  @override
  _KeywordsManagerState createState() => _KeywordsManagerState();
}

class _KeywordsManagerState extends State<KeywordsManager> {
  // List<Keyword> _selectedKeywords = [];
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final List<Keyword> _allKeywords = Keyword.bldrsKeywords();

    // final double _screenWidth  = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);

    // const double _keywordButtonHeight = 90;
    // final double _buttonWidth = _screenWidth * 0.8;
    // const double _spacing = Ratioz.appBarPadding;

    return MainLayout(
      pageTitle: 'All Keywords',
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidsYellow,
      skyType: SkyType.Night,
      layoutWidget: Container(
        width: Scale.superScreenWidth(context) - Ratioz.appBarMargin * 2, // this dictates overall width
        // child: Scrollbar(
        //   isAlwaysShown: false,
        //   radius: Radius.circular(Ratioz.appBarPadding * 0.5),
        //   thickness: Ratioz.appBarPadding,
        //   // controller: ,
        //   // key: ,
        //   // child: ListView.builder(
        //   //   itemCount: _allKeywords.length,
        //   //   physics: const BouncingScrollPhysics(),
        //   //   padding: const EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.stratosphere),
        //   //   itemExtent: _keywordButtonHeight + _spacing,
        //   //   itemBuilder: (ctx, index){
        //   //
        //   //     final Keyword _keyword = _allKeywords[index];
        //   //     final String _keywordID = _allKeywords[index].keywordID;
        //   //     final String _icon = Keyword.getImagePath(_keyword);
        //   //     final String _keywordName = Keyword.getKeywordNameByKeywordID(context, _keywordID);
        //   //     final String _groupID = _keyword.groupID;
        //   //     final String _subGroupID = _keyword.subGroupID == '' ? '...' : _keyword.subGroupID;
        //   //     // int _uses = _keyword.uses;
        //   //     // FlyerType _keywordFlyerType = _keyword.flyerType;
        //   //     // List<Name> _keywordNames = _keyword.names;
        //   //     final String _arabicName = Keyword.getKeywordArabicName(_keyword);
        //   //
        //   //     return
        //   //         Container(
        //   //           width: _buttonWidth,
        //   //           // height: _keywordButtonHeight,
        //   //           margin: const EdgeInsets.only(bottom: _spacing),
        //   //           decoration: BoxDecoration(
        //   //             borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner),
        //   //             color: Colorz.bloodTest,
        //   //           ),
        //   //           child: Row(
        //   //             mainAxisAlignment: MainAxisAlignment.start,
        //   //             crossAxisAlignment: CrossAxisAlignment.start,
        //   //             children: <Widget>[
        //   //
        //   //               DreamBox(
        //   //                 height: _keywordButtonHeight,
        //   //                 width: _keywordButtonHeight,
        //   //                 icon: _icon,
        //   //                 bubble: false,
        //   //               ),
        //   //
        //   //               const SizedBox(
        //   //                 width: _spacing,
        //   //               ),
        //   //
        //   //               Column(
        //   //                 mainAxisAlignment: MainAxisAlignment.start,
        //   //                 crossAxisAlignment: CrossAxisAlignment.start,
        //   //                 children: <Widget>[
        //   //
        //   //                   /// index - ID
        //   //                   SuperVerse(
        //   //                     verse: '$index : ID : $_keywordID',
        //   //                     size: 1,
        //   //                   ),
        //   //
        //   //                   /// english name
        //   //                   SuperVerse(
        //   //                     verse: _keywordName,
        //   //                     size: 2,
        //   //                   ),
        //   //
        //   //                   /// arabic name
        //   //                   SuperVerse(
        //   //                     verse: _arabicName,
        //   //                     size: 1,
        //   //                   ),
        //   //
        //   //                   /// GroupID
        //   //                   SuperVerse(
        //   //                     verse: _groupID,
        //   //                     size: 0,
        //   //                     weight: VerseWeight.thin,
        //   //                   ),
        //   //
        //   //
        //   //                   /// subGroupID
        //   //                   SuperVerse(
        //   //                     verse: _subGroupID,
        //   //                     size: 0,
        //   //                     weight: VerseWeight.thin,
        //   //                   ),
        //   //
        //   //
        //   //                 ],
        //   //               ),
        //   //             ],
        //   //           ),
        //   //         );
        //   //   },
        //   //
        //   // ),
        // ),
      ),
    );
  }
}
