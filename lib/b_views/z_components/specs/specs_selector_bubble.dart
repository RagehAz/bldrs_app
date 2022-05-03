import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/chain_expander/c_chains_sons_builder.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SpecSelectorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecSelectorBubble({
    @required this.specList,
    @required this.selectedSpecs,
    @required this.onSpecTap,
    @required this.bubbleHeight,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final SpecPicker specList;
  final List<SpecModel> selectedSpecs;
  final ValueChanged<String> onSpecTap;
  final double bubbleHeight;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);

    blog('selected specs are : ${selectedSpecs.toString()}');

    return Container(
      width: _screenWidth,
      height: bubbleHeight,
      alignment: Alignment.center,
      // color: Colorz.red230,
      child: Container(
        width: BldrsAppBar.width(context),
        height: bubbleHeight - (2 * Ratioz.appBarMargin),
        decoration: BoxDecoration(
            color: Colorz.white10,
            borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner),
        ),
        alignment: Alignment.topCenter,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[

            ChainSonsBuilder(
              boxWidth: BldrsAppBar.width(context) - Ratioz.appBarMargin * 2,
              chain: Chain.filterSpecListChainRange(
                specList: specList,
                context: context,
              ),
              onKeywordTap: (String keywordID) => onSpecTap(keywordID),
              selectedKeywordsIDs: SpecModel.getSpecsIDs(selectedSpecs),
              initiallyExpanded: false,
            ),

          ],
        ),

        // ListView.builder(
        //     itemCount: specList.specChain.sons.length,
        //     physics: const BouncingScrollPhysics(),
        //     padding: const EdgeInsets.symmetric(vertical: 5),
        //     itemBuilder: (BuildContext ctx, int index){
        //
        //        final KW _kw = specList.specChain.sons[index];
        //
        //        final bool _specsContainThis = Spec.specsContainThisSpec(
        //          specs: selectedSpecs,
        //          spec: Spec.getSpecFromKW(kw: _kw, specsListID: specList.id),
        //        );
        //
        //        final Color _color = _specsContainThis == true ? Colorz.green255 : null;
        //
        //       return
        //
        //         // DreamBox(
        //         //   width: BldrsAppBar.width(context) - Ratioz.appBarMargin * 2,
        //         //   height: BldrsAppBar.height(context, AppBarType.Basic),
        //         //   margins: 5,
        //         //   verse: Name.getNameByCurrentLingoFromNames(context, _kw.names),
        //         //   verseWeight: VerseWeight.thin,
        //         //   verseScaleFactor: 0.9,
        //         //   color: _color,
        //         //   onTap: () => onSpecTap(_kw),
        //         // );
        //
        //     }
        // ),

      ),
    );
  }
}
