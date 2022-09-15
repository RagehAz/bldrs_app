import 'dart:io';

import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_title.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/super_validator.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
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
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<FileModel> onChangePDF;
  final Function onDeletePDF;
  final FileModel existingPDF;
  final GlobalKey<FormState> formKey;
  final AppBarType appBarType;
  final bool canValidate;
  /// --------------------------------------------------------------------------
  @override
  _PDFSelectionBubbleState createState() => _PDFSelectionBubbleState();
  /// --------------------------------------------------------------------------
}

class _PDFSelectionBubbleState extends State<PDFSelectionBubble> {
  // -----------------------------------------------------------------------------
  final GlobalKey globalKey = GlobalKey();
  // --------------------
  ValueNotifier<FileModel> _pdf = ValueNotifier(null);
  // --------------------
  TextEditingController _textController;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'PDFSelectionBubble',);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _pdf = ValueNotifier(widget.existingPDF);
    _textController = TextEditingController(text: widget.existingPDF?.fileName);
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading().then((_) async {
        // -------------------------------
        _pdf.value = await FileModel.completeModel(_pdf.value);
        // -------------------------------
        await _triggerLoading();

      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _pdf.dispose();
    _textController.dispose();
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: _pdf,
        builder: (_, FileModel pdf, Widget child){

          final bool _fileExists = pdf?.file != null;
          final bool _urlExists = pdf?.url != null;
          final bool _sizeLimitReached = pdf?.checkSizeLimitReached() == true;
          // final String _fileName = pdf?.fileName;

          return Bubble(
            bubbleColor: Formers.validatorBubbleColor(
              validator: () => Formers.pdfValidator(
                fileModel: pdf,
                canValidate: widget.canValidate,
              ),
            ),
            width: Bubble.bubbleWidth(context),
            headerViewModel: const BubbleHeaderVM(
              headlineVerse: Verse(
                text: 'phid_pdf_attachment',
                translate: true,
              ),
            ),

            columnChildren: <Widget>[

              const BulletPoints(
                bulletPoints: <Verse>[
                  Verse(text:'##You can attach a PDF File to this flyer.', translate: true,),
                  Verse(text:'##Anybody can view and download this PDF file.', translate: true,),
                  Verse(text:'##PDF file size can only be less than 3 Mb.', translate: true,),
                ],
              ),

              if (_fileExists == true || _urlExists == true)
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


                    if (pdf.size != null)
                    SuperVerse(
                      verse: Verse(
                        text: '##${_sizeLimitReached == true ? 'Max Limit Reached' : 'File Size'} : ${pdf.size} Mb / 3 Mb',
                        translate: true,
                      ),
                      italic: true,
                      color: _sizeLimitReached == true ? Colorz.red255 : Colorz.white125,
                      weight: VerseWeight.thin,
                      scaleFactor: 0.9,
                    ),

                    if (pdf.size == null)
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


                if (_fileExists == true || _urlExists == true)
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

                  _pdf.value = _pdf.value.copyWith(
                    fileName: _textController.text,
                  );

                  widget.onChangePDF(_pdf.value);

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
                  fileModel: pdf,
                  canValidate: widget.canValidate,
                ),
                // autoValidate: true,
              ),

              /// SELECTION BUTTON
              Row(
                // width: width: Bubble.clearWidth(context),
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  /// DELETE PDF
                  if (_fileExists == true || _urlExists == true)
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
                        _pdf.value = null;
                        widget.onDeletePDF();
                      },
                    ),

                  /// SELECT PDF
                  DreamBox(
                    height: 50,
                    verse: Verse(
                      text: _fileExists == true || pdf?.url != null ? 'phid_replace_pdf' : 'phid_select_a_pdf',
                      translate: true,
                    ),
                    verseScaleFactor: 0.6,
                    verseWeight: VerseWeight.black,
                    verseItalic: true,
                    margins: const EdgeInsets.only(top: 10),
                    onTap: () async {

                      final File _file = await Filers.pickPDF();

                      if (_file != null){

                        final String _fileName = Filers.getFileNameFromFile(
                          file: _file,
                          withExtension: false,
                        );
                        _textController.text = _fileName;

                        _pdf.value = FileModel(
                          file: _file,
                          fileName: _fileName,
                          size: Filers.getFileSize(_file),
                          // url: null,
                        );

                        widget.onChangePDF(_pdf.value);

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
