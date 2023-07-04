import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:bldrs/a_models/c_chain/aa_chain_path_converter.dart';
import 'package:basics/helpers/classes/time/timers.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
/// => TAMAM
@immutable
class PollModel {
  // --------------------------------------------------------------------------
  const PollModel({
    required this.buttons,
    required this.reply,
    required this.replyTime,
  });
  // --------------------------------------------------------------------------
  final List<String>? buttons;
  final String? reply;
  final DateTime? replyTime;
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const String accept = 'phid_accept';
  static const String decline = 'phid_decline';
  static const String pending = 'phid_pending';
  static const String cancel = 'phid_cancel';
  static const String expired = 'phid_expired';
  static const List<String> acceptDeclineButtons = <String>[accept, decline];
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  PollModel copyWith({
    List<String>? buttons,
    String? reply,
    DateTime? replyTime,
  }){
    return PollModel(
      buttons: buttons ?? this.buttons,
      reply: reply ?? this.reply,
      replyTime: replyTime ?? this.replyTime,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    required bool toJSON,
  }){
    return {
      'buttons': cipherButtons(buttons),
      'reply': reply ?? pending,
      'replyTime': Timers.cipherTime(
          time: replyTime,
          toJSON: toJSON,
      ),
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PollModel? decipherPoll({
    required Map<String, dynamic>? map,
    required bool fromJSON,
  }){
    PollModel? _model;

    if (map != null){

      _model = PollModel(
        buttons: decipherButtons(map['buttons']),
        reply: map['reply'],
        replyTime: Timers.decipherTime(
            time: map['replyTime'],
            fromJSON: fromJSON,
        ),
      );

    }

    return _model;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherButtons(List<String>? buttons){
    String? _output;

    if (Mapper.checkCanLoopList(buttons) == true){

      _output = Stringer.generateStringFromStrings(
          strings: buttons,
          stringsSeparator: '/',
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String>? decipherButtons(String? buttonsString){
    List<String>? _buttons;

    // blog('1 - START : decipherButtons : buttonsString: $buttonsString');

    if (TextCheck.isEmpty(buttonsString) == false){

      final List<String> _nodes = ChainPathConverter.splitPathNodes(buttonsString);

      // blog('2 - decipherButtons : _nodes: $_nodes');

      if (Mapper.checkCanLoopList(_nodes) == true){

        final List<String> _cleaned = Stringer.cleanListNullItems(_nodes);

        // blog('3 - decipherButtons : _cleaned: $_cleaned');

        if (Mapper.checkCanLoopList(_cleaned) == true){
          _buttons = _cleaned;
        }

      }

    }

    // blog('4 - END : decipherButtons : _buttons: $_buttons');

    return _buttons;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogPoll(){
    blog('buttons : $buttons : replyTime : $replyTime : reply : $reply');
  }
  // -----------------------------------------------------------------------------

  /// DUMMIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static PollModel dummyPoll(){
    return PollModel(
      buttons: acceptDeclineButtons,
      replyTime: DateTime.now(),
      reply: accept,
    );
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPollsAreIdentical({
    required PollModel? poll1,
    required PollModel? poll2,
  }){
    bool _identical = false;

    if (poll1 == null && poll2 == null){
      _identical = true;
    }

    else {

      if (poll1 != null && poll2 != null){

        if (
            Mapper.checkListsAreIdentical(list1: poll1.buttons, list2: poll2.buttons) &&
            poll1.reply == poll2.reply &&
            Timers.checkTimesAreIdentical(
                accuracy: TimeAccuracy.microSecond,
                time1: poll1.replyTime,
                time2: poll2.replyTime
            ) == true
        ){
          _identical = true;
        }

      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is PollModel){
      _areIdentical = checkPollsAreIdentical(
        poll1: this,
        poll2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      buttons.hashCode^
      replyTime.hashCode^
      reply.hashCode;
  // -----------------------------------------------------------------------------
}
