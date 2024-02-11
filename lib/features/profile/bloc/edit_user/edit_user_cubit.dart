import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:meta/meta.dart';

part 'edit_user_state.dart';

class EditUserCubit extends Cubit<EditUserState> {
  final ProfileRepository _profileRepository;

  EditUserCubit({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(EditUserInitial());

  Future<void> editProfile(
      String displayName, String username, XFile? image) async {
    emit(EditUserLoadingState());
    try {
      _profileRepository.deleteOldUserAvatar();

      String? imageUrl;
      if (image != null) {
        imageUrl = await _profileRepository.uploadAvatar(image.path);
      }

      await _profileRepository.editUser(username, displayName, imageUrl);
      emit(EditUserSuccessState());
    } catch (e) {
      emit(EditUserFailState(e as Exception));
    }
  }
}
