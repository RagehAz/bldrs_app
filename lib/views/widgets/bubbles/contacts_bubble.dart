import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class ContactsBubble extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    // double pageMargin = Ratioz.ddAppBarMargin * 2;

    double abPadding = Ratioz.ddAppBarMargin;
    // double abHeight = screenWidth * 0.25;
    // double profilePicHeight = abHeight;
    // double abButtonsHeight = abHeight - (2 * abPadding);

    double contactBoxHeight = 35;

    return InPyramidsBubble(
      centered: false,
      columnChildren: <Widget>[

        // --- Contants
        SuperVerse(
          verse: '${Wordz.contacts(context)} :',
          margin: abPadding,
          color: Colorz.Grey,
        ),

        Wrap(
          spacing: abPadding,
            children: <Widget>[


              DreamBox(
                height: contactBoxHeight,
                icon: Iconz.ComPhone,
                boxMargins: EdgeInsets.all(abPadding),
                verse: '0155 4555 107',
                verseColor: Colorz.White,
                verseWeight: VerseWeight.thin,
                verseItalic: true,
                iconSizeFactor: 0.6,
              ),

              DreamBox(
                height: contactBoxHeight,
                icon: Iconz.ComWhatsapp,
                boxMargins: EdgeInsets.all(abPadding),
                iconSizeFactor: 0.7,
                iconRounded: false,
                bubble: true,
                verse: '0155 4555 107',
                verseColor: Colorz.White,
                verseWeight: VerseWeight.thin,
                verseItalic: true,
                verseScaleFactor: 0.86,
              ),

              DreamBox(
                height: contactBoxHeight,
                icon: Iconz.ComEmail,
                boxMargins: EdgeInsets.all(abPadding),
                verse: 'rageh-@hotmail.com',
                verseColor: Colorz.White,
                verseWeight: VerseWeight.thin,
                verseItalic: true,
                iconSizeFactor: 0.6,
              ),

              DreamBox(
                // width: contactBoxHeight,
                height: contactBoxHeight,
                icon: Iconz.ComWebsite,
                boxMargins: EdgeInsets.all(abPadding),
                verse: 'www.website.com',
                verseColor: Colorz.White,
                verseWeight: VerseWeight.thin,
                verseItalic: true,
                iconSizeFactor: 0.6,
              ),

            ],
          ),

        Wrap(
            children: <Widget>[


              DreamBox(
                height: contactBoxHeight,
                icon: Iconz.ComFacebook,
                boxMargins: EdgeInsets.all(abPadding),
              ),

              DreamBox(
                height: contactBoxHeight,
                icon: Iconz.ComTwitter,
                boxMargins: EdgeInsets.all(abPadding),
              ),

              DreamBox(
                height: contactBoxHeight,
                icon: Iconz.ComInstagram,
                boxMargins: EdgeInsets.all(abPadding),
              ),

              DreamBox(
                height: contactBoxHeight,
                icon: Iconz.ComLinkedin,
                boxMargins: EdgeInsets.all(abPadding),
              ),

              DreamBox(
                height: contactBoxHeight,
                icon: Iconz.ComMap,
                boxMargins: EdgeInsets.all(abPadding),
              ),

            ],
          ),

      ],
    );
  }
}
