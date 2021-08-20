import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart' show Stratosphere;
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

import 'quest_model.dart';

class QuestList extends StatelessWidget {
  const QuestList({Key key, this.questions}) : super(key: key);
  final List<Quest> questions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: Stratosphere.stratosphereSandwich,
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: SuperVerse(
              verse: '($index) :\n${questions[index].body}',
              maxLines: 100,
              labelColor: Colorz.White10,
              weight: VerseWeight.thin,
              size: 1,
              margin: 5,
              centered: false,
              color: Colorz.Yellow255,

            ),
          );
        });
  }
}