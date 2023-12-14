// import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
// import 'package:basics/helpers/classes/space/scale.dart';
// 
// import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
// import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
// import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
// import 'package:bldrs/c_controllers/d_user_controllers/a_user_profile/z_invite_bzz_screen_controllers.dart';
// import 'package:bldrs/d_providers/user_provider.dart';
// import 'package:basics/helpers/classes/maps/mapper.dart';
// 
// import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
/*
List<String> getNamesFromDeviceContacts(List<Contact> deviceContacts){
  final List<String> _names = <String>[];

  if (Lister.checkCanLoop(deviceContacts)){
    for (final Contact contact in deviceContacts){
      final String _nameString = contact.displayName; //?? '${contact.givenName} ${contact.middleName} ${contact.familyName}';
      _names.add(_nameString);
    }
  }

  return _names;
}
 */

class InviteBusinessesScreenView extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const InviteBusinessesScreenView({
    super.key
  });
  // -----------------------------------------------------------------------------
  /*
  bool _contactIsSelected({
    required BuildContext context,
    required String contactString,
  }){

    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final bool _isSelected = _usersProvider.deviceContactIsSelected(contactString);

    return _isSelected;
  }
// -----------------------------------------------------------------------------
  void _onContactTap({
    required BuildContext context,
    required String contactString,
  }){
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    _usersProvider.selectDeviceContact(contactString);
  }
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: true);

    return const SizedBox();

    // final List<Contact> _allContacts = _usersProvider.myDeviceContacts;

    // final List<Contact> _searchedContacts = _usersProvider.searchedDeviceContacts;
    // final bool _isSearching = _usersProvider.isSearchingDeviceContacts;

    // if (Lister.checkCanLoop(_allContacts) == false){
    //   return Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     // crossAxisAlignment: CrossAxisAlignment.center,
    //     children: <Widget>[
    //
    //       DreamBox(
    //         height: 50,
    //         verse:  'Import Contacts',
    //         icon: Iconz.phone,
    //         iconSizeFactor: 0.7,
    //         onTap: () => onImportDeviceContactsTap(context),
    //       ),
    //
    //     ],
    //
    //   );
    // }
    //
    // else {
    //
    //   // final List<String> _contactsStrings = _isSearching ?
    //   //     getNamesFromDeviceContacts(_searchedContacts)
    //   //         :
    //   //     getNamesFromDeviceContacts(_allContacts);
    //
    //   return Container();
    //
    //   // return AlphabetListScrollView(
    //   //   strList: _contactsStrings,
    //   //   indexedHeight: (int height){
    //   //     // blog('indexedHeight is : $height');
    //   //     return 40;
    //   //   },
    //   //   showPreview: true,
    //   //   // headerWidgetList: <AlphabetScrollListHeader>[
    //   //     // AlphabetScrollListHeader(
    //   //     //     widgetList: <Widget>[
    //   //     //       const SuperVerse(
    //   //     //         verse:  'what the hell',
    //   //     //       ),
    //   //     //     ],
    //   //     //     icon: Icon(Icons.search),
    //   //     //     indexedHeaderHeight: (int height){
    //   //     //       blog('indexedHeaderHeight is : $height');
    //   //     //       return 40;
    //   //     //     },
    //   //     // ),
    //   //   // ],
    //   //   highlightTextStyle: SuperVerse.createStyle(
    //   //       context: context,
    //   //       color: Colorz.yellow255,
    //   //       weight: VerseWeight.thin,
    //   //       // italic: true,
    //   //       size: 1,
    //   //       // shadow: true,
    //   //   ),
    //   //   normalTextStyle: SuperVerse.createStyle(
    //   //     context: context,
    //   //     color: Colorz.yellow255,
    //   //     weight: VerseWeight.thin,
    //   //     // italic: true,
    //   //     size: 1,
    //   //     // shadow: true,
    //   //   ),
    //   //   keyboardUsage: true,
    //   //   itemBuilder: (BuildContext ctx, int index){
    //   //
    //   //     final String _contactString = _contactsStrings[index];
    //   //
    //   //     final bool _isSelected = _contactIsSelected(
    //   //       context: context,
    //   //       contactString: _contactString,
    //   //     );
    //   //
    //   //     final Color _verseColor = _isSelected ? Colorz.yellow255 : Colorz.white255;
    //   //     final String _icon = _isSelected ? Iconz.check : Iconz.dvBlankPNG;
    //   //
    //   //     return Align(
    //   //       alignment: Aligners.superCenterAlignment(context),
    //   //       child: DreamBox(
    //   //         height: 35,
    //   //         width: Scale.superScreenWidth(context) - 10,
    //   //         verse: _contactString,
    //   //         verseColor: _verseColor,
    //   //         margins: const EdgeInsets.symmetric(horizontal: 5),
    //   //         bubble: false,
    //   //         iconSizeFactor: 0.7,
    //   //         verseCentered: false,
    //   //         // secondLine: _contactPhones,
    //   //         icon: _icon,
    //   //         onTap: () => _onContactTap(
    //   //           context: context,
    //   //           contactString: _contactString,
    //   //         ),
    //   //       ),
    //   //     );
    //   //
    //   //   },
    //   //
    //   // );
    //
    // }
  }
  // -----------------------------------------------------------------------------
}
