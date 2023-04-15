library super_fire;
// -----------------------------------------------------------------------------

/// COMMON IMPORTS

// --------------------
import 'dart:io';
import 'package:devicer/devicer.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'dart:async';
// -----------------------------------------------------------------------------

/// NATIVE IMPLEMENTATION IMPORTS

// --------------------
import 'package:firedart/firedart.dart' as fd;
import 'package:firebase_dart/firebase_dart.dart' as f_d;
import 'package:firedart/auth/user_gateway.dart' as fd_u;
// -----------------------------------------------------------------------------

/// AUTHING IMPORTS

// --------------------
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as f_a;
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fui;
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/googleapis_auth.dart'; // as gapis;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:space_time/space_time.dart';
import 'package:super_box/super_box.dart';
// --------------------
export 'package:firebase_auth/firebase_auth.dart';
// -----------------------------------------------------------------------------

/// FIRE IMPORTS

// --------------------
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cloud;
// --------------------
export 'package:firebase_core/firebase_core.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
// -----------------------------------------------------------------------------

/// STORAGE IMPORTS

// --------------------
import 'official/storage/src/foundation/storage_byte_ops.dart';
import 'official/storage/src/foundation/storage_delete_ops.dart';
import 'official/storage/src/foundation/storage_file_ops.dart';
import 'official/storage/src/foundation/storage_meta_ops.dart';
import 'official/storage/src/foundation/storage_ref.dart';
// ignore: unnecessary_import
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:numeric/numeric.dart';
import 'package:firebase_storage/firebase_storage.dart';
/// --------------------------------------------------------------------------
export 'package:firebase_storage/firebase_storage.dart';
// -----------------------------------------------------------------------------

/// REAL IMPORTS

// -----------------------------------------------------------------------------
import 'dart:convert';
import 'package:animators/animators.dart';
import 'package:firebase_database/firebase_database.dart' as f_db;
import 'package:http/http.dart' as http;
// -----------------------------------------------------------------------------
///
// --------------------

/// PARTS

// --------------------
///
// -----------------------------------------------------------------------------

/// AUTHING PARTS

// --------------------
/// METHODS
part 'official/authing/methods/a_authing.dart';
part 'official/authing/methods/b_email_authing.dart';
part 'official/authing/methods/c_google_authing.dart';
part 'official/authing/methods/d_facebook_authing.dart';
part 'official/authing/methods/e_apple_authing.dart';
// --------------------
/// HELPERS
part 'official/authing/helpers/auth_error.dart';
part 'official/authing/helpers/auth_blog.dart';
// --------------------
/// MODELS
part 'official/authing/models/sign_in_method.dart';
part 'official/authing/models/auth_model.dart';
part 'official/authing/models/social_keys.dart';
// --------------------
/// WIDGETS
part 'official/authing/buttons/auth_button_box.dart';
part 'official/authing/buttons/social_auth_button.dart';
// -----------------------------------------------------------------------------

/// FIRE PARTS

// --------------------
/// FIRE
part 'official/fire/src/foundation/methods.dart';
// --------------------------------------------
/// FIRE FINDER MODEL
part 'official/fire/src/models/fire_finder.dart';
/// FIRE QUERY MODEL
part 'official/fire/src/models/fire_query_model.dart';
/// FIRE COMPARISON
part 'official/fire/src/models/fire_comparison_enum.dart';
/// QUERY ORDER BY
part 'official/fire/src/models/query_order_by.dart';
/// SCROLL LISTENERS
part 'official/fire/src/helpers/scroll_listeners.dart';
// --------------------------------------------
/// FIRE COLL PAGINATOR
part 'official/fire/src/paginator/fire_coll_paginator.dart';
part 'official/fire/src/paginator/pagination_controller.dart';
// --------------------------------------------
/// FIRE COLL STREAMER
part 'official/fire/src/streamer/fire_coll_streamer.dart';
part 'official/fire/src/streamer/fire_doc_streamer.dart';
// -----------------------------------------------------------------------------

/// STORAGE PARTS

// --------------------
part 'official/storage/src/methods.dart';
part 'official/storage/src/pic_meta_model.dart';
// -----------------------------------------------------------------------------

/// REAL PARTS

// --------------------
part 'official/real/src/methods/real_http.dart';
part 'official/real/src/methods/real_methods.dart';
part 'official/real/src/models/real_query_model.dart';
part 'official/real/src/widgets/real_coll_paginator.dart';
part 'official/real/src/widgets/real_coll_streamer.dart';
part 'official/real/src/widgets/real_doc_streamer.dart';
// -----------------------------------------------------------------------------

/// NATIVE PARTS

// --------------------
part 'native/native_fire.dart';
part 'native/native_storage.dart';
part 'native/native_real.dart';
part 'native/native_auth.dart';
part 'native/native_initializer.dart';
// -----------------------------------------------------------------------------
