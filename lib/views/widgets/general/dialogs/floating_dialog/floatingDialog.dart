import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class FloatingDialog extends StatefulWidget {
  final String title;
  final List<String> list;
  final bool fieldIsRequired;
  final String actionBtIcon;
  final Color actionBtColor;
  final Function actionBtFunction;


  const FloatingDialog({
    @required this.title,
    @required this.list,
    this.fieldIsRequired = false,
    this.actionBtColor,
    this.actionBtIcon,
    this.actionBtFunction,
  });

  @override
  _FloatingDialogState createState() => _FloatingDialogState();
}

class _FloatingDialogState extends State<FloatingDialog> {
  String chosenValue = '';

  @override
  Widget build(BuildContext context) {

    const int titleVerseSize = 2;
    final double actionBtSize = SuperVerse.superVerseRealHeight(context, titleVerseSize, 1, null);
    final double actionBtCorner = actionBtSize * 0.4;

    return Bubble(
      columnChildren: <Widget>[

        Container(
          // color: Colorz.YellowSmoke,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// BUBBLE TITLE
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                child: SuperVerse(
                  verse: widget.title,
                  size: titleVerseSize,
                  redDot: widget.fieldIsRequired,
                ),
              ),

              /// ACTION BUTTON
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
          width: Bubble.clearWidth(context),
          height: 35,
          decoration: BoxDecoration(
            color: Colorz.bloodTest,
            borderRadius: Borderers.superBorderOnly(context: context, enTopLeft: 10, enBottomLeft: 10, enBottomRight: 10, enTopRight: 10),
          ),
          child: DropdownButtonFormField(
            value: widget.list[0] ?? widget.list[0],
            dropdownColor: Colorz.blue225,
            elevation: 0,
            style: TextStyle(color: Colorz.red255, ),
            iconSize: 20,
            isExpanded: true,
            isDense: true,

            itemHeight: 48,
            onTap: (){print('ganzabeel');},
            icon: DreamBox(height: 20, icon: Iconz.ArrowDown, bubble: false,),
            decoration: InputDecoration(

              border: Borderers.superOutlineInputBorder(Colorz.red255, 10),
              isDense: true,
              contentPadding: EdgeInsets.all(0),
              // labelText: 'label text',
              icon: DreamBox(height: 35, icon: Iconz.DvGouran,),
              fillColor: Colorz.blue225,
              filled: true,
              enabled: true,
              focusColor: Colorz.bloodTest,

            ),
            items: widget.list.map((item){
              return DropdownMenuItem(
                value: item,
                onTap: (){print(item);},
                child: SuperVerse(
                  color: Colorz.black230,
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
