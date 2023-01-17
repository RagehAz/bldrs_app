import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class ContactButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const ContactButton({
    @required this.contactModel,
    @required this.onTap,
    this.height,
    this.margins,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final double height;
  final ContactModel contactModel;
  final dynamic margins;
  final Function onTap;
  // -----------------------------------------------------------------------------
  static const double buttonHeight = 35;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _isSocialMediaContact = ContactModel.checkContactIsSocialMedia(contactModel?.type) == true;

    return DreamBox(
      key: const ValueKey<String>('ContactButton'),
      height: height ?? buttonHeight,
      icon: ContactModel.concludeContactIcon(contactModel?.type),
      margins: margins,
      verse: _isSocialMediaContact == true ? null : Verse.plain(contactModel?.value),
      verseWeight: VerseWeight.thin,
      verseItalic: true,
      iconSizeFactor: _isSocialMediaContact == true ? 1 : 0.6,
      bubble: false,
      color: Colorz.white10,
      textDirection: TextDirection.ltr,
      onTap: onTap,
    );

  }
  // -----------------------------------------------------------------------------
}
