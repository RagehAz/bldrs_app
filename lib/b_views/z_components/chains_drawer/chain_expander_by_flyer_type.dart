import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/chain_expander/a_chain_expander_starter.dart';
import 'package:bldrs/c_controllers/g_chains_dialog_controller.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ChainExpanderByFlyerType extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainExpanderByFlyerType({
    @required this.bubbleWidth,
    @required this.flyerType,
    @required this.inActiveMode,
    @required this.chain,
    this.initiallyExpanded = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double bubbleWidth;
  final FlyerType flyerType;
  final bool inActiveMode;
  final Chain chain;
  final bool initiallyExpanded;
  /// --------------------------------------------------------------------------
  String _sectionIcon({
    @required FlyerType section,
    @required bool inActiveMode
  }){

    String _icon;

    if (inActiveMode == true) {
      _icon = Iconizer.flyerTypeIconOff(section);
    } else {
      _icon = Iconizer.flyerTypeIconOn(section);
    }

    return _icon;
  }
// -----------------------------------------------------------------------------
  Future<void> _onKeywordTap(BuildContext context, String _keywordID) async {

    await onSelectKeyword(
      phid: _keywordID,
      context: context,
      flyerType: flyerType,
      inActiveMode: inActiveMode,
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ChainExpanderStarter(
      key: PageStorageKey<String>(flyerType.toString()),
      chain: chain,
      boxWidth: bubbleWidth - (2 * Ratioz.appBarMargin),
      icon: _sectionIcon(section: flyerType, inActiveMode: inActiveMode),
      firstHeadline: translateFlyerType(
        context: context,
        flyerType: flyerType,
      ),
      secondHeadline: TextGen.flyerTypeDescriptionStringer(context, flyerType),
      isDisabled: inActiveMode,
      initiallyExpanded: initiallyExpanded,
      onKeywordTap: (String keywordID) => _onKeywordTap(context, keywordID),
    );

  }
}
