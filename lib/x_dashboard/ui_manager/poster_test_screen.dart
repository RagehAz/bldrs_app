import 'dart:typed_data';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/i_pic/pic_meta_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/j_poster/poster_type.dart';
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/small_flyer.dart';
import 'package:bldrs/b_views/z_components/app_bar/app_bar_button.dart';
import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
import 'package:bldrs/b_views/z_components/poster/poster_display.dart';
import 'package:bldrs/b_views/z_components/poster/structure/x_note_poster_box.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:bldrs/x_dashboard/zz_widgets/dashboard_layout.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:numeric/numeric.dart';
import 'package:scale/scale.dart';
import 'package:screenshot/screenshot.dart';

class PosterTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PosterTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _TheStatefulScreenState createState() => _TheStatefulScreenState();
  /// --------------------------------------------------------------------------
}

class _TheStatefulScreenState extends State<PosterTestScreen> {
  // -----------------------------------------------------------------------------
  FlyerModel _flyer;
  BzModel _bz;
  Uint8List _posterBytes;
  PicModel _posterPicModel;
  final ScreenshotController _controller = ScreenshotController();
  final GlobalKey globalKey = GlobalKey();
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

        final UserModel _userModel = UsersProvider.proGetMyUserModel(
            context: context,
            listen: false,
        );

        FlyerModel _flyerModel = await FlyerProtocols.fetchFlyer(
          context: context,
          flyerID: _userModel.savedFlyers.all.first,
        );

        _flyerModel = await FlyerProtocols.renderBigFlyer(
          flyerModel: _flyerModel,
          context: context,
        );

        setState(() {
          _flyer = _flyerModel;
          _bz = _flyerModel.bzModel;
        });

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
    FlyerProtocols.disposeRenderedFlyer(
      context: context,
      mounted: mounted,
      flyerModel: _flyer,
      invoker: 'PosterTestScreen',
    );
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  String _createPosterAspectRatioLine({
    @required double width,
    @required double height,
  }){

    return  'w (~${Numeric.roundFractions(width, 1)}) / '
            'h (~${Numeric.roundFractions(height, 1)}) = '
            '${Numeric.roundFractions(width/height, 1)}';

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<PicModel> _createPicModel(Uint8List bytes) async {

    final PicModel _picModel = PicModel(
      path: 'flyers/{flyerID}/poster', // TASK : WTF IS THIS ?
      bytes: bytes,
      meta: PicMetaModel(
          ownersIDs: const ['{ownerID}'],  // TASK : WTF IS THIS ?
          dimensions: await Dimensions.superDimensions(bytes),
    ),
    );

    return _picModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _captureTreeShot() async {

    await _triggerLoading(setTo: true);
    final double _screenWidth = Scale.screenWidth(context);

    final Uint8List _bytes = await _controller.capture(
      // MediaQuery.of(context).devicePixelRatio // no need for this, it messes my final result file width
      pixelRatio: _desiredPosterWidth / _screenWidth,
      delay: const Duration(milliseconds: 200),
    );
    final PicModel _picModel = await _createPicModel(_bytes);

    setState(() {
      _posterBytes = _bytes;
      _posterPicModel = _picModel;
    });

    await _triggerLoading(setTo: false);
  }
  // --------------------
  static final double _desiredPosterWidth = Standards.posterDimensions.width;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _captureTreelessShot() async {
    await _triggerLoading(setTo: true);

    final Uint8List _bytes = await PosterDisplay.capturePoster(
      posterType: PosterType.flyer,
      finalDesiredPicWidth: _desiredPosterWidth,
      model: _flyer,
      helperModel: _bz,
    );

    final PicModel _picModel = await _createPicModel(_bytes);

    setState(() {
      _posterBytes = _bytes;
      _posterPicModel = _picModel;
    });

    await _triggerLoading(setTo: false);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _deleteShot() {
    setState(() {
      _posterBytes = null;
      _posterPicModel = null;
    });
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _posterWidth = Scale.screenWidth(context);
    final double _posterHeight = NotePosterBox.getBoxHeight(_posterWidth);
    // --------------------
    return DashBoardLayout(
      loading: _loading,
      appBarWidgets: <Widget>[

        const Expander(),

        /// DELETE
        AppBarButton(
          icon: Iconz.xSmall,
          onTap: _deleteShot,
        ),

        /// TREE-LESS CAPTURE
        AppBarButton(
          verse: Verse.plain('Treeless shot'),
          isDeactivated: _flyer == null,
          onTap: _captureTreelessShot,
        ),

        /// TREE CAPTURE
        AppBarButton(
          verse: Verse.plain('Tree shot'),
          isDeactivated: _flyer == null,
          onTap: _captureTreeShot,
        ),

        // /// KEY SHOT
        // AppBarButton(
        //   verse: Verse.plain('Key shot'),
        //   isDeactivated: _flyer == null,
        //   onTap: () async {
        //
        //     final RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
        //     final ui.Image image = await boundary.toImage();
        //     final Uint8List _bytes = await Floaters.getUint8ListFromUiImage(image);
        //     // var byteData = await image.toByteData(format: ImageByteFormat.png);
        //     // var pngBytes = byteData.buffer.asUint8List();
        //     // print(pngBytes);
        //
        //     setState(() {
        //       _posterBytes = _bytes;
        //     });
        //
        //   },
        // ),

      ],
      listWidgets: <Widget>[

        // -------------------------------------

        /// FLYER PREVIEW
        SmallFlyer(
          flyerModel: _flyer,
          flyerBoxWidth: 150,
          onTap: null,
          // flyerShadowIsOn: true,
        ),

        // -------------------------------------

        /// POSTER WIDGET TITLE
        SuperVerse(
          verse: Verse.plain('Poster Widget'),
          centered: false,
          margin: 10,
          italic: true,
        ),

        /// POSTER WIDGET
        Container(
          width: Scale.screenWidth(context),
          alignment: Alignment.center,
          child: Screenshot(
            controller: _controller,
            child: PosterDisplay(
              width: _posterWidth,
              posterType: PosterType.flyer,
              model: _flyer,
              modelHelper: _bz,
            ),
          ),
        ),

        // -------------------------------------

        /// POSTER DIMENSIONS
        DataStrip(
          dataKey: 'Screen width',
          dataValue: Dimensions(
            width: Numeric.roundFractions(_posterWidth, 1),
            height: Numeric.roundFractions(_posterHeight, 1),
          ).toString(),
          withHeadline: true,
          color: Colorz.blue80,
        ),

        /// POSTER BOX ASPECT RATIO
        DataStrip(
          dataKey: 'Aspect Ratio ( posterWidth = screenWidth )',
          dataValue: _createPosterAspectRatioLine(
            width: _posterWidth,
            height: _posterHeight,
          ),
          withHeadline: true,
          color: Colorz.blue80,
        ),

        // -------------------------------------

        const SeparatorLine(
          withMargins: true,
        ),

        /// POSTER DIMENSIONS
        if (_posterPicModel != null)
          DataStrip(
            dataKey: 'Poster Original Dims',
            dataValue: Dimensions(
              width: _desiredPosterWidth,
              height:  NotePosterBox.getBoxHeight(_desiredPosterWidth),
            ).toString(),
            withHeadline: true,
            color: Colorz.green20,
          ),

        /// POSTER BYTES TITLE
        SuperVerse(
          verse: Verse.plain('Poster bytes'),
          centered: false,
          margin: 10,
          italic: true,
        ),

        /// POSTER BYTES
        Container(
          width: Scale.screenWidth(context),
          alignment: Alignment.center,
          child: ValueListenableBuilder(
            valueListenable: _loading,
            builder: (_, bool loading, Widget child){

              return BldrsImage(
                width: _posterWidth,
                height: _posterHeight,
                pic: _posterBytes,
                backgroundColor: Colorz.white10,
                loading: loading,
              );

            },
          ),
        ),

        // -------------------------------------

        // _treelessShotWidth

        /// POSTER DIMENSIONS
        if (_posterPicModel != null)
          DataStrip(
            dataKey: 'Poster Dims',
            dataValue: _posterPicModel.meta.dimensions.toString(),
            withHeadline: true,
          ),

        /// POSTER BOX ASPECT RATIO
        if (_posterPicModel != null)
          DataStrip(
            dataKey: 'Poster Aspect Ratio',
            dataValue: _createPosterAspectRatioLine(
              width: _posterPicModel.meta.dimensions.width,
              height: _posterPicModel.meta.dimensions.height,
            ),
            withHeadline: true,
          ),

        // -------------------------------------

        const Horizon(),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
