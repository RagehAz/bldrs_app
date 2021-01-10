import 'enums/enum_bz_form.dart';
import 'enums/enum_bz_type.dart';

class BzModel {
  final String bzId;
  BzType bzType; // was final
  BzForm bzForm; // was final
  String bzName; // was final
  dynamic bzLogo; // was final String
  final String bzCountry; // countryID
  final String bzCity; // cityID
  final List<String> bzFieldsList;
  final int bzBirth;
  final int bldrBirth;
  String bzAbout; // was final
  final bool bzShowsTeam;
  final bool bzWhatsAppIsOn;
  final bool bzIsVerified;
  final bool bzAccountCanPublish;
  final bool bzAccountIsPublished;
  String bzScope;

  BzModel({
    this.bzId, // -- was @required
    this.bzType, // -- was @required
    this.bzForm, // -- was @required
    this.bzName, // -- was @required
    this.bzLogo, // -- was @required
    this.bzCountry, // -- was @required
    this.bzCity, // -- was @required
    this.bzFieldsList, // -- was @required
    this.bzAbout, // -- was @required
    this.bzShowsTeam, // -- was @required
    this.bldrBirth, // -- was @required
    this.bzIsVerified, // -- was @required
    this.bzAccountCanPublish, // -- was @required
    this.bzAccountIsPublished, // -- was @required
    this.bzWhatsAppIsOn, // -- was @required
    this.bzBirth, // -- was @required
    this.bzScope,
});
}
