import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
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
  static Verse? getVerse({
    required bool? forceShowVerse,
    required ContactModel? contactModel,
  }){
    Verse? _output;

    if (contactModel != null && contactModel.value != null){
      final bool _isSocialMediaContact = ContactModel.checkContactIsSocialMedia(contactModel.type);
      final bool _showVerse = forceShowVerse ?? _isSocialMediaContact == false;

      if (_showVerse == true){

        final bool _isURL = ContactModel.checkIsWebLink(contactModel.type);

        if (_isURL == true){

          String _result = contactModel.value!;

          final bool _textContainsChar = TextCheck.stringContainsSubString(
            string: contactModel.value,
            subString: 'www',
          );

          if (_textContainsChar == true) {
            final int _position = _result.indexOf('www');
            _result =
            (_position != -1) ? _result.substring(_position + 4, _result.length)
                :
            _result;
          }


          _output = Verse.plain(_result);

        }

        else {
          _output = Verse.plain(contactModel.value);
        }

      }

    }

    return _output;
  }
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
      verse: getVerse(
        contactModel: contactModel,
        forceShowVerse: forceShowVerse,
      ),
      verseWeight: VerseWeight.thin,
      verseItalic: true,
      iconSizeFactor: _isSocialMediaContact == true ? 1 : 0.6,
      verseScaleFactor: _isSocialMediaContact == true ? 0.55 : 0.55/0.6,
      bubble: bubble,
      color: Colorz.white10,
      textDirection: TextDirection.ltr,
      verseCentered: false,
      onTap: onTap,
    );

  }
  // -----------------------------------------------------------------------------
}
