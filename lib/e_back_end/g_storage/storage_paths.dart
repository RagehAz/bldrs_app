
/// ------------------------------------o

/*

  | => STORAGE DATA TREE ----------------------|
  |
  | - [admin]
  |     | - stuff ...
  |     | - ...
  |
  | --------------------------|
  |
  | - [phids]
  |     | - {phid}
  |     |     | - phid.jpeg
  |     |     | - ...
  |     |
  |     | - ...
  |
  | --------------------------|  |
  | - [users]
  |     | - {userID}
  |     |     | - pic.jpeg
  |     |     | - ...
  |     |
  |     | - ...
  |
  | --------------------------|
  |
  | - [bzz]
  |     | - {bzID}
  |     |     | - logo.jpeg
  |     |     | - poster.jpeg
  |     |     | - {authorID}.jpeg
  |     |     | - ...
  |     |
  |     | - ...
  |
  | --------------------------|
  |
  | - [flyers]
  |     | - {flyerID}
  |     |     | - attachment.pdf
  |     |     | - poster.jpg
  |     |     | - {slide_id}.jpeg
  |     |     | - ...
  |     |
  |     | - ...
  |
  | -------------------------------------------|

 */

/// ------------------------------------o

abstract class StorageColl{
  // -----------------------------------------------------------------------------

  const StorageColl();

  // -----------------------------------------------------------------------------

  /// COLL NAMES

  // --------------------
  static const String bldrs         = 'storage/bldrs';
  static const String bzz           = 'storage/bzz';
  static const String flyers        = 'storage/flyers';
  static const String users         = 'storage/users';
  static const String phids         = 'storage/phids';
  // --------------------
}
