import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:flutter/material.dart';

class GroupsPage extends StatelessWidget {
  final List<String> groups;
  final Function onTap;
  final String selectedGroup;

  GroupsPage({
    Key key,
    @required this.groups,
    @required this.onTap,
    @required this.selectedGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 20,
      // height: 20,
      // color: _colors[pageIndex],
      child: ListView.builder(
          itemCount: groups.length,
          padding: const EdgeInsets.all(Ratioz.appBarMargin),
          itemBuilder: (context, groupIndex){

            String _group = groups[groupIndex];

            Color _color = selectedGroup == _group ? Colorz.Yellow : Colorz.Nothing;

            return
              DreamBox(
                height: 70,
                // width: 120,
                color: _color,
                boxMargins: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
                verse: _group,
                boxFunction: () => onTap(_group),
              );
          }
      ),
    );
  }
}
