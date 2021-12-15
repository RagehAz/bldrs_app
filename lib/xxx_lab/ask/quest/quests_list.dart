import 'package:bldrs/b_views/widgets/components/stratosphere.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/xxx_lab/ask/quest/quest_model.dart';
import 'package:flutter/material.dart';

class QuestList extends StatelessWidget {
  const QuestList({Key key, this.questions}) : super(key: key);
  final List<Quest> questions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: Stratosphere.stratosphereSandwich,
        itemCount: questions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: SuperVerse(
              verse: '($index) :\n${questions[index].body}',
              maxLines: 100,
              labelColor: Colorz.white10,
              weight: VerseWeight.thin,
              size: 1,
              margin: 5,
              centered: false,
              color: Colorz.yellow255,
            ),
          );
        });
  }
}
