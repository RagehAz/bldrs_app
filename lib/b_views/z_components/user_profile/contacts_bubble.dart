import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/launchers.dart' as Launcher;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ContactsBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ContactsBubble({
    @required this.contacts,
    this.stretchy = false,
    this.onTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<ContactModel> contacts;
  final bool stretchy;
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _abPadding = Ratioz.appBarPadding;
    const double _contactBoxHeight = 35;
    final List<ContactModel> _contactsWithStrings = ContactModel.getContactsWithStringsFromContacts(contacts);
    final List<ContactModel> _socialMediaContacts = ContactModel.getSocialMediaContactsFromContacts(contacts);

    return Bubble(
      stretchy: stretchy,
      title: '${superPhrase(context, 'phid_contacts')} :',
      columnChildren: <Widget>[
        /// CONTACTS WITH STRINGS
        Wrap(
          spacing: _abPadding,
          children: <Widget>[

            ...List<Widget>.generate(_contactsWithStrings.length, (int index) {
              final String _value = _contactsWithStrings[index].contact;

              return DreamBox(
                  height: _contactBoxHeight,
                  icon: Iconizer.superContactIcon(
                      _contactsWithStrings[index].contactType),
                  margins: const EdgeInsets.all(_abPadding),
                  verse: _value,
                  verseWeight: VerseWeight.thin,
                  verseItalic: true,
                  iconSizeFactor: 0.6,
                  color: Colorz.bloodTest,
                  onTap: onTap == null
                      ? () async {
                          await Launcher.launchURL(
                              'https://${_contactsWithStrings[index].contact}');
                        }
                      : () => onTap(_value));
            }),

          ],
        ),

        /// SOCIAL MEDIA CONTACTS
        Wrap(
          children: <Widget>[

            ...List<Widget>.generate(_socialMediaContacts.length, (int index) {

              final String _value = _socialMediaContacts[index].contact;

              return DreamBox(
                  height: _contactBoxHeight,
                  icon: Iconizer.superContactIcon(
                      _socialMediaContacts[index]?.contactType),
                  margins: const EdgeInsets.all(_abPadding),
                  onTap: onTap == null
                      ? () async {
                          await Launcher.launchURL(
                              'https://${_socialMediaContacts[index].contact}');
                        }
                      : () => onTap(_value));
            }),

            /// USER LOCATION
            const DreamBox(
              height: _contactBoxHeight,
              icon: Iconz.comMap,
              margins: EdgeInsets.all(_abPadding),
            ),

          ],
        ),
      ],
    );
  }
}
