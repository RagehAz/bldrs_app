import 'package:bldrs/controllers/theme/keywordz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/keywords/filter_model.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/keywords/group_model.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/widgets/flyer/stacks/flyer_stack.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupWall extends StatelessWidget {
  final Sequence groupModel;
  final FlyerType flyersType;

  GroupWall({
    @required this.groupModel,
    @required this.flyersType,
  });

  String _stackTitle({BuildContext context, Sequence groupModel, int index}){
    String _stackTitle;

    /// in crafts groups, second keywords are zone areas
    // List<GroupModel> _craftsGroups = GroupModel.craftsGroups(context);
    // bool _firstKeyIDisFromCraftsGroup = GroupModel.groupsContainThisFirstKeyID(
    //     context: context,
    //     groups: _craftsGroups,
    //     firstKeyID: groupModel.firstKeyID
    // );

    bool _groupSecondKeysAreZoneAreas = Sequence.sequenceSecondKeysAreZoneDistricts(groupModel);

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);
    String _provinceName = _countryPro.getProvinceNameWithCurrentLanguageIfPossible(context, _countryPro.currentProvinceID);

    if(_groupSecondKeysAreZoneAreas == true){
      String _areaName = _countryPro.getDistrictNameWithCurrentLanguageIfPossible(context, groupModel.secondKeywords.keywordModels[index].keywordID);
      String _keywordName = KeywordModel.getKeywordNameByKeywordID(context, groupModel.firstKeyID);

      _stackTitle = '$_keywordName - ${Wordz.inn(context)} $_areaName , $_provinceName';
    }

    else if (groupModel?.secondKeywords?.keywordModels == null){
      List<KeywordModel> _keywordsByGroupID = KeywordModel.getKeywordsByGroupID(groupModel.firstKeyID);
      String _keywordName = KeywordModel.getKeywordNameByKeywordID(context, _keywordsByGroupID[index].keywordID);
      _stackTitle = '$_keywordName - ${Wordz.inn(context)} $_provinceName';
    }

    else {
      String _keywordID = groupModel.secondKeywords.keywordModels[index].keywordID;
      KeywordModel _keyword = KeywordModel.getKeywordByKeywordID(_keywordID);
      String _keywordName = KeywordModel.getKeywordNameByKeywordID(context, _keywordID);
      String _groupName = KeywordModel.getKeywordNameByKeywordID(context, groupModel.firstKeyID);
      _stackTitle = '$_groupName - ${_keywordName} - ${Wordz.inn(context)} $_provinceName';
    }

    return _stackTitle;
  }

  void _flyerOnTap({TinyFlyer tinyFlyer, dynamic firstKeyword, dynamic secondKeyword}){

    if (secondKeyword == _newFlyersTag) {
      print ('flyer is from the new flyers stack');
    }
    else {

      print('flyerID : ${tinyFlyer.flyerID} - ${tinyFlyer.flyerType} ---------- ');
      print('first keyword : ${firstKeyword}');
      print('second Keyword : ${secondKeyword}');
    }

  }

  static const String _newFlyersTag = 'newFlyers';

  @override
  Widget build(BuildContext context) {

    Widget _spacer = SizedBox(height: Ratioz.appBarMargin, width: Ratioz.appBarMargin,);

    List<KeywordModel> _keywordsByGroupID = KeywordModel.getKeywordsByGroupID(groupModel.firstKeyID);

    print(groupModel.firstKeyID);
    print(_keywordsByGroupID);

    List<Widget> _groupWallWidgets = <Widget>[

      _spacer,

      FlyerStack(
        flyersType: FlyerType.Property,
        title: 'New ${groupModel.firstKeyID} flyers in Heliopolis',
        tinyFlyers: TinyFlyer.dummyTinyFlyers(),
        flyerOnTap: (tinyFlyer) => _flyerOnTap(
          tinyFlyer: tinyFlyer,
          firstKeyword: groupModel.firstKeyID,
          secondKeyword: _newFlyersTag,
        ),
      ),

      _spacer,
      _spacer,

      /// If groupModel requires second keywords to generate flyers ( keyword x another keyword )
      if(groupModel?.secondKeywords?.keywordModels != null)
      ...List.generate(
          groupModel.secondKeywords.keywordModels.length,
              (index){

                String _firstKeyword = groupModel?.firstKeyID;
                FilterModel _secondKeywords = groupModel?.secondKeywords;
                dynamic _secondKeyword = _secondKeywords == null ? null : groupModel?.secondKeywords?.keywordModels[index];

                return
              Padding(
                padding: const EdgeInsets.only(bottom: Ratioz.appBarMargin * 2),
                child: FlyerStack(
                  flyersType: null,
                  title: _stackTitle(context: context, groupModel: groupModel, index: index),
                  tinyFlyers: TinyFlyer.dummyTinyFlyers(),
                  flyerOnTap: (tinyFlyer) => _flyerOnTap(
                    tinyFlyer: tinyFlyer,
                    firstKeyword: _firstKeyword,
                    secondKeyword: _secondKeyword,
                  ),
                ),
              );
              }
      ),

      /// If groupModel has its keywords straight nested (filterID - groupID - subGroupID - keywordID)
      if(groupModel?.secondKeywords?.keywordModels == null)
        ...List.generate(
          _keywordsByGroupID.length,
              (index){

            String _firstKeyword = groupModel?.firstKeyID;
            FilterModel _secondKeywords = groupModel?.secondKeywords;
            dynamic _secondKeyword = _secondKeywords == null ? null : groupModel?.secondKeywords?.keywordModels[index];

            return
              Padding(
                padding: const EdgeInsets.only(bottom: Ratioz.appBarMargin * 2),
                child: FlyerStack(
                  flyersType: null,
                  titleIcon: KeywordModel.getImagePath(_keywordsByGroupID[index].keywordID),
                  title: _stackTitle(context: context, groupModel: groupModel, index: index),//'${KeywordModel.getKeywordNameByKeywordID(context, _keywordsByGroupID[index].keywordID)} in Cairo',
                  tinyFlyers: TinyFlyer.dummyTinyFlyers(),
                  flyerOnTap: (tinyFlyer) => _flyerOnTap(
                    tinyFlyer: tinyFlyer,
                    firstKeyword: _firstKeyword,
                    secondKeyword: _secondKeyword,
                  ),
                ),
              );
              }
        ),

      PyramidsHorizon(heightFactor: 5,),

    ];

    return ListView.builder(
      padding: EdgeInsets.only(top: Ratioz.stratosphere),
      scrollDirection: Axis.vertical,
      itemCount: _groupWallWidgets.length,

      itemBuilder: (ctx, index){

        return
          _groupWallWidgets[index];
      },
    );
  }
}
