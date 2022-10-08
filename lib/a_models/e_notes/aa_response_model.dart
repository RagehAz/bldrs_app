import 'package:bldrs/a_models/c_chain/aa_chain_path_converter.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:flutter/material.dart';

@immutable
class PollModel {
  /// --------------------------------------------------------------------------
  const PollModel({
    @required this.buttons,
    @required this.reply,
    @required this.replyTime,
  });
  /// --------------------------------------------------------------------------
  final List<String> buttons;
  final String reply;
  final DateTime replyTime;
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const String accept = 'phid_accept';
  static const String decline = 'phid_decline';
  static const String pending = 'phid_pending';
  static const List<String> acceptDeclineButtons = <String>[accept, decline];
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  PollModel copyWith({
    List<String> buttons,
    String reply,
    DateTime replyTime,
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
  ///
  Map<String, dynamic> toMap({
    @required bool toJSON,
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
  ///
  static PollModel decipherPoll({
    @required Map<String, dynamic> map,
    @required bool fromJSON,
  }){
    PollModel _model;

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
  ///
  static String cipherButtons(List<String> buttons){
    String _output;

    if (Mapper.checkCanLoopList(buttons) == true){

      _output = Stringer.generateStringFromStrings(
          strings: buttons,
          stringsSeparator: '/',
      );

    }

    return _output;
  }
  // --------------------
  ///
  static List<String> decipherButtons(String buttonsString){
    return ChainPathConverter.splitPathNodes(buttonsString);
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  ///
  static bool checkPollsAreIdentical({
    @required PollModel poll1,
    @required PollModel poll2,
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

  /// BLOGGING

  // --------------------
  ///
  void blogPoll(){
    blog('buttons : $buttons : replyTime : $replyTime : reply : $reply');
  }
  // -----------------------------------------------------------------------------

  /// DUMMIES

  // --------------------
  ///
  static PollModel dummyPoll(){
    return PollModel(
      buttons: acceptDeclineButtons,
      replyTime: DateTime.now(),
      reply: accept,
    );
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
