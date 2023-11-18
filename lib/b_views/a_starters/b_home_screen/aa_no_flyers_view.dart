import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/layouts/separators/separator_line.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_home_screen_controllers.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:flutter/material.dart';

class NoFlyersView extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const NoFlyersView({
    super.key
  });
  // -----------------------------------------------------------------------------
  Verse _createNothingFoundTitle(){
    final String? _currentPhid = ChainsProvider.proGetHomeWallPhid(
      context: getMainContext(),
      listen: false,
    );
    final String? _translated = Verse.bakeVerseToString(verse: Verse.trans(_currentPhid));
    final Verse? _zoneVerse = ZoneModel.generateInZoneVerse(
      zoneModel: ZoneProvider.proGetCurrentZone(
        context: getMainContext(),
        listen: false,
      ),
    );
    final String? _zoneLine = Verse.bakeVerseToString(verse: _zoneVerse);
    final Verse _title = Verse.plain('$_translated . $_zoneLine');

    return _title;
  }
  // --------------------
  Verse _createNothingFoundBody(){
    const Verse _body = Verse(
              id: 'phid_no_flyers_to_show',
              translate: true,
              // casing: Casing.upperCase,
            );
    return _body;
  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    // final UserModel? _userModel = UsersProvider.proGetMyUserModel(
    //     context: context,
    //     listen: true,
    // );
    // final ZoneModel? _currentZone = ZoneProvider.proGetCurrentZone(
    //   context: context,
    //   listen: true,
    // );
    final double _width = Bubble.bubbleWidth(context: context);
    final double _screenHeight = Scale.screenHeight(context);

    return FloatingList(
      width: Scale.screenWidth(context),
      height: _screenHeight,
      mainAxisAlignment: MainAxisAlignment.end,
      padding: Stratosphere.stratosphereSandwich,
      columnChildren: <Widget>[

        /// SEPARATOR
        SeparatorLine(
          width: _width * 0.5,
          withMargins: true,
        ),

        /// SPACING
        SizedBox(
          height: _screenHeight * 0.04,
        ),

        /// TITLE
        BldrsText(
          verse: _createNothingFoundTitle(),
          width: _width * 0.8,
          size: 4,
          maxLines: 4,
          italic: true,
          weight: VerseWeight.black,
          // margin: 20,
          color: Colorz.yellow200,
        ),

        /// BODY
        BldrsText(
          verse: _createNothingFoundBody(),
          width: _width * 0.8,
          size: 3,
          maxLines: 4,
          italic: true,
          // margin: 20,
          color: Colorz.yellow200,
        ),

        // /// ZONE LINE
        // ZoneLine(
        //   zoneModel: _currentZone,
        //   width: _width,
        // ),

        SizedBox(
          height: _screenHeight * 0.04,
        ),

        /// SEPARATOR
        SeparatorLine(
          width: _width * 0.5,
          withMargins: true,
        ),

        /// SELECT ZONE BUTTON
        BldrsBox(
          height: 60,
          width: _width * .9,
          icon: Iconz.planet,
          iconSizeFactor: 0.7,
          verse: const Verse(
            id: 'phid_select_another_zone',
            translate: true,
          ),
          margins: 10,
          verseScaleFactor: 0.8 / 0.7,
          verseMaxLines: 2,
          onTap: () async {
            final UserModel? userModel = UsersProvider.proGetMyUserModel(
              context: context,
              listen: false,
            );

            final ZoneModel? _newZone = await ZoneSelection.goBringAZone(
              depth: ZoneDepth.city,
              zoneViewingEvent: ViewingEvent.homeView,
              settingCurrentZone: true,
              viewerZone: userModel?.zone,
              selectedZone: ZoneProvider.proGetCurrentZone(context: context, listen: false),
            );

            _newZone?.blogZone(
              invoker: 'Got New Zone from No flyers View',
            );

          },
        ),

        /// OR
        BldrsText(
          verse: const Verse(
            id: 'phid_or',
            translate: true,
          ),
          width: _width * 0.8,
          size: 3,
          maxLines: 4,
          italic: true,
          // margin: 20,
          color: Colorz.yellow200,
        ),

        /// CHANGE KEYWORD
        BldrsBox(
          height: 60,
          width: _width * .9,
          icon: Iconz.keyword,
          iconSizeFactor: 0.7,
          verse: const Verse(
            id: 'phid_change_keyword',
            translate: true,
          ),
          margins: 10,
          verseScaleFactor: 0.8 / 0.7,
          verseMaxLines: 2,
          onTap: onSectionButtonTap,
        ),

        /// SEPARATOR
        SeparatorLine(
          width: _width * 0.5,
          withMargins: true,
        ),

        // /// SHARE APP
        // BldrsBox(
        //   height: 60,
        //   width: _width * .9,
        //   icon: Iconz.bldrsAppIcon,
        //   verse: const Verse(
        //     id: 'phid_inviteBusinesses',
        //     translate: true,
        //   ),
        //   verseWeight: VerseWeight.thin,
        //   margins: 10,
        //   verseScaleFactor: 0.6,
        //   verseCentered: false,
        //   verseMaxLines: 2,
        //   onTap: () => onInviteFriendsTap(),
        // ),
        //
        // /// WE ARE WORKING ON IT
        // BldrsText(
        //   verse: const Verse(
        //     id: 'phid_we_are_working_on_it',
        //     translate: true,
        //   ),
        //   width: _width * 0.8,
        //   maxLines: 25,
        //   italic: true,
        //   weight: VerseWeight.thin,
        //   margin: 10,
        // ),

        // /// SEPARATOR
        // const DotSeparator(),

        // /// ADD BZ BUTTON
        // if (
        //     UserModel.userIsSignedUp(_userModel) == true
        //     &&
        //     UserModel.checkUserIsAuthor(_userModel) == false
        // )
        // const CreateNewBzButton(),
        //
        // /// ADD FLYER BUTTON
        // if (UserModel.checkUserIsAuthor(_userModel) == true)
        //   AddFlyerButton(
        //     flyerBoxWidth: Scale.screenShortestSide(context) * 0.45,
        //     onTap: () => AddFlyerButton.onHomeWallAddFlyer(),
        //   ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}

/// THE ONE THAT AUTO POPS THE CHANGE KEYWORD DIALOG
// class NoFlyersView extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const NoFlyersView({
//     super.key
//   });
//   /// --------------------------------------------------------------------------
//   @override
//   _NoFlyersViewState createState() => _NoFlyersViewState();
//   /// --------------------------------------------------------------------------
// }
//
// class _NoFlyersViewState extends State<NoFlyersView> {
//   // -----------------------------------------------------------------------------
//   /// --- LOADING
//   final ValueNotifier<bool> _loading = ValueNotifier(false);
//   // --------------------
//   Future<void> _triggerLoading({required bool setTo}) async {
//     setNotifier(
//       notifier: _loading,
//       mounted: mounted,
//       value: setTo,
//     );
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//   }
//   // --------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//
//     if (_isInit && mounted) {
//       _isInit = false; // good
//
//       asyncInSync(() async {
//
//         await _triggerLoading(setTo: true);
//
//         await Future.delayed(const Duration(seconds: 1));
//
//         if (mounted){
//
//           await Dialogs.centerNotice(
//             verse: _createNothingFoundTitle(),
//             body: _createNothingFoundBody(),
//             confirmVerse: const Verse(
//               id: 'phid_change_keyword',
//               translate: true,
//             ),
//           );
//
//           await onSectionButtonTap();
//
//         }
//
//         /// GO BABY GO
//         await _triggerLoading(setTo: false);
//
//       });
//
//     }
//     super.didChangeDependencies();
//   }
//   // --------------------
//   /*
//   @override
//   void didUpdateWidget(TheStatefulScreen oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.thing != widget.thing) {
//       unawaited(_doStuff());
//     }
//   }
//    */
//   // --------------------
//   @override
//   void dispose() {
//     _loading.dispose();
//     super.dispose();
//   }
//   // -----------------------------------------------------------------------------
//   Verse _createNothingFoundTitle(){
//     final String? _currentPhid = ChainsProvider.proGetHomeWallPhid(
//       context: context,
//       listen: false,
//     );
//     final String? _translated = Verse.bakeVerseToString(verse: Verse.trans(_currentPhid));
//     final Verse? _zoneVerse = ZoneModel.generateInZoneVerse(
//       zoneModel: ZoneProvider.proGetCurrentZone(
//         context: context,
//         listen: false,
//       ),
//     );
//     final String? _zoneLine = Verse.bakeVerseToString(verse: _zoneVerse);
//     final Verse _title = Verse.plain('$_translated . $_zoneLine');
//
//     return _title;
//   }
//   // --------------------
//   Verse _createNothingFoundBody(){
//     const Verse _body = Verse(
//               id: 'phid_no_flyers_to_show',
//               translate: true,
//               // casing: Casing.upperCase,
//             );
//     return _body;
//   }
//   // --------------------
//   @override
//   Widget build(BuildContext context) {
//
//     // final UserModel? _userModel = UsersProvider.proGetMyUserModel(
//     //     context: context,
//     //     listen: true,
//     // );
//     // final ZoneModel? _currentZone = ZoneProvider.proGetCurrentZone(
//     //   context: context,
//     //   listen: true,
//     // );
//     final double _width = Bubble.bubbleWidth(context: context);
//     final double _screenHeight = Scale.screenHeight(context);
//
//     return FloatingList(
//       width: Scale.screenWidth(context),
//       height: _screenHeight,
//       mainAxisAlignment: MainAxisAlignment.end,
//       padding: Stratosphere.stratosphereSandwich,
//       columnChildren: <Widget>[
//
//         /// SEPARATOR
//         SeparatorLine(
//           width: _width * 0.5,
//           withMargins: true,
//         ),
//
//         /// SPACING
//         SizedBox(
//           height: _screenHeight * 0.04,
//         ),
//
//         /// TITLE
//         BldrsText(
//           verse: _createNothingFoundTitle(),
//           width: _width * 0.8,
//           size: 4,
//           maxLines: 4,
//           italic: true,
//           weight: VerseWeight.black,
//           // margin: 20,
//           color: Colorz.yellow200,
//         ),
//
//         /// BODY
//         BldrsText(
//           verse: _createNothingFoundBody(),
//           width: _width * 0.8,
//           size: 3,
//           maxLines: 4,
//           italic: true,
//           // margin: 20,
//           color: Colorz.yellow200,
//         ),
//
//         // /// ZONE LINE
//         // ZoneLine(
//         //   zoneModel: _currentZone,
//         //   width: _width,
//         // ),
//
//         SizedBox(
//           height: _screenHeight * 0.04,
//         ),
//
//         /// SEPARATOR
//         SeparatorLine(
//           width: _width * 0.5,
//           withMargins: true,
//         ),
//
//         /// SELECT ZONE BUTTON
//         BldrsBox(
//           height: 60,
//           width: _width * .9,
//           icon: Iconz.planet,
//           iconSizeFactor: 0.7,
//           verse: const Verse(
//             id: 'phid_select_another_zone',
//             translate: true,
//           ),
//           margins: 10,
//           verseScaleFactor: 0.8 / 0.7,
//           verseMaxLines: 2,
//           onTap: () async {
//             final UserModel? userModel = UsersProvider.proGetMyUserModel(
//               context: context,
//               listen: false,
//             );
//
//             final ZoneModel? _newZone = await ZoneSelection.goBringAZone(
//               depth: ZoneDepth.city,
//               zoneViewingEvent: ViewingEvent.homeView,
//               settingCurrentZone: true,
//               viewerZone: userModel?.zone,
//               selectedZone: ZoneProvider.proGetCurrentZone(context: context, listen: false),
//             );
//
//             _newZone?.blogZone(
//               invoker: 'Got New Zone from No flyers View',
//             );
//
//           },
//         ),
//
//         /// OR
//         BldrsText(
//           verse: const Verse(
//             id: 'phid_or',
//             translate: true,
//           ),
//           width: _width * 0.8,
//           size: 3,
//           maxLines: 4,
//           italic: true,
//           // margin: 20,
//           color: Colorz.yellow200,
//         ),
//
//         /// CHANGE KEYWORD
//         BldrsBox(
//           height: 60,
//           width: _width * .9,
//           icon: Iconz.keyword,
//           iconSizeFactor: 0.7,
//           verse: const Verse(
//             id: 'phid_change_keyword',
//             translate: true,
//           ),
//           margins: 10,
//           verseScaleFactor: 0.8 / 0.7,
//           verseMaxLines: 2,
//           onTap: onSectionButtonTap,
//         ),
//
//         /// SEPARATOR
//         SeparatorLine(
//           width: _width * 0.5,
//           withMargins: true,
//         ),
//
//         // /// SHARE APP
//         // BldrsBox(
//         //   height: 60,
//         //   width: _width * .9,
//         //   icon: Iconz.bldrsAppIcon,
//         //   verse: const Verse(
//         //     id: 'phid_inviteBusinesses',
//         //     translate: true,
//         //   ),
//         //   verseWeight: VerseWeight.thin,
//         //   margins: 10,
//         //   verseScaleFactor: 0.6,
//         //   verseCentered: false,
//         //   verseMaxLines: 2,
//         //   onTap: () => onInviteFriendsTap(),
//         // ),
//         //
//         // /// WE ARE WORKING ON IT
//         // BldrsText(
//         //   verse: const Verse(
//         //     id: 'phid_we_are_working_on_it',
//         //     translate: true,
//         //   ),
//         //   width: _width * 0.8,
//         //   maxLines: 25,
//         //   italic: true,
//         //   weight: VerseWeight.thin,
//         //   margin: 10,
//         // ),
//
//         // /// SEPARATOR
//         // const DotSeparator(),
//
//         // /// ADD BZ BUTTON
//         // if (
//         //     UserModel.userIsSignedUp(_userModel) == true
//         //     &&
//         //     UserModel.checkUserIsAuthor(_userModel) == false
//         // )
//         // const CreateNewBzButton(),
//         //
//         // /// ADD FLYER BUTTON
//         // if (UserModel.checkUserIsAuthor(_userModel) == true)
//         //   AddFlyerButton(
//         //     flyerBoxWidth: Scale.screenShortestSide(context) * 0.45,
//         //     onTap: () => AddFlyerButton.onHomeWallAddFlyer(),
//         //   ),
//
//       ],
//     );
//
//   }
//   // -----------------------------------------------------------------------------
// }
