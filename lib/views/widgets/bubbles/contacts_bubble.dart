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
  final bool stretchy;
  final Function onTap;

  ContactsBubble({
    @required this.contacts,
    this.stretchy = false,
    this.onTap,
});

  @override
  Widget build(BuildContext context) {



    double abPadding = Ratioz.ddAppBarPadding;
    double contactBoxHeight = 35;

    List<ContactModel> contactsWithStrings = getContactsWithStringsFromContacts(contacts);
    List<ContactModel> socialMediaContacts = getSocialMediaContactsFromContacts(contacts);

    return InPyramidsBubble(
      centered: false,
      stretchy: stretchy,
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

                    String _value = contactsWithStrings[index].contact;

                    return
                        DreamBox(
                          height: contactBoxHeight,
                          icon: superContactIcon(contactsWithStrings[index].contactType),
                          boxMargins: EdgeInsets.all(abPadding),
                          verse: _value,
                          verseColor: Colorz.White,
                          verseWeight: VerseWeight.thin,
                          verseItalic: true,
                          iconSizeFactor: 0.6,
                          boxFunction:
                              onTap == null ?
                              (){launchURL('https://${contactsWithStrings[index].contact}');}
                              :
                              () => onTap(_value)
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

                        String _value = socialMediaContacts[index].contact;

                        return
                      DreamBox(
                        height: contactBoxHeight,
                        icon: superContactIcon(socialMediaContacts[index]?.contactType),
                        boxMargins: EdgeInsets.all(abPadding),
                        boxFunction:
                        onTap == null ?
                            (){launchURL('https://${socialMediaContacts[index].contact}');}
                            :
                            () => onTap(_value)

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


