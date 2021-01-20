import 'dart:io';
import 'package:bldrs/views/widgets/bubbles/contact_field_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:path_provider/path_provider.dart' as sysPaths;
import 'package:path/path.dart' as path;
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x20_ad_bz.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final Function cancelEdits;
  final Function confirmEdits;

  EditProfilePage({
    this.cancelEdits,
    this.confirmEdits,
});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File _storedLogo;
// ---------------------------------------------------------------------------
  Future<void> _takeGalleryPicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (imageFile == null){return;}

    setState(() {
      _storedLogo = File(imageFile.path);
    });

    final appDir = await sysPaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedLogo.copy('${appDir.path}/$fileName');
    // _selectImage(savedImage);
  }
// ---------------------------------------------------------------------------
  void _deleteLogo(){
    setState(() {
      _storedLogo = null;
    });
  }
// ---------------------------------------------------------------------------
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
        AddLogoBubble(
          logo: _storedLogo,
          addBtFunction: _takeGalleryPicture,
          deleteLogoFunction: _deleteLogo,
        ),

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
