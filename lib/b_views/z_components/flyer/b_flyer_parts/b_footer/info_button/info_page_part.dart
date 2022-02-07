import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/records/publish_time_model.dart';
import 'package:bldrs/a_models/kw/specs/spec_list_model.dart';
import 'package:bldrs/a_models/kw/specs/spec_model.dart';
import 'package:bldrs/a_models/secondary_models/name_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/paragraph_bubble.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/stats_line.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

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
        'And the user can expand and type and keep typing as long as he would '
        'like to do\n'
        'Te3mel eh tayyeb rabbena mesh rayed,, w mesh kol 7aga t3ozha w teegy '
        '3ala hawak hata5odha'
        'take care that you can sometimes wish and pray for conflicting things'
        'one pray to take you forward'
        'the other one would take you backwards'
        'and So the trust is were Allah woill choose the best for you'
        'because he loves you'
        'he gave you too many signals for his love to you'
        'and you should kno that by heart'
        'never regret'
        'never surrender'
        'never lose faith'
        'all is good '
        '2ool el 7amdolellah';

    final List<SpecModel> _specs = SpecModel.dummySpecs();

    final List<SpecList> _specsLists = SpecList.getSpecsListsByFlyerType(flyerModel.flyerType);

    return Container(
      key: const ValueKey<String>('InfoPagePart'),
      width: _pageWidth,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[

          /// SEPARATOR
          InfoPageSeparator(
            pageWidth: _pageWidth,
          ),

          /// Flyer Type
          StatsLine(
            bubbleWidth: _pageWidth,
            verse: 'Flyer Type : ${TextGen.flyerTypeSingleStringer(context, flyerModel.flyerType)}',
            icon: Iconizer.flyerTypeIconOff(flyerModel.flyerType),
            iconSizeFactor: 1,
            verseScaleFactor: 0.85 * 0.7,
          ),

          /// PUBLISH TIME
          StatsLine(
            bubbleWidth: _pageWidth,
            verse: 'Published ${Timers.getSuperTimeDifferenceString(from: PublishTime.getPublishTimeFromTimes(times: flyerModel.times, state: FlyerState.published), to: DateTime.now())}',
            icon: Iconz.calendar,
          ),

          /// ZONE
          StatsLine(
            verse: 'Targeting : ${flyerZone?.cityName} , ${flyerZone?.countryName}',
            icon: Flag.getFlagIconByCountryID(flyerZone?.countryID),
            bubbleWidth: _pageWidth,
          ),

          /// SEPARATOR
          InfoPageSeparator(
              pageWidth: _pageWidth,
          ),

          /// MORE INFO HEADLINE
          InfoPageHeadline(
            pageWidth: _pageWidth,
            headline: 'Flyer specifications',
          ),

          /// SPECS
          SizedBox(
            width: _pageWidth,
            child: Column(
              children: <Widget>[

                ...List.generate(_specs.length, (int index){

                  final SpecModel _spec = _specs[index];


                  final SpecList _specList = SpecList.getSpecListFromSpecsListsByID(
                      specsLists: _specsLists,
                      specListID: _spec.specsListID,
                  );

                  final String _specName = SpecModel.getSpecNameFromSpecsLists(
                      context: context,
                      spec: _spec,
                      specsLists: _specsLists,
                  );

                  final Name _specListName = Name.getNameByCurrentLingoFromNames(context: context, names: _specList?.names);

                  return
                      Container(
                        width: _pageWidth,
                        decoration: BoxDecoration(
                          borderRadius: superBorderAll(context, _pageWidth * 0.03),
                          color: Colorz.blue80,
                        ),
                        margin: const EdgeInsets.only(bottom: 2.5),
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            SuperVerse(
                              verse: '${_specListName?.value} :',
                              weight: VerseWeight.thin,
                              italic: true,
                              color: Colorz.white200,
                            ),

                            SuperVerse(
                              verse: _specName,
                              size: 3,
                            ),
                          ],
                        ),
                      );

                }),

              ],
            ),
          ),

          /// SEPARATOR
          InfoPageSeparator(
            pageWidth: _pageWidth,
          ),

          /// MORE INFO HEADLINE
          InfoPageHeadline(
              pageWidth: _pageWidth,
              headline: 'More about this flyer',
          ),

          /// INFO BODY
          Center(
            child: Container(
              width: _pageWidth,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: const SuperVerse(
                verse: _flyerInfo, //flyerModel.info,
                maxLines: 500,
                centered: false,
                weight: VerseWeight.thin,
                size: 3,
              ),
            ),
          ),

          /// SEPARATOR
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
