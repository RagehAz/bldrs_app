import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/g_statistics/counters/bz_counter_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/c_protocols/census_protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/z_note_events.dart';
import 'package:bldrs/c_protocols/records_protocols/recorder_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// EXPANSION INITIALIZATION

// --------------------
AnimationController initializeHeaderAnimationController({
  required BuildContext context,
  required TickerProvider vsync,
}){

  // final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
  // final bool _headerIsExpanded = _activeFlyerProvider.headerIsExpanded;

  // _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;

  final AnimationController _headerAnimationController = AnimationController(
      reverseDuration: Ratioz.durationFading200,
      duration: Ratioz.durationFading200,
      vsync: vsync
  );

  // if (_headerIsExpanded == true) {
  //   _headerAnimationController.value  = 1.0;
  // }
  // else {
  //   _headerAnimationController.value  = 0;
  // }

  return _headerAnimationController;
}
// -----------------------------------------------------------------------------

/// ANIMATION TRIGGER

// --------------------
Future<void> onTriggerHeader({
  required BuildContext context,
  required AnimationController headerAnimationController,
  required ScrollController verticalController,
  required ValueNotifier<bool> headerIsExpanded,
  required ValueNotifier<double> progressBarOpacity,
  required ValueNotifier<double> headerPageOpacity,
  required bool mounted,
}) async {

    await _triggerProgressBarOpacity(
      context: context,
      progressBarOpacity: progressBarOpacity,
      mounted: mounted,
    );

    /// HEADER ANIMATION
    _animateHeaderExpansion(
      context: context,
      headerAnimationController: headerAnimationController,
      verticalController: verticalController,
      headerIsExpanded: headerIsExpanded,
    );

    /// HEADER EXPANSION
    _triggerHeaderExpansion(
      context: context,
      notify: false,
      headerIsExpanded: headerIsExpanded,
      mounted: mounted,
    );

    /// HEADER FADING
    _triggerHeaderPageOpacity(
      context: context,
      notify: false,
      headerPageOpacity: headerPageOpacity,
      mounted: mounted,
    );

  // blog('_onHeaderTap : headerIsExpanded is : ${headerIsExpanded.value}');
}
// --------------------
Future<void> readBzCounters({
  required String? bzID,
  required ValueNotifier<BzCounterModel?> bzCounters,
  required bool mounted,
}) async {

  final BzCounterModel? _bzCounters = await RecorderProtocols.fetchBzCounters(
    bzID: bzID,
    forceRefetch: false,
  );

  setNotifier(
      notifier: bzCounters,
      mounted: mounted,
      value: _bzCounters,
  );

}
// --------------------
/// PROGRESS BAR OPACITY
Future<void> _triggerProgressBarOpacity({
  required BuildContext context,
  required ValueNotifier<double> progressBarOpacity,
  required bool mounted,
}) async {
  /// progressBarOpacity is used because it has a slight delay after triggering header
  /// AND SO headerIsExpanded can not be used to hold the progress bar opacity value

  /// WHEN PROGRESS BAR IS VISIBLE
  if (progressBarOpacity.value == 1) {
    // blog('triggering _progressBarOpacity to 0');
    setNotifier(notifier: progressBarOpacity, mounted: mounted, value: 0.0);
  }

  /// WHEN PROGRESS BAR IS HIDDEN
  else {
    await Future<void>.delayed(Ratioz.durationFading210, () {
      // blog('triggering _progressBarOpacity to 1');
      setNotifier(notifier: progressBarOpacity, mounted: mounted, value: 1.0);
    });
  }

}
// --------------------
/// HEADER IS EXPANDED
void _triggerHeaderExpansion({
  required BuildContext context,
  required bool notify,
  required ValueNotifier<bool> headerIsExpanded,
  required bool mounted,
}) {

  setNotifier(
      notifier: headerIsExpanded,
      mounted: mounted,
      value: !headerIsExpanded.value,
  );

  /// TASK : MAYBE WILL REMOVE THIS
  PageStorage.of(context).writeState(context, headerIsExpanded.value);

}
// --------------------
/// HEADER PAGE OPACITY
void _triggerHeaderPageOpacity({
  required BuildContext context,
  required bool notify,
  required ValueNotifier<double> headerPageOpacity,
  required bool mounted,
}) {

  // blog('_headerPageOpacity = ${headerPageOpacity.value}');

  Future<void>.delayed(Ratioz.durationFading200, () {

    /// WHEN PAGE IS VISIBLE
    if (headerPageOpacity.value == 1) {
      setNotifier(
          notifier: headerPageOpacity,
          mounted: mounted,
          value: 0.0,
      );
    }

    /// WHEN HEADER PAGE IS HIDDEN
    else {
      setNotifier(
          notifier: headerPageOpacity,
          mounted: mounted,
          value: 1.0,
      );
    }

  });
}
// -----------------------------------------------------------------------------

/// EXPANSION ANIMATION

// --------------------
/// HEADER EXPANSION ANIMATION
void _animateHeaderExpansion({
  required BuildContext context,
  required AnimationController headerAnimationController,
  required ScrollController verticalController,
  required ValueNotifier<bool> headerIsExpanded,
}){

  /// WHEN HEADER IS COLLAPSED
  if (headerIsExpanded.value == false) {
    headerAnimationController.forward();
  }

  /// WHEN HEADER IS EXPANDED
  else {
    headerAnimationController.reverse().then<void>((dynamic value) async {

      await verticalController.animateTo(0,
          duration: Ratioz.durationFading200,
          curve: Curves.easeOut
      );

    });
  }

}
// -----------------------------------------------------------------------------

/// TAPS - BUTTONS

// --------------------
/// ON FOLLOW
Future<void> onFollowTap({
  required BzModel? bzModel,
  required String? flyerID,
  required ValueNotifier<bool> followIsOn,
  required bool mounted,
}) async {

  final UserModel? _user = UsersProvider.proGetMyUserModel(
    context: getMainContext(),
    listen: false,
  );

  if (Authing.userIsSignedUp(_user?.signInMethod) == false){

    final bool _goToFlyerPreview = flyerID != null;
    final String _routeName = _goToFlyerPreview == true ? ScreenName.flyerPreview : ScreenName.bzPreview;
    final String? argument = _goToFlyerPreview == true ? flyerID : bzModel?.id;

    await Dialogs.youNeedToBeSignedUpDialog(
      afterHomeRouteName: _routeName,
      afterHomeRouteArgument: argument,
    );

  }

  else {

    setNotifier(
        notifier: followIsOn,
        mounted: mounted,
        value: !followIsOn.value
    );

    await UserProtocols.followingProtocol(
      bzToFollow: bzModel,
      followIsOn: followIsOn.value,
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onCallTap({
  required BzModel? bzModel,
  required FlyerModel? flyerModel,
}) async {

  final UserModel? _userModel = UsersProvider.proGetMyUserModel(
    context: getMainContext(),
    listen: false,
  );

  /// USER IS NOT SIGNED IN
  if (Authing.userIsSignedUp(_userModel?.signInMethod) == false){

    final bool _goToFlyerPreview = flyerModel?.id != null;
    final String _routeName = _goToFlyerPreview == true ? ScreenName.flyerPreview : ScreenName.bzPreview;
    final String? argument = _goToFlyerPreview == true ? flyerModel?.id : bzModel?.id;

    await Dialogs.youNeedToBeSignedUpDialog(
      afterHomeRouteName: _routeName,
      afterHomeRouteArgument: argument,
    );

  }

  /// USER IS SIGNED IN
  else {

    final bool _bzHasContacts = BzModel.checkBzHasContacts(
      bzModel: bzModel,
    );

    /// BZ HAS NO CONTACTS
    if (_bzHasContacts == false){

      await BldrsCenterDialog.showCenterDialog(
        titleVerse: const Verse(
          id: 'phid_no_contacts_available',
          translate: true,
        ),
        bodyVerse: const Verse(
          id: 'phid_reminder_will_be_sent_to_bz_for_phone',
          translate: true,
        ),
      );

      await NoteEvent.sendNoBzContactAvailableNote(
        context: getMainContext(),
        bzModel: bzModel,
      );

    }

    /// BZ HAS CONTACTS
    else {

      bool _contactIsOn = false;

      await Dialogs.bzContactsDialog(
          titleVerse: const Verse(
            id: 'phid_contact_directly',
            translate: true,
          ),
          bodyVerse: const Verse(
            id: 'phid_select_author_to_contact',
            translate: true,
          ),
          bzModel: bzModel,
          onContact: (String authorID, ContactModel contact) async {

            if (_contactIsOn == false){

              _contactIsOn = true;

              await Future.wait(<Future>[

                /// LAUNCH CONTACT
                Launcher.launchContactModel(
                  contact: contact,
                ),

                /// CALL RECORD PROTOCOL
                RecorderProtocols.onCallBz(
                  bzID: bzModel?.id,
                  contact: contact,
                  authorID: authorID,
                ),

                /// CENSUS
                CensusListener.onCallBz(
                  bzModel: bzModel,
                ),

              ]);

              _contactIsOn = false;
            }

          }
      );


    }

  }

}
// -----------------------------------------------------------------------------
