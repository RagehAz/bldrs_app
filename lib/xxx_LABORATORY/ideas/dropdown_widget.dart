import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class DropDownBubble extends StatefulWidget {
  final String title;
  final List<String> list;
  final bool fieldIsRequired;
  final String actionBtIcon;
  final Color actionBtColor;
  final Function actionBtFunction;


  DropDownBubble({
    @required this.title,
    @required this.list,
    this.fieldIsRequired = false,
    this.actionBtColor,
    this.actionBtIcon,
    this.actionBtFunction,
  });

  @override
  _DropDownBubbleState createState() => _DropDownBubbleState();
}

class _DropDownBubbleState extends State<DropDownBubble> {
  String chosenValue = '';

  @override
  Widget build(BuildContext context) {

    int titleVerseSize = 2;
    double actionBtSize = superVerseRealHeight(context, titleVerseSize, 1, null);
    double actionBtCorner = actionBtSize * 0.4;

    return InPyramidsBubble(
      columnChildren: <Widget>[


        Container(
          // color: Colorz.YellowSmoke,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              // --- BUBBLE TITLE
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                child: SuperVerse(
                  verse: widget.title,
                  size: titleVerseSize,
                  redDot: widget.fieldIsRequired,
                ),
              ),

              // --- ACTION BUTTON
              widget.actionBtIcon == null ? Container() :
              DreamBox(
                height: actionBtSize,
                width: actionBtSize,
                corners: actionBtCorner,
                color: widget.actionBtColor,
                icon: widget.actionBtIcon,
                iconSizeFactor: 0.6,
                onTap: widget.actionBtFunction,
              ),

            ],
          ),
        ),


        Container(
          width: Scale.superBubbleClearWidth(context),
          height: 35,
          decoration: BoxDecoration(
            color: Colorz.BloodTest,
            borderRadius: Borderers.superBorderRadius(context: context, enTopLeft: 10, enBottomLeft: 10, enBottomRight: 10, enTopRight: 10),
          ),
          child: DropdownButtonFormField(
            // value: widget.list[0] ?? widget.list[0],
            dropdownColor: Colorz.Blue225,
            elevation: 0,
            style: TextStyle(color: Colorz.Red225, ),
            iconSize: 30,
            isExpanded: true,
            isDense: true,

            itemHeight: 48,
            onTap: (){print('ganzabeel');},
            icon: DreamBox(height: 20, icon: Iconz.ArrowDown, bubble: false,),
            decoration: InputDecoration(
              border: Borderers.superOutlineInputBorder(Colorz.Red225, 10),
              isDense: true,
              contentPadding: EdgeInsets.all(0),
              // labelText: 'label text',
              icon: DreamBox(height: 35, icon: Iconz.DvGouran,),
              fillColor: Colorz.Blue225,
              filled: true,
              enabled: true,
              focusColor: Colorz.BloodTest,

            ),
            items: widget.list.map((item){
              return DropdownMenuItem(
                // value: widget.list[0] ?? widget.list[0],
                onTap: (){print(item);},
                child: SuperVerse(
                  color: Colorz.Black225,
                  verse: item,
                ),
              );
            }).toList(),
            onChanged: (val) => setState(()=> chosenValue = val),
          ),
        ),

      ],
    );
  }
}
