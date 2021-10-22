import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/helpers/namez_model.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:flutter/material.dart';

class RandomTestSpace extends StatefulWidget {
final double flyerBoxWidth;

RandomTestSpace({
  @required this.flyerBoxWidth,
});

  @override
  _RandomTestSpaceState createState() => _RandomTestSpaceState();
}

class _RandomTestSpaceState extends State<RandomTestSpace> {
  // List<int> _list = <int>[1,2,3,4,5,6,7,8];
  // int _loops = 0;
  // Color _color = Colorz.BloodTest;
  // SuperFlyer _flyer;
  // bool _thing;

  ScrollController _ScrollController;

// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if(mounted){

      if (function == null){
        setState(() {
          _loading = !_loading;
        });
      }

      else {
        setState(() {
          _loading = !_loading;
          function();
        });
      }

    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _ScrollController = new ScrollController(initialScrollOffset: 0, keepScrollOffset: true);
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async{

        /// do Futures here

        _triggerLoading(
          function: (){
            /// set new values here
          }
        );
      });


    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
//     double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    // double _gWidth = _screenWidth * 0.4;
    // double _gHeight = _screenWidth * 0.6;


    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      loading: _loading,
      tappingRageh: (){
        print('wtf');
      },

      appBarRowWidgets: <Widget>[

      ],

      layoutWidget: Center(
        child: MaxBounceNavigator(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            controller: _ScrollController,
            children: <Widget>[

              const Stratosphere(),

              WideButton(
                  color: Colorz.bloodTest,
                  verse: 'Properties keys',
                  icon: Iconz.Share,
                  onTap: () async {

                    _triggerLoading();

                    /// do things here

                    List<Keyword> _keywords = Keyword.getKeywordsByGroupID('group_ppt_type');

                    List<String> _subGroupIDs = Keyword.getSubGroupsIDsFromKeywords(keywords: _keywords);

                    for (int i = 0; i< _subGroupIDs.length; i++){
                      final String _num = Numeric.getNumberWithinDigits(num: i + 1, digits : 4);

                      final String _subGroupID = _subGroupIDs[i];
                      final String _enName = Keyword.getSubGroupNameBySubGroupIDAndLingoCode(context: context, lingoCode: 'en', subGroupID: _subGroupID);
                      final String _arName = Keyword.getSubGroupNameBySubGroupIDAndLingoCode(context: context, lingoCode: 'ar', subGroupID: _subGroupID);

                      final List<Keyword> _keywords = Keyword.getKeywordsBySubGroupID(_subGroupID);

                      print('$_num :             // -----------------------------------------------');
                      print('$_num : /// $_enName');

                      print('$_num : const Chain(');
                      print('$_num : id: \'${_subGroupID}\',');
                      print('$_num : names: <Name>[Name(code: \'en\', value: \'${_enName}\'), Name(code: \'ar\', value: \'${_arName}\')],');
                      print('$_num : sons: const <KW>[');


                      _keywords.forEach((kw) {

                        final String _kwID = kw.keywordID;
                        final String _kwEnName = Keyword.getKeywordNameByKeywordID(context, _kwID);
                        final String _kwArName = Keyword.getKeywordArabicName(kw);

                        String _names = '<Name>[Name(code: \'en\', value: \'${_kwEnName}\'), Name(code: \'ar\', value: \'${_kwArName}\')],';
                        print('$_num : KW(id: \'${_kwID}\', names: ${_names}),');

                      });

                      print('$_num : ],');
                      print('$_num : ),');

                    };


                    _triggerLoading();

                  }
              ),

              WideButton(
                  color: Colorz.bloodTest,
                  verse: 'Designs keys',
                  icon: Iconz.Share,
                  onTap: () async {

                    _triggerLoading();

                    /// do things here

                    List<Keyword> _keywords = Keyword.getKeywordsByGroupID('group_dz_type');


                    for (int i = 0; i< _keywords.length; i++){
                      final String _num = Numeric.getNumberWithinDigits(num: i + 1, digits : 4);

                      final Keyword _keyword = _keywords[i];


                        final String _kwID = _keyword.keywordID;
                        final String _kwEnName = Keyword.getKeywordNameByKeywordID(context, _kwID);
                        final String _kwArName = Keyword.getKeywordArabicName(_keyword);

                        // print('$_num :             // -----------------------------------------------');
                        // print('$_num : /// $_kwEnName');

                        final String _names = '<Name>[Name(code: \'en\', value: \'${_kwEnName}\'), Name(code: \'ar\', value: \'${_kwArName}\')],';
                        print('$_num : KW(id: \'${_kwID}\', names: ${_names}),');


                    };


                    _triggerLoading();

                  }
              ),

              WideButton(
                  color: Colorz.bloodTest,
                  verse: 'crafts keys',
                  icon: Iconz.Share,
                  onTap: () async {

                    _triggerLoading();

                    /// do things here

                    List<Keyword> _keywords = Keyword.getKeywordsByGroupID('group_craft_trade');


                    for (int i = 0; i< _keywords.length; i++){
                      final String _num = Numeric.getNumberWithinDigits(num: i + 1, digits : 4);

                      final Keyword _keyword = _keywords[i];


                      final String _kwID = _keyword.keywordID;
                      final String _kwEnName = Keyword.getKeywordNameByKeywordID(context, _kwID);
                      final String _kwArName = Keyword.getKeywordArabicName(_keyword);

                      // print('$_num :             // -----------------------------------------------');
                      // print('$_num : /// $_kwEnName');

                      final String _names = '<Name>[Name(code: \'en\', value: \'${_kwEnName}\'), Name(code: \'ar\', value: \'${_kwArName}\')],';
                      print('$_num : KW(id: \'${_kwID}\', names: ${_names}),');


                    };


                    _triggerLoading();

                  }
              ),

              WideButton(
                  color: Colorz.bloodTest,
                  verse: 'Products keys',
                  icon: Iconz.Share,
                  onTap: () async {

                    _triggerLoading();

                    /// do things here

                    List<String> _groupsIDs = Keyword.getGroupsIDsByFlyerType(FlyerType.product);


                    for (int i = 0; i< _groupsIDs.length; i++){

                      final String _groupID = _groupsIDs[i];
                      final Namez _groupNames = Keyword.getGroupNamezByGroupID(_groupID);
                      final List<Name> _names = _groupNames.names;
                      final String _groupNameEn = Name.getNameByLingoFromNames(names: _names, lingoCode: 'en');
                      final String _groupNameAr = Name.getNameByLingoFromNames(names: _names, lingoCode: 'ar');


                      print('            // -----------------------------------------------');
                      print('/// $_groupNameEn');

                      print('const Chain(');
                      print('id: \'${_groupID}\',');
                      print('names: <Name>[Name(code: \'en\', value: \'${_groupNameEn}\'), Name(code: \'ar\', value: \'${_groupNameAr}\')],');
                      print('sons: const <Chain>[');

                      final List<Keyword> _groupKeywords = Keyword.getKeywordsByGroupID(_groupID);
                      final List<String> _subGroupsIDs = Keyword.getSubGroupsIDsFromKeywords(keywords: _groupKeywords);

                      _subGroupsIDs.forEach((subGroupID) {

                        final String _subGroupNameEn = Keyword.getSubGroupNameBySubGroupIDAndLingoCode(subGroupID: subGroupID, lingoCode: 'en', context: context);
                        final String _subGroupNameAr = Keyword.getSubGroupNameBySubGroupIDAndLingoCode(subGroupID: subGroupID, lingoCode: 'ar', context: context);
                        print('            // ----------------------------------');
                        print('/// $_subGroupNameEn');

                        print('const Chain(');
                        print('id: \'${subGroupID}\',');
                        print('names: <Name>[Name(code: \'en\', value: \'${_subGroupNameEn}\'), Name(code: \'ar\', value: \'${_subGroupNameAr}\')],');
                        print('sons: const <KW>[');

                        List<Keyword> _keywords = Keyword.getKeywordsBySubGroupID(subGroupID);

                        _keywords.forEach((kw) {

                          final String _kwID = kw.keywordID;
                          final String _kwEnName = Keyword.getKeywordNameByKeywordID(context, _kwID);
                          final String _kwArName = Keyword.getKeywordArabicName(kw);

                          final String _names = '<Name>[Name(code: \'en\', value: \'${_kwEnName}\'), Name(code: \'ar\', value: \'${_kwArName}\')],';
                          print('KW(id: \'${_kwID}\', names: ${_names}),');

                        });

                        print('],');
                        print('),');

                      });

                      print('],');
                      print('),');

                    };


                    _triggerLoading();

                  }
              ),

              WideButton(
                  color: Colorz.bloodTest,
                  verse: 'Equipment keys',
                  icon: Iconz.Share,
                  onTap: () async {

                    _triggerLoading();

                    /// do things here

                    List<String> _groupsIDs = Keyword.getGroupsIDsByFlyerType(FlyerType.equipment);


                    for (int i = 0; i< _groupsIDs.length; i++){

                      final String _groupID = _groupsIDs[i];
                      final Namez _groupNames = Keyword.getGroupNamezByGroupID(_groupID);
                      final List<Name> _names = _groupNames.names;
                      final String _groupNameEn = Name.getNameByLingoFromNames(names: _names, lingoCode: 'en');
                      final String _groupNameAr = Name.getNameByLingoFromNames(names: _names, lingoCode: 'ar');


                      print('            // -----------------------------------------------');
                      print('/// $_groupNameEn');

                      print('const Chain(');
                      print('id: \'${_groupID}\',');
                      print('names: <Name>[Name(code: \'en\', value: \'${_groupNameEn}\'), Name(code: \'ar\', value: \'${_groupNameAr}\')],');
                      print('sons: const <Chain>[');

                      final List<Keyword> _groupKeywords = Keyword.getKeywordsByGroupID(_groupID);
                      final List<String> _subGroupsIDs = Keyword.getSubGroupsIDsFromKeywords(keywords: _groupKeywords);

                      _subGroupsIDs.forEach((subGroupID) {

                        final String _subGroupNameEn = Keyword.getSubGroupNameBySubGroupIDAndLingoCode(subGroupID: subGroupID, lingoCode: 'en', context: context);
                        final String _subGroupNameAr = Keyword.getSubGroupNameBySubGroupIDAndLingoCode(subGroupID: subGroupID, lingoCode: 'ar', context: context);
                        print('            // ----------------------------------');
                        print('/// $_subGroupNameEn');

                        print('const Chain(');
                        print('id: \'${subGroupID}\',');
                        print('names: <Name>[Name(code: \'en\', value: \'${_subGroupNameEn}\'), Name(code: \'ar\', value: \'${_subGroupNameAr}\')],');
                        print('sons: const <KW>[');

                        List<Keyword> _keywords = Keyword.getKeywordsBySubGroupID(subGroupID);

                        _keywords.forEach((kw) {

                          final String _kwID = kw.keywordID;
                          final String _kwEnName = Keyword.getKeywordNameByKeywordID(context, _kwID);
                          final String _kwArName = Keyword.getKeywordArabicName(kw);

                          final String _names = '<Name>[Name(code: \'en\', value: \'${_kwEnName}\'), Name(code: \'ar\', value: \'${_kwArName}\')],';
                          print('KW(id: \'${_kwID}\', names: ${_names}),');

                        });

                        print('],');
                        print('),');

                      });

                      print('],');
                      print('),');

                    };


                    _triggerLoading();

                  }
              ),

              WideButton(
                  color: Colorz.bloodTest,
                  verse: 'groups keywords with no sub groups',
                  icon: Iconz.Share,
                  onTap: () async {

                    _triggerLoading();

                    /// do things here

                    String _groupID = 'group_ppt_license';

                    List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
                    final Namez _groupNames = Keyword.getGroupNamezByGroupID(_groupID);
                    final List<Name> _names = _groupNames.names;
                    final String _groupNameEn = Name.getNameByLingoFromNames(names: _names, lingoCode: 'en');
                    final String _groupNameAr = Name.getNameByLingoFromNames(names: _names, lingoCode: 'ar');


                    print('            // -----------------------------------------------');
                    print('/// $_groupNameEn');
                    print('const Chain(');
                    print('id: \'${_groupID}\',');
                    print('names: <Name>[Name(code: \'en\', value: \'${_groupNameEn}\'), Name(code: \'ar\', value: \'${_groupNameAr}\')],');
                    print('sons: const <KW>[');



                    for (int i = 0; i< _keywords.length; i++){

                      final Keyword _keyword = _keywords[i];


                      final String _kwID = _keyword.keywordID;
                      final String _kwEnName = Keyword.getKeywordNameByKeywordID(context, _kwID);
                      final String _kwArName = Keyword.getKeywordArabicName(_keyword);

                      // print('$_num :             // -----------------------------------------------');
                      // print('$_num : /// $_kwEnName');

                      final String _names = '<Name>[Name(code: \'en\', value: \'${_kwEnName}\'), Name(code: \'ar\', value: \'${_kwArName}\')],';
                      print('KW(id: \'${_kwID}\', names: ${_names}),');

                    };

                    print('],');
                    print('),');

                    _triggerLoading();

                  }
              ),

              WideButton(
                  color: Colorz.bloodTest,
                  verse: 'groups keywords with sub groups',
                  icon: Iconz.Share,
                  onTap: () async {

                    _triggerLoading();

                    final String _groupID = 'group_space_type';
                    final Namez _groupNames = Keyword.getGroupNamezByGroupID(_groupID);
                    final List<Name> _names = _groupNames.names;
                    final String _groupNameEn = Name.getNameByLingoFromNames(names: _names, lingoCode: 'en');
                    final String _groupNameAr = Name.getNameByLingoFromNames(names: _names, lingoCode: 'ar');


                    print('            // -----------------------------------------------');
                    print('/// $_groupNameEn');

                    print('const Chain(');
                    print('id: \'${_groupID}\',');
                    print('names: <Name>[Name(code: \'en\', value: \'${_groupNameEn}\'), Name(code: \'ar\', value: \'${_groupNameAr}\')],');
                    print('sons: const <Chain>[');

                    final List<Keyword> _groupKeywords = Keyword.getKeywordsByGroupID(_groupID);
                    final List<String> _subGroupsIDs = Keyword.getSubGroupsIDsFromKeywords(keywords: _groupKeywords);

                    _subGroupsIDs.forEach((subGroupID) {

                      final String _subGroupNameEn = Keyword.getSubGroupNameBySubGroupIDAndLingoCode(subGroupID: subGroupID, lingoCode: 'en', context: context);
                      final String _subGroupNameAr = Keyword.getSubGroupNameBySubGroupIDAndLingoCode(subGroupID: subGroupID, lingoCode: 'ar', context: context);
                      print('            // ----------------------------------');
                      print('/// $_subGroupNameEn');

                      print('const Chain(');
                      print('id: \'${subGroupID}\',');
                      print('names: <Name>[Name(code: \'en\', value: \'${_subGroupNameEn}\'), Name(code: \'ar\', value: \'${_subGroupNameAr}\')],');
                      print('sons: const <KW>[');

                      List<Keyword> _keywords = Keyword.getKeywordsBySubGroupID(subGroupID);

                      _keywords.forEach((kw) {

                        final String _kwID = kw.keywordID;
                        final String _kwEnName = Keyword.getKeywordNameByKeywordID(context, _kwID);
                        final String _kwArName = Keyword.getKeywordArabicName(kw);

                        final String _names = '<Name>[Name(code: \'en\', value: \'${_kwEnName}\'), Name(code: \'ar\', value: \'${_kwArName}\')],';
                        print('KW(id: \'${_kwID}\', names: ${_names}),');

                      });

                      print('],');
                      print('),');

                    });

                    print('],');
                    print('),');


                    _triggerLoading();

                  }
              ),


            ],
          ),
        ),
      ),
    );
  }


}