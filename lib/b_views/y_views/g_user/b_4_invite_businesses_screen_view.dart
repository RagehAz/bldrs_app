import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';


List<String> getNamesFromDeviceContacts(List<Contact> deviceContacts){
  List<String> _names = <String>[];

  if (Mapper.canLoopList(deviceContacts)){
    for (final Contact contact in deviceContacts){
      final String _nameString = contact.displayName ?? '${contact.givenName} ${contact.middleName} ${contact.familyName}';
      _names.add(_nameString);
    }
  }

  return _names;
}

class InviteBusinessesScreenView extends StatelessWidget {

  const InviteBusinessesScreenView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: true);
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: true);
    final List<Contact> _contacts = _usersProvider.myDeviceContacts;

    if (canLoopList(_contacts) == false){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          DreamBox(
            height: 50,
            verse: 'Import Contacts',
            icon: Iconz.phone,
            iconSizeFactor: 0.7,
            onTap: () => onImportDeviceContactsTap(context),
          ),

        ],

      );
    }

    else {

      final List<String> _contactsStrings = getNamesFromDeviceContacts(_contacts);

      return AlphabetListScrollView(
        strList: _contactsStrings,
        indexedHeight: (int height){
          blog('indexedHeight is : $height');
          return 40;
        },
        showPreview: true,
        headerWidgetList: <AlphabetScrollListHeader>[
          AlphabetScrollListHeader(
              widgetList: <Widget>[
                const SuperVerse(
                  verse: 'x',
                ),
              ],
              icon: Icon(Icons.search),
              indexedHeaderHeight: (int height){
                blog('indexedHeaderHeight is : $height');
                return 40;
              },
          ),
        ],
        itemBuilder: (BuildContext ctx, int index){

          final String _contactString = _contactsStrings[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SuperVerse(
              verse: _contactString,
              centered: false,
            ),
          );
        },
        highlightTextStyle: SuperVerse.createStyle(
            context: context,
            color: Colorz.yellow255,
            weight: VerseWeight.thin,
            italic: true,
            size: 1,
            shadow: true,
        ),
        normalTextStyle: SuperVerse.createStyle(
          context: context,
          color: Colorz.yellow255,
          weight: VerseWeight.thin,
          italic: true,
          size: 1,
          shadow: true,
        ),
        keyboardUsage: true,

      );

    }
  }
}
