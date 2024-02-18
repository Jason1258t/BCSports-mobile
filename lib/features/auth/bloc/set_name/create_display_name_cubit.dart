import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_display_name_state.dart';

class CreateDisplayNameCubit extends Cubit<CreateDisplayNameState> {
  final ProfileRepository _profileRepository;

  CreateDisplayNameCubit(ProfileRepository profileRepository)
      : _profileRepository = profileRepository,
        super(CreateDisplayNameInitial());

  void createName(String name) async {
    emit(CreateLoadingState());
    await _profileRepository.saveDisplayName(name);
    emit(CreateSuccessState());
  }
}
