import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/c_controllers/g_user_controllers/user_screen_controllers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';


class InviteBzzButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InviteBzzButton({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const String _verse = 'Invite Businesses you know';

    return DreamBox(
      height: SettingsWideButton.height,
      width: SettingsWideButton.width,
      margins: const EdgeInsets.all(Ratioz.appBarMargin),
      color: Colorz.yellow255,
      verse: _verse.toUpperCase(),
      verseScaleFactor: 1.2,
      verseMaxLines: 2,
      verseWeight: VerseWeight.black,
      verseItalic: true,
      secondLine: 'To join Bldrs.net',
      secondLineColor: Colorz.black255,
      secondLineScaleFactor: 1.1,
      verseColor: Colorz.black255,
      verseCentered: false,
      icon: Iconz.bz,
      iconColor: Colorz.black255,
      iconSizeFactor: SettingsWideButton.iconSizeFactor,
      onTap: () => onInviteBusinessesTap(context),
    );
  }
}
