import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/a_profile_page/x1_user_profile_page_controllers.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactsBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ContactsBubble({
    @required this.contacts,
    @required this.location,
    @required this.canLaunchOnTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<ContactModel> contacts;
  final GeoPoint location;
  final bool canLaunchOnTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _abPadding = Ratioz.appBarPadding;
    const double _contactBoxHeight = 35;
    final List<ContactModel> _contactsWithStrings = ContactModel.filterContactsWhichShouldViewValue(contacts);
    final List<ContactModel> _socialMediaContacts = ContactModel.filterSocialMediaContacts(contacts);
    // --------------------
    return AbsorbPointer(
      absorbing: !canLaunchOnTap,
      child: Bubble(
        bubbleHeaderVM: BubbleHeaderVM(
          headlineVerse: const Verse(text: 'phid_contacts', translate: true),
          headerWidth: Bubble.clearWidth(context) - 20,
        ),
        columnChildren: <Widget>[

          /// CONTACTS WITH STRINGS
          Wrap(
            spacing: _abPadding,
            children: <Widget>[

              ...List<Widget>.generate(_contactsWithStrings.length, (int index) {

                final ContactModel _contact = _contactsWithStrings[index];

                return DreamBox(
                  height: _contactBoxHeight,
                  icon: ContactModel.concludeContactIcon(_contact.type),
                  margins: const EdgeInsets.all(_abPadding),
                  verse: Verse.plain(_contact?.value),
                  verseWeight: VerseWeight.thin,
                  verseItalic: true,
                  iconSizeFactor: 0.6,
                  bubble: false,
                  color: Colorz.white10,
                  onTap: () => onUserContactTap(
                    context: context,
                    contact: _contact,
                  ),
                );

              }
              ),

            ],
          ),

          /// SOCIAL MEDIA CONTACTS
          Wrap(
            children: <Widget>[

              ...List<Widget>.generate(_socialMediaContacts.length, (int index) {

                final ContactModel _contact = _socialMediaContacts[index];

                return DreamBox(
                  height: _contactBoxHeight,
                  icon: ContactModel.concludeContactIcon(_contact.type),
                  margins: const EdgeInsets.all(_abPadding),
                  onTap: () => onUserContactTap(
                    context: context,
                    contact: _contact,
                  ),
                );

              }
              ),

              /// USER LOCATION
              if (location != null)
                DreamBox(
                  height: _contactBoxHeight,
                  icon: Iconz.comMap,
                  margins: const EdgeInsets.all(_abPadding),
                  onTap: () => onUserLocationTap(location),
                ),

            ],
          ),

        ],
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
