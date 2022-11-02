import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/pic_protocols/pic_protocols.dart';
import 'package:bldrs/d_providers/user_provider.dart';
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
  String _thePath;
  String _theURL;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------

    final UserModel _userModel = UsersProvider.proGetMyUserModel(context: context, listen: true);
    final String _url = _userModel.pic;

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

        /// PREVIEW
        SuperImage(
          width: 40,
          height: 40,
          pic: _picModel?.bytes ?? _theURL ?? Iconz.dvBlankSVG,
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
              _thePath = _pic.path;
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
