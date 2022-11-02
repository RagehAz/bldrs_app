import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bldrs/a_models/x_utilities/file_model.dart';
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/a_models/x_utilities/keyboard_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/d_user_search_screen/search_users_screen.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/clocking/stop_watch/stop_watch_controller.dart';
import 'package:bldrs/b_views/z_components/clocking/stop_watch/stop_watch_counter_builder.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/layouts/corner_widget_maximizer.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/customs/stats_line.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/keyboard_screen/keyboard_screen.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/e_back_end/h_caching/cache_ops.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/ui_manager/bldrs_icons_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/ldb_viewer/ldb_viewer_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/images_test/image_tile.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';

class CacheViewerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CacheViewerScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _CacheViewerScreenState createState() => _CacheViewerScreenState();
/// --------------------------------------------------------------------------
}

class _CacheViewerScreenState extends State<CacheViewerScreen> {
  // -----------------------------------------------------------------------------
  List<FileStat> stats;
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

        await _readTemDirectory();

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
  Future<void> _readTemDirectory() async {

    final List<FileStat> _stats = await CacheOps.getTempDirFiles();

    setState(() {
      stats = _stats;
    });

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      loading: _loading,
      appBarType: AppBarType.scrollable,
      appBarRowWidgets: <Widget>[

        /// SEPARATOR
        const DotSeparator(boxWidth: 20,),

        const Expander(),

        /// CLEAR CACHE
        AppBarButton(
          icon: Iconz.power,
          onTap: () async {

            final bool _continue = await Dialogs.confirmProceed(
                context: context,
                titleVerse: Verse.plain('This will delete All Caches in the world'),
            );

            if (_continue == true){

              await Future.wait(<Future>[
                CacheOps.clearTempDirectoryCache(),
                CacheOps.clearAppDocsDirectory(),
                CacheOps.clearCacheByManager(),
              ]);

                CacheOps.clearCache();
                CacheOps.clearLiveImages();
                CacheOps.clearPaintingBindingImageCache();

              await _readTemDirectory();

            }

          },
        ),

      ],
      layoutWidget: ValueListenableBuilder(
        valueListenable: _loading,
        builder: (_, bool isLoading, Widget child){

          if (isLoading == true){
            return const LoadingFullScreenLayer();
          }

          else {
            return SingleChildScrollView(
              padding: Stratosphere.stratosphereSandwich,
              physics: const BouncingScrollPhysics(),
              child:Column(
                  children: <Widget>[

                    if (Mapper.checkCanLoopList(stats) == true)
                      ...List.generate(stats.length, (index){

                        final FileStat _stat = stats[index];
                        final String type = _stat.type.toString();
                        // ---
                        final int size = _stat.size;
                        final double _sizeMB = Filers.calculateSize(size, FileSizeUnit.kiloByte);
                        final String _sizeString = Numeric.formatNumToSeparatedKilos(number: _sizeMB);
                        // ---
                        final String _accessed = Timers.generateString_hh_i_mm_i_ss(_stat.accessed);
                        final String _changed = Timers.generateString_hh_i_mm_i_ss(_stat.changed);
                        final String _modified = Timers.generateString_hh_i_mm_i_ss(_stat.modified);
                        // ---
                        final int _mode = _stat.mode;
                        final String _modeString = _stat.modeString();
                        // ---
                        return Bubble(
                          headerViewModel: const BubbleHeaderVM(),
                          columnChildren: <Widget>[

                            /// TYPE
                            StatsLine(
                                icon: Iconz.circleDot,
                                verse: Verse.plain('type : $type : modeString : $_modeString'),
                            ),

                            /// size
                            StatsLine(
                                icon: Iconz.circleDot,
                                verse: Verse.plain('Size : $_sizeString Kb : mode : $_mode'),
                            ),

                            /// ACCESSED
                            StatsLine(
                                bubbleWidth: Bubble.clearWidth(context),
                                icon: Iconz.circleDot,
                                verse: Verse.plain('Accesses : $_accessed')
                            ),

                            /// CHANGED
                            StatsLine(
                                bubbleWidth: Bubble.clearWidth(context),
                                icon: Iconz.circleDot,
                                verse: Verse.plain('Changed : $_changed')
                            ),

                            /// MODIFIED
                            StatsLine(
                              bubbleWidth: Bubble.clearWidth(context),
                              icon: Iconz.circleDot,
                              verse: Verse.plain('Modified : $_modified'),
                            ),

                          ],
                        );

                      }),

                    ///
                    DataStrip(
                      dataKey: 'Name',
                      dataValue: 'wtf',
                      tooTipVerse: Verse.plain(
                          'this splits ( file.path ) property of ( File ) '
                              'variable and gets the last part after last ( / ) '
                              'in path string'
                      ),
                    ),


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

                    const Horizon(),

                  ]
              ),


            );
          }

        },
      ),
    );

  }
// -----------------------------------------------------------------------------
}
