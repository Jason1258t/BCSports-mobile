import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_post_state.dart';

class DeletePostCubit extends Cubit<DeletePostState> {
  final ProfileRepository _profileRepository;

  DeletePostCubit(ProfileRepository profileRepository)
      : _profileRepository = profileRepository,
        super(DeletePostInitial());

  void deletePost(String id) async {
    emit(DeleteProcessState(id));
    try {
      await _profileRepository.deletePost(id);
      emit(DeleteSuccessState(id));
    } catch (e) {
      emit(DeleteFailState(id));
      rethrow;
    }
  }
}
