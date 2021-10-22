

import 'package:bldrs/models/helpers/namez_model.dart';
import 'package:bldrs/models/kw/chain.dart';
import 'package:bldrs/models/kw/kw.dart';

abstract class Specs{

  static const List<Chain> chains = <Chain>[

    // -----------------------------------------------
    /// Kiosk Type
    const Chain(
      id: 'group_dz_kioskType',
      names: <Name>[Name(code: 'en', value: 'Kiosk Type'), Name(code: 'ar', value: 'نوع الكشك')],
      sons: const <KW>[
        const KW(id: 'kiosk_food', names: <Name>[Name(code: 'en', value: 'Food & Beverages'), Name(code: 'ar', value: 'أكل و شراب')],),
        const KW(id: 'kiosk_medical', names: <Name>[Name(code: 'en', value: 'Medical'), Name(code: 'ar', value: 'صحي')],),
        const KW(id: 'kiosk_retail', names: <Name>[Name(code: 'en', value: 'Retail'), Name(code: 'ar', value: 'تجاري')],),
        const KW(id: 'kiosk_admin', names: <Name>[Name(code: 'en', value: 'Admin.'), Name(code: 'ar', value: 'إداري')],),
      ],
    ),
    // -----------------------------------------------
    /// Architectural Style
    const Chain(
      id: 'group_dz_style',
      names: <Name>[Name(code: 'en', value: 'Architectural Style'), Name(code: 'ar', value: 'الطراز المعماري')],
      sons: const <KW>[
        KW(id: 'arch_style_arabian', names: <Name>[Name(code: 'en', value: 'Arabian'), Name(code: 'ar', value: 'عربي')],),
        KW(id: 'arch_style_andalusian', names: <Name>[Name(code: 'en', value: 'Andalusian'), Name(code: 'ar', value: 'أندلسي')],),
        KW(id: 'arch_style_asian', names: <Name>[Name(code: 'en', value: 'Asian'), Name(code: 'ar', value: 'آسيوي')],),
        KW(id: 'arch_style_chinese', names: <Name>[Name(code: 'en', value: 'Chinese'), Name(code: 'ar', value: 'صيني')],),
        KW(id: 'arch_style_contemporary', names: <Name>[Name(code: 'en', value: 'Contemporary'), Name(code: 'ar', value: 'معاصر')],),
        KW(id: 'arch_style_classic', names: <Name>[Name(code: 'en', value: 'Classic'), Name(code: 'ar', value: 'كلاسيكي')],),
        KW(id: 'arch_style_eclectic', names: <Name>[Name(code: 'en', value: 'Eclectic'), Name(code: 'ar', value: 'انتقائي')],),
        KW(id: 'arch_style_english', names: <Name>[Name(code: 'en', value: 'English'), Name(code: 'ar', value: 'إنجليزي')],),
        KW(id: 'arch_style_farmhouse', names: <Name>[Name(code: 'en', value: 'Farmhouse'), Name(code: 'ar', value: 'ريفي')],),
        KW(id: 'arch_style_french', names: <Name>[Name(code: 'en', value: 'French'), Name(code: 'ar', value: 'فرنساوي')],),
        KW(id: 'arch_style_gothic', names: <Name>[Name(code: 'en', value: 'Gothic'), Name(code: 'ar', value: 'قوطي')],),
        KW(id: 'arch_style_greek', names: <Name>[Name(code: 'en', value: 'Greek'), Name(code: 'ar', value: 'يوناني')],),
        KW(id: 'arch_style_indian', names: <Name>[Name(code: 'en', value: 'Indian'), Name(code: 'ar', value: 'هندي')],),
        KW(id: 'arch_style_industrial', names: <Name>[Name(code: 'en', value: 'Industrial'), Name(code: 'ar', value: 'صناعي')],),
        KW(id: 'arch_style_japanese', names: <Name>[Name(code: 'en', value: 'Japanese'), Name(code: 'ar', value: 'ياباني')],),
        KW(id: 'arch_style_mediterranean', names: <Name>[Name(code: 'en', value: 'Mediterranean'), Name(code: 'ar', value: 'البحر المتوسط')],),
        KW(id: 'arch_style_midcentury', names: <Name>[Name(code: 'en', value: 'Mid century modern'), Name(code: 'ar', value: 'منتصف القرن الحديث')],),
        KW(id: 'arch_style_medieval', names: <Name>[Name(code: 'en', value: 'Medieval'), Name(code: 'ar', value: 'القرون الوسطى')],),
        KW(id: 'arch_style_minimalist', names: <Name>[Name(code: 'en', value: 'Minimalist'), Name(code: 'ar', value: 'مينيماليزم')],),
        KW(id: 'arch_style_modern', names: <Name>[Name(code: 'en', value: 'Modern'), Name(code: 'ar', value: 'حديث')],),
        KW(id: 'arch_style_moroccan', names: <Name>[Name(code: 'en', value: 'Moroccan'), Name(code: 'ar', value: 'مغربي')],),
        KW(id: 'arch_style_rustic', names: <Name>[Name(code: 'en', value: 'Rustic'), Name(code: 'ar', value: 'فلاحي')],),
        KW(id: 'arch_style_scandinavian', names: <Name>[Name(code: 'en', value: 'Scandinavian'), Name(code: 'ar', value: 'إسكاندنيفي')],),
        KW(id: 'arch_style_shabbyChic', names: <Name>[Name(code: 'en', value: 'Shabby Chic'), Name(code: 'ar', value: 'مهترئ أنيق')],),
        KW(id: 'arch_style_american', names: <Name>[Name(code: 'en', value: 'American'), Name(code: 'ar', value: 'أمريكي')],),
        KW(id: 'arch_style_spanish', names: <Name>[Name(code: 'en', value: 'Spanish'), Name(code: 'ar', value: 'أسباني')],),
        KW(id: 'arch_style_traditional', names: <Name>[Name(code: 'en', value: 'Traditional'), Name(code: 'ar', value: 'تقليدي')],),
        KW(id: 'arch_style_transitional', names: <Name>[Name(code: 'en', value: 'Transitional'), Name(code: 'ar', value: 'انتقالي')],),
        KW(id: 'arch_style_tuscan', names: <Name>[Name(code: 'en', value: 'Tuscan'), Name(code: 'ar', value: 'توسكاني')],),
        KW(id: 'arch_style_tropical', names: <Name>[Name(code: 'en', value: 'Tropical'), Name(code: 'ar', value: 'استوائي')],),
        KW(id: 'arch_style_victorian', names: <Name>[Name(code: 'en', value: 'Victorian'), Name(code: 'ar', value: 'فيكتوريان')],),
        KW(id: 'arch_style_vintage', names: <Name>[Name(code: 'en', value: 'Vintage'), Name(code: 'ar', value: 'عتيق')],),
      ],
    ),
    // -----------------------------------------------
    /// Area
    const Chain(
      id: 'group_ppt_area',
      names: <Name>[Name(code: 'en', value: 'Area'), Name(code: 'ar', value: 'المساحة')],
      sons: const <Chain>[
        // ----------------------------------
        /// Property Area
        const Chain(
          id: 'sub_ppt_area_pptArea',
          names: <Name>[Name(code: 'en', value: 'Property Area'), Name(code: 'ar', value: 'مساحة العقارر')],
          sons: const <KW>[
            KW(id: 'pArea_less', names: <Name>[Name(code: 'en', value: 'Less than 50 m²'), Name(code: 'ar', value: 'أقل من 50 م²')],),
            KW(id: 'pArea_50_100', names: <Name>[Name(code: 'en', value: '50 - 100 m² '), Name(code: 'ar', value: 'بين 50 - 100 م²')],),
            KW(id: 'pArea_100_150', names: <Name>[Name(code: 'en', value: '100 - 150 m²'), Name(code: 'ar', value: 'بين 100 - 150 م²')],),
            KW(id: 'pArea_150_200', names: <Name>[Name(code: 'en', value: '150 - 200 m² '), Name(code: 'ar', value: 'بين 150 - 200 م²')],),
            KW(id: 'pArea_200_250', names: <Name>[Name(code: 'en', value: '200 - 250 m² '), Name(code: 'ar', value: 'بين 200 - 250 م²')],),
            KW(id: 'pArea_250_300', names: <Name>[Name(code: 'en', value: '250 - 300 m²'), Name(code: 'ar', value: 'بين 250 - 300 م²')],),
            KW(id: 'pArea_300_400', names: <Name>[Name(code: 'en', value: '300 - 400 m² '), Name(code: 'ar', value: 'بين 300 - 400 م²')],),
            KW(id: 'pArea_400_500', names: <Name>[Name(code: 'en', value: '400 - 500 m² '), Name(code: 'ar', value: 'بين 400 - 500 م²')],),
            KW(id: 'pArea_500_700', names: <Name>[Name(code: 'en', value: '500 - 700 m² '), Name(code: 'ar', value: 'بين 500 - 700 م²')],),
            KW(id: 'pArea_700_1000', names: <Name>[Name(code: 'en', value: '700 - 1,000 m²'), Name(code: 'ar', value: 'بين 700 - 1000 م²')],),
            KW(id: 'pArea_1000_2000', names: <Name>[Name(code: 'en', value: '1,000 - 2,000 m² '), Name(code: 'ar', value: 'بين 1000 - 2000 م²')],),
            KW(id: 'pArea_2000_5000', names: <Name>[Name(code: 'en', value: '2,000 - 5,000 m²'), Name(code: 'ar', value: 'بين 2000 - 5000 م²')],),
            KW(id: 'pArea_5000_10000', names: <Name>[Name(code: 'en', value: '5,000 - 10,000 m²'), Name(code: 'ar', value: 'بين 5000 - 10000 م²')],),
            KW(id: 'pArea_more', names: <Name>[Name(code: 'en', value: 'More than 10000 m²'), Name(code: 'ar', value: 'أكبر من 10000 م²')],),
          ],
        ),
        // ----------------------------------
        /// Lot Area
        const Chain(
          id: 'sub_ppt_area_lotArea',
          names: <Name>[Name(code: 'en', value: 'Lot Area'), Name(code: 'ar', value: 'مساحة الأرض')],
          sons: const <KW>[
            KW(id: 'lArea_200_500', names: <Name>[Name(code: 'en', value: '200 - 500 m²'), Name(code: 'ar', value: 'بين 200 - 500 م²')],),
            KW(id: 'lArea_500_1000', names: <Name>[Name(code: 'en', value: '500 - 1000 m²'), Name(code: 'ar', value: 'بين 500 - 1000 م²')],),
            KW(id: 'lArea_1000_2000', names: <Name>[Name(code: 'en', value: '1,000 - 2,000 m²'), Name(code: 'ar', value: 'بين 1000 - 2000 م²')],),
            KW(id: 'lArea_2000_5000', names: <Name>[Name(code: 'en', value: ',000 - 5,000 m²'), Name(code: 'ar', value: 'بين 2000 - 5000 م²')],),
            KW(id: 'lArea_5000_10000', names: <Name>[Name(code: 'en', value: '5,000 - 10,000 m²'), Name(code: 'ar', value: 'بين 5000 - 10000 م²')],),
            KW(id: 'lArea_10000_20000', names: <Name>[Name(code: 'en', value: '10,000 - 20,000 m²'), Name(code: 'ar', value: 'بين 10000 - 20000 م²')],),
            KW(id: 'lArea_20000_50000', names: <Name>[Name(code: 'en', value: '20,000 - 50,000 m²'), Name(code: 'ar', value: 'بين 20000 - 50000 م²')],),
            KW(id: 'lArea_more', names: <Name>[Name(code: 'en', value: 'More than 50,000 m²'), Name(code: 'ar', value: 'أكبر من 50000 م²')],),
          ],
        ),
        // ----------------------------------
      ],
    ),
    // -----------------------------------------------
    /// Property Features
    const Chain(
      id: 'group_ppt_features',
      names: <Name>[Name(code: 'en', value: 'Property Features'), Name(code: 'ar', value: 'خواص العقار')],
      sons: const <Chain>[
        // ----------------------------------
        /// Property View
        const Chain(
          id: 'sub_ppt_feat_view',
          names: <Name>[Name(code: 'en', value: 'Property View'), Name(code: 'ar', value: 'المنظر المطل عليه  العقار')],
          sons: const <KW>[
            KW(id: 'view_golf', names: <Name>[Name(code: 'en', value: 'Golf course view'), Name(code: 'ar', value: 'مضمار جولف')],),
            KW(id: 'view_hill', names: <Name>[Name(code: 'en', value: 'Hill or Mountain view'), Name(code: 'ar', value: 'تل أو جبل')],),
            KW(id: 'view_ocean', names: <Name>[Name(code: 'en', value: 'Ocean view'), Name(code: 'ar', value: 'محيط')],),
            KW(id: 'view_city', names: <Name>[Name(code: 'en', value: 'City view'), Name(code: 'ar', value: 'مدينة')],),
            KW(id: 'view_lake', names: <Name>[Name(code: 'en', value: 'Lake view'), Name(code: 'ar', value: 'بحيرة')],),
            KW(id: 'view_lagoon', names: <Name>[Name(code: 'en', value: 'Lagoon view'), Name(code: 'ar', value: 'لاجون')],),
            KW(id: 'view_river', names: <Name>[Name(code: 'en', value: 'River view'), Name(code: 'ar', value: 'نهر')],),
            KW(id: 'view_mainStreet', names: <Name>[Name(code: 'en', value: 'Main street view'), Name(code: 'ar', value: 'شارع رئيسي')],),
            KW(id: 'view_sideStreet', names: <Name>[Name(code: 'en', value: 'Side street view'), Name(code: 'ar', value: 'شارع جانبي')],),
            KW(id: 'view_corner', names: <Name>[Name(code: 'en', value: 'Corner view'), Name(code: 'ar', value: 'ناصية الشارع')],),
            KW(id: 'view_back', names: <Name>[Name(code: 'en', value: 'Back view'), Name(code: 'ar', value: 'خلفي')],),
            KW(id: 'view_garden', names: <Name>[Name(code: 'en', value: 'Garden view'), Name(code: 'ar', value: 'حديقة')],),
            KW(id: 'view_pool', names: <Name>[Name(code: 'en', value: 'Pool view'), Name(code: 'ar', value: 'حمام سباحة')],),
          ],
        ),
        // ----------------------------------
        /// Number of Floor
        const Chain(
          id: 'sub_ppt_feat_floors',
          names: <Name>[Name(code: 'en', value: 'Number of Floor'), Name(code: 'ar', value: 'الدور')],
          sons: const <KW>[
            KW(id: 'floor_lower', names: <Name>[Name(code: 'en', value: 'Under B-1'), Name(code: 'ar', value: 'أسفل البدروم الأول')],),
            KW(id: 'floor_b1', names: <Name>[Name(code: 'en', value: 'B-1'), Name(code: 'ar', value: 'البدروم الأول')],),
            KW(id: 'floor_g', names: <Name>[Name(code: 'en', value: 'Ground floor'), Name(code: 'ar', value: 'الدور الأرضي')],),
            KW(id: 'floor_1_10', names: <Name>[Name(code: 'en', value: '1ˢᵗ - 10ᵗʰ'), Name(code: 'ar', value: '1ˢᵗ - 10ᵗʰ')],),
            KW(id: 'floor_10_20', names: <Name>[Name(code: 'en', value: '10ᵗʰ - 20ᵗʰ'), Name(code: 'ar', value: '10ᵗʰ - 20ᵗʰ')],),
            KW(id: 'floor_20_30', names: <Name>[Name(code: 'en', value: '20ᵗʰ - 30ᵗʰ'), Name(code: 'ar', value: '20ᵗʰ - 30ᵗʰ')],),
            KW(id: 'floor_30_40', names: <Name>[Name(code: 'en', value: '30ᵗʰ - 40ᵗʰ'), Name(code: 'ar', value: '30ᵗʰ - 40ᵗʰ')],),
            KW(id: 'floor_40_50', names: <Name>[Name(code: 'en', value: '40ᵗʰ - 50ᵗʰ'), Name(code: 'ar', value: '40ᵗʰ - 50ᵗʰ')],),
            KW(id: 'floor_50_60', names: <Name>[Name(code: 'en', value: '50ᵗʰ - 60ᵗʰ'), Name(code: 'ar', value: '50ᵗʰ - 60ᵗʰ')],),
            KW(id: 'floor_60_70', names: <Name>[Name(code: 'en', value: '60ᵗʰ - 70ᵗʰ'), Name(code: 'ar', value: '60ᵗʰ - 70ᵗʰ')],),
            KW(id: 'floor_70_80', names: <Name>[Name(code: 'en', value: '70ᵗʰ - 80ᵗʰ'), Name(code: 'ar', value: '70ᵗʰ - 80ᵗʰ')],),
            KW(id: 'floor_90_100', names: <Name>[Name(code: 'en', value: '90ᵗʰ - 100ᵗʰ'), Name(code: 'ar', value: '90ᵗʰ - 100ᵗʰ')],),
            KW(id: 'floor_100_163', names: <Name>[Name(code: 'en', value: '100ᵗʰ - 163ʳᵈ'), Name(code: 'ar', value: '100ᵗʰ - 163ʳᵈ')],),
          ],
        ),
        // ----------------------------------
        /// Indoor Features
        const Chain(
          id: 'sub_ppt_feat_indoor',
          names: <Name>[Name(code: 'en', value: 'Indoor Features'), Name(code: 'ar', value: 'خواص داخلية')],
          sons: const <KW>[
            KW(id: 'pFeature_disabilityFeatures', names: <Name>[Name(code: 'en', value: 'Disability features'), Name(code: 'ar', value: 'خواص معتبرة للإعاقة و المقعدين')],),
            KW(id: 'pFeature_fireplace', names: <Name>[Name(code: 'en', value: 'Fireplace'), Name(code: 'ar', value: 'مدفأة حطب')],),
            KW(id: 'pFeature_energyEfficient', names: <Name>[Name(code: 'en', value: 'Energy efficient'), Name(code: 'ar', value: 'موفر للطاقة')],),
            KW(id: 'pFeature_electricityBackup', names: <Name>[Name(code: 'en', value: 'Electricity backup'), Name(code: 'ar', value: 'دعم كهرباء احتياطي')],),
            KW(id: 'pFeature_centralAC', names: <Name>[Name(code: 'en', value: 'Central AC'), Name(code: 'ar', value: 'تكييف مركزي')],),
            KW(id: 'pFeature_centralHeating', names: <Name>[Name(code: 'en', value: 'Central heating'), Name(code: 'ar', value: 'تدفئة مركزية')],),
            KW(id: 'pFeature_builtinWardrobe', names: <Name>[Name(code: 'en', value: 'Built-in wardrobes'), Name(code: 'ar', value: 'دواليب داخل الحوائط')],),
            KW(id: 'pFeature_kitchenAppliances', names: <Name>[Name(code: 'en', value: 'Kitchen Appliances'), Name(code: 'ar', value: 'أجهزة مطبخ')],),
            KW(id: 'pFeature_elevator', names: <Name>[Name(code: 'en', value: 'Elevator'), Name(code: 'ar', value: 'مصعد')],),
            KW(id: 'pFeature_intercom', names: <Name>[Name(code: 'en', value: 'Intercom'), Name(code: 'ar', value: 'إنتركوم')],),
            KW(id: 'pFeature_internet', names: <Name>[Name(code: 'en', value: 'Broadband internet'), Name(code: 'ar', value: 'إنترنت')],),
            KW(id: 'pFeature_tv', names: <Name>[Name(code: 'en', value: 'Satellite / Cable TV'), Name(code: 'ar', value: 'قمر صناعي / تلفزيون مركزي')],),
            KW(id: 'pFeature_atm', names: <Name>[Name(code: 'en', value: 'ATM'), Name(code: 'ar', value: 'ماكينة سحب أموال ATM')],),
          ],
        ),
        // ----------------------------------
        /// In a Compound
        const Chain(
          id: 'sub_ppt_feat_compound',
          names: <Name>[Name(code: 'en', value: 'In a Compound'), Name(code: 'ar', value: 'في مجمع سكني')],
          sons: const <KW>[
            KW(id: 'compound_notInCompound', names: <Name>[Name(code: 'en', value: 'Not in a compound'), Name(code: 'ar', value: 'ليس في مجمع سكني')],),
            KW(id: 'compound_inCompound', names: <Name>[Name(code: 'en', value: 'Only in a compound'), Name(code: 'ar', value: 'في مجمع سكني')],),
          ],
        ),
        // ----------------------------------
        /// Finishing level
        const Chain(
          id: 'sub_ppt_feat_finishing',
          names: <Name>[Name(code: 'en', value: 'Finishing level'), Name(code: 'ar', value: 'مستوى التشطيب')],
          sons: const <KW>[
            KW(id: 'finish_coreAndShell', names: <Name>[Name(code: 'en', value: 'Core and shell'), Name(code: 'ar', value: 'خرسانات و حوائط خارجية')],),
            KW(id: 'finish_withoutFinishing', names: <Name>[Name(code: 'en', value: 'Without finishing'), Name(code: 'ar', value: 'غير متشطب')],),
            KW(id: 'finish_semiFinished', names: <Name>[Name(code: 'en', value: 'Semi finished'), Name(code: 'ar', value: 'نصف تشطيب')],),
            KW(id: 'finish_lux', names: <Name>[Name(code: 'en', value: 'Lux'), Name(code: 'ar', value: 'تشطيب لوكس')],),
            KW(id: 'finish_superLux', names: <Name>[Name(code: 'en', value: 'Super lux'), Name(code: 'ar', value: 'تشطيب سوبر لوكس')],),
            KW(id: 'finish_extraSuperLux', names: <Name>[Name(code: 'en', value: 'Extra super lux'), Name(code: 'ar', value: 'تشطيب إكسترا سوبر لوكس')],),
          ],
        ),
        // ----------------------------------
        /// Building Age
        const Chain(
          id: 'sub_ppt_feat_age',
          names: <Name>[Name(code: 'en', value: 'Building Age'), Name(code: 'ar', value: 'عمر المنشأ')],
          sons: const <KW>[
            KW(id: 'age_1_2', names: <Name>[Name(code: 'en', value: '1 - 2 years'), Name(code: 'ar', value: 'بين 1 - 2 عام')],),
            KW(id: 'age_2_5', names: <Name>[Name(code: 'en', value: '2 - 5 years'), Name(code: 'ar', value: 'بين 2 - 5 أعوام')],),
            KW(id: 'age_5_10', names: <Name>[Name(code: 'en', value: '5 - 10 years'), Name(code: 'ar', value: 'بين 5 - 10 أعوام')],),
            KW(id: 'age_10_20', names: <Name>[Name(code: 'en', value: '10 - 20 years'), Name(code: 'ar', value: 'بين 10 - 20 عام')],),
            KW(id: 'age_20_50', names: <Name>[Name(code: 'en', value: '20 - 50 years'), Name(code: 'ar', value: 'بين 20 - 50 عام')],),
            KW(id: 'age_50_100', names: <Name>[Name(code: 'en', value: '50 - 100 years'), Name(code: 'ar', value: 'بين 50 - 100 عام')],),
            KW(id: 'age_more', names: <Name>[Name(code: 'en', value: 'More than 100 years'), Name(code: 'ar', value: 'أقدم من 100 عام')],),
          ],
        ),
        // ----------------------------------
        /// Amenities
        const Chain(
          id: 'sub_ppt_feat_amenities',
          names: <Name>[Name(code: 'en', value: 'Amenities'), Name(code: 'ar', value: 'منشآت خدمية')],
          sons: const <KW>[
            KW(id: 'am_laundry', names: <Name>[Name(code: 'en', value: 'Laundry'), Name(code: 'ar', value: 'مغسلة')],),
            KW(id: 'am_swimmingPool', names: <Name>[Name(code: 'en', value: 'Swimming pool'), Name(code: 'ar', value: 'حمام سباحة')],),
            KW(id: 'am_kidsPool', names: <Name>[Name(code: 'en', value: 'Kids pool'), Name(code: 'ar', value: 'حمام سباحة أطفال')],),
            KW(id: 'am_boatFacilities', names: <Name>[Name(code: 'en', value: 'Boat facilities'), Name(code: 'ar', value: 'خدمات مراكب مائية')],),
            KW(id: 'am_gymFacilities', names: <Name>[Name(code: 'en', value: 'Gym'), Name(code: 'ar', value: 'صالة جيمنازيوم')],),
            KW(id: 'am_clubHouse', names: <Name>[Name(code: 'en', value: 'Clubhouse'), Name(code: 'ar', value: 'كلاب هاوس')],),
            KW(id: 'am_horseFacilities', names: <Name>[Name(code: 'en', value: 'Horse facilities'), Name(code: 'ar', value: 'خدمات خيول')],),
            KW(id: 'am_sportsCourts', names: <Name>[Name(code: 'en', value: 'Sports courts'), Name(code: 'ar', value: 'ملاعب رياضية')],),
            KW(id: 'am_park', names: <Name>[Name(code: 'en', value: 'Park / garden'), Name(code: 'ar', value: 'حديقة')],),
            KW(id: 'am_golfCourse', names: <Name>[Name(code: 'en', value: 'Golf course'), Name(code: 'ar', value: 'مضمار جولف')],),
            KW(id: 'am_spa', names: <Name>[Name(code: 'en', value: 'Spa'), Name(code: 'ar', value: 'منتجع صحي')],),
            KW(id: 'am_kidsArea', names: <Name>[Name(code: 'en', value: 'Kids Area'), Name(code: 'ar', value: 'منطقة أطفال')],),
            KW(id: 'am_cafeteria', names: <Name>[Name(code: 'en', value: 'Cafeteria'), Name(code: 'ar', value: 'كافيتيريا')],),
            KW(id: 'am_businessCenter', names: <Name>[Name(code: 'en', value: 'Business center'), Name(code: 'ar', value: 'مقر أعمال')],),
            KW(id: 'am_lobby', names: <Name>[Name(code: 'en', value: 'Building lobby'), Name(code: 'ar', value: 'ردهة مدخل للمبنى')],),
          ],
        ),
        // ----------------------------------
        /// Additional Services
        const Chain(
          id: 'sub_ppt_feat_services',
          names: <Name>[Name(code: 'en', value: 'Additional Services'), Name(code: 'ar', value: 'خدمات إضافية')],
          sons: const <KW>[
            KW(id: 'pService_houseKeeping', names: <Name>[Name(code: 'en', value: 'Housekeeping'), Name(code: 'ar', value: 'خدمة تنظيف منزلي')],),
            KW(id: 'pService_laundryService', names: <Name>[Name(code: 'en', value: 'LaundryService'), Name(code: 'ar', value: 'خدمة غسيل ملابس')],),
            KW(id: 'pService_concierge', names: <Name>[Name(code: 'en', value: 'Concierge'), Name(code: 'ar', value: 'خدمة استقبال')],),
            KW(id: 'pService_securityStaff', names: <Name>[Name(code: 'en', value: 'Security  staff'), Name(code: 'ar', value: 'فريق حراسة')],),
            KW(id: 'pService_securityCCTV', names: <Name>[Name(code: 'en', value: 'CCTV security'), Name(code: 'ar', value: 'كاميرات مراقبة')],),
            KW(id: 'pService_petsAllowed', names: <Name>[Name(code: 'en', value: 'Pets allowed'), Name(code: 'ar', value: 'مسموح بالحيوانات الأليفة')],),
            KW(id: 'pService_doorMan', names: <Name>[Name(code: 'en', value: 'Doorman'), Name(code: 'ar', value: 'بواب')],),
            KW(id: 'pService_maintenance', names: <Name>[Name(code: 'en', value: 'Maintenance staff'), Name(code: 'ar', value: 'فريق صيانة')],),
            KW(id: 'pService_wasteDisposal', names: <Name>[Name(code: 'en', value: 'Waste disposal'), Name(code: 'ar', value: 'خدمة رفع القمامة')],),
          ],
        ),
        // ----------------------------------
      ],

    ),
    // -----------------------------------------------
    /// Property Form
    const Chain(
      id: 'group_ppt_form',
      names: <Name>[Name(code: 'en', value: 'Property Form'), Name(code: 'ar', value: 'هيئة العقار')],
      sons: const <KW>[
        KW(id: 'pf_fullFloor', names: <Name>[Name(code: 'en', value: 'Full floor'), Name(code: 'ar', value: 'دور كامل')],),
        KW(id: 'pf_halfFloor', names: <Name>[Name(code: 'en', value: 'Half floor'), Name(code: 'ar', value: 'نصف دور')],),
        KW(id: 'pf_partFloor', names: <Name>[Name(code: 'en', value: 'Part of floor'), Name(code: 'ar', value: 'جزء من دور')],),
        KW(id: 'pf_building', names: <Name>[Name(code: 'en', value: 'Whole building'), Name(code: 'ar', value: 'مبنى كامل')],),
        KW(id: 'pf_land', names: <Name>[Name(code: 'en', value: 'Land'), Name(code: 'ar', value: 'أرض')],),
        KW(id: 'pf_mobile', names: <Name>[Name(code: 'en', value: 'Mobile'), Name(code: 'ar', value: 'منشأ متنقل')],),
      ],
    ),
    // -----------------------------------------------
    /// Property License
    const Chain(
      id: 'group_ppt_license',
      names: <Name>[Name(code: 'en', value: 'Property License'), Name(code: 'ar', value: 'رخصة العقار')],
      sons: const <KW>[
        KW(id: 'ppt_lic_residential', names: <Name>[Name(code: 'en', value: 'Residential'), Name(code: 'ar', value: 'سكني')],),
        KW(id: 'ppt_lic_administration', names: <Name>[Name(code: 'en', value: 'Administration'), Name(code: 'ar', value: 'إداري')],),
        KW(id: 'ppt_lic_educational', names: <Name>[Name(code: 'en', value: 'Educational'), Name(code: 'ar', value: 'تعليمي')],),
        KW(id: 'ppt_lic_utilities', names: <Name>[Name(code: 'en', value: 'Utilities'), Name(code: 'ar', value: 'خدمات')],),
        KW(id: 'ppt_lic_sports', names: <Name>[Name(code: 'en', value: 'Sports'), Name(code: 'ar', value: 'رياضي')],),
        KW(id: 'ppt_lic_entertainment', names: <Name>[Name(code: 'en', value: 'Entertainment'), Name(code: 'ar', value: 'ترفيهي')],),
        KW(id: 'ppt_lic_medical', names: <Name>[Name(code: 'en', value: 'Medical'), Name(code: 'ar', value: 'طبي')],),
        KW(id: 'ppt_lic_retail', names: <Name>[Name(code: 'en', value: 'Retail'), Name(code: 'ar', value: 'تجاري')],),
        KW(id: 'ppt_lic_hotel', names: <Name>[Name(code: 'en', value: 'Hotel'), Name(code: 'ar', value: 'فندقي')],),
        KW(id: 'ppt_lic_industrial', names: <Name>[Name(code: 'en', value: 'Industrial'), Name(code: 'ar', value: 'صناعي')],),
      ],
    ),
    // -----------------------------------------------
    /// Property Price
    const Chain(
      id: 'group_ppt_price',
      names: <Name>[Name(code: 'en', value: 'Property Price'), Name(code: 'ar', value: 'سعر العقار')],
      sons: const <Chain>[
        // ----------------------------------
        /// Rental Type
        const Chain(
          id: 'sub_ppt_price_rentalType',
          names: <Name>[Name(code: 'en', value: 'Rental Type'), Name(code: 'ar', value: 'نوع الإيجار')],
          sons: const <KW>[
            KW(id: 'rent_perDay', names: <Name>[Name(code: 'en', value: 'Per day'), Name(code: 'ar', value: 'باليوم')],),
            KW(id: 'rent_perMonth', names: <Name>[Name(code: 'en', value: 'Per Month'), Name(code: 'ar', value: 'بالشهر')],),
          ],
        ),
        // ----------------------------------
        /// Rental Price
        const Chain(
          id: 'sub_ppt_price_rentValue',
          names: <Name>[Name(code: 'en', value: 'Rental Price'), Name(code: 'ar', value: 'سعر إيجار العقار')],
          sons: const <KW>[
            KW(id: 'rent_val_less', names: <Name>[Name(code: 'en', value: 'Less than 1 K EGP'), Name(code: 'ar', value: 'أقل من 1 ألف جم')],),
            KW(id: 'rent_val_1_2_k', names: <Name>[Name(code: 'en', value: '1 K - 2 K EGP'), Name(code: 'ar', value: 'بين 1 ألف - 2 ألف جم')],),
            KW(id: 'rent_val_2_5_k', names: <Name>[Name(code: 'en', value: '2 K - 5 K EGP'), Name(code: 'ar', value: 'بين 2 ألف - 5 آلاف جم')],),
            KW(id: 'rent_val_5_10_k', names: <Name>[Name(code: 'en', value: '5 K - 10 K EGP'), Name(code: 'ar', value: 'بين 5 آلاف - 10 آلاف جم')],),
            KW(id: 'rent_val_10_20_k', names: <Name>[Name(code: 'en', value: '10 K- 20 K EGP'), Name(code: 'ar', value: 'بين 10 آلاف - 20 ألف جم')],),
            KW(id: 'rent_val_20_50_k', names: <Name>[Name(code: 'en', value: '20 K - 50 K EGP'), Name(code: 'ar', value: 'بين 20 ألف - 50 ألف جم')],),
            KW(id: 'rent_val_more', names: <Name>[Name(code: 'en', value: 'More than 50 K EGP'), Name(code: 'ar', value: 'أكثر من 50 ألف جم')],),
          ],
        ),
        // ----------------------------------
        /// Property selling price (EGP)
        const Chain(
          id: 'sub_ppt_price_sellEGY',
          names: <Name>[Name(code: 'en', value: 'Property selling price (EGP)'), Name(code: 'ar', value: 'سعر بيع العقار (جم)')],
          sons: const <KW>[
            KW(id: 'pPriceEGY_100_200_k', names: <Name>[Name(code: 'en', value: '100K - 200K EGP'), Name(code: 'ar', value: 'بين  100 ألف - 200 ألف جم')],),
            KW(id: 'pPriceEGY_200_500_k', names: <Name>[Name(code: 'en', value: '200K - 500 EGP'), Name(code: 'ar', value: 'بين  200 ألف - 500 ألف جم')],),
            KW(id: 'pPriceEGY_500_1_m', names: <Name>[Name(code: 'en', value: '500k - 1M EGP'), Name(code: 'ar', value: 'بين  500 ألف - 1 مليون جم')],),
            KW(id: 'pPriceEGY_1_2_m', names: <Name>[Name(code: 'en', value: '1M - 2M EGP'), Name(code: 'ar', value: 'بين  1 مليون - 2 مليون جم')],),
            KW(id: 'pPriceEGY_2_5_m', names: <Name>[Name(code: 'en', value: '2M - 5M EGP'), Name(code: 'ar', value: 'بين  2 مليون - 5 مليون جم')],),
            KW(id: 'pPriceEGY_5_10_m', names: <Name>[Name(code: 'en', value: '5M - 10M EGP'), Name(code: 'ar', value: 'بين  5 مليون - 10 مليون جم')],),
            KW(id: 'pPriceEGY_10_20_m', names: <Name>[Name(code: 'en', value: '10M - 20M EGP'), Name(code: 'ar', value: 'بين  10 مليون - 20 مليون جم')],),
            KW(id: 'pPriceEGY_20_50_m', names: <Name>[Name(code: 'en', value: '20M - 50M EGP'), Name(code: 'ar', value: 'بين  20 مليون - 50 مليون جم')],),
            KW(id: 'pPriceEGY_50_100_m', names: <Name>[Name(code: 'en', value: '50M - 100M EGP'), Name(code: 'ar', value: 'بين  50 مليون - 100 مليون جم')],),
            KW(id: 'pPriceEGY_100_200_m', names: <Name>[Name(code: 'en', value: '100M - 200M EGP'), Name(code: 'ar', value: 'بين  100 مليون - 200 مليون جم')],),
            KW(id: 'pPriceEGY_more', names: <Name>[Name(code: 'en', value: 'More than 200M EGP'), Name(code: 'ar', value: 'أكثر من 200 مليون جم')],),
          ],
        ),
        // ----------------------------------
        /// Payment Method
        const Chain(
          id: 'sub_ppt_price_payments',
          names: <Name>[Name(code: 'en', value: 'Payment Method'), Name(code: 'ar', value: 'طريقة السداد')],
          sons: const <KW>[
            KW(id: 'payment_cash', names: <Name>[Name(code: 'en', value: 'Cash Only'), Name(code: 'ar', value: 'كل المبلغ دفعة واحدة')],),
            KW(id: 'payment_installments', names: <Name>[Name(code: 'en', value: 'Installments Only'), Name(code: 'ar', value: 'على دفعات فقط')],),
          ],
        ),
        // ----------------------------------
        /// Installments Duration
        const Chain(
          id: 'sub_ppt_price_duration',
          names: <Name>[Name(code: 'en', value: 'Installments Duration'), Name(code: 'ar', value: 'فترة الأقساط')],
          sons: const <KW>[
            KW(id: 'inst_dur_less', names: <Name>[Name(code: 'en', value: 'Less than 1 year'), Name(code: 'ar', value: 'أقل من 1 عام')],),
            KW(id: 'inst_dur_1_2', names: <Name>[Name(code: 'en', value: '1 - 2 years'), Name(code: 'ar', value: 'بين 1 - 2 عام')],),
            KW(id: 'inst_dur_2_5', names: <Name>[Name(code: 'en', value: '2 - 5 years'), Name(code: 'ar', value: 'بين 2 - 5 أعوام')],),
            KW(id: 'inst_dur_5_10', names: <Name>[Name(code: 'en', value: '5 - 10 years'), Name(code: 'ar', value: 'بين 5 - 10 أعوام')],),
            KW(id: 'inst_dur_10_20', names: <Name>[Name(code: 'en', value: '10 - 20 years'), Name(code: 'ar', value: 'بين 10 - 20 عام')],),
            KW(id: 'inst_dur_more', names: <Name>[Name(code: 'en', value: 'More than 20 years'), Name(code: 'ar', value: 'أكثر من 20 عام')],),
          ],
        ),
      ],
    ),
    // -----------------------------------------------
    /// Spaces
    const Chain(
      id: 'group_ppt_spaces',
      names: <Name>[Name(code: 'en', value: 'Spaces'), Name(code: 'ar', value: 'مساحات العقار')],
      sons: const <Chain>[
        // ----------------------------------
        /// Property Rooms
        const Chain(
          id: 'sub_ppt_spaces_rooms',
          names: <Name>[Name(code: 'en', value: 'Property Rooms'), Name(code: 'ar', value: 'غرف العقار')],
          sons: const <KW>[
            KW(id: 'space_dining', names: <Name>[Name(code: 'en', value: 'Dining room'), Name(code: 'ar', value: 'غرفة طعام')],),
            KW(id: 'space_laundry', names: <Name>[Name(code: 'en', value: 'Laundry room'), Name(code: 'ar', value: 'غرفة غسيل ملابس')],),
            KW(id: 'space_living', names: <Name>[Name(code: 'en', value: 'Living room'), Name(code: 'ar', value: 'غرفة معيشة')],),
            KW(id: 'space_maid', names: <Name>[Name(code: 'en', value: 'Maid room'), Name(code: 'ar', value: 'غرفة مربية')],),
            KW(id: 'space_balcony', names: <Name>[Name(code: 'en', value: 'Balcony'), Name(code: 'ar', value: 'شرفة')],),
            KW(id: 'space_walkInCloset', names: <Name>[Name(code: 'en', value: 'Walk In closet'), Name(code: 'ar', value: 'غرفة دواليب ملابس')],),
            KW(id: 'space_barbecue', names: <Name>[Name(code: 'en', value: 'Barbecue area'), Name(code: 'ar', value: 'مساحة شواية')],),
            KW(id: 'space_garden', names: <Name>[Name(code: 'en', value: 'Private garden'), Name(code: 'ar', value: 'حديقة خاصة')],),
            KW(id: 'space_privatePool', names: <Name>[Name(code: 'en', value: 'Private pool'), Name(code: 'ar', value: 'حمام سباحة خاص')],),
          ],
        ),
        // ----------------------------------
        /// Number of private Parking Lots
        const Chain(
          id: 'sub_ppt_spaces_parkings',
          names: <Name>[Name(code: 'en', value: 'Number of private Parking Lots'), Name(code: 'ar', value: 'عدد مواقف السيارات الخاصة')],
          sons: const <KW>[
            KW(id: 'parking_1', names: <Name>[Name(code: 'en', value: '1'), Name(code: 'ar', value: '1')],),
            KW(id: 'parking_2', names: <Name>[Name(code: 'en', value: '2'), Name(code: 'ar', value: '2')],),
            KW(id: 'parking_3', names: <Name>[Name(code: 'en', value: '3'), Name(code: 'ar', value: '3')],),
            KW(id: 'parking_more', names: <Name>[Name(code: 'en', value: 'More than 3'), Name(code: 'ar', value: 'أكثر من 3')],),
          ],
        ),
        // ----------------------------------
        /// Number of Bedrooms
        const Chain(
          id: 'sub_ppt_spaces_bedrooms',
          names: <Name>[Name(code: 'en', value: 'Number of Bedrooms'), Name(code: 'ar', value: 'عدد غرف النوم')],
          sons: const <KW>[
            KW(id: 'rooms_1', names: <Name>[Name(code: 'en', value: '1'), Name(code: 'ar', value: '1')],),
            KW(id: 'rooms_2', names: <Name>[Name(code: 'en', value: '2'), Name(code: 'ar', value: '2')],),
            KW(id: 'rooms_3', names: <Name>[Name(code: 'en', value: '3'), Name(code: 'ar', value: '3')],),
            KW(id: 'rooms_4', names: <Name>[Name(code: 'en', value: '4'), Name(code: 'ar', value: '4')],),
            KW(id: 'rooms_5', names: <Name>[Name(code: 'en', value: '5'), Name(code: 'ar', value: '5')],),
            KW(id: 'rooms_6', names: <Name>[Name(code: 'en', value: '6'), Name(code: 'ar', value: '6')],),
            KW(id: 'rooms_7', names: <Name>[Name(code: 'en', value: '7'), Name(code: 'ar', value: '7')],),
            KW(id: 'rooms_more', names: <Name>[Name(code: 'en', value: 'More than 7'), Name(code: 'ar', value: 'أكثر من 7')],),
          ],
        ),
        // ----------------------------------
        /// Number of Bathrooms
        const Chain(
          id: 'sub_ppt_spaces_bathrooms',
          names: <Name>[Name(code: 'en', value: 'Number of Bathrooms'), Name(code: 'ar', value: 'عدد الحمامات')],
          sons: const <KW>[
            KW(id: 'bath_1', names: <Name>[Name(code: 'en', value: '1'), Name(code: 'ar', value: '1')],),
            KW(id: 'bath_2', names: <Name>[Name(code: 'en', value: '2'), Name(code: 'ar', value: '2')],),
            KW(id: 'bath_3', names: <Name>[Name(code: 'en', value: '3'), Name(code: 'ar', value: '3')],),
            KW(id: 'bath_4', names: <Name>[Name(code: 'en', value: '4'), Name(code: 'ar', value: '4')],),
            KW(id: 'bath_5', names: <Name>[Name(code: 'en', value: '5'), Name(code: 'ar', value: '5')],),
            KW(id: 'bath_6', names: <Name>[Name(code: 'en', value: '6'), Name(code: 'ar', value: '6')],),
            KW(id: 'bath_7', names: <Name>[Name(code: 'en', value: '7'), Name(code: 'ar', value: '7')],),
            KW(id: 'bath_more', names: <Name>[Name(code: 'en', value: 'More than 7'), Name(code: 'ar', value: 'أكثر من 7')],),
          ],
        ),
      ],
    ),
    // -----------------------------------------------
    /// Product Price
    const Chain(
      id: 'group_prd_price',
      names: <Name>[Name(code: 'en', value: 'Product Price'), Name(code: 'ar', value: 'سعر المنتج')],
      sons: const <Chain>[
        // ----------------------------------
        /// Product price
        const Chain(
          id: 'sub_prd_price',
          names: <Name>[Name(code: 'en', value: 'Product price'), Name(code: 'ar', value: 'سعر المنتج')],
          sons: const <KW>[
            KW(id: 'prd_price_sell_egp_100_500', names: <Name>[Name(code: 'en', value: '10 - 500 EGP'), Name(code: 'ar', value: 'بين  10 - 500 جم')],),
            KW(id: 'prd_price_sell_egp_500_1k', names: <Name>[Name(code: 'en', value: '500 - 1K EGP'), Name(code: 'ar', value: 'بين  500 - 1 ألف جم')],),
            KW(id: 'prd_price_sell_egp_1k_2k', names: <Name>[Name(code: 'en', value: '1K - 2K EGP'), Name(code: 'ar', value: 'بين  1 ألف - 2 ألف جم')],),
            KW(id: 'prd_price_sell_egp_2k_5k', names: <Name>[Name(code: 'en', value: '2K - 5K EGP'), Name(code: 'ar', value: 'بين  2 ألف - 5 ألف جم')],),
            KW(id: 'prd_price_sell_egp_5k_10k', names: <Name>[Name(code: 'en', value: '5K - 10K EGP'), Name(code: 'ar', value: 'بين  5 ألف - 10 ألف جم')],),
            KW(id: 'prd_price_sell_egp_10k_20k', names: <Name>[Name(code: 'en', value: '10K - 20K EGP'), Name(code: 'ar', value: 'بين  10 ألف - 20 ألف جم')],),
            KW(id: 'prd_price_sell_egp_20k_50k', names: <Name>[Name(code: 'en', value: '20K - 50K EGP'), Name(code: 'ar', value: 'بين  20 ألف - 50 ألف جم')],),
            KW(id: 'prd_price_sell_egp_50k_100k', names: <Name>[Name(code: 'en', value: '50K - 100K EGP'), Name(code: 'ar', value: 'بين  50 ألف - 100 ألف جم')],),
            KW(id: 'prd_price_sell_egp_100k_200k', names: <Name>[Name(code: 'en', value: '100K - 200K EGP'), Name(code: 'ar', value: 'بين  100 ألف - 200 ألف جم')],),
            KW(id: 'prd_price_sell_egp_200k_500k', names: <Name>[Name(code: 'en', value: '200K - 500K EGP'), Name(code: 'ar', value: 'بين  200 ألف - 500 ألف جم')],),
            KW(id: 'prd_price_sell_egp_500k_1M', names: <Name>[Name(code: 'en', value: '500K - 1M EGP'), Name(code: 'ar', value: 'بين  500 ألف - 1 مليون جم')],),
            KW(id: 'prd_price_sell_egp_more', names: <Name>[Name(code: 'en', value: 'More than 1M EGP'), Name(code: 'ar', value: 'أكثر من 1 مليون جم')],),
          ],
        ),
        // ----------------------------------
        /// Price type
        const Chain(
          id: 'sub_prd_priceType',
          names: <Name>[Name(code: 'en', value: 'Price type'), Name(code: 'ar', value: 'نوع السعر')],
          sons: const <KW>[
            KW(id: 'prd_price_type_sale', names: <Name>[Name(code: 'en', value: 'Selling price'), Name(code: 'ar', value: 'سعر البيع')],),
            KW(id: 'prd_price_type_rent', names: <Name>[Name(code: 'en', value: 'Rent price'), Name(code: 'ar', value: 'سعر الإيجار')],),
          ],
        ),
        // ----------------------------------
        /// Rent type
        const Chain(
          id: 'sub_prd_rentType',
          names: <Name>[Name(code: 'en', value: 'Rent type'), Name(code: 'ar', value: 'نوع الإيجار')],
          sons: const <KW>[
            KW(id: 'prd_price_rent_hour', names: <Name>[Name(code: 'en', value: 'Per Hour'), Name(code: 'ar', value: 'في الساعة')],),
            KW(id: 'prd_price_rent_day', names: <Name>[Name(code: 'en', value: 'Per Day'), Name(code: 'ar', value: 'في اليوم')],),
            KW(id: 'prd_price_rent_week', names: <Name>[Name(code: 'en', value: 'Per Week'), Name(code: 'ar', value: 'في الأسبوع')],),
            KW(id: 'prd_price_rent_year', names: <Name>[Name(code: 'en', value: 'Per Year'), Name(code: 'ar', value: 'في السنة')],),
          ],
        ),
        // ----------------------------------
        /// Measurement unit
        const Chain(
          id: 'sub_prd_price_unit',
          names: <Name>[Name(code: 'en', value: 'Measurement unit'), Name(code: 'ar', value: 'وحدة القياس')],
          sons: const <KW>[
            KW(id: 'pd_price_unit_m', names: <Name>[Name(code: 'en', value: 'Meter'), Name(code: 'ar', value: 'متر طولي')],),
            KW(id: 'pd_price_unit_sqm', names: <Name>[Name(code: 'en', value: 'Square Meter'), Name(code: 'ar', value: 'متر مربع')],),
            KW(id: 'pd_price_unit_cubicm', names: <Name>[Name(code: 'en', value: 'Cubic Meter'), Name(code: 'ar', value: 'متر مكعب')],),
            KW(id: 'pd_price_unit_ml', names: <Name>[Name(code: 'en', value: 'Millilitre'), Name(code: 'ar', value: 'مللي لتر')],),
            KW(id: 'pd_price_unit_l', names: <Name>[Name(code: 'en', value: 'Litre'), Name(code: 'ar', value: 'لتر')],),
          ],
        ),
      ],
    ),
    // -----------------------------------------------
    /// Space Type
    const Chain(
      id: 'group_space_type',
      names: <Name>[Name(code: 'en', value: 'Space Type'), Name(code: 'ar', value: 'نوع الفراغ')],
      sons: const <Chain>[
        // ----------------------------------
        /// Administration
        const Chain(
          id: 'ppt_lic_administration',
          names: <Name>[Name(code: 'en', value: 'Administration'), Name(code: 'ar', value: 'إداري')],
          sons: const <KW>[
            KW(id: 'pt_office', names: <Name>[Name(code: 'en', value: 'Office'), Name(code: 'ar', value: 'مكتب إداري')],),
            KW(id: 'space_office', names: <Name>[Name(code: 'en', value: 'Office'), Name(code: 'ar', value: 'مكتب')],),
            KW(id: 'space_kitchenette', names: <Name>[Name(code: 'en', value: 'Office Kitchenette'), Name(code: 'ar', value: 'أوفيس / مطبخ صغير')],),
            KW(id: 'space_meetingRoom', names: <Name>[Name(code: 'en', value: 'Meeting room'), Name(code: 'ar', value: 'غرفة اجتماعات')],),
            KW(id: 'space_seminarHall', names: <Name>[Name(code: 'en', value: 'Seminar hall'), Name(code: 'ar', value: 'قاعة سمينار')],),
            KW(id: 'space_conventionHall', names: <Name>[Name(code: 'en', value: 'Convention hall'), Name(code: 'ar', value: 'قاعة عرض')],),
          ],
        ),
        // ----------------------------------
        /// Educational
        const Chain(
          id: 'ppt_lic_educational',
          names: <Name>[Name(code: 'en', value: 'Educational'), Name(code: 'ar', value: 'تعليمي')],
          sons: const <KW>[
            KW(id: 'space_lectureRoom', names: <Name>[Name(code: 'en', value: 'Lecture room'), Name(code: 'ar', value: 'غرفة محاضرات')],),
            KW(id: 'space_library', names: <Name>[Name(code: 'en', value: 'Library'), Name(code: 'ar', value: 'مكتبة')],),
          ],
        ),
        // ----------------------------------
        /// Entertainment
        const Chain(
          id: 'ppt_lic_entertainment',
          names: <Name>[Name(code: 'en', value: 'Entertainment'), Name(code: 'ar', value: 'ترفيهي')],
          sons: const <KW>[
            KW(id: 'space_theatre', names: <Name>[Name(code: 'en', value: 'Theatre'), Name(code: 'ar', value: 'مسرح')],),
            KW(id: 'space_concertHall', names: <Name>[Name(code: 'en', value: 'Concert hall'), Name(code: 'ar', value: 'قاعة موسيقية')],),
            KW(id: 'space_homeCinema', names: <Name>[Name(code: 'en', value: 'Home Cinema'), Name(code: 'ar', value: 'مسرح منزلي')],),
          ],
        ),
        // ----------------------------------
        /// Medical
        const Chain(
          id: 'ppt_lic_medical',
          names: <Name>[Name(code: 'en', value: 'Medical'), Name(code: 'ar', value: 'طبي')],
          sons: const <KW>[
            KW(id: 'space_spa', names: <Name>[Name(code: 'en', value: 'Spa'), Name(code: 'ar', value: 'منتجع صحي')],),
          ],
        ),
        // ----------------------------------
        /// Residential
        const Chain(
          id: 'ppt_lic_residential',
          names: <Name>[Name(code: 'en', value: 'Residential'), Name(code: 'ar', value: 'سكني')],
          sons: const <KW>[
            KW(id: 'space_lobby', names: <Name>[Name(code: 'en', value: 'Lobby'), Name(code: 'ar', value: 'ردهة')],),
            KW(id: 'space_living', names: <Name>[Name(code: 'en', value: 'Living room'), Name(code: 'ar', value: 'غرفة معيشة')],),
            KW(id: 'space_bedroom', names: <Name>[Name(code: 'en', value: 'Bedroom'), Name(code: 'ar', value: 'غرفة نوم')],),
            KW(id: 'space_kitchen', names: <Name>[Name(code: 'en', value: 'Home Kitchen'), Name(code: 'ar', value: 'مطبخ')],),
            KW(id: 'space_bathroom', names: <Name>[Name(code: 'en', value: 'Bathroom'), Name(code: 'ar', value: 'حمام')],),
            KW(id: 'space_reception', names: <Name>[Name(code: 'en', value: 'Reception'), Name(code: 'ar', value: 'استقبال')],),
            KW(id: 'space_salon', names: <Name>[Name(code: 'en', value: 'Salon'), Name(code: 'ar', value: 'صالون')],),
            KW(id: 'space_laundry', names: <Name>[Name(code: 'en', value: 'Laundry room'), Name(code: 'ar', value: 'غرفة غسيل')],),
            KW(id: 'space_balcony', names: <Name>[Name(code: 'en', value: 'Balcony'), Name(code: 'ar', value: 'تراس')],),
            KW(id: 'space_toilet', names: <Name>[Name(code: 'en', value: 'Toilet'), Name(code: 'ar', value: 'دورة مياه')],),
            KW(id: 'space_dining', names: <Name>[Name(code: 'en', value: 'Dining room'), Name(code: 'ar', value: 'غرفة طعام')],),
            KW(id: 'space_stairs', names: <Name>[Name(code: 'en', value: 'Stairs'), Name(code: 'ar', value: 'سلالم')],),
            KW(id: 'space_attic', names: <Name>[Name(code: 'en', value: 'Attic'), Name(code: 'ar', value: 'علية / صندرة')],),
            KW(id: 'space_corridor', names: <Name>[Name(code: 'en', value: 'Corridor'), Name(code: 'ar', value: 'رواق / طرقة')],),
            KW(id: 'space_garage', names: <Name>[Name(code: 'en', value: 'Garage'), Name(code: 'ar', value: 'جراج')],),
            KW(id: 'space_storage', names: <Name>[Name(code: 'en', value: 'Storage room'), Name(code: 'ar', value: 'مخزن')],),
          ],
        ),
        // ----------------------------------
        /// Retail
        const Chain(
          id: 'ppt_lic_retail',
          names: <Name>[Name(code: 'en', value: 'Retail'), Name(code: 'ar', value: 'تجاري')],
          sons: const <KW>[
            KW(id: 'space_store', names: <Name>[Name(code: 'en', value: 'Store / Shop'), Name(code: 'ar', value: 'محل / متجر')],),
          ],
        ),
        // ----------------------------------
        /// Sports
        const Chain(
          id: 'ppt_lic_sports',
          names: <Name>[Name(code: 'en', value: 'Sports'), Name(code: 'ar', value: 'رياضي')],
          sons: const <KW>[
            KW(id: 'space_gymnasium', names: <Name>[Name(code: 'en', value: 'Gymnasium'), Name(code: 'ar', value: 'جيمنازيوم')],),
            KW(id: 'space_sportsCourt', names: <Name>[Name(code: 'en', value: 'Sports court'), Name(code: 'ar', value: 'ملعب رياضي')],),
            KW(id: 'space_sportStadium', names: <Name>[Name(code: 'en', value: 'Stadium'), Name(code: 'ar', value: 'استاد رياضي')],),
          ],
        ),
        // ----------------------------------
        /// Utilities
        const Chain(
          id: 'ppt_lic_utilities',
          names: <Name>[Name(code: 'en', value: 'Utilities'), Name(code: 'ar', value: 'خدمات')],
          sons: const <KW>[
            KW(id: 'pFeature_elevator', names: <Name>[Name(code: 'en', value: 'Elevator'), Name(code: 'ar', value: 'مصعد')],),
            KW(id: 'space_electricityRoom', names: <Name>[Name(code: 'en', value: 'Electricity rooms'), Name(code: 'ar', value: 'غرفة كهرباء')],),
            KW(id: 'space_plumbingRoom', names: <Name>[Name(code: 'en', value: 'Plumbing rooms'), Name(code: 'ar', value: 'غرفة صحي و صرف')],),
            KW(id: 'space_mechanicalRoom', names: <Name>[Name(code: 'en', value: 'Mechanical rooms'), Name(code: 'ar', value: 'غرفة ميكانيكية')],),
          ],
        ),
      ],
    ),
    // -----------------------------------------------

  ];

}