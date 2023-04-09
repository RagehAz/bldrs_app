import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class ContactButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const ContactButton({
    @required this.contactModel,
    @required this.onTap,
    this.height,
    this.margins,
    this.width,
    this.forceShowVerse = false,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final double height;
  final double width;
  final ContactModel contactModel;
  final dynamic margins;
  final Function onTap;
  final bool forceShowVerse;
  // -----------------------------------------------------------------------------
  static const double buttonHeight = 40;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _isSocialMediaContact = ContactModel.checkContactIsSocialMedia(contactModel?.type);
    final bool _showVerse = forceShowVerse ?? _isSocialMediaContact == false;

    return BldrsBox(
      key: const ValueKey<String>('ContactButton'),
      height: height ?? buttonHeight,
      width: width,
      icon: ContactModel.concludeContactIcon(contactModel?.type),
      margins: margins,
      verse: _showVerse == true ? Verse.plain(contactModel?.value) : null,
      verseWeight: VerseWeight.thin,
      verseItalic: true,
      iconSizeFactor: _isSocialMediaContact == true ? 1 : 0.6,
      verseScaleFactor: _isSocialMediaContact == true ? 0.7 : 0.7/0.6,
      bubble: false,
      color: Colorz.white10,
      textDirection: TextDirection.ltr,
      verseCentered: false,
      onTap: onTap,
    );

  }
  // -----------------------------------------------------------------------------
}
