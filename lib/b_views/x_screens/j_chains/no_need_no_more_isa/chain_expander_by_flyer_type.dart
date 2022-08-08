import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/expander_structure/a_chain_builder.dart';
import 'package:bldrs/c_controllers/a_starters_controllers/d_chains_drawer_controllers.dart';
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ChainExpanderForFlyerType extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainExpanderForFlyerType({
    @required this.bubbleWidth,
    @required this.chain,
    @required this.flyerType,
    @required this.deactivated,
    this.selectedKeywordsIDs,
    this.initiallyExpanded = false,
    this.onKeywordTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double bubbleWidth;
  final Chain chain;
  final FlyerType flyerType;
  final bool deactivated;
  final bool initiallyExpanded;
  final ValueChanged<String> onKeywordTap;
  final List<String> selectedKeywordsIDs;
  /// --------------------------------------------------------------------------
  String _sectionIcon({
    @required FlyerType section,
    @required bool inActiveMode
  }){

    String _icon;

    if (inActiveMode == true) {
      _icon = FlyerTyper.flyerTypeIconOff(section);
    } else {
      _icon = FlyerTyper.flyerTypeIconOn(section);
    }

    return _icon;
  }
// -----------------------------------------------------------------------------
  Future<void> _onKeywordTap(BuildContext context, String keywordID) async {

    if (onKeywordTap == null){

    await onChangeHomeSection(
      phid: keywordID,
      context: context,
      flyerType: flyerType,
      inActiveMode: deactivated,
    );

    }

    else {
      onKeywordTap(keywordID);
    }
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (chain == null){
      return const SizedBox();
    }

    else {
      return ChainBuilder(
      key: PageStorageKey<String>(chain.id),
      chain: chain,
      boxWidth: bubbleWidth - (2 * Ratioz.appBarMargin),
      alignment: Alignment.center,
      icon: _sectionIcon(section: flyerType, inActiveMode: deactivated),
      firstHeadline: FlyerTyper.translateFlyerType(
        context: context,
        flyerType: flyerType,
      ),
      secondHeadline: TextGen.flyerTypeDescriptionStringer(context, flyerType),
      isDisabled: deactivated,
      initiallyExpanded: initiallyExpanded,
      onPhidTap: (String keywordID) => _onKeywordTap(context, keywordID),
      selectedPhids: selectedKeywordsIDs,
      initialColor: Colorz.white10,
    );
    }


  }
}
