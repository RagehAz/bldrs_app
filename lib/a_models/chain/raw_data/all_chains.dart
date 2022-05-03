import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/a_models/chain/raw_data/keywords_chains/chain_crafts.dart';
import 'package:bldrs/a_models/chain/raw_data/keywords_chains/chain_designs.dart';
import 'package:bldrs/a_models/chain/raw_data/keywords_chains/chain_equipment.dart';
import 'package:bldrs/a_models/chain/raw_data/keywords_chains/chain_products.dart';
import 'package:bldrs/a_models/chain/raw_data/keywords_chains/chain_properties.dart';
import 'package:bldrs/a_models/chain/raw_data/specs/raw_specs_chains.dart' as specsChain;

// -----------------------------------------------------------------------------

/// SECTIONS / KEYWORDS CHAINS

// --------------------------------------------
const Chain bldrsChain = Chain(
  id: 'phid_sections',
  icon: Iconz.bldrsNameEn,
  sons: <Chain>[

    /// PROPERTIES
    ChainProperties.chain,

    /// DESIGN
    ChainDesigns.chain,

    /// CRAFTS
    ChainCrafts.chain,

    /// PRODUCTS
    ChainProducts.chain,

    /// EQUIPMENT
    ChainEquipment.chain,

  ],
);
// -----------------------------------------------------------------------------

/// SPECS CHAINS

// --------------------------------------------
const Chain allSpecsChain = Chain(
  id: 'phid_s_specs_chain',
  icon: null,
  sons: <Chain>[
    specsChain.style,
    specsChain.color,
    specsChain.contractType,
    specsChain.paymentMethod,
    specsChain.price,
    specsChain.currency,
    specsChain.unitPriceInterval,
    specsChain.numberOfInstallments,
    specsChain.installmentsDuration,
    specsChain.installmentsDurationUnit,
    specsChain.duration,
    specsChain.durationUnit,
    specsChain.propertyArea,
    specsChain.propertyAreaUnit,
    specsChain.lotArea,
    specsChain.lotAreaUnit,
    specsChain.propertyForm,
    specsChain.propertyLicense,
    specsChain.propertySpaces,
    specsChain.propertyFloorNumber,
    specsChain.propertyDedicatedParkingLotsCount,
    specsChain.propertyNumberOfBedrooms,
    specsChain.propertyNumberOfBathrooms,
    specsChain.propertyView,
    specsChain.propertyIndoorFeatures,
    specsChain.propertyFinishingLevel,
    specsChain.buildingNumberOfFloors,
    specsChain.buildingAgeInYears,
    specsChain.buildingTotalParkingLotsCount,
    specsChain.buildingTotalUnitsCount,
    specsChain.inACompound,
    specsChain.amenities,
    specsChain.communityServices,
    specsChain.constructionActivityMeasurementMethod,
    specsChain.width,
    specsChain.length,
    specsChain.height,
    specsChain.thickness,
    specsChain.diameter,
    specsChain.radius,
    specsChain.linearMeasurementUnit,
    specsChain.footPrint,
    specsChain.areaMeasureUnit,
    specsChain.volume,
    specsChain.volumeMeasurementUnit,
    specsChain.weight,
    specsChain.weightMeasurementUnit,
    specsChain.count,
    specsChain.size,
    specsChain.wattage,
    specsChain.voltage,
    specsChain.ampere,
    specsChain.inStock,
    specsChain.deliveryAvailable,
    specsChain.deliveryDuration,
    specsChain.deliveryDurationUnit,
    specsChain.madeIn,
    specsChain.warrantyDuration,
    specsChain.warrantyDurationUnit,
  ],
);
// -----------------------------------------------------------------------------
