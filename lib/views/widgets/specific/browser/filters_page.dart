import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/group_model.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:flutter/material.dart';

class FiltersPage extends StatelessWidget {
  final List<GroupModel> groups;
  final Function onTap;
  final GroupModel selectedGroup;

  const FiltersPage({
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

            final GroupModel _group = groups[keyIndex];
            final Color _color = selectedGroup?.groupID == _group.groupID ? Colorz.yellow255 : Colorz.nothing;

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
