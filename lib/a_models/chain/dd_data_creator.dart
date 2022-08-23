

enum DataCreator{

  // fromList,
  doubleKeyboard, // TASK : to be renamed to ( doubleKeyboard)
  doubleSlider,
  doubleRangeSlider,

  integerKeyboard, // TASK : to be renamed to ( integerKeyboard )
  integerSlider,
  integerRangeSlider,

  boolSwitch,
  country,

}
// ------------------------------------------------------------
bool isDoubleDataCreator(DataCreator creator){

  switch (creator){
    case DataCreator.doubleKeyboard : return true; break;
    case DataCreator.doubleRangeSlider : return true; break;
    case DataCreator.doubleSlider : return true; break;

    default : return false;
  }
}
// ------------------------------------------------------------
bool isIntDataCreator(DataCreator creator){

  switch (creator){
    case DataCreator.integerKeyboard : return true; break;
    case DataCreator.integerSlider : return true; break;
    case DataCreator.integerRangeSlider : return true; break;

    default : return false;
  }
}
// ------------------------------------------------------------
bool isBoolDataCreator(DataCreator creator){

  switch (creator){
    case DataCreator.boolSwitch : return true; break;
    default : return false;
  }

}
// ------------------------------------------------------------
bool isCountryDataCreator(DataCreator creator){
  switch (creator){
    case DataCreator.country : return true; break;
    default : return false;
  }
}
// ------------------------------------------------------------
