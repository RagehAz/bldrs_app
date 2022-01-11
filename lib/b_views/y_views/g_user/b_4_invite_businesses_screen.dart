import 'package:bldrs/a_models/kw/specs/raw_specs.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubbles_separator.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/b_views/widgets/general/loading/loading.dart';
import 'package:bldrs/b_views/widgets/general/textings/data_strip.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/y_views/g_user/b_4_invite_businesses_screen_view.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_controllers/g_user_screen_controller.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';

class InviteBusinessesScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InviteBusinessesScreen({Key key}) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      historyButtonIsOn: false,
      pageTitle: 'Invite Businesses',
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      skyType: SkyType.black,
      layoutWidget: Padding(
        padding: EdgeInsets.only(top: Ratioz.stratosphere),
        child: InviteBusinessesScreenView(),
      ),

      // ListView(
      //   physics: const NeverScrollableScrollPhysics(),
      //   children: <Widget>[
      //
      //     const Stratosphere(),
      //
      //     SuperVerse(
      //       verse: 'Here is what you need to do ...',
      //       size: 3,
      //       onTap: (){},
      //     ),
      //
      //     DreamBox(
      //       height: 50,
      //       verse: 'Import Contacts',
      //       icon: Iconz.phone,
      //       iconSizeFactor: 0.7,
      //       onTap: () => onImportDeviceContactsTap(context),
      //     ),
      //
      //     Container(
      //       height: 550,
      //       child: Selector<UiProvider, bool>(
      //           selector: (_, UiProvider uiProvider) => uiProvider.isLoading,
      //           // child: WebsafeSvg.asset(widget.pyramidsIcon),
      //           // shouldRebuild: ,
      //           builder: (BuildContext context, bool isLoading, Widget child) {
      //
      //             if (isLoading == true){
      //
      //               return const Center(
      //                 child: Loading(loading: true,),
      //               );
      //
      //             }
      //
      //             else {
      //
      //               return
      //
      //                 Selector<UsersProvider, List<Contact>>(
      //                     selector: (_, UsersProvider usersProvider) => usersProvider.myDeviceContacts,
      //                     // child: WebsafeSvg.asset(widget.pyramidsIcon),
      //                     // shouldRebuild: ,
      //                     builder: (BuildContext context, List<Contact> contacts, Widget child){
      //
      //                       /// NO DEVICE CONTACTS YET
      //                       if (Mapper.canLoopList(contacts) == false){
      //                         return const SuperVerse(
      //                           verse: 'No contacts imported',
      //                         );
      //                       }
      //
      //                       else {
      //                         return Container(
      //                           width: Scale.superScreenWidth(context),
      //                           height: 500,
      //                           child: ListView.builder(
      //                               shrinkWrap: true,
      //                               itemCount: contacts.length,
      //                               physics: const BouncingScrollPhysics(),
      //                               itemBuilder: (BuildContext ctx, int index){
      //
      //                                 final Contact _contact = contacts[index];
      //
      //                                 return
      //                                   Container(
      //                                     width: Scale.superScreenWidth(context),
      //                                     decoration: const BoxDecoration(
      //                                       color: Colorz.black125,
      //                                     ),
      //                                     margin: const EdgeInsets.only(bottom: 3),
      //                                     child: Column(
      //                                       children: <Widget>[
      //
      //                                         /// NAME
      //                                         SuperVerse(
      //                                           verse: _contact.displayName ?? '${_contact.givenName} ${_contact.middleName} $_contact.familyName}',
      //                                           size: 2,
      //                                           centered: false,
      //                                         ),
      //
      //                                         SuperVerse(
      //
      //                                         ),
      //
      //                                         DataStrip(dataKey: 'displayName', dataValue: _contact.displayName),
      //                                         DataStrip(dataKey: 'givenName', dataValue: _contact.givenName),
      //                                         DataStrip(dataKey: 'middleName', dataValue: _contact.middleName),
      //                                         DataStrip(dataKey: 'familyName', dataValue: _contact.familyName),
      //                                         if (_contact.jobTitle != null)
      //                                           DataStrip(dataKey: 'jobTitle', dataValue: _contact.jobTitle),
      //                                         if (_contact.company != null)
      //                                           DataStrip(dataKey: 'company', dataValue: _contact.company),
      //                                         // DataStrip(dataKey: 'androidAccountName', dataValue: _contact.androidAccountName),
      //                                         // DataStrip(dataKey: 'androidAccountType', dataValue: _contact.androidAccountType),
      //                                         // DataStrip(dataKey: 'androidAccountTypeRaw', dataValue: _contact.androidAccountTypeRaw),
      //                                         // DataStrip(dataKey: 'avatar', dataValue: _contact.avatar),
      //                                         // DataStrip(dataKey: 'birthday', dataValue: _contact.birthday),
      //                                         // DataStrip(dataKey: 'identifier', dataValue: _contact.identifier),
      //                                         // DataStrip(dataKey: 'postalAddresses', dataValue: _contact.postalAddresses),
      //                                         // DataStrip(dataKey: 'prefix', dataValue: _contact.prefix),
      //                                         // DataStrip(dataKey: 'suffix', dataValue: _contact.suffix),
      //
      //                                         ... List.generate(_contact?.phones?.length, (index) =>
      //                                             DataStrip(dataKey: 'phone ${index + 1}', dataValue: _contact.phones[index].value),
      //                                         ),
      //
      //                                         ... List.generate(_contact?.emails?.length, (index) =>
      //                                             DataStrip(dataKey: 'email ${index + 1}', dataValue: _contact.emails[index].value),
      //                                         ),
      //
      //                                         const BubblesSeparator(),
      //
      //                                       ],
      //                                     ),
      //                                   );
      //                               }
      //                           ),
      //                         );
      //                       }
      //
      //
      //                     }
      //
      //                 );
      //
      //
      //             }
      //           }
      //       ),
      //     ),
      //
      //   ],
      // ),

    );
  }
}
