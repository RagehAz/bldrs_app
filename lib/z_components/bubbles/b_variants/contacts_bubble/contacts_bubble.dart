import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/a_profile_page/x1_user_profile_page_controllers.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/buttons/bz_buttons/contact_button.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class ContactsBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ContactsBubble({
    required this.contacts,
    required this.location,
    required this.canLaunchOnTap,
    required this.showMoreButton,
    required this.showBulletPoints,
    required this.contactsArePublic,
    required this.onMoreTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final List<ContactModel>? contacts;
  final GeoPoint? location;
  final bool canLaunchOnTap;
  final bool showMoreButton;
  final bool showBulletPoints;
  final bool contactsArePublic;
  final Function? onMoreTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _hideBubble = contactsArePublic == false && showMoreButton == false;

    if (_hideBubble == true){
      return const SizedBox();
    }
    else {
      // --------------------
      const double _abPadding = Ratioz.appBarPadding;
      final List<ContactModel> _contactsWithStrings = ContactModel.filterContactsWhichShouldViewValue(contacts);
      final List<ContactModel> _socialMediaContacts = ContactModel.filterSocialMediaContacts(contacts);
      // --------------------
      return AbsorbPointer(
        absorbing: !canLaunchOnTap,
        child: Bubble(
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            headlineVerse: const Verse(id: 'phid_contacts', translate: true),
            headerWidth: Bubble.clearWidth(context: context) - 20,
            hasMoreButton: showMoreButton,
            onMoreButtonTap: onMoreTap,
          ),
          columnChildren: <Widget>[

            if (showBulletPoints == true)
            BldrsBulletPoints(
                bulletPoints: [
                  if (contactsArePublic == true)
                  const Verse(id: 'phid_all_contacts_are_public', translate: true),
                  if (contactsArePublic == false)
                  const Verse(id: 'phid_contacts_are_hidden', translate: true),

                  const Verse(id: 'phid_edit_contacts_in_settings', translate: true),
                ],
              showBottomLine: false,
            ),

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
                    width: Bubble.clearWidth(context: context) - 20,
                    isPublic: contactsArePublic,
                    onTap: () => onUserContactTap(
                      contact: _contact,
                    ),
                  );

                }
                ),

              ],
            ),

            /// SOCIAL MEDIA CONTACTS
            if (contactsArePublic == true)
            Wrap(
              children: <Widget>[

                ...List<Widget>.generate(_socialMediaContacts.length, (int index) {

                  final ContactModel _contact = _socialMediaContacts[index];

                  return ContactButton(
                    contactModel: _contact,
                    margins: const EdgeInsets.all(_abPadding),
                    isPublic: contactsArePublic,
                    onTap: () => onUserContactTap(
                      contact: _contact,
                    ),
                  );

                }
                ),

                /// USER LOCATION
                if (location != null)
                  BldrsBox(
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

  }
  /// --------------------------------------------------------------------------
}
