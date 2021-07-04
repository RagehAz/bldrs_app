import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/keywords/group_model.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/views/widgets/flyer/stacks/flyer_stack.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class GroupWall extends StatelessWidget {
  final GroupModel groupModel;
  final FlyerType flyersType;

  GroupWall({
    @required this.groupModel,
    @required this.flyersType,
  });

  @override
  Widget build(BuildContext context) {

    Widget _spacer = SizedBox(height: Ratioz.appBarMargin, width: Ratioz.appBarMargin,);

    List<KeywordModel> _keywordsByGroupID = KeywordModel.getKeywordsByGroupID(groupModel.firstKeyword);

    print(groupModel.firstKeyword);
    print(_keywordsByGroupID);

    List<Widget> _groupWallWidgets = <Widget>[

      _spacer,

      FlyerStack(
        flyersType: FlyerType.Property,
        title: 'New ${groupModel.firstKeyword} flyers in Heliopolis',
        tinyFlyers: TinyFlyer.dummyTinyFlyers(),
      ),

      _spacer,
      _spacer,

      /// If groupModel requires second keywords to generate flyers ( keyword x another keyword )
      if(groupModel?.secondKeywords?.keywordModels != null)
      ...List.generate(
          groupModel.secondKeywords.keywordModels.length,
              (index) =>
              Padding(
                padding: const EdgeInsets.only(bottom: Ratioz.appBarMargin * 4),
                child: FlyerStack(
                  flyersType: null,
                  title: '${groupModel.firstKeyword} - ${groupModel.secondKeywords.keywordModels[index].keywordID} in Heliopolis, Cairo',
                  tinyFlyers: TinyFlyer.dummyTinyFlyers(),
                ),
              ),
      ),

      /// If groupModel has its keywords straight nested (filterID - groupID - subGroupID - keywordID)
      if(groupModel?.secondKeywords?.keywordModels == null)
        ...List.generate(
          _keywordsByGroupID.length,
              (index) =>
              Padding(
                padding: const EdgeInsets.only(bottom: Ratioz.appBarMargin * 4),
                child: FlyerStack(
                  flyersType: null,
                  titleIcon: KeywordModel.getImagePath(_keywordsByGroupID[index].keywordID),
                  title: '${_keywordsByGroupID[index].keywordID} in Cairo',
                  tinyFlyers: TinyFlyer.dummyTinyFlyers(),
                ),
              ),
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
