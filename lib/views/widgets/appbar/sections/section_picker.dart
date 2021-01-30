import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:flutter/material.dart';
import 'section_label.dart';

class SectionPicker extends StatelessWidget {
  final String currentSection;
  final Function selectingASection;
  final bool sectionsListIsOpen;
  final Function openingTheList;

  SectionPicker({
    @required this.currentSection,
    @required this.selectingASection,
    @required this.sectionsListIsOpen,
    @required this.openingTheList,
  });

  @override
  Widget build(BuildContext context) {
    String _properties = Wordz.properties(context);
    String _designs = Wordz.designs(context);
    String _products = Wordz.products(context);
    String _projects = Wordz.projects(context);
    String _crafts = Wordz.crafts(context);
    String _equipment = Wordz.equipments(context);

    return
      sectionsListIsOpen == false ?
    SectionLabel(
      label: Wordz.section(context),
      labelDescription: '',
      sectionsListIsOpen: sectionsListIsOpen,
      tappingSection: openingTheList,
    )
        :
    Column(
      children: <Widget>[

        SectionLabel(
          label: Wordz.properties(context),
          sectionsListIsOpen: sectionsListIsOpen,
          tappingSection: () {selectingASection(_properties);},
          labelDescription: Wordz.propertiesDescription(context),),

        SizedBox(
          width: double.infinity,
          height: 20,
        ),

        SectionLabel(
          sectionsListIsOpen: sectionsListIsOpen,
          label: Wordz.designs(context),
          tappingSection: () {selectingASection(_designs);},
          labelDescription: Wordz.designsDescription(context),),

        SizedBox(
          width: double.infinity,
          height: 20,
        ),

        SectionLabel(
          sectionsListIsOpen: sectionsListIsOpen,
          label: Wordz.products(context),
          tappingSection: () {selectingASection(_products);},
          labelDescription: Wordz.productsDescription(context),),

        SizedBox(
          width: double.infinity,
          height: 20,
        ),

        SectionLabel(
          sectionsListIsOpen: sectionsListIsOpen,
          label: Wordz.projects(context),
          tappingSection: () {selectingASection(_projects);},
          labelDescription: Wordz.productsDescription(context),),

              SizedBox(
                width: double.infinity,
                height: 20,
              ),

              SectionLabel(
                sectionsListIsOpen: sectionsListIsOpen,
                label: Wordz.crafts(context),
                tappingSection: () {selectingASection(_crafts);},
                labelDescription: Wordz.craftsDescription(context),),

              SizedBox(
                width: double.infinity,
                height: 20,
              ),

              SectionLabel(
                sectionsListIsOpen: sectionsListIsOpen,
                label: Wordz.equipment(context),
                tappingSection: () {selectingASection(_equipment);},
                labelDescription: Wordz.equipmentDescription(context),),

            ],
          );
  }
}
