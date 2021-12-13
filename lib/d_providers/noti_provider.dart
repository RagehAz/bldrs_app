import 'package:bldrs/a_models/notification/noti_model.dart';
import 'package:flutter/material.dart';

// final NotiProvider _notiProvider = Provider.of<NotiProvider>(context, listen: false);
class NotiProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------
  /// NOTIFICATION IS ON
  bool _notiIsOn = false;
// -------------------------------------
  bool get notiIsOn {
    return _notiIsOn;
  }

// -------------------------------------
  void triggerNotiIsOn({bool setNotiIsOn}) {
    if (setNotiIsOn == null) {
      _notiIsOn = !_notiIsOn;
    } else {
      _notiIsOn = setNotiIsOn;
    }

    notifyListeners();
  }

// -----------------------------------------------------------------------------
  List<NotiModel> _unreadNotiModels;
// -------------------------------------
  List<NotiModel> get unreadNotiModels {
    return [..._unreadNotiModels];
  }

// -------------------------------------
  void getSetNotiModels() {
    /// TASK : get notifications
    /// TASK : set notifications

    _unreadNotiModels = [];
    notifyListeners();
  }
// -----------------------------------------------------------------------------

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

}
