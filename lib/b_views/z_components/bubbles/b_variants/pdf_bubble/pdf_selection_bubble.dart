import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_title.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/super_validator.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/pdf_protocols/protocols/pdf_protocols.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';

import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class PDFSelectionBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PDFSelectionBubble({
    @required this.onChangePDF,
    @required this.onDeletePDF,
    @required this.existingPDF,
    @required this.formKey,
    @required this.appBarType,
    @required this.canValidate,
    @required this.flyerID,
    @required this.bzID,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<PDFModel> onChangePDF;
  final Function onDeletePDF;
  final PDFModel existingPDF;
  final GlobalKey<FormState> formKey;
  final AppBarType appBarType;
  final bool canValidate;
  final String flyerID;
  final String bzID;
  /// --------------------------------------------------------------------------
  @override
  _PDFSelectionBubbleState createState() => _PDFSelectionBubbleState();
  /// --------------------------------------------------------------------------
}

class _PDFSelectionBubbleState extends State<PDFSelectionBubble> {
  // -----------------------------------------------------------------------------
  final GlobalKey globalKey = GlobalKey();
  // --------------------
  final ValueNotifier<PDFModel> _pdfNotifier = ValueNotifier(null);
  // --------------------
  final TextEditingController _textController = TextEditingController();
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
    setNotifier(notifier: _pdfNotifier, mounted: mounted, value: widget.existingPDF);
    _textController.text = widget.existingPDF?.name;
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {

        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _pdfNotifier.dispose();
    _textController.dispose();
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: _pdfNotifier,
        builder: (_, PDFModel pdfModel, Widget child){

          final bool _bytesExist = pdfModel?.bytes != null;
          final bool _pathExists = pdfModel?.path != null;
          final bool _sizeLimitReached = pdfModel?.checkSizeLimitReached() == true;
          // final String _fileName = pdf?.fileName;

          return Bubble(
            bubbleColor: Formers.validatorBubbleColor(
              validator: () => Formers.pdfValidator(
                context: context,
                pdfModel: pdfModel,
                canValidate: widget.canValidate,
              ),
            ),
            width: Bubble.bubbleWidth(context),
            bubbleHeaderVM: const BubbleHeaderVM(
              headlineVerse: Verse(
                text: 'phid_pdf_attachment',
                translate: true,
              ),
            ),

            columnChildren: <Widget>[

              const BulletPoints(
                bulletPoints: <Verse>[
                  Verse(
                    pseudo:'You can attach a PDF File to this flyer.',
                    text: 'phid_you_can_attach_flyer_pdf',
                    translate: true,
                  ),
                  Verse(
                    pseudo:'Anybody can view and download this PDF file.',
                    text: 'phid_flyer_pdf_is_public',
                    translate: true,
                  ),
                  Verse(
                    pseudo:'PDF file size can only be less than 3 Mb.',
                    text: 'phid_pdf_size_less_than_3',
                    translate: true,
                  ),
                ],
              ),

              if (_bytesExist == true || _pathExists == true)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    const BubbleTitle(
                      titleVerse: Verse(
                        text: 'phid_pdf_file_name',
                        translate: true,
                      ),
                      titleScaleFactor: 0.9,
                    ),

                    if (pdfModel.sizeMB != null)
                    SuperVerse(
                      verse: PDFModel.getSizeLine(
                        context: context,
                        size: pdfModel.sizeMB,
                        maxSize: Standards.maxFileSizeLimit,
                        sizeLimitReached: _sizeLimitReached,
                      ),
                      italic: true,
                      color: _sizeLimitReached == true ? Colorz.red255 : Colorz.white125,
                      weight: VerseWeight.thin,
                      scaleFactor: 0.9,
                    ),

                    if (pdfModel.sizeMB == null)
                      Loading(
                        loading: true,
                        size: SuperVerse.superVerseRealHeight(
                            context: context,
                            size: 2,
                            sizeFactor: 0.9,
                            hasLabelBox: false,
                        ),
                      )

                  ],
                ),


                if (_bytesExist == true || _pathExists == true)
              SuperTextField(
                appBarType: widget.appBarType,
                globalKey: globalKey,
                width: Bubble.clearWidth(context),
                titleVerse: const Verse(
                  text: 'phid_file_name',
                  translate: true,
                ),
                maxLines: 1,
                textController: _textController,
                onChanged: (String text){

                  setNotifier(
                      notifier: _pdfNotifier,
                      mounted: mounted,
                      value: _pdfNotifier.value.copyWith(
                        name: _textController.text,
                      ),
                  );

                  widget.onChangePDF(_pdfNotifier.value);

                },
                isFormField: true,
                isFloatingField: true,
                // autoValidate: true,
                validator: (String text){

                  final bool _hasExtension = TextCheck.stringContainsSubString(
                    string: _textController.text,
                    subString: '.pdf',
                  );

                  final bool _hasDot = TextCheck.stringContainsSubString(
                    string: _textController.text,
                    subString: '.',
                  );

                  blog('is valid : $_hasExtension');

                  if (_hasExtension == true){
                    return 'remove ( .pdf ) from file name';
                  }

                  else if (_hasDot == true) {
                    return 'file name should not have any dots';
                  }
                  else {
                    return null;
                  }
                },
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

              /// VALIDATOR
              SuperValidator(
                width: Bubble.clearWidth(context),
                validator: () => Formers.pdfValidator(
                  context: context,
                  pdfModel: pdfModel,
                  canValidate: widget.canValidate,
                ),
                focusNode: null,
                // autoValidate: true,
              ),

              /// SELECTION BUTTON
              Row(
                // width: width: Bubble.clearWidth(context),
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  /// DELETE PDF
                  if (_bytesExist == true || _pathExists == true)
                    DreamBox(
                      height: 50,
                      verse: const Verse(
                        text: 'phid_remove',
                        translate: true,
                      ),
                      verseScaleFactor: 0.6,
                      verseWeight: VerseWeight.black,
                      verseItalic: true,
                      margins: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      onTap: () async {

                        setNotifier(notifier: _pdfNotifier, mounted: mounted, value: null);
                        widget.onDeletePDF();

                      },
                    ),

                  /// SELECT PDF
                  DreamBox(
                    height: 50,
                    verse: Verse(
                      text: _bytesExist == true || pdfModel?.path != null ? 'phid_replace_pdf' : 'phid_select_a_pdf',
                      translate: true,
                    ),
                    verseScaleFactor: 0.6,
                    verseWeight: VerseWeight.black,
                    verseItalic: true,
                    margins: const EdgeInsets.only(top: 10),
                    onTap: () async {

                      final PDFModel _pdfModel = await PDFProtocols.pickPDF(
                        context: context,
                        flyerID: widget.flyerID,
                        bzID: widget.bzID,
                      );

                      if (_pdfModel != null){

                        _textController.text = _pdfModel.name;

                        setNotifier(notifier: _pdfNotifier, mounted: mounted, value: _pdfModel);

                        widget.onChangePDF(_pdfNotifier.value);

                      }

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
