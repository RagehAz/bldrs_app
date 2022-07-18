import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class DynamicLinksTestScreen extends StatelessWidget {

  const DynamicLinksTestScreen({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CenteredListLayout(
        title: 'Dynamic Links',
        columnChildren: <Widget>[

          WideButton(
            verse: 'Dynamic Link Shit',
            onTap: (){

              blog('Fuck You Bitch');

            },
          ),

        ],
    );

  }
}
