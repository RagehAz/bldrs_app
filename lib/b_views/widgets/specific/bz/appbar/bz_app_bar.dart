import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/specific/bz/appbar/bz_credits_counter.dart';
import 'package:bldrs/b_views/widgets/specific/bz/dialogs/dialog_of_bz_options.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BzAppBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzAppBar({
    // @required this.bzModel,
    // @required this.userModel,
    // @required this.countryModel,
    // @required this.cityModel,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  // final BzModel bzModel;
  // final UserModel userModel;
  // final CountryModel countryModel;
  // final CityModel cityModel;

  /// --------------------------------------------------------------------------
  Future<void> _slideBzOptions(BuildContext context, BzModel bzModel) async {

    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final UserModel _myUserModel = _usersProvider.myUserModel;

    await DialogOfBzOptions.show(
      context: context,
      bzModel: bzModel,
      userModel: _myUserModel,
    );
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: true);
    final BzModel _bzModel = _bzzProvider.myActiveBz;
    final CountryModel _bzCountry = _bzzProvider.myActiveBzCountry;
    final CityModel _bzCity = _bzzProvider.myActiveBzCity;

    // final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: true);
    // final UserModel _myUserModel = _usersProvider.myUserModel;


    final double _appBarBzButtonWidth = Scale.superScreenWidth(context) -
        (Ratioz.appBarMargin * 2) -
        (Ratioz.appBarButtonSize * 2) -
        (Ratioz.appBarPadding * 4) -
        (Ratioz.appBarButtonSize * 1.4) -
        Ratioz.appBarPadding;

    final String _zoneString = TextGen.cityCountryStringer(
      context: context,
      zone: _bzModel.zone,
      country: _bzCountry,
      city: _bzCity,
    );

    return Row(
      children: <Widget>[

        /// --- BZ LOGO
        DreamBox(
          height: Ratioz.appBarButtonSize,
          width: _appBarBzButtonWidth,
          icon: _bzModel.logo,
          verse: _bzModel.name,
          verseCentered: false,
          bubble: false,
          verseScaleFactor: 0.65,
          color: Colorz.white20,
          secondLine: '${TextGen.bzTypeSingleStringer(context, _bzModel.bzType)} $_zoneString',
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
          icon: Iconz.more,
          iconSizeFactor: 0.6,
          margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          bubble: false,
          onTap: () => _slideBzOptions(context, _bzModel),
        ),

      ],
    );
  }
}
