import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:flutter/material.dart';

class GroupsPage extends StatelessWidget {
  final List<String> groups;
  final Function onTap;
  final String selectedGroup;

  const GroupsPage({
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
          itemBuilder: (context, groupIndex){

            final String _group = groups[groupIndex];
            final Color _color = selectedGroup == _group ? Colorz.yellow255 : Colorz.nothing;

            return
              DreamBox(
                height: 70,
                // width: 120,
                color: _color,
                margins: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
                verse: _group,
                onTap: () => onTap(_group),
              );
          }
      ),
    );
  }
}
