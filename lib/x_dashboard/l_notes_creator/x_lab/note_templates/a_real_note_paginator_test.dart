import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/e_back_end/c_real/widgets/real_coll_paginator.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class RealNotePaginatorTest extends StatefulWidget {

  const RealNotePaginatorTest({
    Key key
  }) : super(key: key);

  @override
  _RealNotePaginatorTestState createState() => _RealNotePaginatorTestState();

}

class _RealNotePaginatorTestState extends State<RealNotePaginatorTest> {

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    const double _panelHeight = 100;
    final double _pageHeight = _screenHeight - _panelHeight - Stratosphere.smallAppBarStratosphere;

    return MainLayout(
      appBarType: AppBarType.basic,
      sectionButtonIsOn: false,
      pyramidsAreOn: true,
      appBarRowWidgets: [

        const Expander(),

        AppBarButton(
          icon: Iconz.reload,
          verse: Verse.plain('Reload page'),
          onTap: (){
            setState(() {});
          },
        ),

        AppBarButton(
          verse: Verse.plain('create a note'),
          onTap: () async {

            final NoteModel _note =NoteModel.quickUserNotice(
                userID: AuthFireOps.superUserID(),
                title: DateTime.now().second.toString(),
                body: 'x'
            );

            await NoteProtocols.composeToOne(
                context: context,
                note: _note,
            );

          },
        ),

      ],
      layoutWidget: Column(
        children: <Widget>[

          const Stratosphere(),

          Container(
            width: _screenWidth,
            height: _panelHeight,
            color: Colorz.bloodTest,
          ),

          RealCollPaginator(
            nodePath: 'notes/${AuthFireOps.superUserID()}',
            scrollController: _scrollController,
            builder: (_, List<Map<String, dynamic>> maps, bool isLoading){

              final List<NoteModel> _notes = NoteModel.decipherNotes(
                  maps: maps,
                  fromJSON: true,
              );

              return SizedBox(
                width: _screenWidth,
                height: _pageHeight,
                child: PageBubble(
                  screenHeightWithoutSafeArea: _pageHeight,
                  appBarType: AppBarType.non,
                  child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(
                        bottom: Ratioz.horizon,
                        top: Ratioz.appBarMargin,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: _notes.length,
                      itemBuilder: (_, index){

                        final NoteModel _note = _notes[index];

                        return NoteCard(
                          bubbleWidth: PageBubble.clearWidth(context),
                          noteModel: _note,
                          isDraftNote: false,
                        );
                      }
                  ),
                ),
              );


            },
          ),


        ],

      ),
    );

  }

}
