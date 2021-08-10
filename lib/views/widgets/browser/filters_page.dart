import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/groups.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:flutter/material.dart';

class FiltersPage extends StatelessWidget {
  final List<Group> groups;
  final Function onTap;
  final Group selectedGroup;

  FiltersPage({
    Key key,
    @required this.groups,
    @required this.onTap,
    @required this.selectedGroup,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 20,
      // height: 20,
      // color: _colors[pageIndex],
      child: ListView.builder(
          itemCount: groups.length,
          padding: const EdgeInsets.all(Ratioz.appBarMargin),
          itemBuilder: (context, keyIndex){

            Group _group = groups[keyIndex];

            Color _color = selectedGroup?.groupID == _group.groupID ? Colorz.Yellow255 : Colorz.Nothing;

            return
              DreamBox(
                height: 70,
                // width: 120,
                color: _color,
                margins: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
                verse: _group.groupID,
                onTap: () => onTap(_group),
              );
          }
      ),
    );
  }
}
