import 'package:bcsports_mobile/utils/enums.dart';

class ProfileRepository{
  EnumProfileTab activeTap = EnumProfileTab.Nft;

  void setProfileActiveTap(EnumProfileTab profileTap){
    activeTap = profileTap;
  }
}