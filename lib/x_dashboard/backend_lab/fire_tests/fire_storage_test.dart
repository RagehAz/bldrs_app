
import 'dart:io';

import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/f_cloud/cloud_functions.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/ui_manager/bldrs_icons_screen.dart';
import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class FireStorageTest extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FireStorageTest({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _FireStorageTestState createState() => _FireStorageTestState();
/// --------------------------------------------------------------------------
}

class _FireStorageTestState extends State<FireStorageTest> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------

    return DashBoardLayout(
      loading: _loading,
      pageTitle: 'Fire storage test',
      listWidgets: <Widget>[

        /// PICK ICONS AND UPLOAD
        WideButton(
          verse: Verse.plain('Upload pic to Storage'),
          onTap: () async {

            final List<String> _icons = await BldrsIconsScreen.selectIcons(context);

            final List<File> _files = await Filers.getFilesFromLocalRasterImages(
              localAssets: _icons,
            );

            final List<String> _names = await Filers.getFilesNamesFromFiles(
                files: _files,
                withExtension: false,
            );


            await Storage.createMultipleStoragePicsAndGetURLs(
              files: _files,
              names: _names,
              ownersIDs: [AuthFireOps.superUserID()],
              docName: 'test/',
            );

            await Dialogs.showSuccessDialog(context: context);

          },
        ),

        /// DELETE ICONS STORAGE DIRECTORY
        WideButton(
          verse: Verse.plain('Delete icons storage directory'),
          onTap: () async {

            final dynamic result = await CloudFunction.call(
              context: context,
              functionName: CloudFunction.callDeleteStorageDirectory,
              mapToPass: {
                'path': 'test/',
              },
            );

            blog('result is : ${result?.runtimeType} : $result');

          },
        ),

        const DotSeparator(),

        ///
        WideButton(
          verse: Verse.plain('get URL by path'),
          onTap: () async {

            final Reference _ref = Storage.getRef(
              storageDocName: StorageDoc.users,
              fileName: AuthFireOps.superUserID(),
            );

            final String _url = await _ref.getDownloadURL();

            blog('url is : $_url');

          },
        ),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}

