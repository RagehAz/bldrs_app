import 'package:bldrs/controllers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/specific/bz/appbar/bz_credits_counter.dart';
import 'package:bldrs/views/widgets/specific/bz/dialogs/dialog_of_bz_options.dart';
import 'package:flutter/material.dart';

class BzAppBar extends StatelessWidget {
  final BzModel bzModel;
  final UserModel userModel;
  final CountryModel countryModel;
  final CityModel cityModel;

  const BzAppBar({
    @required this.bzModel,
    @required this.userModel,
    @required this.countryModel,
    @required this.cityModel,
    Key key,
  }) : super(key: key);
// -----------------------------------------------------------------------------
  Future<void> _slideBzOptions(BuildContext context, BzModel bzModel) async {

    await DialogOfBzOptions.show(
      context: context,
      bzModel: bzModel,
      userModel: userModel,
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _appBarBzButtonWidth = Scale.superScreenWidth(context) - (Ratioz.appBarMargin * 2) -
        (Ratioz.appBarButtonSize * 2) - (Ratioz.appBarPadding * 4) - (Ratioz.appBarButtonSize * 1.4) - Ratioz.appBarPadding;

    final String _zoneString = TextGen.cityCountryStringer(
        context: context,
        zone: bzModel.zone,
      country: countryModel,
      city: cityModel,
    );

    return Row(
      children: <Widget>[

        /// --- BZ LOGO
        DreamBox(
          height: Ratioz.appBarButtonSize,
          width: _appBarBzButtonWidth,
          icon: bzModel.logo,
          verse: '${bzModel.name}',
          verseCentered: false,
          bubble: false,
          verseScaleFactor: 0.65,
          color: Colorz.white20,
          secondLine: '${TextGen.bzTypeSingleStringer(context, bzModel.bzType)} $_zoneString',
          secondLineColor: Colorz.white200,
          secondLineScaleFactor: 0.7,
        ),

        const SizedBox(
          width: Ratioz.appBarPadding,
          height: Ratioz.appBarPadding,
        ),

        BzCreditsCounter(
          width: Ratioz.appBarButtonSize * 1.4,
          slidesCredit: Numeric.counterCaliber(context, 1234),
          ankhsCredit: Numeric.counterCaliber(context, 123),
        ),

        /// -- SLIDE BZ ACCOUNT OPTIONS
        DreamBox(
          height: Ratioz.appBarButtonSize,
          width: Ratioz.appBarButtonSize,
          icon: Iconz.More,
          iconSizeFactor: 0.6,
          margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          bubble: false,
          onTap:  () => _slideBzOptions(context, bzModel),
        ),

      ],
    );
  }
}
