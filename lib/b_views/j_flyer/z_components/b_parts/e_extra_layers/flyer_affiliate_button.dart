import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class FlyerAffiliateButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const FlyerAffiliateButton({
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.inStack,
    Key key
  }) : super(key: key);
  // --------------------
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final bool inStack;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _height = FlyerDim.footerBoxHeight(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        infoButtonExpanded: false,
        hasLink: false,
      );

    final double _width = FlyerDim.gtaButtonWidth(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
      );

    if (flyerModel?.affiliateLink == null){
      return const SizedBox();
    }
    else {

      final double _price = Speccer.getSalePrice(flyerModel?.specs);
      final String _currencyID = Speccer.getCurrencyID(flyerModel?.specs);

      final String _currencySymbol = ZoneProvider.proGetCurrencyByCurrencyID(
        currencyID: _currencyID,
        listen: false,
      )?.symbol;
      final String _priceLine = '$_price $_currencySymbol';
      final Verse _priceVerse = Verse(id: _priceLine, translate: false);
      const Verse _buyOnAmazonVerse = Verse(id: 'phid_buy_on_amazon', translate: true,);
      final bool _showPrice = _price != null && _currencyID != null;
      final Verse _firstLine = _showPrice == true ? _priceVerse : _buyOnAmazonVerse;
      final Verse _secondLine = _showPrice == true ? _buyOnAmazonVerse : null;

      final Widget _button = BldrsBox(
        color: const Color.fromARGB(255, 255, 153, 0),
        height: _height,
        width: _width,
        verse: _firstLine,
        secondLine: _secondLine,
        verseMaxLines: 3,
        icon: Iconz.amazon,
        iconSizeFactor: 0.7,
        verseScaleFactor: 0.7,
        verseCentered: false,
        verseColor: Colorz.black255,
        iconColor: Colorz.white255,
        verseShadow: true,
        corners: flyerBoxWidth * 0.05,
        margins: FlyerDim.gtaButtonMargins(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        ),
        verseWeight: FlyerDim.isTinyMode(context, flyerBoxWidth) == true ? VerseWeight.bold : VerseWeight.black,
        onTap: () async {
          await Launcher.launchURL(flyerModel.affiliateLink);
          },
      );

      if (inStack == true){
        return SuperPositioned(
          enAlignment: Alignment.bottomLeft,
          verticalOffset: FlyerDim.footerBoxHeight(
            context: context,
            flyerBoxWidth: flyerBoxWidth,
            infoButtonExpanded: false,
            hasLink: false,
          ),
          appIsLTR: UiProvider.checkAppIsLeftToRight(),
          child: _button,
        );
      }

      else {
        return _button;
      }
    }

    // --------------------

  }
  // -----------------------------------------------------------------------------
}
