import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:flutter/material.dart';

// final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
class NotesProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------

  /// USER NOTES

// -------------------------------------
  /// NOTIFICATION IS ON
  bool _notiIsOn = false;
// -------------------------------------
  bool get notiIsOn {
    return _notiIsOn;
  }
// -------------------------------------
  void triggerNotiIsOn({
    @required bool notify,
    bool setNotiIsOn,
  }) {
    if (setNotiIsOn == null) {
      _notiIsOn = !_notiIsOn;
    } else {
      _notiIsOn = setNotiIsOn;
    }

    if (notify == true){
      notifyListeners();
    }
  }
// -----------------------------------------------------------------------------

  /// UNREAD NOTES

// -------------------------------------
  List<NoteModel> _unseenUserNotes = <NoteModel>[];
// -------------------------------------
  List<NoteModel> get unreadNotifications => _unseenUserNotes;
// -------------------------------------
  void getSetNotiModels({
  @required bool notify,
}) {
    /// TASK : get notifications
    /// TASK : set notifications

    _unseenUserNotes = [];
    if (notify == true){
      notifyListeners();
    }
  }
// -----------------------------------------------------------------------------

  /// BZZ NOTES

// -------------------------------------

  /// P

  List<NoteModel> _unseenBzzNotes = <NoteModel>[];
  List<NoteModel> get unseenBzzNotes => _unseenBzzNotes;
// -------------------------------------

}

/*

  //   NotiModel _noti;
  bool _notiIsOn = false;
Future<void> receiveAndActUponNoti({dynamic msgMap, NotiType notiType}) async {
  blog('receiveAndActUponNoti : notiType : $notiType');

  final NotiModel _noti = await NotiOps.receiveAndActUponNoti(
    context: context,
    notiType: notiType,
    msgMap: msgMap,
  );

  if (_noti != null){
    setState(() {
      // _noti = noti;
      _notiIsOn = true;
    });
  }

}
// -----------------------------------------------------------------------------


   */
