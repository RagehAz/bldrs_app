import 'dart:typed_data';

import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PDFScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PDFScreen({
    required this.pdf,
    super.key
  });
  /// --------------------------------------------------------------------------
  final PDFModel? pdf;
  /// --------------------------------------------------------------------------
  @override
  _PDFScreenState createState() => _PDFScreenState();
  /// --------------------------------------------------------------------------
}

class _PDFScreenState extends State<PDFScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<Uint8List?> _uInt8List = ValueNotifier(null);
  final ValueNotifier<ProgressBarModel?> _progressBarModel = ValueNotifier(null);
  PdfController? _controller;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(true);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {

    if (widget.pdf?.bytes != null){
      _controller = PdfController(
        document: PdfDocument.openData(widget.pdf!.bytes!,
          // password:
        ),
        initialPage: 0,
        // viewportFraction: 1,
      );
    }

    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good


    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _uInt8List.dispose();
    _progressBarModel.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      canSwipeBack: true,
      loading: _loading,
      title: Verse(
        id: '${widget.pdf?.name}.pdf',
        translate: false,
      ),
      appBarType: AppBarType.basic,
      progressBarModel: _progressBarModel,
      skyType: SkyType.grey,
      child: PageBubble(
        appBarType: AppBarType.basic,
        screenHeightWithoutSafeArea: Scale.screenHeight(context),

        /// --------------------

        child: _controller == null ?
        const SizedBox()
            :
        PdfView(
          key: const ValueKey<String>('PDFScreen_pdfView'),
          /// DATA
          controller: _controller!,
          physics: const BouncingScrollPhysics(),
          // reverse: false,
          // pageSnapping: true,
          // scrollDirection: Axis.horizontal,
          renderer: (PdfPage page) => page.render(
            width: page.width * 2,
            height: page.height * 2,
            // format: PdfPageImageFormat.jpeg,
            backgroundColor: '#FFFFFF',
            quality: 90,
            // forPrint: false,
          ),
          /// EVENTS
          onPageChanged: (int pageNumber){

            ProgressBarModel.onSwipe(
              progressBarModel: _progressBarModel,
              newIndex: pageNumber-1,
              context: context,
              mounted: mounted,
            );

            },
          onDocumentError: (dynamic error){
            blog('onError : error.runtimeType : ${error.runtimeType} : error : $error');
            },
          onDocumentLoaded: (PdfDocument document){

            blog('''
            onDocumentLoaded : 
              id : ${document.id},
              isClosed : ${document.isClosed},
              pagesCount : ${document.pagesCount},
              sourceName : ${document.sourceName},
            ''');

            if (document.pagesCount != 0){
              setNotifier(
                notifier: _progressBarModel,
                mounted: mounted,
                value: ProgressBarModel.initialModel(
                  numberOfStrips: document.pagesCount,
                  // index: 0,
                ),
              );
            }

            _triggerLoading(setTo: false);

          },
          // backgroundDecoration: ,

        ),

        /// --------------------

    ),
    );

  }
// -----------------------------------------------------------------------------
}

/// OLD
/*
class OldPDFScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const OldPDFScreen({
    required this.pdf,
    super.key
  });
  /// --------------------------------------------------------------------------
  final PDFModel? pdf;
  /// --------------------------------------------------------------------------
  @override
  _OldPDFScreenState createState() => _OldPDFScreenState();
  /// --------------------------------------------------------------------------
}

class _OldPDFScreenState extends State<OldPDFScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<Uint8List?> _uInt8List = ValueNotifier(null);
  // ProgressBarModel.emptyModel());
  final ValueNotifier<ProgressBarModel?> _progressBarModel = ValueNotifier(null);
  final ValueNotifier<PDFViewController?> _pdfController = ValueNotifier(null);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {

    setNotifier(
        notifier: _uInt8List,
        mounted: mounted,
        value: widget.pdf?.bytes,
    );

    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {

        await _triggerLoading(setTo: false);
      });

    }
    super.didChangeDependencies();
  }
  // --------------------
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
      title: Verse(
        id: '${widget.pdf?.name}.pdf',
        translate: false,
      ),
      appBarType: AppBarType.basic,
      progressBarModel: _progressBarModel,
      skyType: SkyType.grey,
      child: PageBubble(
        appBarType: AppBarType.basic,
        screenHeightWithoutSafeArea: Scale.screenHeight(context),

        /// --------------------

        child: ValueListenableBuilder(
          valueListenable: _uInt8List,
          builder: (_, Uint8List? data, Widget? child){

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
                // nightMode: false,
                swipeHorizontal: true,

                /// INTERACTION
                // enableSwipe: true,
                pageFling: false,
                // pageSnap: true,
                // gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{},

                /// EVENTS
                onPageChanged: (int? newIndex, int? numberOfPages){
                  // blog('onPageChanged : x : $newIndex : y : $numberOfPages');
                  ProgressBarModel.onSwipe(
                    progressBarModel: _progressBarModel,
                    newIndex: newIndex,
                    context: context,
                    mounted: mounted,
                  );
                },
                onError: (dynamic error){
                  blog('onError : error.runtimeType : ${error.runtimeType} : error : $error');
                },
                onPageError: (int? x, dynamic error){
                  blog('onPageError : x : $x : error.runtimeType : ${error.runtimeType} : error : $error}');
                },
                onLinkHandler: (String? link){
                  blog('onLinkHandler : link : $link');
                },
                onRender: (int? pageCount){
                  blog('onRender : x : $pageCount');

                  if (
                  // _progressBarModel.value.numberOfStrips == null &&
                  pageCount != null && pageCount != 0
                  ){

                    setNotifier(
                      notifier: _progressBarModel,
                      mounted: mounted,
                      value: ProgressBarModel.initialModel(
                          numberOfStrips: pageCount,
                      ),
                    );

                  }

                },
                onViewCreated: (PDFViewController controller) async {

                  setNotifier(
                      notifier: _pdfController,
                      mounted: mounted,
                      value: controller,
                  );


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

        /// --------------------

      //   child: PdfDocumentLoader.openData(
      //     widget.pdf.bytes,
      //     onError: (dynamic thing){
      //
      //       blog('onError : thing.runtimeType : ${thing.runtimeType} : thing : ${thing.toString()}');
      //
      //     },
      //     // pageBuilder: ,
      //     // pageNumber: ,
      //     documentBuilder: (BuildContext context, PdfDocument pdfDocument, int pageCount){
      //
      //       return ListView.builder(
      //         physics: const BouncingScrollPhysics(),
      //         itemCount: pageCount,
      //         itemBuilder: (_, int index){
      //
      //           return PdfPageView(
      //             pdfDocument: pdfDocument,
      //             pageNumber: index + 1,
      //             // pageBuilder: (BuildContext context, PdfPageTextureBuilder textureBuilder, Size pageSize){
      //             //     return Container(
      //             //       height: pageSize.height,
      //             //       width: pageSize.width,
      //             //       color: Colorz.bloodTest,
      //             //     );
      //             // },
      //           );
      //
      //         },
      //       );
      //
      //     },
      //
      // ),
    ),
    );

  }
// -----------------------------------------------------------------------------
}
 */
