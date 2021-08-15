import 'package:bldrs/controllers/drafters/animators.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/keywords/groups.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/keywords/sequence_model.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/screens/b_3_sequence_flyers_screen.dart';
import 'package:bldrs/views/widgets/flyer/stacks/flyer_stack.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SequencesWall extends StatelessWidget {
  final Sequence sequence;
  final FlyerType flyersType;

  SequencesWall({
    @required this.sequence,
    @required this.flyersType,
  });

  String _stackTitle({BuildContext context, Sequence sequence, int index}){
    String _stackTitle;

    /// in crafts groups, second keywords are zone areas
    // List<GroupModel> _craftsGroups = GroupModel.craftsGroups(context);
    // bool _firstKeyIDisFromCraftsGroup = GroupModel.groupsContainThisFirstKeyID(
    //     context: context,
    //     groups: _craftsGroups,
    //     firstKeyID: groupModel.firstKeyID
    // );

    bool _groupSecondKeysAreZoneAreas = Sequence.sequenceSecondKeysAreZoneDistricts(sequence);

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);
    String _provinceName = _countryPro.getCityNameWithCurrentLanguageIfPossible(context, _countryPro.currentCityID);

    if(_groupSecondKeysAreZoneAreas == true){
      String _areaName = _countryPro.getDistrictNameWithCurrentLanguageIfPossible(context, sequence.secondKeywords.keywords[index].keywordID);
      String _keywordName = Keyword.getKeywordNameByKeywordID(context, sequence.titleID);

      _stackTitle = '$_keywordName - ${Wordz.inn(context)} $_areaName , $_provinceName';
    }

    else if (sequence?.secondKeywords?.keywords == null){
      List<Keyword> _keywordsByGroupID = Keyword.getKeywordsByGroupID(sequence.titleID);
      String _keywordName = Keyword.getKeywordNameByKeywordID(context, _keywordsByGroupID[index].keywordID);
      _stackTitle = '$_keywordName - ${Wordz.inn(context)} $_provinceName';
    }

    else {
      String _keywordID = sequence.secondKeywords.keywords[index].keywordID;
      Keyword _keyword = Keyword.getKeywordByKeywordID(_keywordID);
      String _keywordName = Keyword.getKeywordNameByKeywordID(context, _keywordID);
      String _sequenceName = Keyword.getKeywordNameByKeywordID(context, sequence.titleID);
      _stackTitle = '$_sequenceName - ${_keywordName} - ${Wordz.inn(context)} $_provinceName';
    }

    return _stackTitle;
  }

  void _onScrollEnd({BuildContext context, int index,Sequence sequence}){

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);
    String _currentProvinceID = _countryPro.currentCityID;

    bool _sequenceIsNewFlyers = index == null ? true : false;

    Keyword _firstKeyword =
    sequence.idType == SequenceType.byKeyID ? Keyword.getKeywordByKeywordID(sequence.titleID) :
    sequence.idType == SequenceType.byGroupID && _sequenceIsNewFlyers == false ? Keyword.getKeywordsByGroupID(sequence.titleID)[index] :
    sequence.idType == SequenceType.byGroupID && _sequenceIsNewFlyers == true ? null :
    null;

    Keyword _secondKeyword;

    if (_sequenceIsNewFlyers == true) {
      print ('1 - flyer is from the new flyers stack');

    }

    else {
      print ('1 - flyer is from sequence keywords');

      Group _secondKeywords = sequence?.secondKeywords;

      _secondKeyword = _secondKeywords == null ? null : _secondKeywords?.keywords[index];
      bool _sequenceHasSecondKeywords = _secondKeyword != null ? true : false;
      bool _secondKeyIsDistrict = _secondKeyword?.subGroupID == _currentProvinceID;

      if(_sequenceHasSecondKeywords == true){
        print('2 - sequence has second keywords : ${_secondKeyword.keywordID}');

        if (_secondKeyIsDistrict == true){
          print ('3 - secondKey is District : ${_countryPro.getCityNameWithCurrentLanguageIfPossible(context, _currentProvinceID)}');
        }

        else {
          print('3 - secondKey is Not District');
        }
      }

      else {
        print('2 - sequence has NO second keywords, idType is ${sequence.idType}, sequenceID is groupID :${sequence.titleID}');
        // List<KeywordModel> _keywords = KeywordModel.getKeywordsByGroupID(sequence.id);

      }



    }

    print('first keywordID : ${_firstKeyword?.keywordID}');
    print('second KeywordID : ${_secondKeyword?.keywordID}');

    if (_firstKeyword == null && _secondKeyword == null){
      print('both first and second keywords are null, so will get all flyers by groupID : ${sequence.titleID}');
    }

    Nav.goToNewScreen(context,
        SequenceFlyersScreen(
          firstKeyword: _firstKeyword,
          secondKeyword: _secondKeyword,
          sequence: sequence,
        ),
        transitionType: Animators.superHorizontalTransition(context));

  }

  // static const String _newFlyersTag = 'newFlyers';

  @override
  Widget build(BuildContext context) {

    Widget _spacer = SizedBox(height: Ratioz.appBarMargin, width: Ratioz.appBarMargin,);

    List<Keyword> _keywordsByGroupID = Keyword.getKeywordsByGroupID(sequence.titleID);

    print(sequence.titleID);
    print(_keywordsByGroupID);

    List<Widget> _sequenceWallWidgets = <Widget>[

      _spacer,

      FlyerStack(
        flyersType: FlyerType.rentalProperty,
        title: 'New ${sequence.titleID} flyers in Heliopolis',
        tinyFlyers: TinyFlyer.dummyTinyFlyers(),
        onScrollEnd: () => _onScrollEnd(
          context: context,
          index: null,
          sequence: sequence,
        ),
      ),

      _spacer,
      _spacer,

      /// If groupModel requires second keywords to generate flyers ( keyword x another keyword )
      if(sequence?.secondKeywords?.keywords != null)
      ...List.generate(
          sequence.secondKeywords.keywords.length,
              (index){

                // String _firstKeyword = sequence?.titleID;
                // Group _secondKeywords = sequence?.secondKeywords;
                // dynamic _secondKeyword = _secondKeywords == null ? null : sequence?.secondKeywords?.keywords[index];

                return
              Padding(
                padding: const EdgeInsets.only(bottom: Ratioz.appBarMargin * 2),
                child: FlyerStack(
                  flyersType: null,
                  title: _stackTitle(context: context, sequence: sequence, index: index),
                  tinyFlyers: TinyFlyer.dummyTinyFlyers(),
                  onScrollEnd: () => _onScrollEnd(
                    context: context,
                    index: index,
                    sequence: sequence,
                  ),
                ),
              );
              }
      ),

      /// If groupModel has its keywords straight nested (filterID - groupID - subGroupID - keywordID)
      if(sequence?.secondKeywords?.keywords == null)
        ...List.generate(
          _keywordsByGroupID.length,
              (index){

            // String _firstKeyword = sequence?.titleID;
            // Group _secondKeywords = sequence?.secondKeywords;
            // dynamic _secondKeyword = _secondKeywords == null ? null : sequence?.secondKeywords?.keywords[index];

            return
              Padding(
                padding: const EdgeInsets.only(bottom: Ratioz.appBarMargin * 2),
                child: FlyerStack(
                  flyersType: null,
                  titleIcon: Keyword.getImagePath(_keywordsByGroupID[index]),
                  title: _stackTitle(context: context, sequence: sequence, index: index),//'${KeywordModel.getKeywordNameByKeywordID(context, _keywordsByGroupID[index].keywordID)} in Cairo',
                  tinyFlyers: TinyFlyer.dummyTinyFlyers(),
                  onScrollEnd: () => _onScrollEnd(
                    context: context,
                    index: index,
                    sequence: sequence,
                  ),
                ),
              );
              }
        ),

      PyramidsHorizon(heightFactor: 5,),

    ];

    return GoHomeOnMaxBounce(

      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: Ratioz.stratosphere),
        scrollDirection: Axis.vertical,
        itemCount: _sequenceWallWidgets.length,

        itemBuilder: (ctx, index){

          return
            _sequenceWallWidgets[index];
        },
      ),
    );
  }
}
