library super_fire;
// -----------------------------------------------------------------------------

/// COMMON IMPORTS

// --------------------
import 'dart:io';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'dart:async';
// --------------------
import 'package:firedart/firedart.dart' as firedart;
import 'package:firebase_dart/firebase_dart.dart' as fd;
// -----------------------------------------------------------------------------

/// AUTHING IMPORTS

// --------------------
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fireUI;
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
import 'package:cloud_firestore/cloud_firestore.dart' as cloudFire;
// --------------------
export 'package:firebase_core/firebase_core.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
// -----------------------------------------------------------------------------

/// STORAGE IMPORTS

// --------------------
import 'packages/storage/src/foundation/storage_byte_ops.dart';
import 'packages/storage/src/foundation/storage_delete_ops.dart';
import 'packages/storage/src/foundation/storage_file_ops.dart';
import 'packages/storage/src/foundation/storage_meta_ops.dart';
import 'packages/storage/src/foundation/storage_ref.dart';
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
import 'package:firebase_database/firebase_database.dart' as fireDB;
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
part 'packages/authing/methods/a_authing.dart';
part 'packages/authing/methods/b_email_authing.dart';
part 'packages/authing/methods/c_google_authing.dart';
part 'packages/authing/methods/d_facebook_authing.dart';
part 'packages/authing/methods/e_apple_authing.dart';
// --------------------
/// HELPERS
part 'packages/authing/helpers/auth_error.dart';
part 'packages/authing/helpers/auth_blog.dart';
// --------------------
/// MODELS
part 'packages/authing/models/sign_in_method.dart';
part 'packages/authing/models/auth_model.dart';
part 'packages/authing/models/social_keys.dart';
// --------------------
/// WIDGETS
part 'packages/authing/buttons/auth_button_box.dart';
part 'packages/authing/buttons/social_auth_button.dart';
// -----------------------------------------------------------------------------

/// FIRE PARTS

// --------------------
/// FIRE
part 'packages/fire/src/foundation/methods.dart';
// --------------------------------------------
/// FIRE FINDER MODEL
part 'packages/fire/src/models/fire_finder.dart';
/// FIRE QUERY MODEL
part 'packages/fire/src/models/fire_query_model.dart';
/// FIRE COMPARISON
part 'packages/fire/src/models/fire_comparison_enum.dart';
/// QUERY ORDER BY
part 'packages/fire/src/models/query_order_by.dart';
/// SCROLL LISTENERS
part 'packages/fire/src/helpers/scroll_listeners.dart';
// --------------------------------------------
/// FIRE COLL PAGINATOR
part 'packages/fire/src/paginator/fire_coll_paginator.dart';
part 'packages/fire/src/paginator/pagination_controller.dart';
// --------------------------------------------
/// FIRE COLL STREAMER
part 'packages/fire/src/streamer/fire_coll_streamer.dart';
part 'packages/fire/src/streamer/fire_doc_streamer.dart';
// -----------------------------------------------------------------------------

/// STORAGE PARTS

// --------------------
part 'packages/storage/src/methods.dart';
part 'packages/storage/src/pic_meta_model.dart';
// -----------------------------------------------------------------------------

/// REAL PARTS

// --------------------
part 'packages/real/src/methods/real_http.dart';
part 'packages/real/src/methods/real_methods.dart';
part 'packages/real/src/models/real_query_model.dart';
part 'packages/real/src/widgets/real_coll_paginator.dart';
part 'packages/real/src/widgets/real_coll_streamer.dart';
part 'packages/real/src/widgets/real_doc_streamer.dart';
// -----------------------------------------------------------------------------
