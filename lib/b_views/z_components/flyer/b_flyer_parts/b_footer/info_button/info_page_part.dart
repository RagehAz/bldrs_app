import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/records/publish_time_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/kw/specs/spec_list_model.dart';
import 'package:bldrs/a_models/kw/specs/spec_model.dart';
import 'package:bldrs/a_models/secondary_models/name_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/paragraph_bubble.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/stats_line.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/widgets/specific/keywords/keyword_button.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/keywords_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoPagePart extends StatelessWidget {

  const InfoPagePart({
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.flyerZone,
    Key key
  }) : super(key: key);

  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final ZoneModel flyerZone;

  @override
  Widget build(BuildContext context) {

    final double _pageWidth = InfoButton.expandedWidth(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    const String _flyerInfo = 'Flyer info here because this is going to be super '
        'super duper awesome baby,, like the user author of'
        ' this flyer can type whatever he wants here '
        'to describe this flyer w keda u kno\n'
        'And the user can expand and type and keep typing as long as he would\n'
        'like to do\n'
        'Te3mel eh tayyeb rabbena mesh rayed,, w mesh kol 7aga t3ozha w teegy\n'
        '3ala hawak hata5odha\n'
        'take care that you can sometimes wish and pray for conflicting things\n'
        'one pray to take you forward\n'
        'the other one would take you backwards\n'
        'and So the trust is were Allah woill choose the best for you\n'
        'because he loves you\n'
        'he gave you too many signals for his love to you\n'
        'and you should kno that by heart\n'
        'never regret\n'
        'never surrender\n'
        'never lose faith\n'
        'all is good\n'
        '2ool el 7amdolellah';


    return Container(
      key: const ValueKey<String>('InfoPagePart'),
      width: _pageWidth,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[

          /// -------------------------------------------------------- SEPARATOR
          InfoPageSeparator(
            pageWidth: _pageWidth,
          ),

          /// MAIN DETAILS HEADLINE
          InfoPageHeadline(
            pageWidth: _pageWidth,
            headline: 'Main Details',
          ),

          /// MAIN DETAILS
          InfoPageMainDetails(
            pageWidth: _pageWidth,
            flyerModel: flyerModel,
            flyerZone: flyerZone,
          ),

          /// -------------------------------------------------------- SEPARATOR
          InfoPageSeparator(
            pageWidth: _pageWidth,
          ),

          /// KEYWORDS HEADLINE
          InfoPageHeadline(
            pageWidth: _pageWidth,
            headline: 'Flyer Keywords',
          ),

          /// MAIN DETAILS
          InfoPageKeywords(
            pageWidth: _pageWidth,
            flyerModel: flyerModel,
          ),

          /// -------------------------------------------------------- SEPARATOR
          InfoPageSeparator(
            pageWidth: _pageWidth,
          ),

          /// MORE INFO HEADLINE
          InfoPageHeadline(
            pageWidth: _pageWidth,
            headline: 'Flyer specifications',
          ),

          /// SPECS
          InfoPageSpecs(
            pageWidth: _pageWidth,
            flyerModel: flyerModel,
          ),

          /// -------------------------------------------------------- SEPARATOR
          InfoPageSeparator(
            pageWidth: _pageWidth,
          ),

          /// MORE INFO HEADLINE
          InfoPageHeadline(
              pageWidth: _pageWidth,
              headline: 'More about this flyer',
          ),

          /// INFO BODY
          InfoPageParagraph(
            pageWidth: _pageWidth,
            flyerInfo: _flyerInfo,
          ),

          /// -------------------------------------------------------- SEPARATOR
          InfoPageSeparator(
            pageWidth: _pageWidth,
          ),

          // ParagraphBubble(
          //   key: const ValueKey<String>('info_page_flyer_info_bubble'),
          //   bubbleWidth: _pageWidth,
          //   margins: const EdgeInsets.symmetric(horizontal: 10),
          //   // corners: _bubbleCorners,
          //   title: 'More info',
          //   maxLines: 3,
          //   paragraph: flyerModel.info,
          //   // editMode: false,
          //   // onParagraphTap: null,
          // ),


        ],
      ),
    );
  }
}

class InfoPageSeparator extends StatelessWidget {

  const InfoPageSeparator({
    @required this.pageWidth,
    Key key
  }) : super(key: key);

  final double pageWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: pageWidth * 0.8,
      height: 0.2,
      color: Colorz.white200,
      margin: const EdgeInsets.symmetric(vertical: 10),
    );
  }
}

class InfoPageMainDetails extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageMainDetails({
    @required this.pageWidth,
    @required this.flyerModel,
    @required this.flyerZone,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final FlyerModel flyerModel;
  final ZoneModel flyerZone;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        /// Flyer Type
        StatsLine(
          bubbleWidth: pageWidth,
          verse: 'Flyer Type : ${TextGen.flyerTypeSingleStringer(context, flyerModel.flyerType)}',
          icon: Iconizer.flyerTypeIconOff(flyerModel.flyerType),
          iconSizeFactor: 1,
          verseScaleFactor: 0.85 * 0.7,
        ),

        /// PUBLISH TIME
        StatsLine(
          bubbleWidth: pageWidth,
          verse: 'Published ${Timers.getSuperTimeDifferenceString(from: PublishTime.getPublishTimeFromTimes(times: flyerModel.times, state: FlyerState.published), to: DateTime.now())}',
          icon: Iconz.calendar,
        ),

        /// ZONE
        StatsLine(
          verse: 'Targeting : ${flyerZone?.cityName} , ${flyerZone?.countryName}',
          icon: Flag.getFlagIconByCountryID(flyerZone?.countryID),
          bubbleWidth: pageWidth,
        ),

      ],
    );
  }
}

class InfoPageHeadline extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageHeadline({
    @required this.pageWidth,
    @required this.headline,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final String headline;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      width: pageWidth,
      alignment: Aligners.superCenterAlignment(context),
      // padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(bottom: 10),
      child: SuperVerse(
        verse: headline,
        centered: false,
        size: 3,
        leadingDot: true,
      ),
    );
  }
}

class InfoPageParagraph extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageParagraph({
    @required this.pageWidth,
    @required this.flyerInfo,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final String flyerInfo;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: pageWidth,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SuperVerse(
          verse: flyerInfo,
          maxLines: 500,
          centered: false,
          weight: VerseWeight.thin,
          size: 3,
        ),
      ),
    );
  }
}

class InfoPageSpecs extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageSpecs({
    @required this.pageWidth,
    @required this.flyerModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final FlyerModel flyerModel;
  /// --------------------------------------------------------------------------
  List<SpecList> _getFlyerSpecsLists({
    @required List<SpecModel> flyerSpecs,
    @required FlyerType flyerType,
  }){
    final List<SpecList> _specsLists = <SpecList>[];

    final List<SpecList> _flyerTypeSpecsLists = SpecList.getSpecsListsByFlyerType(flyerType);

    if (Mapper.canLoopList(flyerSpecs)){
      
      for (final SpecModel _spec in flyerSpecs){
        
        final SpecList _specList = SpecList.getSpecListFromSpecsListsByID(
            specsLists: _flyerTypeSpecsLists,
            specListID: _spec.specsListID,
        );
        
        final bool _alreadyAdded = SpecList.specsListsContainSpecList(
          specsLists: _specsLists,
          specList: _specList,
        );

        if (_alreadyAdded == false){
          _specsLists.add(_specList);
        }
      }
      
    }
    
    return _specsLists;
  }
// -----------------------------------------------------------------------------
  String _generateSpecsString({
    @required BuildContext context,
    @required List<SpecModel> flyerSpecs,
    @required SpecList specList,
  }){

    String _output = '';

    final List<SpecModel> _flyerSpecsFromThisSpecList = <SpecModel>[];

    /// GET FLYER SPECS MATHCHING THIS SPECLIST
    if (Mapper.canLoopList(flyerSpecs) == true){

      for (final SpecModel spec in flyerSpecs){

        if (spec.specsListID == specList.id){

          final bool _alreadyAdded = SpecModel.specsContainThisSpecValue(
              specs: _flyerSpecsFromThisSpecList,
              value: spec.value,
          );

          if (_alreadyAdded == false){
            _flyerSpecsFromThisSpecList.add(spec);
          }

        }

      }

    }

    /// TRANSLATE THOSE FOUND SPECS
    if (Mapper.canLoopList(_flyerSpecsFromThisSpecList)){

      for (final SpecModel _spec in _flyerSpecsFromThisSpecList){

        final String _specName = SpecModel.getSpecNameFromSpecsLists(
          context: context,
          spec: _spec,
          specsLists: [specList],
        );

        if (_output == ''){
          _output = _specName;
        }
        else {
          _output = '$_output, $_specName';
        }

      }

    }

    return _output == null || _output == '' ? null : _output;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<SpecModel> _specs =
        // flyerModel.specs
    SpecModel.dummySpecs();

    final List<SpecList> _flyerSpecsLists = _getFlyerSpecsLists(
      // flyerType: flyerModel.flyerType,
      flyerType: FlyerType.property,
      flyerSpecs: _specs,
    );

    // SpecList.blogSpecsLists(_flyerSpecsLists);

    return SizedBox(
      width: pageWidth,
      child:

      ListView.builder(
          itemCount: _flyerSpecsLists.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
          itemBuilder: (_, int index){

            final SpecList _specList = _flyerSpecsLists[index];

            final Name _specListName = Name.getNameByCurrentLingoFromNames(context: context, names: _specList.names);

            blog('_specListName is : ${_specListName.value}');

            final String _specsInString = _generateSpecsString(
              context: context,
              flyerSpecs: _specs,
              specList: _specList,
            );

            return Container(
              width: pageWidth,
              decoration: BoxDecoration(
                borderRadius: superBorderAll(context, pageWidth * 0.04),
                color: Colorz.blue80,
              ),
              margin: const EdgeInsets.only(bottom: 2.5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  /// SPEC LIST NAME
                  SuperVerse(
                    verse: '${_specListName?.value} :',
                    weight: VerseWeight.thin,
                    color: Colorz.white200,
                    centered: false,
                    size: 1,
                    scaleFactor: 1.3,
                  ),

                  /// SPECS
                  SuperVerse(
                    verse: _specsInString.toUpperCase(),
                    // size: 2,
                    maxLines: 10,
                    centered: false,
                    italic: true,
                  ),

                ],
              ),
            );

        }
      )
    );
  }
}

class InfPageKeywords extends StatelessWidget {

  const InfPageKeywords({
    @required this.flyerModel,
    @required this.pageWidth,
    Key key
  }) : super(key: key);

  final FlyerModel flyerModel;
  final double pageWidth;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class InfoPageKeywords extends StatelessWidget {

  const InfoPageKeywords({
    @required this.flyerModel,
    @required this.pageWidth,
    Key key
  }) : super(key: key);

  final FlyerModel flyerModel;
  final double pageWidth;

  @override
  Widget build(BuildContext context) {

    // final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);
    // final List<KW> _allKeywords = _keywordsProvider.allKeywords;
    // final List<KW> _keywords = KW.getKeywordsFromKeywordsByIDs(
    //     sourceKWs: _allKeywords,
    //     keywordsIDs: flyerModel.keywordsIDs,
    // );

    final List<KW> _keywords = KW.dummyKeywords(
      context: context,
      length: 10,
    );

    return Wrap(
      children: <Widget>[
        ...List<Widget>.generate(_keywords?.length, (int index) {

          final KW _keyword = _keywords[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: Ratioz.appBarPadding),
            child: KeywordBarButton(
              keyword: _keyword,
              xIsOn: false,
              onTap: null,
            ),
          );
        }),
      ],
    );
  }
}
