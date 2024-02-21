import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_color.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class CallButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CallButton({
    required this.onCallTap,
    required this.flyerBoxWidth,
    required this.contacts,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Function? onCallTap;
  final List<ContactModel> contacts;
  /// --------------------------------------------------------------------------
  String _getIcon(){

    if (Lister.checkCanLoop(contacts) == false){
      return Iconz.comWhatsappPlain;
    }
    else {

      if (ContactModel.getContactFromContacts(contacts: contacts, type: ContactType.instagram) != null){
        return Iconz.comInstagramPlain;
      }
      else if (ContactModel.getContactFromContacts(contacts: contacts, type: ContactType.facebook) != null){
        return Iconz.comFacebookPlain;
      }
      else if (ContactModel.getContactFromContacts(contacts: contacts, type: ContactType.tiktok) != null){
        return Iconz.comTikTokPlain;
      }
      else if (ContactModel.getContactFromContacts(contacts: contacts, type: ContactType.linkedIn) != null){
        return Iconz.comLinkedInPlain;
      }
      else if (ContactModel.getContactFromContacts(contacts: contacts, type: ContactType.twitter) != null){
        return Iconz.comTwitterPlain;
      }
      else {
        return Iconz.comWhatsappPlain;
      }

    }

  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _callBTHeight = FlyerDim.callButtonHeight(flyerBoxWidth);
    final double _callBTWidth = FlyerDim.followAndCallBoxWidth(flyerBoxWidth);
    // --------------------
    final BorderRadius _corners = FlyerDim.superFollowOrCallCorners(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        gettingFollowCorner: false
    );
    // --------------------
    final String _icon = _getIcon();
    final double _iconSizeFactor = _icon == Iconz.comWhatsappPlain ? 0.9 : 1.3;
    final double _callIconWidth = flyerBoxWidth * 0.05;
    // --------------------
    return TapLayer(
      width: _callBTWidth,
      height: _callBTHeight,
      onTap: onCallTap,
      corners: _corners,
      splashColor: Colorz.green255,
      child: Container(
        height: _callBTHeight,
        width: _callBTWidth,
        decoration: BoxDecoration(
          color: FlyerColors.callButtonColor,
          // boxShadow: Shadower.superFollowBtShadow(_callBTHeight),
          borderRadius: _corners,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            /// BUTTON GRADIENT
            Container(
              height: _callBTHeight,
              width: _callBTWidth,
              decoration: BoxDecoration(
                borderRadius: _corners,
                gradient: FlyerColors.followButtonGradient,
              ),
            ),

            /// BUTTON COMPONENTS : ICON, NUMBER, VERSE
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                /// CALL ICON
                BldrsBox(
                  height: _callIconWidth * 1.1,
                  width: _callIconWidth * 1.1,
                  // margin: EdgeInsets.all(flyerBoxWidth * 0.01),
                  // color: Colorz.bloodTest,
                  corners: 0,
                  bubble: false,
                  icon: _icon,
                  iconSizeFactor: _iconSizeFactor,
                  // child: WebsafeSvg.asset(
                  //   _getIcon(),
                  //   width: _callIconWidth,
                  //   height: _callIconWidth,
                  //   // package: Iconz.bldrsTheme,
                  // ),
                ),

                /// SPACING
                SizedBox(
                  width: _callIconWidth,
                  height: _callIconWidth * 0.1,
                ),

                /// FLYERS TEXT
                BldrsText(
                  width: _callBTWidth,
                  verse: const Verse(
                    id: 'phid_call',
                    translate: true,
                  ),
                  size: 0,
                  scaleFactor: flyerBoxWidth * 0.003,
                )

              ],
            ),

          ],
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
