import 'package:bldrs/models/old_models_to_delete_when_done/contact_model.dart';
import 'package:bldrs/models/old_models_to_delete_when_done/location_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:flutter/foundation.dart';

class CoUser {
  final UserModel user;
  final List<ContactModel> userContacts;
  final LocationModel userLocation;

  CoUser({
    @required this.user,
    @required this.userContacts,
    @required this.userLocation,
  });
}
