import 'package:bldrs/controllers/drafters/numberers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/specific/bz/appbar/bz_credits_counter.dart';
import 'package:bldrs/views/widgets/specific/bz/dialogs/dialog_of_bz_options.dart';
import 'package:flutter/material.dart';

class BzAppBar extends StatelessWidget {
  final BzModel bzModel;
  final UserModel userModel;

  const BzAppBar({
    @required this.bzModel,
    @required this.userModel,
  });
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

    double _appBarBzButtonWidth = Scale.superScreenWidth(context) - (Ratioz.appBarMargin * 2) -
        (Ratioz.appBarButtonSize * 2) - (Ratioz.appBarPadding * 4) - (Ratioz.appBarButtonSize * 1.4) - Ratioz.appBarPadding;

    String _zoneString = TextGenerator.cityCountryStringer(context: context, zone: bzModel.bzZone);

    return Row(
      children: <Widget>[

        /// --- BZ LOGO
        DreamBox(
          height: Ratioz.appBarButtonSize,
          width: _appBarBzButtonWidth,
          icon: bzModel.bzLogo,
          verse: '${bzModel.bzName}',
          verseCentered: false,
          bubble: false,
          verseScaleFactor: 0.7,
          color: Colorz.White20,
          secondLine: '${TextGenerator.bzTypeSingleStringer(context, bzModel.bzType)} $_zoneString',
          secondLineColor: Colorz.White200,
          secondLineScaleFactor: 0.8,
        ),

        SizedBox(
          width: Ratioz.appBarPadding,
          height: Ratioz.appBarPadding,
        ),

        BzCreditsCounter(
          width: Ratioz.appBarButtonSize * 1.4,
          slidesCredit: Numberers.counterCaliber(context, 1234),
          ankhsCredit: Numberers.counterCaliber(context, 123),
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
