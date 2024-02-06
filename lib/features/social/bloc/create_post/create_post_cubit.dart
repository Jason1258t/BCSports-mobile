import 'package:bcsports_mobile/features/social/data/social_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final SocialRepository _socialRepository;

  CreatePostCubit(SocialRepository socialRepository)
      : _socialRepository = socialRepository,
        super(CreatePostInitial());

}
