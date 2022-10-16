import 'dart:io';
import 'dart:typed_data';
import 'package:bldrs/a_models/x_utilities/file_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
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
  final FileModel pdf;
  /// --------------------------------------------------------------------------
  @override
  _PDFScreenState createState() => _PDFScreenState();
  /// --------------------------------------------------------------------------
}

class _PDFScreenState extends State<PDFScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<Uint8List> _uInt8List = ValueNotifier(null);
  final ValueNotifier<ProgressBarModel> _progressBarModel = ValueNotifier(ProgressBarModel.emptyModel());
  final ValueNotifier<PDFViewController> _pdfController = ValueNotifier<PDFViewController>(null);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
      addPostFrameCallBack: false,
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

        final File _pdfFile = await Filers.getFileFromURL(widget.pdf.url);
        final Uint8List _data = await Floaters.getUint8ListFromFile(_pdfFile);
        _uInt8List.value = _data;

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _loading.dispose();
    _uInt8List.dispose();
    _progressBarModel.dispose();
    _pdfController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      loading: _loading,
      pageTitleVerse: Verse(
        text: '${widget.pdf.fileName}.pdf',
        translate: false,
      ),
      appBarType: AppBarType.basic,
      progressBarModel: _progressBarModel,
      appBarRowWidgets: const <Widget>[

        Expander(),

        /// WORKS BUT LOOKS UGLY
        // ValueListenableBuilder(
        //     valueListenable: _pdfController,
        //     builder: (_, PDFViewController controller, Widget child){
        //
        //       return Row(
        //         children: <Widget>[
        //
        //           AppBarButton(
        //             icon: Iconz.arrowLeft,
        //             isDeactivated: controller == null,
        //             onTap: (){
        //               final int _pastIndex = _progressBarModel.value.index - 1;
        //               controller.setPage(_pastIndex);
        //             },
        //           ),
        //
        //           AppBarButton(
        //             icon: Iconz.arrowRight,
        //             isDeactivated: controller == null,
        //             onTap: (){
        //               final int _nextIndex = _progressBarModel.value.index + 1;
        //               controller.setPage(_nextIndex);
        //             },
        //           ),
        //
        //         ],
        //       );
        //
        //     }
        // )

      ],
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
                autoSpacing: false,
                // fitEachPage: true,
                fitPolicy: FitPolicy.BOTH,
                nightMode: true,
                swipeHorizontal: true,

                /// INTERACTION
                // enableSwipe: true,
                pageFling: false,
                // pageSnap: true,
                // gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{},

                /// EVENTS
                onPageChanged: (int newIndex, int numberOfPages){
                  // blog('onPageChanged : x : $newIndex : y : $numberOfPages');
                  ProgressBarModel.onSwipe(
                    progressBarModel: _progressBarModel,
                    newIndex: newIndex,
                    context: context,
                  );
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

                  _pdfController.value = controller;

                  // final int _currentPage = await controller.getCurrentPage();
                  // final int _pageCount = await controller.getPageCount();
                  // final bool _pageSet = await controller.setPage(0);
                  // blog('onViewCreated : controller : ${controller.toString()}');
                  // blog('onViewCreated : _currentPage : $_currentPage');
                  // blog('onViewCreated : _pageCount : $_pageCount');

                },

              );
            }

          },
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
