import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/pic_protocols/pic_protocols.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/g_storage/storage_ref.dart';
import 'package:bldrs/e_back_end/h_caching/cache_ops.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/backend_lab/ldb_viewer/ldb_viewer_screen.dart';
import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PicProtocolsTest extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PicProtocolsTest({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _PicProtocolsTestState createState() => _PicProtocolsTestState();
/// --------------------------------------------------------------------------
}

class _PicProtocolsTestState extends State<PicProtocolsTest> {
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
  PicModel _picModel;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------

    blog('fuck');

    return DashBoardLayout(
      loading: _loading,
      pageTitle: 'Fire storage test',
      appBarWidgets: [

        /// LDB
        AppBarButton(
          icon: Iconz.form,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const LDBViewerScreen(
                ldbDocName: LDBDoc.pics,
              ),
            );

          },
        ),

        /// DELETE + CLEAR CACHE
        AppBarButton(
          icon: Iconz.xSmall,
          onTap: () async {

            await CacheOps.wipeCaches();

            setState(() {

            });

            // setState(() {
            //   _picModel = null;
            // });


          },
        ),

        /// PREVIEW
        SuperImage(
          width: 40,
          height: 40,
          pic: _picModel?.bytes ?? Iconz.dvBlankSVG,
        ),

      ],
      listWidgets: <Widget>[

        /// FETCH PIC
        WideButton(
          verse: Verse.plain('Fetch pic'),
          onTap: () async {

            final String _path = '${StorageDoc.users}/${AuthFireOps.superUserID()}';

            final PicModel _pic = await PicProtocols.fetchPic(_path);

            setState(() {
              _picModel = _pic;
            });

          },
        ),

        /// GET URL BY PATH
        WideButton(
          verse: Verse.plain('get URL by path'),
          onTap: () async {

            final Reference _ref = StorageRef.byNodes(
              collName: StorageDoc.users,
              docName: AuthFireOps.superUserID(),
            );

            final String _url = await _ref.getDownloadURL();

            blog('url is : $_url');
            await Dialogs.showSuccessDialog(context: context);

          },
        ),

        const DotSeparator(),

        // /// PICK ICONS AND UPLOAD
        // WideButton(
        //   verse: Verse.plain('Upload pic to Storage'),
        //   onTap: () async {
        //
        //     final List<String> _icons = await BldrsIconsScreen.selectIcons(context);
        //
        //     final List<File> _files = await Filers.getFilesFromLocalRasterImages(
        //       localAssets: _icons,
        //     );
        //
        //     final List<String> _names = await Filers.getFilesNamesFromFiles(
        //         files: _files,
        //         withExtension: false,
        //     );
        //
        //
        //     await Storage.createMultipleStoragePicsAndGetURLs(
        //       files: _files,
        //       docsNames: _names,
        //       ownersIDs: [AuthFireOps.superUserID()],
        //       collName: 'test/',
        //     );
        //
        //     await Dialogs.showSuccessDialog(context: context);
        //
        //   },
        // ),
        //
        // /// DELETE ICONS STORAGE DIRECTORY
        // WideButton(
        //   verse: Verse.plain('Delete icons storage directory'),
        //   onTap: () async {
        //
        //     final dynamic result = await CloudFunction.call(
        //       context: context,
        //       functionName: CloudFunction.callDeleteStorageDirectory,
        //       mapToPass: {
        //         'path': 'test/',
        //       },
        //     );
        //
        //     blog('result is : ${result?.runtimeType} : $result');
        //
        //     await Dialogs.showSuccessDialog(context: context);
        //
        //   },
        // ),

        // /// put uInt In Path
        // WideButton(
        //   verse: Verse.plain('upload uInt8List with / in name'),
        //   onTap: () async {
        //
        //     final String icon = await BldrsIconsScreen.selectIcon(context);
        //
        //     final File _file = await Filers.getFileFromLocalRasterAsset(
        //         localAsset: icon,
        //     );
        //
        //     final Uint8List _int = await Floaters.getUint8ListFromFile(_file);
        //     final Dimensions dim = await Dimensions.superDimensions(_int);
        //
        //     final Reference _ref = StorageRef.byNodes(
        //       collName: 'test',
        //       docName: 'fuck/you_bitch',
        //     );
        //     /// ASSIGN FILE OWNERS
        //     Map<String, String> _metaDataMap = <String, String>{};
        //       _metaDataMap[AuthFireOps.superUserID()] = 'cool';
        //
        //       _metaDataMap = Mapper.mergeMaps(
        //         baseMap: _metaDataMap,
        //         insert: <String, String>{
        //           'width': '${dim.width}',
        //           'height': '${dim.height}',
        //         },
        //         replaceDuplicateKeys: true,
        //       );
        //
        //     /// FORM METADATA
        //     final SettableMetadata metaData = SettableMetadata(
        //       customMetadata: _metaDataMap,
        //     );
        //
        //     final TaskSnapshot _taskSnapshot = await _ref.putData(
        //       _int,
        //       metaData,
        //     );
        //
        //     final String _url = await _ref.getDownloadURL();
        //
        //     blog('url is : $_url');
        //     blog('_taskSnapshot : ${_taskSnapshot.totalBytes} : ${_taskSnapshot.state}');
        //     await Dialogs.showSuccessDialog(context: context);
        //
        //   },
        // ),

        /// SEPARATOR
        const SeparatorLine(),

        /// CACHE
        SuperVerse(
          verse: Verse.plain('Cache'),
        ),

        /// CURRENT SIZE
        DataStrip(
          dataKey: 'current Size',
          dataValue: '${imageCache.currentSize} ',
          color: Colorz.yellow20,
        ),

        /// CURRENT SIZE BYTES
        DataStrip(
          dataKey: 'current Size Bytes',
          dataValue: '${Filers.calculateSize(imageCache.currentSizeBytes, FileSizeUnit.megaByte)} Mb',
          color: Colorz.yellow20,
        ),

        /// LIVE IMAGE COUNT
        DataStrip(
          dataKey: 'liveImageCount',
          dataValue: '${imageCache.liveImageCount} ',
          color: Colorz.yellow20,
        ),

        /// PENDING IMAGE COUNT
        DataStrip(
          dataKey: 'pendingImageCount',
          dataValue: '${imageCache.pendingImageCount} ',
          color: Colorz.yellow20,
        ),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
