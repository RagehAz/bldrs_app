import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/launchers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class ContactsBubble extends StatelessWidget {
  final List<ContactModel> contacts;
  final bool stretchy;
  final Function onTap;

  const ContactsBubble({
    @required this.contacts,
    this.stretchy = false,
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const double _abPadding = Ratioz.appBarPadding;
    const double _contactBoxHeight = 35;

    final List<ContactModel> _contactsWithStrings = ContactModel.getContactsWithStringsFromContacts(contacts);
    final List<ContactModel> _socialMediaContacts = ContactModel.getSocialMediaContactsFromContacts(contacts);

    return Bubble(
      centered: false,
      stretchy: stretchy,
      title: '${Wordz.contacts(context)} :',
      columnChildren: <Widget>[

        /// CONTACTS WITH STRINGS
        Wrap(
          spacing: _abPadding,
          children: <Widget>[

            ...List<Widget>.generate(
                _contactsWithStrings.length,
                    (index){

                  final String _value = _contactsWithStrings[index].contact;

                  return
                    DreamBox(
                        height: _contactBoxHeight,
                        icon: Iconizer.superContactIcon(_contactsWithStrings[index].contactType),
                        margins: const EdgeInsets.all(_abPadding),
                        verse: _value,
                        verseColor: Colorz.white255,
                        verseWeight: VerseWeight.thin,
                        verseItalic: true,
                        iconSizeFactor: 0.6,
                        color: Colorz.bloodTest,
                        onTap:
                        onTap == null ?
                            () async { await Launch.launchURL('https://${_contactsWithStrings[index].contact}');}
                            :
                            () => onTap(_value)
                    );
                }
                ),

          ],
        ),

        /// SOCIAL MEDIA CONTACTS
        Wrap(
          children: <Widget>[

            ...List<Widget>.generate(
                _socialMediaContacts.length,
                    (index){

                  final String _value = _socialMediaContacts[index].contact;

                  return
                    DreamBox(
                        height: _contactBoxHeight,
                        icon: Iconizer.superContactIcon(_socialMediaContacts[index]?.contactType),
                        margins: const EdgeInsets.all(_abPadding),
                        onTap:
                        onTap == null ?
                            () async {await Launch.launchURL('https://${_socialMediaContacts[index].contact}');}
                            :
                            () => onTap(_value)

                    );
                }
                ),

            /// USER LOCATION
            const DreamBox(
                height: _contactBoxHeight,
                icon: Iconz.ComMap,
                margins: const EdgeInsets.all(_abPadding),
              ),

            ],
          ),

      ],
    );
  }
}


