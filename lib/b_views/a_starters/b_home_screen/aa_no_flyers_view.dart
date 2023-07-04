import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/layouts/separators/dot_separator.dart';
import 'package:basics/layouts/separators/separator_line.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/staging_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/customs/zone_line.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:flutter/material.dart';

class NoFlyersView extends StatelessWidget {

  const NoFlyersView({
    super.key
  });

  @override
  Widget build(BuildContext context) {

    final ZoneModel? _currentZone = ZoneProvider.proGetCurrentZone(
      context: context,
      listen: true,
    );

    final double _width = Bubble.bubbleWidth(context: context);
    final double _screenHeight = Scale.screenHeight(context);

    return FloatingList(
      width: Scale.screenWidth(context),
      height: _screenHeight,
      mainAxisAlignment: MainAxisAlignment.end,
      padding: Stratosphere.stratosphereSandwich,
      columnChildren: <Widget>[

        /// SEPARATOR
        SeparatorLine(
          width: _width * 0.5,
          withMargins: true,
        ),

        SizedBox(
          height: _screenHeight * 0.05,
        ),

        /// NO FLYERS YET
        BldrsText(
          verse: const Verse(
            id: 'phid_no_flyers_to_show',
            translate: true,
            casing: Casing.upperCase,
          ),
          width: _width * 0.8,
          size: 6,
          maxLines: 4,
          italic: true,
          weight: VerseWeight.black,
          margin: 20,
          color: Colorz.yellow200,
        ),

        /// ZONE LINE
        ZoneLine(
          zoneModel: _currentZone,
          width: _width,
        ),

        SizedBox(
          height: _screenHeight * 0.05,
        ),

        /// SEPARATOR
        SeparatorLine(
          width: _width * 0.5,
          withMargins: true,
        ),

        /// SELECT ZONE BUTTON
        BldrsBox(
          height: 60,
          width: _width * .9,
          icon: Iconz.contAfrica,
          iconSizeFactor: 0.7,
          verse: const Verse(
            id: 'phid_select_another_zone',
            translate: true,
          ),
          margins: 10,
          verseScaleFactor: 0.8 / 0.7,
          verseMaxLines: 2,
          onTap: () async {
            final UserModel? userModel = UsersProvider.proGetMyUserModel(
              context: context,
              listen: false,
            );

            final ZoneModel? _newZone = await ZoneSelection.goBringAZone(
              depth: ZoneDepth.city,
              zoneViewingEvent: ViewingEvent.homeView,
              settingCurrentZone: true,
              viewerCountryID: userModel?.zone?.countryID,
            );

            _newZone?.blogZone(
              invoker: 'Got New Zone from No flyers View',
            );

          },
        ),

        /// SEPARATOR
        SeparatorLine(
          width: _width * 0.5,
          withMargins: true,
        ),

        /// SHARE APP
        BldrsBox(
          height: 60,
          width: _width * .9,
          icon: Iconz.bldrsAppIcon,
          verse: const Verse(
            id: 'phid_inviteBusinesses',
            translate: true,
          ),
          verseWeight: VerseWeight.thin,
          margins: 10,
          verseScaleFactor: 0.6,
          verseCentered: false,
          verseMaxLines: 2,
          onTap: () async {},
        ),

        /// WE ARE WORKING ON IT
        BldrsText(
          verse: const Verse(
            id: 'phid_we_are_working_on_it',
            translate: true,
          ),
          width: _width * 0.8,
          maxLines: 25,
          italic: true,
          weight: VerseWeight.thin,
          margin: 10,
        ),

        /// SEPARATOR
        const DotSeparator(),

      ],
    );
  }
}
