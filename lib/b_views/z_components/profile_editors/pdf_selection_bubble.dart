import 'dart:io';

import 'package:bldrs/a_models/flyer/sub/flyer_pdf.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_title.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:flutter/material.dart';

class PDFSelectionBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PDFSelectionBubble({
    @required this.onChangePDF,
    @required this.onDeletePDF,
    @required this.existingPDF,
    @required this.formKey,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<FlyerPDF> onChangePDF;
  final Function onDeletePDF;
  final FlyerPDF existingPDF;
  final GlobalKey<FormState> formKey;
  /// --------------------------------------------------------------------------
  @override
  _PDFSelectionBubbleState createState() => _PDFSelectionBubbleState();
/// --------------------------------------------------------------------------
}

class _PDFSelectionBubbleState extends State<PDFSelectionBubble> {
// ------------------------------
  ValueNotifier<FlyerPDF> _pdf = ValueNotifier(null);
  TextEditingController _textController;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _pdf = ValueNotifier(widget.existingPDF);
    _textController = TextEditingController(text: widget.existingPDF?.fileName);
    super.initState();
  }

  @override
  void dispose() {
    _pdf.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: _pdf,
        builder: (_, FlyerPDF pdf, Widget child){

          final bool _fileExists = pdf?.file != null;
          final bool _urlExists = pdf?.url != null;
          // final String _fileName = pdf?.fileName;

          return Bubble(
            width: Bubble.bubbleWidth(context: context, stretchy: false),
            title: 'PDF Attachment',
            columnChildren: <Widget>[

              const BubbleBulletPoints(
                bulletPoints: <String>[
                  'You can attach a PDF File to this flyer',
                  'Anybody can view and download this PDF file',
                ],
              ),

              if (_fileExists == true || _urlExists == true)
                const BubbleTitle(
                  title: 'PDF File name',
                  // centered: false,
                  redDot: true,
                  titleScaleFactor: 0.9,
                  // titleColor: Colorz.white255,
                ),

                if (_fileExists == true || _urlExists == true)
              SuperTextField(
                width: Bubble.clearWidth(context),
                title: 'File Name',
                maxLines: 1,
                textController: _textController,
                onChanged: (String text){

                  _pdf.value = _pdf.value.copyWith(
                    fileName: _textController.text,
                  );

                  widget.onChangePDF(_pdf.value);

                },
                isFormField: true,
                isTheSuperKeyboardField: true,
                autoValidate: true,
                validator: (){

                  final bool _hasExtension = TextChecker.stringContainsSubString(
                    string: _textController.text,
                    subString: '.pdf',
                  );

                  final bool _hasDot = TextChecker.stringContainsSubString(
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

              /// SELECTION BUTTON
              Row(
                // width: width: Bubble.clearWidth(context),
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  /// DELETE PDF
                  if (_fileExists == true || _urlExists == true)
                    DreamBox(
                      height: 50,
                      verse: 'Remove',
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
                    verse: _fileExists == true || pdf?.url != null ? 'Replace PDF' : 'Select a PDF',
                    verseScaleFactor: 0.6,
                    verseWeight: VerseWeight.black,
                    verseItalic: true,
                    margins: const EdgeInsets.only(top: 10),
                    onTap: () async {

                      final File _file = await Filers.pickPDF();

                      if (_file != null){

                        final String _fileName = Filers.getFileNameFromFile(file: _file);
                        _textController.text = _fileName;

                        _pdf.value = FlyerPDF(
                          file: _file,
                          fileName: _fileName,
                          url: null,
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
}
