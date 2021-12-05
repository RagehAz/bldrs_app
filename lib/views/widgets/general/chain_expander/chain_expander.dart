import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/views/widgets/general/chain_expander/components/bldrs_chains.dart';
import 'package:bldrs/views/widgets/general/chain_expander/components/expanding_tile.dart';
import 'package:flutter/material.dart';

class ChainExpander extends StatelessWidget {
  final Chain chain;
  final bool inActiveMode;
  final double width;
  final ValueChanged<bool> onTap;
  final String icon;
  final String firstHeadline;
  final String secondHeadline;
  final Color initialColor;
  final Color expansionColor;
  final EdgeInsets margin;

  const ChainExpander({
    @required this.chain,
    @required this.width,
    @required this.onTap,
    @required this.icon,
    @required this.firstHeadline,
    @required this.secondHeadline,
    this.inActiveMode = false,
    this.margin,
    this.initialColor = Colorz.black50,
    this.expansionColor = Colorz.white20,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Opacity(
      opacity: inActiveMode == true ? 0.3 : 1,
      child: ExpandingTile(
        key: key,
        width: width,
        margin: margin,
        onTap: (bool isExpanded) => onTap(isExpanded),
        inActiveMode: inActiveMode,
        // maxHeight: 150,
        icon: icon,
        firstHeadline: firstHeadline,
        secondHeadline: secondHeadline,
        initialColor: initialColor,
        expansionColor: expansionColor,
        child: Container(
          width: width,
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
            boxWidth: width,
          ),

          // child: ListView.builder(
          //   key: ValueKey('${key}_list_builder'),
          //     itemCount: _sequences.length,
          //     physics: const NeverScrollableScrollPhysics(),
          //     addAutomaticKeepAlives: true,
          //     shrinkWrap: true,
          //     padding: const EdgeInsets.all(Ratioz.appBarMargin),
          //     itemBuilder: (BuildContext ctx, int index){
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
