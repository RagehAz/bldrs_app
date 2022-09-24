import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_country_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/b_views/d_user/z_components/user_tile_button.dart';
import 'package:bldrs/x_dashboard/f_bzz_manager/bz_long_button.dart';
import 'package:bldrs/x_dashboard/z_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class NoteSenderDynamicButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteSenderDynamicButton({
    @required this.model,
    @required this.width,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic model;
  final double width;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// USER WIDE BUTTON
    if (model.runtimeType.toString() == 'UserModel'){

      final UserModel _userModel = model;

      return UserTileButton(
        boxWidth: width,
        userModel: _userModel,
      );

    }

    /// BZ WIDE BUTTON
    else if (model.runtimeType.toString() == 'BzModel'){

      final BzModel _bzModel = model;

      return BzLongButton(
        bzModel: _bzModel,
        boxWidth: width,
      );

    }

    /// COUNTRY WIDE BUTTON
    else if (model.runtimeType.toString() == 'CountryModel'){

      final CountryModel _countryModel = model;

      return WideCountryButton(
        width: width,
        countryID: _countryModel.id,
        onTap: null,
      );

    }

    /// BLDRS IN MAP MODEL
    else if (model.runtimeType.toString() == 'MapModel'){

      final MapModel _mapModel = model;

      return WideButton(
        width: width,
        verse: Verse.plain(_mapModel.key),
        icon: _mapModel.value,
        iconSizeFactor: 0.7,
      );
    }

    /// NOTHINGNESS
    else {
      return const SizedBox();
    }

  }
  /// --------------------------------------------------------------------------
}
