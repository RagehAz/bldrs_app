import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/a_profile_page/x1_user_profile_page_controllers.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/buttons/contact_button.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
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
    final List<ContactModel> _contactsWithStrings = ContactModel.filterContactsWhichShouldViewValue(contacts);
    final List<ContactModel> _socialMediaContacts = ContactModel.filterSocialMediaContacts(contacts);
    // --------------------
    return AbsorbPointer(
      absorbing: !canLaunchOnTap,
      child: Bubble(
        bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
          headlineVerse: const Verse(id: 'phid_contacts', translate: true),
          headerWidth: Bubble.clearWidth(context: context) - 20,
        ),
        columnChildren: <Widget>[

          /// CONTACTS WITH STRINGS
          Wrap(
            spacing: _abPadding,
            children: <Widget>[

              ...List<Widget>.generate(_contactsWithStrings.length, (int index) {

                final ContactModel _contact = _contactsWithStrings[index];

                return ContactButton(
                  contactModel: _contact,
                  margins: const EdgeInsets.all(_abPadding),
                  forceShowVerse: true,
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

                return ContactButton(
                  contactModel: _contact,
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
                  height: ContactButton.buttonHeight,
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
