import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/kw/specs/spec_list_model.dart';
import 'package:bldrs/a_models/kw/specs/spec_model.dart';
import 'package:bldrs/b_views/z_components/chain_expander/components/bldrs_chains.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
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
  final SpecList specList;
  final List<SpecModel> selectedSpecs;
  final ValueChanged<KW> onSpecTap;
  final double bubbleHeight;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);

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
            borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner)),
        alignment: Alignment.topCenter,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[

            BldrsChain(
              boxWidth: BldrsAppBar.width(context) - Ratioz.appBarMargin * 2,
              chain: Chain.filterSpecListChainRange(specList),
              onKeywordTap: (KW kw) => onSpecTap(kw),
              selectedKeywordsIDs: KW.getKeywordsIDsFromSpecs(selectedSpecs),
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
