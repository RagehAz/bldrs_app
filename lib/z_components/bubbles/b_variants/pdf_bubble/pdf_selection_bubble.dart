import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/components/drawing/expander.dart';
import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/b_screens/x_situational_screens/c_pdf_screen.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bubble_title.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/bldrs_text_field/bldrs_text_field.dart';
import 'package:bldrs/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/pdf_protocols/protocols/pdf_protocols.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';

class PDFSelectionBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PDFSelectionBubble({
    required this.onChangePDF,
    required this.onDeletePDF,
    required this.existingPDF,
    required this.formKey,
    required this.appBarType,
    required this.canValidate,
    required this.flyerID,
    required this.bzID,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueChanged<PDFModel?> onChangePDF;
  final Function onDeletePDF;
  final PDFModel? existingPDF;
  final GlobalKey<FormState>? formKey;
  final AppBarType appBarType;
  final bool canValidate;
  final String? flyerID;
  final String? bzID;
  /// --------------------------------------------------------------------------
  @override
  _PDFSelectionBubbleState createState() => _PDFSelectionBubbleState();
  /// --------------------------------------------------------------------------
}

class _PDFSelectionBubbleState extends State<PDFSelectionBubble> {
  // -----------------------------------------------------------------------------
  final GlobalKey globalKey = GlobalKey();
  // --------------------
  final ValueNotifier<PDFModel?> _pdfNotifier = ValueNotifier(null);
  // --------------------
  final TextEditingController _textController = TextEditingController();
  // -----------------------------------------------------------------------------
  /// --- LOADING
  bool _loading = false;
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {

    if (mounted == true && setTo != _loading){
      setState(() {
        _loading = setTo;
      });
    }

  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    setNotifier(notifier: _pdfNotifier, mounted: mounted, value: widget.existingPDF);
    _textController.text = widget.existingPDF?.name ?? '';
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
    _pdfNotifier.dispose();
    _textController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: _pdfNotifier,
        builder: (_, PDFModel? pdfModel, Widget? child){

          final bool _bytesExist = pdfModel?.bytes != null;
          final bool _pathExists = pdfModel?.path != null;
          final bool _sizeLimitReached = pdfModel?.checkSizeLimitReached() ?? false;
          // final String _fileName = pdf?.fileName;

          return Bubble(
            bubbleColor: Formers.validatorBubbleColor(
              validator: () => Formers.pdfValidator(
                pdfModel: pdfModel,
                canValidate: widget.canValidate,
              ),
            ),
            width: Bubble.bubbleWidth(context: context),
            appIsLTR: UiProvider.checkAppIsLeftToRight(),
            bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
              context: context,
              headlineVerse: const Verse(
                id: 'phid_pdf_attachment',
                translate: true,
              ),
              loading: _loading,
              leadingIcon: Iconz.pdf,
              leadingIconSizeFactor: 0.6,
            ),

            columnChildren: <Widget>[

              /// BULLET POINTS
              const BldrsBulletPoints(
                showBottomLine: false,
                bulletPoints: <Verse>[
                  Verse(id: 'phid_optional_field', translate: true),
                  Verse(
                    pseudo:'You can attach a PDF File to this flyer.',
                    id: 'phid_you_can_attach_flyer_pdf',
                    translate: true,
                  ),
                  Verse(
                    pseudo:'Anybody can view and download this PDF file.',
                    id: 'phid_flyer_pdf_is_public',
                    translate: true,
                  ),
                  Verse(
                    pseudo:'PDF file size can only be less than 3 Mb.',
                    id: 'phid_pdf_size_less_than_3',
                    translate: true,
                  ),
                ],
              ),

              /// TITLE - SIZE - LOADING
              if (_bytesExist == true || _pathExists == true)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    /// TITLE
                    const BubbleTitle(
                      titleVerse: Verse(
                        id: 'phid_pdf_file_name',
                        translate: true,
                      ),
                      titleScaleFactor: 0.9,
                    ),

                    /// SIZE
                    if (pdfModel?.sizeMB != null)
                    BldrsText(
                      verse: PDFModel.getSizeLine(
                        size: pdfModel?.sizeMB,
                        maxSize: Standards.maxFileSizeLimit,
                        sizeLimitReached: _sizeLimitReached,
                      ),
                      italic: true,
                      color: _sizeLimitReached == true ? Colorz.red255 : Colorz.white125,
                      weight: VerseWeight.thin,
                      scaleFactor: 0.7,
                    ),

                  ],
                ),

                /// FILE NAME FIELD
                if (_bytesExist == true || _pathExists == true)
              BldrsTextField(
                appBarType: widget.appBarType,
                globalKey: globalKey,
                width: Bubble.clearWidth(context: context),
                // titleVerse: const Verse(
                //   id: 'phid_pdf_file_name',
                //   translate: true,
                // ),
                maxLines: 1,
                textController: _textController,
                onChanged: (String? text){

                  setNotifier(
                      notifier: _pdfNotifier,
                      mounted: mounted,
                      value: _pdfNotifier.value?.copyWith(
                        name: _textController.text,
                      ),
                  );

                  widget.onChangePDF(_pdfNotifier.value);

                },
                isFormField: true,
                isFloatingField: true,
                // autoValidate: true,
                autoCorrect: Keyboard.autoCorrectIsOn(),
                enableSuggestions: Keyboard.suggestionsEnabled(),
                validator: (String? text) => Formers.pdfValidator(
                  canValidate: true,
                  pdfModel: pdfModel,
                ),
              ),

              // /// FILE
              // if (_fileExists == true)
              // SizedBox(
              //   width: Bubble.clearWidth(context),
              //   height: 50,
              //   child: SuperVerse(
              //     verse: _fileExists == true ? _fileName : 'Select a file',
              //     weight: _fileExists == true ? VerseWeight.bold : VerseWeight.thin,
              //     italic: !_fileExists,
              //     labelColor: _fileExists == true ? Colorz.blue20 : null,
              //     centered: false,
              //     margin: 10,
              //     onTap: (){
              //
              //       if (_fileExists == true){
              //         blog('should open the damn file now');
              //       }
              //
              //     },
              //     color: _fileExists == true ? Colorz.blue255 : Colorz.white255,
              //     leadingDot: _fileExists,
              //   ),
              // ),
              //
              // /// EXISTING URL
              // if (_fileName != null && _fileExists == false)
              //   DreamBox(
              //     height: 50,
              //     width: Bubble.clearWidth(context),
              //     verse: _fileName,
              //     color: Colorz.blue20,
              //     verseCentered: false,
              //     icon: Iconz.comWebsite,
              //     onTap: (){
              //
              //       if (_fileExists == true){
              //         blog('should open the damn file now');
              //       }
              //
              //     },
              //   ),

              /// SELECTION BUTTON
              Row(
                // width: width: Bubble.clearWidth(context),
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  /// VIEW FILE
                  if (_bytesExist == true || _pathExists == true)
                    BldrsBox(
                      height: 50,
                      verse: const Verse(
                        id: 'phid_view',
                        translate: true,
                      ),
                      icon: Iconz.viewsIcon,
                      color: Colorz.white10,
                      iconSizeFactor: 0.4,
                      verseScaleFactor: (1 / 0.4) * 0.6,
                      verseWeight: VerseWeight.black,
                      verseItalic: true,
                      margins: const EdgeInsets.only(top: 10),
                      onTap: () async {

                        PDFModel? _pdf = pdfModel;

                        if (_bytesExist == true){
                         // do nothing
                        }
                        else if (_pathExists == true){
                          _pdf = await PDFProtocols.fetch(pdfModel?.path);
                        }

                        if (_pdf?.bytes == null){
                          await Dialogs.topNotice(
                              verse: const Verse(
                                id: 'phid_can_not_open_file',
                                translate: true,
                              ),
                          );
                        }

                        else {
                          await BldrsNav.goToNewScreen(
                            screen: PDFScreen(
                              pdf: pdfModel,
                            ),
                          );
                        }

                      },
                    ),

                  const Expander(),

                  /// DELETE PDF
                  if (_bytesExist == true || _pathExists == true)
                    BldrsBox(
                      height: 50,
                      verse: const Verse(
                        id: 'phid_remove',
                        translate: true,
                      ),
                      verseScaleFactor: 0.6,
                      verseWeight: VerseWeight.black,
                      verseItalic: true,
                      margins: const EdgeInsets.only(top: 10, left: 5, right: 5),
                      color: Colorz.white10,
                      onTap: () async {

                        setNotifier(notifier: _pdfNotifier, mounted: mounted, value: null);
                        widget.onDeletePDF();

                      },
                    ),

                  /// SELECT PDF
                  BldrsBox(
                    height: 50,
                    verse: Verse(
                      id: _bytesExist == true || pdfModel?.path != null ? 'phid_replace_pdf' : 'phid_select_a_pdf',
                      translate: true,
                    ),
                    verseScaleFactor: 0.6,
                    verseWeight: VerseWeight.black,
                    verseItalic: true,
                    color: Colorz.white10,
                    margins: const EdgeInsets.only(top: 10),
                    onTap: () async {

                      await _triggerLoading(setTo: true);

                      final PDFModel? _pdfModel = await PDFProtocols.pickPDF(
                        context: context,
                        flyerID: widget.flyerID,
                        bzID: widget.bzID,
                      );

                      if (_pdfModel != null){

                        _textController.text = _pdfModel.name ?? '';

                        setNotifier(notifier: _pdfNotifier, mounted: mounted, value: _pdfModel);

                        widget.onChangePDF(_pdfNotifier.value);

                      }

                      await _triggerLoading(setTo: false);

                    },
                  ),

                ],

              ),

            ],
          );

        },
    );

  }
  // -----------------------------------------------------------------------------
}
