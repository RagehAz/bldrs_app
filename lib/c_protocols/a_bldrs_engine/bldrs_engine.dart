library bldrs_engine;

import 'dart:async';
import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/checks/errorize.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/mediator/sounder/sounder.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/a_models/e_notes/c_channel_model.dart';
import 'package:bldrs/bldrs_keys.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/countries_phrases_protocols/countries_phrases_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/e_back_end/e_fcm/background_msg_handler.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm_starter.dart';
import 'package:bldrs/e_back_end/f_cloud/dynamic_links.dart';
import 'package:bldrs/e_back_end/i_app_check/app_check.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/firebase_options.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/main.dart';
import 'package:fire/super_fire.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:universal_html/html.dart';
import 'package:basics/components/sensors/app_version_builder.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/a_models/x_secondary/app_state_model.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/app_state_protocols.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/time/timers.dart';
import 'package:bldrs/b_screens/x_on_boarding/a_on_boarding_screen.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_timers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/c_protocols/authorship_protocols/f_new_authorship_exit.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/a_user/account_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/e_notes/aa_device_model.dart';
import 'package:bldrs/b_screens/b_user_screens/c_user_editor_screen/user_editor_screen.dart';
import 'package:bldrs/c_protocols/auth_protocols/account_ldb_ops.dart';
import 'package:bldrs/c_protocols/records_protocols/recorder_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';

part 'src/a_engine.dart';
part 'src/b_app_state_initializer.dart';
part 'src/c_ui_initializer.dart';
part 'src/d_user_initializer.dart';
part 'src/d_user_session_starter.dart';
part 'src/d_user_spawner.dart';
part 'src/e_bzz_initializations.dart';
