import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_trigger_model.dart';
import 'package:bldrs/c_protocols/authorship_protocols/a_authorship_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class TriggerProtocols {
  /// --------------------------------------------------------------------------

  const TriggerProtocols();
  // -----------------------------------------------------------------------------

  /// CONSTANTS (trid = trigger ID)

  // --------------------
  /// -> fires refetch flyer protocol
  static const String tridRefetchFlyer = 'tridRefetchFlyer';
  // --------------------
  /// -> fires refetchBZ
  static const String tridRefetchBz = 'tridRefetchBz';
  // --------------------
  // /// -> shows note buttons + allows [ add Me To Bz Protocol ] + allows [ decline authorship protocol ]
  // static const String tridAuthorshipInvitation = 'tridAuthorshipInvitation';
  // --------------------
  /// -> fire AuthorshipProtocols.addMeToBz
  static const String tridAddMeAsAuthorToBz = 'tridAddMeAsAuthorToBz';
  // --------------------
  /// -> fires AuthorshipProtocols.removeMeAsAuthorAfterBzDeletion
  static const String tridRemoveBzTracesAfterDeletion = 'tridRemoveBzTracesAfterDeletion';
  // --------------------
  /// -> fires BzProtocols.tridWipePendingAuthor
  static const String tridWipePendingAuthor = 'tridWipePendingAuthor';
  // -----------------------------------------------------------------------------

  /// CREATORS

  // --------------------
  ///
  static TriggerModel createFlyerRefetchTrigger({ /// re-fetch flyer
    @required String flyerID,
  }){
    return TriggerModel(
      name: tridRefetchFlyer,
      argument: flyerID,
      done: false,
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
  ///
  static TriggerModel createDeleteBzLocallyTrigger({
    @required String bzID,
  }){
    return TriggerModel(
      name: tridRemoveBzTracesAfterDeletion,
      argument: bzID,
      done: false,
    );
  }
  // --------------------
  ///
  static TriggerModel createRefetchBzTrigger({
    @required String bzID,
  }){
    return TriggerModel(
      name: tridRefetchBz,
      argument: bzID,
      done: false,
    );
  }
  // --------------------
  ///
  static TriggerModel createDeletePendingAuthorTrigger({
    @required String userID,
    @required String bzID,
  }){
    return TriggerModel(
      name: tridWipePendingAuthor,
      argument: '${userID}_$bzID',
      done: false,
    );
  }
  // -----------------------------------------------------------------------------

  /// FIRE

  // --------------------
  ///
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
  ///
  static Future<void> _fireTrigger({
    @required BuildContext context,
    @required NoteModel noteModel,
  }) async {

    blog('TriggerProtocols._fireTrigger  (noteID : ${noteModel.id}) -- START');

    if (
        noteModel != null
        &&
        noteModel.trigger != null
        &&
        noteModel?.trigger?.done == false
    ){

      await _triggerSwitcher(
        context: context,
        trigger: noteModel.trigger,
      );

      final TriggerModel _updatedTrigger = noteModel.trigger.copyWith(
        done: true,
      );

      final NoteModel _newNote = noteModel.copyWith(
        trigger: _updatedTrigger,
      );

      await NoteProtocols.renovate(
        context: context,
        oldNote: noteModel,
        newNote: _newNote,
      );


    }

    blog('TriggerProtocols._fireTrigger  (noteID : ${noteModel.id}) -- END');

  }
  // --------------------
  ///
  static Future<void> _triggerSwitcher({
    @required BuildContext context,
    @required TriggerModel trigger,
  }) async {

    if (trigger != null && trigger.done == false){

      blog('1--> Switcher : ${trigger.name} : ${trigger.argument} : ${trigger.done}');

      switch(trigger.name){
      // ----------
      /// ADD ME AS NEW AUTHOR TO BZ
        case tridAddMeAsAuthorToBz:
          blog('2--> Switcher : FIRING : ADD ME TO BZ FOR (${trigger.argument}) : START');
          await AuthorshipProtocols.addMeToBz(
            context: context,
            bzID: trigger.argument,
          );
          blog('3--> Switcher : FIRING : END');
          break;
      // ----------
      /// ADD ME AS NEW AUTHOR TO BZ
        case tridRemoveBzTracesAfterDeletion:
          blog('2--> Switcher : FIRING : REMOVE BZ TRACES FOR (${trigger.argument}) : START');
          await AuthorshipProtocols.removeBzTracesAfterDeletion(
            context: context,
            bzID: trigger.argument,
          );
          blog('3--> Switcher : FIRING : END');
          break;
      // ----------
      /// REFETCH FLYER
        case tridRefetchFlyer:
          blog('2--> Switcher : FIRING : REFETCH FLYER FOR (${trigger.argument}) : START');
          await FlyerProtocols.refetch(
            context: context,
            flyerID: trigger.argument,
          );
          blog('3--> Switcher : FIRING : END');
          break;
      // ----------
      /// REFETCH BZ
        case tridRefetchBz:
          blog('2--> Switcher : FIRING : REFETCH BZ (${trigger.argument}) : START');
          await BzProtocols.refetch(
            context: context,
            bzID: trigger.argument,
          );
          blog('3--> Switcher : FIRING : END');
          break;
      // ----------
      /// REFETCH BZ
        case tridWipePendingAuthor:
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
