import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:flutter/material.dart';

class ContactsWrap extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const ContactsWrap({
    required this.rowCount,
    required this.spacing,
    required this.boxWidth,
    required this.contacts,
    this.buttonSize,
    super.key
  });
  // -------------------------------
  final int rowCount;
  final double spacing;
  final double boxWidth;
  final List<ContactModel> contacts;
  final double? buttonSize;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _size = buttonSize ?? Scale.getUniformRowItemWidth(
      context: context,
      numberOfItems: rowCount,
      boxWidth: boxWidth,
      spacing: spacing,
      considerMargins: false,
    );

    return SizedBox(
      width: boxWidth,
      child: Wrap(
        spacing: spacing,
        runSpacing: spacing,
        textDirection: UiProvider.getAppTextDir(),
        children: <Widget>[

          /// CONTACTS
          ... List.generate(contacts.length, (index){

            final ContactModel _contact = contacts[index];

            return BldrsBox(
              width: _size,
              height: _size,
              iconSizeFactor: ContactModel.concludeContactIconSizeFactor(
                contactType: _contact.type,
                isPublic: true,
              ),
              icon: ContactModel.concludeContactIcon(
                contactType: _contact.type,
                isPublic: true,
              ),
              color: Colorz.white10,
              corners: _size * 0.2,
              onTap: () => Launcher.launchContactModel(contact: _contact),
            );
          }),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
