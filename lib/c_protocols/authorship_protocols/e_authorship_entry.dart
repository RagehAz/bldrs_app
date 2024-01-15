import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/sub/pending_author_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
/// => TAMAM
class AuthorshipEntryProtocols {
  // -----------------------------------------------------------------------------

  const AuthorshipEntryProtocols();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> addMeToBz({
    required String? bzID,
  }) async {

    assert(bzID != null, 'AuthorshipEntryProtocols.addMeToBz : bzID is null');

    blog('AuthorshipEntryProtocols.addMeToBz : START');

    final BzModel? _oldBz = await BzProtocols.fetchBz(
      bzID: bzID,
    );

    /// GET AND MODIFY MY USER MODEL --------------------------
    // NOTE : modify user before bz to allow the user modify the bz in fire security rules
    final UserModel? _oldUser = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );

    UserModel? _newUser = UserModel.addBzIDToUserBzzIDs(
      oldUser: _oldUser,
      bzIDToAdd: _oldBz?.id,
    );

    _newUser = UserModel.addAllBzTopicsToMyTopics(
        oldUser: _newUser,
        bzID: bzID
    );

    /// SUBSCRIBE TO BZ TOPICS
    await NoteProtocols.subscribeToAllBzTopics(
      bzID: bzID,
      renovateUser: false,
    );

    /// UPDATE MY USER MODEL EVERY WHERE --------------------------
    final UserModel? _uploadedUser = await UserProtocols.renovate(
      newUser: _newUser,
      oldUser: _oldUser,
      invoker: 'AuthorshipEntryProtocols.addMeToBz',
    );

    /// MODIFY BZ MODEL --------------------------
    BzModel? _newBz = await BzModel.addNewUserAsAuthor(
      oldBz: _oldBz,
      newUser: _uploadedUser,
    );

    /// upload author pic // author pic model is adjusted inside this method
    final AuthorModel? _author = AuthorModel.getAuthorFromAuthorsByID(
        authors: _newBz?.authors,
        authorID: _uploadedUser?.id,
    );
    await PicProtocols.composePic(_author?.picModel);

    _newBz = PendingAuthor.removePendingAuthorFromBz(
        bzModel: _newBz,
        userID: _uploadedUser?.id,
    );

    /// UPDATE BZ EVERYWHERE PROTOCOL --------------------------
    // final BzModel _uploadedBzModel =
    await BzProtocols.renovateBz(
      oldBz: _oldBz,
      newBz: _newBz,
      showWaitDialog: false,
      newLogo: null,
    );

    blog('AuthorshipEntryProtocols.addMeToBz : END');

    // return _uploadedBzModel;
  }
  // -----------------------------------------------------------------------------
}
