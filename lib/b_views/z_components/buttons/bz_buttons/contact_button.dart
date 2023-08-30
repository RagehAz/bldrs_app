import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class ContactButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const ContactButton({
    required this.contactModel,
    required this.onTap,
    required this.isPublic,
    this.height,
    this.margins,
    this.width,
    this.forceShowVerse = false,
    this.bubble = true,
    super.key
  });
  // -----------------------------------------------------------------------------
  final double? height;
  final double? width;
  final ContactModel? contactModel;
  final dynamic margins;
  final Function onTap;
  final bool? forceShowVerse;
  final bool isPublic;
  final bool bubble;
  // -----------------------------------------------------------------------------
  static const double buttonHeight = 50;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _isSocialMediaContact = ContactModel.checkContactIsSocialMedia(contactModel?.type);
    final bool _showVerse = forceShowVerse ?? _isSocialMediaContact == false;
    final double _height = height ?? buttonHeight;
    final double? _width = _showVerse == true ? width : _height;

    return BldrsBox(
      key: const ValueKey<String>('ContactButton'),
      height: _height,
      width: _width,
      icon: ContactModel.concludeContactIcon(
        contactType: contactModel?.type,
        isPublic: isPublic,
      ),
      margins: margins,
      verse: _showVerse == true ? Verse.plain(contactModel?.value) : null,
      verseWeight: VerseWeight.thin,
      verseItalic: true,
      iconSizeFactor: _isSocialMediaContact == true ? 1 : 0.6,
      verseScaleFactor: _isSocialMediaContact == true ? 0.7 : 0.7/0.6,
      bubble: bubble,
      color: Colorz.white10,
      textDirection: TextDirection.ltr,
      verseCentered: false,
      onTap: onTap,
    );

  }
  // -----------------------------------------------------------------------------
}
