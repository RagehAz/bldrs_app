import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/chain_expander/a_chain_expander_starter.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/g_chains_drawer_controller.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChainExpanderByFlyerType extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainExpanderByFlyerType({
    @required this.bubbleWidth,
    @required this.flyerType,
    @required this.deactivated,
    this.selectedKeywordsIDs,
    this.initiallyExpanded = false,
    this.onKeywordTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double bubbleWidth;
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

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    blog('flyer type is : $flyerType');
    final Chain _chainByFlyerType = _chainsProvider.getKeywordsChainByFlyerType(flyerType);

    if (_chainByFlyerType == null){
      return const SizedBox();
    }

    else {
      return ChainExpanderStarter(
      key: PageStorageKey<String>(flyerType.toString()),
      chain: _chainByFlyerType,
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
      onKeywordTap: (String keywordID) => _onKeywordTap(context, keywordID),
      selectedKeywordsIDs: selectedKeywordsIDs,
      initialColor: Colorz.white10,
    );
    }


  }
}
