import 'package:bcsports_mobile/utils/enums.dart';

class ProfileRepository{
  EnumProfileTab activeTap = EnumProfileTab.nft;

  void setProfileActiveTap(EnumProfileTab profileTap){
    activeTap = profileTap;
  }
}