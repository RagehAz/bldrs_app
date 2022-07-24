

import 'package:bldrs/c_protocols/author_protocols/wipe_authors.dart';
import 'package:flutter/material.dart';

class AuthorProtocols {

  AuthorProtocols();
// -----------------------------------------------------------------------------

/// COMPOSE

// ----------------------------------

// -----------------------------------------------------------------------------

/// FETCH

// ----------------------------------

// -----------------------------------------------------------------------------

/// RENOVATE

// ----------------------------------

// -----------------------------------------------------------------------------

/// WIPE

// ----------------------------------
  static Future<void> deleteMyAuthorPicProtocol({
    @required BuildContext context,
    @required String bzID,
  }) => WipeAuthorProtocols.deleteMyAuthorPicProtocol(
      context: context,
      bzID: bzID
  );
// -----------------------------------------------------------------------------
}
