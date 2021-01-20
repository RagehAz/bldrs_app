import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/views/widgets/textings/text_field_bubble.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x20_ad_bz.dart';
import 'package:flutter/material.dart';

class EditProfileBubbles extends StatelessWidget {
  final Function cancelEdits;
  final Function confirmEdits;

  EditProfileBubbles({
    this.cancelEdits,
    this.confirmEdits,
});
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
                boxFunction: cancelEdits,
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

        TextFieldBubble(
          title: 'WebSite',
          keyboardTextInputType: TextInputType.url,
          leadingIcon: Iconz.ComWebsite,
        ),

        TextFieldBubble(
          title: 'Facebook account',
          keyboardTextInputType: TextInputType.url,
          leadingIcon: Iconz.ComFacebook,
        ),

        TextFieldBubble(
          title: 'Instagram account',
          keyboardTextInputType: TextInputType.url,
          leadingIcon: Iconz.ComInstagram,
        ),

        TextFieldBubble(
          title: 'Linkedin account',
          keyboardTextInputType: TextInputType.url,
          leadingIcon: Iconz.ComLinkedin,
        ),

        TextFieldBubble(
          title: 'YouTube channel',
          keyboardTextInputType: TextInputType.url,
          leadingIcon: Iconz.ComYoutube,
        ),

        TextFieldBubble(
          title: 'Pinterest',
          keyboardTextInputType: TextInputType.url,
          leadingIcon: Iconz.ComPinterest,
        ),

        TextFieldBubble(
          title: 'TikTok',
          keyboardTextInputType: TextInputType.url,
          leadingIcon: Iconz.ComTikTok,
        ),



        PyramidsHorizon(heightFactor: 5,)

      ],
    );
  }
}
