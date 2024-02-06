import 'dart:typed_data';

import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/social/data/models/post_model.dart';
import 'package:bcsports_mobile/features/social/data/social_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final SocialRepository _socialRepository;
  final ProfileRepository _profileRepository;

  CreatePostCubit(
      SocialRepository socialRepository, ProfileRepository profileRepository)
      : _socialRepository = socialRepository,
        _profileRepository = profileRepository,
        super(CreatePostInitial());

  Future<Uint8List> _compressImage(Uint8List list) async =>
      await FlutterImageCompress.compressWithList(
        list,
        minWidth: 400,
        quality: 96,
      );

  void createPost(String? text, [XFile? image]) async {
    emit(CreateLoadingState());
    try {
      String? imageUrl;
      String? compressedImageUrl;
      if (image != null) {
        imageUrl =
            await _socialRepository.uploadPostImage(filePath: image.path);
        final compressedImage = await _compressImage(await image.readAsBytes());
        compressedImageUrl =
            await _socialRepository.uploadPostImage(bytes: compressedImage);
      }

      await _socialRepository.createPost(PostModel.create(
          creatorId: _profileRepository.user.id,
          text: text,
          imageUrl: imageUrl,
          compressedImageUrl: compressedImageUrl));
      emit(CreateSuccessState());
    } catch (e) {
      emit(CreateFailState(e as Exception));
    }
  }
}
