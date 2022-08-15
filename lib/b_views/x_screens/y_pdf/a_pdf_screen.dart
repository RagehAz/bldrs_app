import 'dart:io';
import 'dart:typed_data';
import 'package:bldrs/a_models/flyer/sub/flyer_pdf.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PDFScreen({
    @required this.pdf,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerPDF pdf;
  /// --------------------------------------------------------------------------
  @override
  _PDFScreenState createState() => _PDFScreenState();
/// --------------------------------------------------------------------------
}

class _PDFScreenState extends State<PDFScreen> {
  final ValueNotifier<Uint8List> _uInt8List = ValueNotifier(null);
  final ValueNotifier<ProgressBarModel> _progressBarModel = ValueNotifier(null);
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'TestingTemplate',);
    }
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        final File _pdfFile = await Filers.getFileFromURL(widget.pdf.url);
        final Uint8List _data = await Floaters.getUint8ListFromFile(_pdfFile);
        _uInt8List.value = _data;

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _loading.dispose();
    _uInt8List.dispose();
    _progressBarModel.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      loading: _loading,
      pageTitle: '${widget.pdf.fileName}.pdf',
      appBarType: AppBarType.basic,
      sectionButtonIsOn: false,
      progressBarModel: _progressBarModel,
      layoutWidget: PageBubble(
        appBarType: AppBarType.basic,
        screenHeightWithoutSafeArea: Scale.superScreenHeightWithoutSafeArea(context),
        child: ValueListenableBuilder(
          valueListenable: _uInt8List,
          builder: (_, Uint8List data, Widget child){

            if (data == null){
              return const LoadingFullScreenLayer();
            }

            else {
              return PDFView(
                key: const ValueKey<String>('PDFScreen_pdfView'),
                /// DATA
                pdfData: data,
                // filePath: '',
                // preventLinkNavigation: false,

                /// PAGES
                // defaultPage: 0,

                /// UI
                // autoSpacing: true,
                // fitEachPage: true,
                fitPolicy: FitPolicy.BOTH,
                // nightMode: false,
                swipeHorizontal: true,

                /// INTERACTION
                // enableSwipe: true,
                // pageFling: true,
                // pageSnap: true,
                // gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{},

                /// EVENTS
                onPageChanged: (int x, int y){
                  blog('onPageChanged : x : $x : y : $y');
                },
                onError: (dynamic error){
                  blog('onError : error.runtimeType : ${error.runtimeType} : error : ${error.toString()}');
                },
                onPageError: (int x, dynamic error){
                  blog('onPageError : x : $x : error.runtimeType : ${error.runtimeType} : error : ${error.toString()}');
                },
                onLinkHandler: (String link){
                  blog('onLinkHandler : link : $link');
                },
                onRender: (int x){
                  blog('onRender : x : $x');
                },
                onViewCreated: (PDFViewController controller) async {

                  final int _currentPage = await controller.getCurrentPage();
                  final int _pageCount = await controller.getPageCount();
                  // final bool _pageSet = await controller.setPage(0);

                  blog('onViewCreated : controller : ${controller.toString()}');
                  blog('onViewCreated : _currentPage : $_currentPage');
                  blog('onViewCreated : _pageCount : $_pageCount');

                },

              );
            }

          },
        ),
      ),
    );

  }

}
