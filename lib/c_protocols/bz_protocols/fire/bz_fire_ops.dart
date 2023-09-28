import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/g_statistics/records/record_type.dart';
import 'package:bldrs/a_models/x_secondary/feedback_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/feedback_protocols/real/app_feedback_real_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class BzFireOps {
  // -----------------------------------------------------------------------------

  const BzFireOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> createEmptyBzDocToGetBzID() async {

    blog('_createEmptyBzDocToGetBzID : START');

    final String? docID = await Fire.createDoc(
      coll: FireColl.bzz,
      input: <String, dynamic>{
        'name': 'x',
      },
    );

    blog('_createEmptyBzDocToGetBzID : END');

    return docID;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel?> readBz({
    required String? bzID,
  }) async {

    if (bzID == null){
      return null;
    }

    final dynamic _bzMap = await Fire.readDoc(
      coll: FireColl.bzz,
      doc: bzID,
    );

    final BzModel? _bz = BzModel.decipherBz(
      map: _bzMap,
      fromJSON: false,
    );

    return _bz;
  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static Future<dynamic> readAndFilterTeamlessBzzByUserModel({
    required BuildContext context,
    required UserModel userModel,
  }) async {
    // ----------
    /// This returns Map<String, dynamic> for which user bzz can he delete
    /// user can delete his bz only if he is the only author
    /// 1 - read all user['myBzzIDs'] bzz
    /// 2 - filters which bz can be deleted and which can not be deleted
    /// 3 - return {'bzzToKeep' : _bzzToKeep, 'bzzToDeactivate' : _bzzToDeactivate, }
    // ----------

    final List<BzModel> _bzzToDeactivate = <BzModel>[];
    final List<BzModel> _bzzToKeep = <BzModel>[];
    for (final String id in userModel.myBzzIDs) {

      final BzModel _bz = await readBz(bzID: id);

      if (_bz.authors.length == 1) {
        _bzzToDeactivate.add(_bz);
      } else {
        _bzzToKeep.add(_bz);
      }
    }

    final Map<String, dynamic> _bzzMap = <String, dynamic>{
      'bzzToKeep': _bzzToKeep,
      'bzzToDeactivate': _bzzToDeactivate,
    };

    return _bzzMap;
  }
   */
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> update(BzModel? bzModel) async {

    if (bzModel?.id != null){

      await Fire.updateDoc(
        coll: FireColl.bzz,
        doc: bzModel!.id!,
        input: bzModel.toMap(toJSON: false),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE BZ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> delete({
    required BzModel? bzModel,
  }) async {

    blog('_deleteBzDoc : START');

    if (bzModel?.id != null){

      await Fire.deleteDoc(
        coll: FireColl.bzz,
        doc: bzModel!.id!,
      );

    }

    blog('_deleteBzDoc : END');

  }
  // -----------------------------------------------------------------------------

  /// REPORT BZ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> reportBz({
    required BuildContext context,
    required BzModel? bzModel,
  }) async {

    if (bzModel != null){

      final UserModel? _user = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

      if (Authing.userIsSignedUp(_user?.signInMethod) == false) {
        await Dialogs.youNeedToBeSignedUpDialog(
          afterHomeRouteName: RouteName.bzPreview,
          afterHomeRouteArgument: bzModel.id,
        );
      }

      else {

        String? _feedback;

        await BottomDialog.showButtonsBottomDialog(
            numberOfWidgets: 3,
            titleVerse: const Verse(
              id: 'phid_report_bz_account',
              translate: true,
            ),
            builder: (_) {
              return <Widget>[
                /// INAPPROPRIATE CONTENT
                BottomDialog.wideButton(
                    verse: const Verse(
                      pseudo: 'This Account published Inappropriate content',
                      id: 'phid_account_published_inapp_content',
                      translate: true,
                    ),
                    onTap: () async {
                      _feedback = 'This Account published Inappropriate content';
                      await Nav.goBack(
                        context: context,
                        invoker: 'reportBz.Inappropriate',
                      );
                    }),

                /// COPY RIGHTS
                BottomDialog.wideButton(
                    verse: const Verse(
                      pseudo: 'This Account violates copyrights',
                      id: 'phid_account_published_copyright_violation',
                      translate: true,
                    ),
                    onTap: () async {
                      _feedback = 'This Account violates copyrights';
                      await Nav.goBack(
                        context: context,
                        invoker: 'reportBz.copyrights',
                      );
                    }),
              ];
            });

        if (_feedback != null) {
          final FeedbackModel _model = FeedbackModel(
            userID: Authing.getUserID(),
            timeStamp: DateTime.now(),
            feedback: _feedback,
            modelType: ModelType.bz,
            modelID: bzModel.id,
          );

          final FeedbackModel? _docRef = await FeedbackRealOps.createFeedback(
            feedback: _model,
          );

          if (_docRef != null) {
            await Dialogs.weWillLookIntoItNotice();
          }
        }

      }

    }

  }
  // -----------------------------------------------------------------------------
}
