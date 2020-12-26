import 'package:flutter/foundation.dart';

import 'enums/enum_bz_form.dart';
import 'enums/enum_bz_type.dart';

class BzModel {
  final String bzId;
  final BzType bzType;
  final BzForm bzForm;
  final String bzName;
  final String bzLogo;
  final String bzCountry; // countryID
  final String bzCity; // cityID
  final List<String> bzFieldsList;
  final int bzBirth;
  final int bldrBirth;
  final String bzAbout;
  final bool bzShowsTeam;
  final bool bzWhatsAppIsOn;
  final bool bzIsVerified;
  final bool bzAccountCanPublish;
  final bool bzAccountIsPublished;

  BzModel({
    @required this.bzId,
    @required this.bzType,
    @required this.bzForm,
    @required this.bzName,
    @required this.bzLogo,
    @required this.bzCountry,
    @required this.bzCity,
    @required this.bzFieldsList,
    @required this.bzAbout,
    @required this.bzShowsTeam,
    @required this.bldrBirth,
    @required this.bzIsVerified,
    @required this.bzAccountCanPublish,
    @required this.bzAccountIsPublished,
    @required this.bzWhatsAppIsOn,
    @required this.bzBirth,
});
}
