enum BzForm {
  Individual,
  Company,
}

List<BzForm> bzFormsList = [
  BzForm.Individual,
  BzForm.Company,
];
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
BzForm decipherBzForm (int x){
  switch (x){
    case 1:   return   BzForm.Individual;   break;
    case 2:   return   BzForm.Company;      break;
    default : return   null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherBzForm (BzForm x){
  switch (x){
    case BzForm.Individual:   return 1; break;
    case BzForm.Company:      return 2; break;
    default : return null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
