import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/launchers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/kw/chain.dart';
import 'package:bldrs/models/secondary_models/link_model.dart';
import 'package:bldrs/providers/general_provider.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/dialog_button.dart';
import 'package:bldrs/views/widgets/general/expansion_tiles/bldrs_chains.dart';
import 'package:bldrs/views/widgets/general/expansion_tiles/expanding_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionTile extends StatelessWidget {
  final double bubbleWidth;
  final Section section;
  final bool inActiveMode;
  final Chain chain;

  const SectionTile({
    @required this.bubbleWidth,
    @required this.section,
    @required this.inActiveMode,
    @required this.chain,
  });
// -----------------------------------------------------------------------------
  String _sectionIcon({@required Section section, @required bool inActiveMode}){
    String _icon;

    if (inActiveMode == true){
      _icon = Iconizer.sectionIconOff(section);
    }
    else {
      _icon = Iconizer.sectionIconOn(section);
    }

    return _icon;
  }
// -----------------------------------------------------------------------------
  Future<void> _onSectionTap(BuildContext context, bool isExpanded) async {

    print('_onSectionTap : isExpanded : $isExpanded');

    final ZoneProvider _zoneProvider =  Provider.of<ZoneProvider>(context, listen: false);
    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    final String _currentCityID = _zoneProvider.currentZone.cityID;

    /// A - if section is not active * if user is author or not
    if(inActiveMode == true){

      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Section "${TextGen.sectionStringer(context, section)}" is\nTemporarily closed in $_currentCityID',
        body: 'The Bldrs in $_currentCityID are adding flyers everyday to properly present their markets.\nplease hold for couple of days and come back again.',
        height: 400,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              DialogButton(
                verse: 'Inform a friend',
                width: 133,
                onTap: () async {
                  await Launch.shareLink(context, LinkModel.bldrsWebSiteLink);
                },
              ),

              DialogButton(
                verse: 'Go back',
                color: Colorz.yellow255,
                verseColor: Colorz.black230,
                onTap: () => Nav.goBack(context),
              ),

            ],
          ),
        ),
      );
    }

    /// A - if section is active
    else {
      await _generalProvider.changeSection(context, section);

      // /// B - close dialog
      // Nav.goBack(context);

    }


  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    final double _tileWidth = bubbleWidth - (Ratioz.appBarMargin * 2);
    // final double _itemWidth = _tileWidth - (Ratioz.appBarMargin * 2);

    // final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: true);
    // final Section _currentSection = _generalProvider.currentSection;

    // final List<Sequence> _sequences = Sequence.getActiveSequencesBySection(context: context,section: section);


    return Opacity(
      opacity: inActiveMode == true ? 0.3 : 1,
      child: ExpandingTile(
        key: PageStorageKey<String>('${section.toString()}'),
        width: _tileWidth,
        onTap: (bool isExpanded) => _onSectionTap(context, isExpanded),
        inActiveMode: inActiveMode,
        // maxHeight: 150,
        icon: _sectionIcon(section: section, inActiveMode: inActiveMode),
        iconSizeFactor: 1,
        initiallyExpanded: false,
        firstHeadline: TextGen.sectionStringer(context, section),
        secondHeadline: TextGen.sectionDescriptionStringer(context, section),
        scrollable: true,
        initialColor: Colorz.black50,
        expansionColor: Colorz.white20,
        child: Container(
          width: _tileWidth,
          // height: 350,
          decoration: BoxDecoration(
            // color: Colorz.white10, // do no do this
            borderRadius: Borderers.superOneSideBorders(
              context: context,
              corner: ExpandingTile.cornersValue,
              side: AxisDirection.down,
            ),
          ),
          padding: const EdgeInsets.only(top: Ratioz.appBarMargin, bottom: Ratioz.appBarMargin),
          child: BldrsChain(
            chain: chain,
            boxWidth: _tileWidth,
          ),

          // child: ListView.builder(
          //   key: ValueKey('${key}_list_builder'),
          //     itemCount: _sequences.length,
          //     physics: const NeverScrollableScrollPhysics(),
          //     addAutomaticKeepAlives: true,
          //     shrinkWrap: true,
          //     padding: const EdgeInsets.all(Ratioz.appBarMargin),
          //     itemBuilder: (ctx, index){
          //
          //       final Sequence _sequence = _sequences[index];
          //       final String _groupName = Sequence.getSequenceNameBySequenceAndSection(
          //         context: context,
          //         section: section,
          //         sequence: _sequence,
          //       );
          //
          //       if (_sequence.sequenceType == SequenceType.byKeyID){
          //         return
          //
          //           /// GROUP ICON
          //           DreamBox(
          //             width: _itemWidth,
          //             height: 50,
          //             verse: _groupName,
          //             verseWeight: VerseWeight.regular,
          //             verseScaleFactor: 0.6,
          //             verseItalic: false,
          //             verseCentered: false,
          //             // color: Colorz.black125,
          //             icon: Sequence.getSequenceImage(_sequence.titleID),
          //             margins: EdgeInsets.only(bottom: Ratioz.appBarPadding),
          //             onTap: (){
          //
          //               Nav.goToNewScreen(context,
          //                 SequenceScreen(
          //                   sequence: _sequence,
          //                   flyersType: FlyerType.non, // TASK : fix this shit
          //                   section: section,
          //                 ),
          //               );
          //
          //             },
          //           );
          //
          //
          //       }
          //
          //       else {
          //
          //         final double _subItemWidth = _itemWidth - (Ratioz.appBarMargin * 2);
          //
          //         final List<Keyword> _keywordsByGroupID = Keyword.getKeywordsByGroupID(_sequence.titleID);
          //         // final GroupModel _group = GroupModel.
          //
          //
          //         return
          //           Padding(
          //             padding: const EdgeInsets.only(bottom: Ratioz.appBarPadding),
          //             child: ExpandingTile(
          //               collapsedHeight: 50,
          //               key: PageStorageKey<String>('${_sequence.titleID}'),
          //               width: _itemWidth,
          //               onTap: (bool isExpanded){print('on tap is expanded aho ya prince ${isExpanded}');},
          //               inActiveMode: false, /// TASK : check this
          //               maxHeight: 250,
          //               icon: Sequence.getSequenceImage(_sequence.titleID),
          //               iconSizeFactor: 1,
          //               initiallyExpanded: false,
          //               firstHeadline: _groupName,
          //               secondHeadline: null,
          //               scrollable: true,
          //               initialColor: Colorz.black50,
          //               expansionColor: Colorz.white20,
          //               child: Container(
          //                   width: _subItemWidth,
          //                   // height: 220,
          //                   decoration: BoxDecoration(
          //                     // color: Colorz.white10, // do no do this
          //                     borderRadius: Borderers.superOneSideBorders(
          //                       context: context,
          //                       corner: ExpandingTile.cornersValue,
          //                       side: AxisDirection.down,
          //                     ),
          //                   ),
          //                   padding: const EdgeInsets.only(top: Ratioz.appBarMargin, bottom: Ratioz.appBarMargin),
          //                   child: ListView.builder(
          //                       key: ValueKey('${_sequence.titleID}_sub_list_builder'),
          //                       itemCount: _keywordsByGroupID.length,
          //                       physics: const NeverScrollableScrollPhysics(),
          //                       addAutomaticKeepAlives: true,
          //                       shrinkWrap: true,
          //                       padding: const EdgeInsets.all(Ratioz.appBarMargin),
          //                       itemBuilder: (ctx, i){
          //
          //                         final Keyword _keyword = _keywordsByGroupID[i];
          //                         final String _keywordName = Keyword.getKeywordNameByKeywordID(context, _keyword.keywordID);
          //
          //                         return DreamBox(
          //                           width: _subItemWidth,
          //                           height: 40,
          //                           verse: _keywordName,
          //                           verseWeight: VerseWeight.regular,
          //                           verseScaleFactor: 0.6,
          //                           verseItalic: false,
          //                           verseCentered: false,
          //                           // color: Colorz.black125,
          //                           icon:  Keyword.getImagePath(_keyword),
          //                           margins: EdgeInsets.only(bottom: Ratioz.appBarPadding),
          //                           onTap: (){
          //
          //                             // Nav.goToNewScreen(context,
          //                             //   SequenceScreen(
          //                             //     sequence: _sequence,
          //                             //     flyersType: FlyerType.non, // TASK : fix this shit
          //                             //     section: section,
          //                             //   ),
          //                             // );
          //
          //                           },
          //                         );
          //                       })),
          //
          //             ),
          //           );
          //
          //
          //       }
          //
          //
          //
          //     }
          // ),
        ),
      ),
    );
  }
}
