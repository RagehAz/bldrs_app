import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/profile_editors/contact_field_bubble.dart';
import 'package:flutter/material.dart';

class ContactsEditorsBubbles extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ContactsEditorsBubbles({
    @required this.contacts,
    @required this.contactsOwnerType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<ContactModel> contacts;
  final ContactsOwnerType contactsOwnerType;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const List<ContactType> _types = <ContactType>[
      ContactType.phone,
      ContactType.email,
      ContactType.website,
      null,
      ContactType.facebook,
      ContactType.linkedIn,
      ContactType.youtube,
      ContactType.instagram,
      ContactType.pinterest,
      ContactType.tiktok,
      ContactType.twitter,
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        const DotSeparator(),

        /// CONTACTS
        ...List.generate(_types.length, (index){

          final ContactType _contactType = _types[index];

          final bool _isBlocked = ContactModel.checkContactIsBlocked(
            contactType: _contactType,
            ownerType: contactsOwnerType,
          );

          if (_isBlocked == true){
            return const SizedBox();
          }

          else {

            return ContactFieldBubble(
              isFormField: true,
              fieldIsRequired: ContactModel.checkContactIsRequired(
                contactType: _contactType,
                ownerType: ContactsOwnerType.author,
              ),
              title: ContactModel.translateContactType(
                context: context,
                contactType: _contactType,
              ),
              textController: ContactModel.getControllerFromContacts(
                contacts: contacts,
                contactType: _contactType,
              ),
              leadingIcon: ContactModel.concludeContactIcon(_contactType),
              keyboardTextInputAction: TextInputAction.next,
              keyboardTextInputType: ContactModel.concludeContactTextInputType(
                contactType: _contactType,
              ),

            );

          }

        }),


        // /// WEBSITE
        // if (_isBlocked(ContactType.website) == false)
        //   ContactFieldBubble(
        //     fieldIsRequired: _isRequired(ContactType.website),
        //     textController: ContactModel.getControllerFromContacts(
        //       contacts: contacts,
        //       contactType: ContactType.website,
        //     ),
        //     isFormField: true,
        //     title: 'phid_website',
        //     leadingIcon: Iconz.comWebsite,
        //     keyboardTextInputAction: TextInputAction.next,
        //     keyboardTextInputType: TextInputType.emailAddress,
        //   ),
        //
        // /// EMAIL
        // if (_isBlocked(ContactType.email) == false)
        //   ContactFieldBubble(
        //     fieldIsRequired: _isRequired(ContactType.email),
        //     textController: ContactModel.getControllerFromContacts(
        //       contacts: contacts,
        //       contactType: ContactType.email,
        //     ),
        //     isFormField: true,
        //     title: 'phid_emailAddress',
        //     leadingIcon: Iconz.comEmail,
        //     keyboardTextInputAction: TextInputAction.next,
        //     keyboardTextInputType: TextInputType.emailAddress,
        //   ),
        //
        // /// PHONE
        // if (_isBlocked(ContactType.phone) == false)
        //   ContactFieldBubble(
        //     keyboardTextInputType: TextInputType.phone,
        //     textController: ContactModel.getControllerFromContacts(
        //       contacts: contacts,
        //       contactType: ContactType.phone,
        //     ),
        //     isFormField: true,
        //     title: 'phid_phone',
        //     leadingIcon: Iconz.comPhone,
        //     keyboardTextInputAction: TextInputAction.next,
        //     fieldIsRequired: _isRequired(ContactType.phone),
        //   ),
        //
        // const DotSeparator(),

        // /// FACEBOOK
        // if (_isBlocked(ContactType.facebook) == false)
        //   ContactFieldBubble(
        //     fieldIsRequired: _isRequired(ContactType.facebook),
        //     textController: ContactModel.getControllerFromContacts(
        //       contacts: contacts,
        //       contactType: ContactType.facebook,
        //     ),
        //     isFormField: true,
        //     title: 'phid_facebookLink',
        //     leadingIcon: Iconz.comFacebook,
        //     keyboardTextInputAction: TextInputAction.next,
        //   ),
        //
        // /// INSTAGRAM
        // if (_isBlocked(ContactType.instagram) == false)
        //   ContactFieldBubble(
        //     fieldIsRequired: _isRequired(ContactType.instagram),
        //     textController: ContactModel.getControllerFromContacts(
        //       contacts: contacts,
        //       contactType: ContactType.instagram,
        //     ),
        //     isFormField: true,
        //     title: 'phid_instagramLink',
        //     leadingIcon: Iconz.comInstagram,
        //     keyboardTextInputAction: TextInputAction.next,
        //   ),
        //
        // /// LINKEDIN
        // if (_isBlocked(ContactType.linkedIn) == false)
        //   ContactFieldBubble(
        //     fieldIsRequired: _isRequired(ContactType.linkedIn),
        //     textController: ContactModel.getControllerFromContacts(
        //       contacts: contacts,
        //       contactType: ContactType.linkedIn,
        //     ),
        //     isFormField: true,
        //     title: 'phid_linkedinLink',
        //     leadingIcon: Iconz.comLinkedin,
        //     keyboardTextInputAction: TextInputAction.next,
        //   ),
        //
        // /// TWITTER
        // if (_isBlocked(ContactType.twitter) == false)
        //   ContactFieldBubble(
        //     fieldIsRequired: _isRequired(ContactType.twitter),
        //     textController: ContactModel.getControllerFromContacts(
        //       contacts: contacts,
        //       contactType: ContactType.twitter,
        //     ),
        //     isFormField: true,
        //     title: 'phid_twitterLink',
        //     leadingIcon: Iconz.comTwitter,
        //     keyboardTextInputAction: TextInputAction.next,
        //   ),
        //
        // /// YOUTUBE
        // if (_isBlocked(ContactType.youtube) == false)
        //   ContactFieldBubble(
        //     fieldIsRequired: _isRequired(ContactType.youtube),
        //     textController: ContactModel.getControllerFromContacts(
        //       contacts: contacts,
        //       contactType: ContactType.youtube,
        //     ),
        //     isFormField: true,
        //     title: 'phid_youtube',
        //     leadingIcon: Iconz.comYoutube,
        //     keyboardTextInputAction: TextInputAction.done,
        //   ),
        //
        // /// TIKTOK
        // if (_isBlocked(ContactType.tiktok) == false)
        //   ContactFieldBubble(
        //     fieldIsRequired: _isRequired(ContactType.tiktok),
        //     textController: ContactModel.getControllerFromContacts(
        //       contacts: contacts,
        //       contactType: ContactType.tiktok,
        //     ),
        //     isFormField: true,
        //     title: 'phid_tiktok',
        //     leadingIcon: Iconz.comTikTok,
        //     keyboardTextInputAction: TextInputAction.done,
        //   ),

        const DotSeparator(),

        /// TO COMPACT CONTACTS = > TURN THE WIDGET INTO STATEFUL WIDGET
        // Container(
        //   width: BldrsAppBar.width(context),
        //   height: 100,
        //   color: Colorz.bloodTest,
        //   child: GridView(
        //     physics: const ,
        //   ),
        // ),

      ],
    );

  }

}
