import 'dart:io';

import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/e_back_end/h_caching/cache_ops.dart';
import 'package:bldrs/x_dashboard/backend_lab/cache_viewer/stats_files_builder.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:scale/scale.dart';

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
  List<FileStat> tempFiles;
  List<FileStat> appFiles;
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

    final List<FileStat> _tempFiles = await CacheOps.getTempDirFiles();
    final List<FileStat> _appFiles = await CacheOps.getAppDocDirFiles();

    setState(() {
      tempFiles = _tempFiles;
      appFiles = _appFiles;
    });

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      loading: _loading,
      appBarType: AppBarType.basic,
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

              await CacheOps.wipeCaches();

              await _readTemDirectory();

            }

          },
        ),

      ],
      child: ValueListenableBuilder(
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

                    if (Mapper.checkCanLoopList(tempFiles) == true)
                      SuperVerse(verse: Verse.plain('Temp files')),

                      if (Mapper.checkCanLoopList(tempFiles) == true)
                      StatsFilesBuilder(
                        stats: tempFiles,
                        color: Colorz.bloodTest,
                      ),

                    if (Mapper.checkCanLoopList(appFiles) == true)
                      SuperVerse(verse: Verse.plain('App files')),

                    if (Mapper.checkCanLoopList(appFiles) == true)
                      StatsFilesBuilder(
                        stats: appFiles,
                        color: Colorz.green125,
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
