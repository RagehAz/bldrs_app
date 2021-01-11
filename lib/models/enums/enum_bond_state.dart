enum BondState {
  Accepted,
  Declined,
  Seen,
  Unseen,
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
BondState decipherBondState (int x){
  switch (x){
    case 1:   return   BondState.Accepted;    break;
    case 2:   return   BondState.Declined;    break;
    case 3:   return   BondState.Seen;        break;
    case 4:   return   BondState.Unseen;      break;
    default : return   null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherBondState (BondState x){
  switch (x){
    case BondState.Accepted:    return 1; break;
    case BondState.Declined:    return 2; break;
    case BondState.Seen:        return 3; break ;
    case BondState.Unseen:      return 4; break ;
    default : return null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
