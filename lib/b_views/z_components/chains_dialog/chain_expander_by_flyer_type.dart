import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/b_views/z_components/chains_dialog/chain_expander_structure/a_chain_expander_starter.dart';
import 'package:bldrs/c_controllers/g_keywords_browser_controller.dart';
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

    await onKeywordTap(
      phid: _keywordID,
      context: context,
      flyerType: flyerType,
      inActiveMode: inActiveMode,
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _width = bubbleWidth - (Ratioz.appBarMargin * 2);

    return ChainExpander(
      key: PageStorageKey<String>(flyerType.toString()),
      chain: chain,
      width: _width,
      // onTap: (bool isExpanded) => _onKeywordTap(context, isExpanded),
      icon: _sectionIcon(section: flyerType, inActiveMode: inActiveMode),
      firstHeadline: translateFlyerType(
        context: context,
        flyerType: flyerType,
      ),
      secondHeadline: TextGen.flyerTypeDescriptionStringer(context, flyerType),
      inActiveMode: inActiveMode,
      initiallyExpanded: initiallyExpanded,
      onKeywordTap: (String keywordID) => _onKeywordTap(context, keywordID),
    );

  }
}
