import 'package:bldrs/ambassadors/services/launchers.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/view_brains/drafters/iconizers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class ContactsBubble extends StatelessWidget {
  final List<ContactModel> contacts;

  ContactsBubble({
    @required this.contacts,
});

  @override
  Widget build(BuildContext context) {


    double abPadding = Ratioz.ddAppBarPadding;
    double contactBoxHeight = 35;

    List<ContactModel> contactsWithStrings = getContactsWithStringsFromContacts(contacts);
    List<ContactModel> socialMediaContacts = getSocialMediaContactsFromContacts(contacts);

    return InPyramidsBubble(
      centered: false,
      columnChildren: <Widget>[

        // --- TITLE
        SuperVerse(
          verse: '${Wordz.contacts(context)} :',
          margin: abPadding,
          color: Colorz.Grey,
        ),

        // --- CONTACTS WITH STRINGS
        Wrap(
          spacing: abPadding,
            children: <Widget>[

              ...List<Widget>.generate(
                  contactsWithStrings.length,
                  (index){
                    return
                        DreamBox(
                          height: contactBoxHeight,
                          icon: superContactIcon(contactsWithStrings[index].contactType),
                          boxMargins: EdgeInsets.all(abPadding),
                          verse: contactsWithStrings[index].contact,
                          verseColor: Colorz.White,
                          verseWeight: VerseWeight.thin,
                          verseItalic: true,
                          iconSizeFactor: 0.6,
                          boxFunction: (){launchURL('https://${contactsWithStrings[index].contact}');},
                        );
                  }
              ),

            ],
          ),

        // --- SOCIAL MEDIA CONTACTS
        Wrap(
            children: <Widget>[

              ...List<Widget>.generate(
                  socialMediaContacts.length,
                      (index){
                    return
                      DreamBox(
                        height: contactBoxHeight,
                        icon: superContactIcon(socialMediaContacts[index]?.contactType),
                        boxMargins: EdgeInsets.all(abPadding),
                        boxFunction: (){launchURL('https://${socialMediaContacts[index].contact}');},
                      );
                  }
              ),

              // --- USER LOCATION
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
