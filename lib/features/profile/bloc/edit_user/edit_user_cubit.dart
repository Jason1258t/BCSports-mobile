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
        super(EditUserInitial()){
    _profileRepository.profileState.listen((event) {
      if(event == LoadingStateEnum.loading) emit(EditUserLoadingState());
      if(event == LoadingStateEnum.fail) emit(EditUserFailState());
      if(event == LoadingStateEnum.success) emit(EditUserSuccessState());
    });
  }

  Future<void> editProfile(String? displayName, String? userName, XFile? image) async {
    emit(EditUserLoadingState());
    try {
      String? imageUrl;
      if (image != null) {
        imageUrl = await _profileRepository.uploadPostImage(image.path);
      }

      await _profileRepository.editUser(userName, displayName, imageUrl);
      emit(EditUserSuccessState());
    } catch (e) {
      emit(EditUserFailState());
    }
  }
}
