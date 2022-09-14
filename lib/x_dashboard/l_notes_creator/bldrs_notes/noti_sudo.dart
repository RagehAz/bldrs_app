import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/foundation.dart';

enum NotiSubject {
  ad,
  welcome,
  newFlyer,
  event,
  reminder,
  education,
  non,
}

enum NotiRecieverType {
  user,
  users,
  author,
  authors,
}

enum CityState {
  private,

  /// app shows bzz only ,, all flyers hidden to public,, currently building content
  public,

  /// app shows all
  any,
}

class NotiPseudo {
  /// --------------------------------------------------------------------------
  const NotiPseudo({
    @required this.subject,
    @required this.eventTrigger,
    @required this.scheduledTiming,
    @required this.ifStatement,
    @required this.cityState,
    @required this.reciever,
  });
  /// --------------------------------------------------------------------------
  final NotiSubject subject;
  final String eventTrigger;
  final String scheduledTiming;
  final String ifStatement;
  final CityState cityState;
  final NotiRecieverType reciever;
  /// --------------------------------------------------------------------------
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subject': cipherNotiSubject(subject),
      'eventTrigger': eventTrigger,
      'scheduledTiming': scheduledTiming,
      'ifStatement': ifStatement,
      'cityState': cipherCityState(cityState),
      'reciever': cipherNotiReciever(reciever),
    };
  }
  // -----------------------------------------------------------------------------
  static NotiPseudo decipherNotiSudo(Map<String, dynamic> map) {
    NotiPseudo _sudo;
    if (map != null) {
      _sudo = NotiPseudo(
        subject: decipherNotiSubject(map['subject']),
        eventTrigger: map['eventTrigger'],
        scheduledTiming: map['scheduledTiming'],
        ifStatement: map['ifStatement'],
        cityState: decipherCityState(map['cityState']),
        reciever: decipherNotiReciever(map['reciever']),
      );
    }

    return _sudo;
  }
  // --------------------
  static String cipherNotiReciever(NotiRecieverType reciever) {
    switch (reciever) {
      case NotiRecieverType.author:
        return 'author';
        break;
      case NotiRecieverType.authors:
        return 'authors';
        break;
      case NotiRecieverType.user:
        return 'user';
        break;
      case NotiRecieverType.users:
        return 'users';
        break;
      default:
        return 'user';
    }
  }
  // --------------------
  static NotiRecieverType decipherNotiReciever(String reciever) {
    switch (reciever) {
      case 'author':
        return NotiRecieverType.author;
        break;
      case 'authors':
        return NotiRecieverType.authors;
        break;
      case 'user':
        return NotiRecieverType.user;
        break;
      case 'users':
        return NotiRecieverType.users;
        break;
      default:
        return NotiRecieverType.user;
    }
  }
  // --------------------
  static String cipherNotiSubject(NotiSubject notiSubject) {
    switch (notiSubject) {
      case NotiSubject.ad:
        return 'ad';
        break;
      case NotiSubject.welcome:
        return 'welcome';
        break;
      case NotiSubject.education:
        return 'education';
        break;
      case NotiSubject.event:
        return 'event';
        break;
      case NotiSubject.newFlyer:
        return 'newFlyer';
        break;
      case NotiSubject.reminder:
        return 'reminder';
        break;
      default:
        return 'non';
    }
  }
  // --------------------
  static NotiSubject decipherNotiSubject(String notiSubject) {
    switch (notiSubject) {
      case 'ad':
        return NotiSubject.ad;
        break;
      case 'welcome':
        return NotiSubject.welcome;
        break;
      case 'education':
        return NotiSubject.education;
        break;
      case 'event':
        return NotiSubject.event;
        break;
      case 'newFlyer':
        return NotiSubject.newFlyer;
        break;
      case 'reminder':
        return NotiSubject.reminder;
        break;
      default:
        return NotiSubject.non;
    }
  }
  // --------------------
  static String cipherCityState(CityState cityState) {
    switch (cityState) {
      case CityState.public:
        return 'public';
        break;
      case CityState.private:
        return 'private';
        break;
      case CityState.any:
        return 'any';
        break;
      default:
        return 'any';
    }
  }
  // --------------------
  static CityState decipherCityState(String cityState) {
    switch (cityState) {
      case 'public':
        return CityState.public;
        break;
      case 'private':
        return CityState.private;
        break;
      case 'any':
        return CityState.any;
        break;
      default:
        return CityState.any;
    }
  }
  // -----------------------------------------------------------------------------
  void printSudo({@required String methodName}) {
    blog('$methodName : PRINTING NOTI SUDO ---------------- START -- ');

    blog('subject : $subject');
    blog('eventTrigger : $eventTrigger');
    blog('scheduledTiming : $scheduledTiming');
    blog('ifStatement : $ifStatement');
    blog('cityState : $cityState');
    blog('reciever : $reciever');

    blog('$methodName : PRINTING NOTI SUDO ---------------- END -- ');
  }
  // -----------------------------------------------------------------------------
}
