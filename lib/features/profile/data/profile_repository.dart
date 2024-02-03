import 'package:bcsports_mobile/utils/enums.dart';

class ProfileRepository{
  EnumProfileTap activeTap = EnumProfileTap.Nft;

  void setProfileActiveTap(EnumProfileTap profileTap){
    activeTap = profileTap;
  }
}