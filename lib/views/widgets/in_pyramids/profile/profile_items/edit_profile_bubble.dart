import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/views/widgets/textings/text_field_bubble.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x20_ad_bz.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class EditProfileBubbles extends StatefulWidget {
  final Function cancelEdits;
  final Function confirmEdits;

  EditProfileBubbles({
    this.cancelEdits,
    this.confirmEdits,
});

  @override
  _EditProfileBubblesState createState() => _EditProfileBubblesState();
}

class _EditProfileBubblesState extends State<EditProfileBubbles> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              // --- TITLE
              SuperVerse(
                verse: 'Edit Profile',
                size: 3,
              ),

              // --- CANCEL BUTTON
              DreamBox(
                height: 35,
                width: 35,
                icon: Iconz.XLarge,
                iconSizeFactor: 0.6,
                boxFunction: widget.cancelEdits,
              )
            ],
          ),
        ),

        // --- ADD LOGO
        // AddLogoBubble(
        //   logo: Iconz.DumBzPNG,
        //   addBtFunction: _takeGalleryPicture,
        //   deleteLogoFunction: _deleteLogo,
        // ),

        TextFieldBubble(
          title: 'Name',
          keyboardTextInputType: TextInputType.name,
          fieldIsRequired: true,
        ),

        TextFieldBubble(
          title: 'Job Title',
          keyboardTextInputType: TextInputType.name,
          fieldIsRequired: true,
        ),

        TextFieldBubble(
          title: 'Company Name',
          keyboardTextInputType: TextInputType.name,
          fieldIsRequired: true,
        ),

        TextFieldBubble(
          title: 'Current City, Country',
          keyboardTextInputType: TextInputType.name,
          fieldIsRequired: true,
        ),

        TextFieldBubble(
          title: 'E-mail',
          keyboardTextInputType: TextInputType.emailAddress,
          fieldIsRequired: true,
          leadingIcon: Iconz.ComEmail,
        ),

        TextFieldBubble(
          title: 'Phone',
          keyboardTextInputType: TextInputType.phone,
          leadingIcon: Iconz.ComPhone,
        ),

        ContactFieldBubble(
          title: 'WebSite',
          leadingIcon: Iconz.ComWebsite,
        ),

        ContactFieldBubble(
          title: 'Facebook account',
          leadingIcon: Iconz.ComFacebook,
        ),

        ContactFieldBubble(
          title: 'Instagram account',
          leadingIcon: Iconz.ComInstagram,
        ),

        ContactFieldBubble(
          title: 'Linkedin account',
          leadingIcon: Iconz.ComLinkedin,
        ),

        ContactFieldBubble(
          title: 'YouTube channel',
          leadingIcon: Iconz.ComYoutube,
        ),

        ContactFieldBubble(
          title: 'Pinterest',
          leadingIcon: Iconz.ComPinterest,
        ),

        ContactFieldBubble(
          title: 'TikTok',
          leadingIcon: Iconz.ComTikTok,
        ),

        PyramidsHorizon(heightFactor: 5,)

      ],
    );
  }
}
