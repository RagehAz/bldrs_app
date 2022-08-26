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
    // -------------------------------
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
    // -------------------------------
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
