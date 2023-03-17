import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/images/super_image/x_cacheless_image.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/g_storage/foundation/storage_paths.dart';
import 'package:bldrs/e_back_end/g_storage/foundation/storage_ref.dart';
import 'package:bldrs/e_back_end/h_caching/cache_ops.dart';
import 'package:bldrs/x_dashboard/backend_lab/ldb_viewer/ldb_viewer_screen.dart';
import 'package:bldrs/x_dashboard/zz_widgets/dashboard_layout.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';

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
  String _theURL;
  String _thePath;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------

    final UserModel _userModel = UsersProvider.proGetMyUserModel(context: context, listen: true);
    final String _url = _userModel.picPath;

    blog('_theURL : $_theURL');

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
              _picModel = null;
            });

          },
        ),

        CachelessImage(
          bytes: _picModel?.bytes,
          width: 40,
          height: 40,
        ),

        const SizedBox(
          width: 5,
          height: 5,
        ),

      ],
      listWidgets: <Widget>[

        /// FETCH PIC
        WideButton(
          verse: Verse.plain('Fetch pic'),
          onTap: () async {

            final String _path = '${StorageColl.users}/${AuthFireOps.superUserID()}';

            final PicModel _pic = await PicProtocols.fetchPic(_path);

            setState(() {
              _picModel = _pic;
              _thePath = _pic.path;
            });

          },
        ),

        /// DOWNLOAD PIC
        WideButton(
          verse: Verse.plain('Download pic'),
          onTap: () async {

            final String _path = '${StorageColl.users}/${AuthFireOps.superUserID()}';

            await PicProtocols.downloadPic(_path);

          },
        ),

        /// GET URL BY PATH
        WideButton(
          verse: Verse.plain('get URL by path'),
          onTap: () async {

            final Reference _ref = StorageRef.getRefByNodes(
              collName: StorageColl.users,
              docName: AuthFireOps.superUserID(),
            );

            final String _url = await _ref.getDownloadURL();

            blog('url is : $_url');
            setState(() {
              _picModel = null;
              _theURL = _url;
            });
            await Dialogs.showSuccessDialog(context: context);

          },
        ),

        const DotSeparator(),

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
          dataValue: '${Filers.calculateSize(imageCache.currentSizeBytes, FileSizeUnit.kiloByte)} Kb',
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

        DataStrip(
          dataKey: 'contains my url ?',
          dataValue: imageCache.containsKey(_url),
          color: Colorz.yellow20,
        ),

        DataStrip(
          dataKey: 'contains path ?',
          dataValue: imageCache.containsKey(_thePath),
          color: Colorz.yellow20,
        ),
      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
