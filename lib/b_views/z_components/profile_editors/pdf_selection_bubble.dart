

import 'dart:io';

import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class PDFSelectionBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PDFSelectionBubble({
    @required this.onFilePicked,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<File> onFilePicked;
  /// --------------------------------------------------------------------------
  @override
  _PDFSelectionBubbleState createState() => _PDFSelectionBubbleState();
/// --------------------------------------------------------------------------
}

class _PDFSelectionBubbleState extends State<PDFSelectionBubble> {

  final ValueNotifier<File> _pdfFile = ValueNotifier<File>(null);

  @override
  Widget build(BuildContext context) {

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

          ValueListenableBuilder(
              valueListenable: _pdfFile,
              builder: (_, File file, Widget child){

                final bool _exists = file != null;
                final String _fileName = Filers.getFileNameFromFile(file);

                return SizedBox(
                  width: Bubble.clearWidth(context),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      SizedBox(
                        width: Bubble.clearWidth(context) - 100,
                        height: 50,
                        child: SuperVerse(
                          verse: _exists == true ? _fileName : 'Select a file',
                          weight: _exists == true ? VerseWeight.bold : VerseWeight.thin,
                          italic: !_exists,
                          labelColor: _exists == true ? Colorz.blue20 : null,
                          centered: false,
                          margin: 10,
                          onTap: (){

                            if (_exists == true){
                              blog('should open the damn file now');
                            }

                          },
                          color: _exists == true ? Colorz.blue255 : Colorz.white255,
                          size: 3,
                          leadingDot: _exists,
                        ),
                      ),

                      DreamBox(
                        height: 50,
                        width: 100,
                        verse: _exists == true ? 're-Select' : 'Select PDF',
                        verseScaleFactor: 0.6,
                        verseWeight: VerseWeight.black,
                        verseItalic: true,
                        onTap: () async {

                          final File _file = await Filers.pickPDF();

                          if (_file != null){

                            _pdfFile.value = _file;
                            widget.onFilePicked(_file);

                          }

                        },
                      ),

                    ],
                  ),
                );

              }
          ),


        ],
    );

  }
}
