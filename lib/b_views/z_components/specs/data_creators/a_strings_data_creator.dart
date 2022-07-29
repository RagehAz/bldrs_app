import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/chain_expander/c_chains_sons_builder.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class StringsDataCreator extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StringsDataCreator({
    @required this.specPicker,
    @required this.selectedSpecs,
    @required this.onSpecTap,
    @required this.height,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final SpecPicker specPicker;
  final List<SpecModel> selectedSpecs;
  final ValueChanged<String> onSpecTap;
  final double height;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);

    blog('selected specs are : ${selectedSpecs.toString()}');

    return Container(
      width: _screenWidth,
      height: height,
      alignment: Alignment.center,
      // color: Colorz.red230,
      child: Container(
        width: BldrsAppBar.width(context),
        height: height - (2 * Ratioz.appBarMargin),
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
                specList: specPicker,
                context: context,
              ),
              onKeywordTap: (String keywordID) => onSpecTap(keywordID),
              selectedKeywordsIDs: SpecModel.getSpecsIDs(selectedSpecs),
              initiallyExpanded: true,
            ),

          ],
        ),

      ),
    );
  }
}
