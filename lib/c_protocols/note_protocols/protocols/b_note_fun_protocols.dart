import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_trigger_model.dart';
import 'package:bldrs/c_protocols/authorship_protocols/a_authorship_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class NoteFunProtocols {
  /// --------------------------------------------------------------------------

  const NoteFunProtocols();
  // -----------------------------------------------------------------------------

  /// CONSTANTS (trid = trigger ID)

  // --------------------
  /// -> fires refetch flyer protocol
  static const String funRefetchFlyer = 'funRefetchFlyer';
  // --------------------
  /// -> fires refetchBZ
  static const String funRefetchBz = 'funRefetchBz';
  // --------------------
  // /// -> shows note buttons + allows [ add Me To Bz Protocol ] + allows [ decline authorship protocol ]
  // static const String tridAuthorshipInvitation = 'tridAuthorshipInvitation';
  // --------------------
  /// -> fire AuthorshipProtocols.addMeToBz
  static const String funAddMeAsAuthorToBz = 'funAddMeAsAuthorToBz';
  // --------------------
  /// -> fires AuthorshipProtocols.removeMeAsAuthorAfterBzDeletion
  static const String funRemoveBzTracesAfterDeletion = 'funRemoveBzTracesAfterDeletion';
  // --------------------
  /// -> fires BzProtocols.wipePendingAuthor
  static const String funWipePendingAuthor = 'funWipePendingAuthor';
  // --------------------
  /// -> fires FlyerProtocols.deleteAllBzFlyersLocally
  static const String funDeleteAllBzFlyersLocally = 'funDeleteAllBzFlyersLocally';
  // --------------------
  static const List<String> triggersList = [
    funRefetchFlyer,
    funRefetchBz,
    funAddMeAsAuthorToBz,
    funRemoveBzTracesAfterDeletion,
    funWipePendingAuthor,
    funDeleteAllBzFlyersLocally,
  ];
  // -----------------------------------------------------------------------------

  /// CREATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static TriggerModel createFlyerRefetchTrigger({
    @required String flyerID,
  }){
    return TriggerModel(
      name: funRefetchFlyer,
      argument: flyerID,
      done: const <String>[],
    );
  }
  // --------------------
  ///
  /*
  static TriggerModel createAuthorshipAcceptanceTrigger(){
    return null;
  }
  */
  // --------------------
  /// TESTED : WORKS PERFECT
  static TriggerModel createDeleteBzLocallyTrigger({
    @required String bzID,
  }){
    return TriggerModel(
      name: funRemoveBzTracesAfterDeletion,
      argument: bzID,
      done: const <String>[],
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static TriggerModel createRefetchBzTrigger({
    @required String bzID,
  }){
    return TriggerModel(
      name: funRefetchBz,
      argument: bzID,
      done: const <String>[],
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static TriggerModel createDeletePendingAuthorTrigger({
    @required String userID,
    @required String bzID,
  }){
    return TriggerModel(
      name: funWipePendingAuthor,
      argument: '${userID}_$bzID',
      done: const <String>[],
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static TriggerModel createDeleteAllBzzFlyersLocally({
    @required String bzID,
  }){
    return TriggerModel(
      name: funDeleteAllBzFlyersLocally,
      argument: bzID,
      done: const <String>[],
    );
  }
  // -----------------------------------------------------------------------------

  /// FIRE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> fireTriggers({
    @required BuildContext context,
    @required List<NoteModel> notes,
  }) async {

    if (Mapper.checkCanLoopList(notes) == true){

      await Future.wait(<Future>[

        ...List.generate(notes.length, (index){

          return _fireTrigger(
              context: context,
              noteModel: notes[index],
          );

      }),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _fireTrigger({
    @required BuildContext context,
    @required NoteModel noteModel,
  }) async {

    blog('TriggerProtocols._fireTrigger  (noteID : ${noteModel.id}) -- START');

    if (
        noteModel != null
        &&
        noteModel.function != null
        &&
        TriggerModel.checkIFiredThisTrigger(noteModel.function) == false
    ){

      await _triggerSwitcher(
        context: context,
        trigger: noteModel.function,
      );

      final NoteModel _newNote = TriggerModel.addMeToTriggerDones(
        noteModel: noteModel,
      );

      await NoteProtocols.renovate(
        context: context,
        oldNote: noteModel,
        newNote: _newNote,
      );

      blog('trigger is done successfully');
    }

    else {
      blog('trigger already fired');
    }

    blog('TriggerProtocols._fireTrigger  (noteID : ${noteModel.id}) -- END');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _triggerSwitcher({
    @required BuildContext context,
    @required TriggerModel trigger,
  }) async {

    assert(
    TriggerModel.checkIFiredThisTrigger(trigger) == false,
    'This user ${AuthFireOps.superUserID()} already fired this trigger ${trigger.name}',
    );

    if (trigger != null && TriggerModel.checkIFiredThisTrigger(trigger) == false){

      blog('1--> Switcher : ${trigger.name} : ${trigger.argument} : ${trigger.done}');

      switch(trigger.name){
      // ----------
      /// ADD ME AS NEW AUTHOR TO BZ
        case funAddMeAsAuthorToBz:
          blog('2--> Switcher : FIRING : ADD ME TO BZ FOR (${trigger.argument}) : START');
          await AuthorshipProtocols.addMeToBz(
            context: context,
            bzID: trigger.argument,
          );
          blog('3--> Switcher : FIRING : END');
          break;
      // ----------
      /// ADD ME AS NEW AUTHOR TO BZ
        case funRemoveBzTracesAfterDeletion:
          blog('2--> Switcher : FIRING : REMOVE BZ TRACES FOR (${trigger.argument}) : START');
          await AuthorshipProtocols.removeBzTracesAfterDeletion(
            context: context,
            bzID: trigger.argument,
          );
          blog('3--> Switcher : FIRING : END');
          break;
      // ----------
      /// REFETCH FLYER
        case funRefetchFlyer:
          blog('2--> Switcher : FIRING : REFETCH FLYER FOR (${trigger.argument}) : START');
          await FlyerProtocols.refetch(
            context: context,
            flyerID: trigger.argument,
          );
          blog('3--> Switcher : FIRING : END');
          break;
      // ----------
      /// REFETCH BZ
        case funRefetchBz:
          blog('2--> Switcher : FIRING : REFETCH BZ (${trigger.argument}) : START');
          await BzProtocols.refetch(
            context: context,
            bzID: trigger.argument,
          );
          blog('3--> Switcher : FIRING : END');
          break;
      // ----------
      /// REFETCH BZ
        case funWipePendingAuthor:
          blog('2--> Switcher : FIRING : WIPE PENDING AUTHOR (${trigger.argument}) : START');
          // argument: '${userID}_$bzID',
          await BzProtocols.wipePendingAuthor(
            context: context,
            pendingUserID: TextMod.removeTextAfterFirstSpecialCharacter(trigger.argument, '_'),
            bzID: TextMod.removeTextBeforeFirstSpecialCharacter(trigger.argument, '_'),
          );
          blog('3--> Switcher : FIRING : END');
          break;
      // ----------
      /// REFETCH BZ
        case funDeleteAllBzFlyersLocally:
          blog('2--> Switcher : FIRING : DELETE ALL BZ FLYERS LOCALLY (${trigger.argument}) : START');
          // argument: '${userID}_$bzID',
          await FlyerProtocols.deleteAllBzFlyersLocally(
            context: context,
            bzID: trigger.argument,
          );
          blog('3--> Switcher : FIRING : END');
          break;
      // ----------
      /// DEFAULT
        default:
          blog('2--> Switcher : : FIRING : nothing to fire');
      // ----------
      }

      blog('X--> Switcher : DONE WITH FIRING');

    }

    else {
      blog('X--> Switcher : trigger is null or already fired : END');

    }

  }
  // -----------------------------------------------------------------------------
}