import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/specs_wrapper.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';

class SpecsBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecsBuilder({
    required this.pageWidth,
    required this.specs,
    required this.onSpecTap,
    required this.onDeleteSpec,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final List<SpecModel>? specs;
  final Function({required SpecModel? value, required SpecModel? unit})? onSpecTap;
  final Function({required SpecModel? value, required SpecModel? unit})? onDeleteSpec;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<PickerModel> _specsPickers = ChainsProvider.proGetPickersBySpecs(
      context: context,
      specs: specs ?? [],
      listen: true,
    );

    if (Mapper.checkCanLoopList(_specsPickers) == true){

      // PickerModel.blogPickers(_specsPickers, invoker: 'fuckii');

      return SizedBox(
        key: const ValueKey<String>('SpecsBuilder'),
        width: pageWidth,
        child: ListView.builder(
            itemCount: _specsPickers.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
            itemBuilder: (_, int index){

              final PickerModel? _picker = _specsPickers[index];

              // _picker?.blogPicker(invoker: 'bobo');

              final List<SpecModel> _specsOfThisPicker = SpecModel.getSpecsBelongingToThisPicker(
                specs: specs,
                picker: _picker,
              );

              return Container(
                width: pageWidth,
                decoration: BoxDecoration(
                  borderRadius: Borderers.cornerAll(pageWidth * 0.04),
                  color: Colorz.white50,
                ),
                margin: const EdgeInsets.only(bottom: 2.5),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    /// SPEC PICKER NAME
                    BldrsText(
                      width: pageWidth - 20,
                      verse: Verse(
                        id: _picker?.chainID,
                        translate: true,
                      ),
                      weight: VerseWeight.thin,
                      color: Colorz.white200,
                      centered: false,
                      size: 1,
                      scaleFactor: 1.3,
                      maxLines: 2,
                    ),

                    /// SPECS
                    SpecsWrapper(
                      width: pageWidth - 20,
                      specs: _specsOfThisPicker,
                      picker: _picker,
                      onSpecTap: onSpecTap,
                      onDeleteSpec: onDeleteSpec,
                      xIsOn: false,
                      padding: 5,
                    ),

                  ],
                ),
              );

            }
        ),
      );
    }
    else {
      return const SizedBox();
    }

  }
// -----------------------------------------------------------------------------
}
