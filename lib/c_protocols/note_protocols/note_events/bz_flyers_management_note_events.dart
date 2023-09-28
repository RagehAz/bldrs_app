import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/a_models/e_notes/aa_trigger_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/b_note_fun_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
/// => TAMAM
class NoteEventsOfBzFlyersManagement {
  // -----------------------------------------------------------------------------

  const NoteEventsOfBzFlyersManagement();

  // -----------------------------------------------------------------------------

  /// SENDERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendFlyerUpdateNoteToItsBz({
    required BzModel? bzModel,
    required String? flyerID,
  }) async {

    blog('NoteEventsOfBzFlyersManagement.sendFlyerUpdateNoteToItsBz : START');

    if (bzModel != null && flyerID != null) {

      final UserModel? _userModel = await UserProtocols.fetch(
        userID: bzModel.authors?.first.userID,
      );

      final FlyerModel? _flyer = await FlyerProtocols.fetchFlyer(
        flyerID: flyerID,
      );

      if (_flyer != null) {

        final String? _title = await Localizer.translateByLangCode(
          phid: 'phid_flyer_has_been_updated',
          langCode: _userModel?.language,
        );

        final NoteModel _note = NoteModel(
          id: null,
          parties: NoteParties(
            senderID: bzModel.id,
            senderImageURL: bzModel.logoPath,
            senderType: PartyType.bz,
            receiverID: bzModel.id,
            receiverType: PartyType.bz,
          ),
          title: _title,
          body: _flyer.headline,
          sentTime: DateTime.now(),
          sendFCM: false,
          topic: TopicModel.bakeTopicID(
            topicID: TopicModel.bzFlyersUpdates,
            bzID: bzModel.id,
            receiverPartyType: PartyType.bz,
          ),
          function: NoteFunProtocols.createFlyerRefetchTrigger(
            flyerID: flyerID,
          ),
          navTo: TriggerModel(
            name: RouteName.flyerPreview,
            argument: flyerID,
            done: const [],
          ),
        );

        await NoteProtocols.composeToOneReceiver(
          note: _note,
        );
      }

    }

    blog('NoteEventsOfBzFlyersManagement.sendFlyerUpdateNoteToItsBz : END');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendFlyerIsVerifiedNoteToBz({
    required String flyerID,
    required String bzID,
  }) async {

    // blog('NoteEventsOfBzFlyersManagement.sendFlyerIsVerifiedNoteToBz : START');

    final BzModel? _bzModel = await BzProtocols.fetchBz(
      bzID: bzID,
    );

    final UserModel? _userModel = await UserProtocols.fetch(
      userID: _bzModel?.authors?.first.userID,
    );

    final String? _title = await Localizer.translateByLangCode(
        phid: 'phid_flyer_has_been_verified',
        langCode: _userModel?.language,
    );

    final String? _body = await Localizer.translateByLangCode(
      phid: 'phid_flyer_is_public_now_and_can_be_seen',
      langCode: _userModel?.language,
    );

    final NoteModel _note = NoteModel(
      id: null,
      parties: NoteParties(
        senderID: Standards.bldrsNotificationSenderID,
        senderImageURL: Standards.bldrsNotificationIconURL,
        senderType: PartyType.bldrs,
        receiverID: bzID,
        receiverType: PartyType.bz,
      ),
      title: _title,
      body: _body,
      sentTime: DateTime.now(),
      function: NoteFunProtocols.createFlyerRefetchTrigger(
        flyerID: flyerID,
      ),
      topic: TopicModel.bakeTopicID(
        topicID: TopicModel.bzVerifications,
        bzID: bzID,
        receiverPartyType: PartyType.bz,
      ),
      navTo: TriggerModel(
        name: RouteName.flyerPreview,
        argument: flyerID,
        done: const [],
      ),
    );

    await NoteProtocols.composeToOneReceiver(
        note: _note
    );

    // blog('NoteEventsOfBzFlyersManagement.sendFlyerIsVerifiedNoteToBz : END');

  }
  // -----------------------------------------------------------------------------
}
