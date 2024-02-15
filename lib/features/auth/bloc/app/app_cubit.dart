import 'package:bcsports_mobile/features/auth/data/auth_repository.dart';
import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/social/data/favourite_posts_repository.dart';
import 'package:bcsports_mobile/features/social/data/social_repository.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;
  final SocialRepository _socialRepository;
  final FavouritePostsRepository _favouritesRepository;
  final MarketRepository _marketRepository;

  AppCubit(
      AuthRepository authRepository,
      ProfileRepository profileRepository,
      SocialRepository socialRepository,
      FavouritePostsRepository favouritePostsRepository,
      MarketRepository marketRepository)
      : _authRepository = authRepository,
        _profileRepository = profileRepository,
        _socialRepository = socialRepository,
        _favouritesRepository = favouritePostsRepository,
        _marketRepository = marketRepository,
        super(AppInitial()) {
    subscribe();
  }

  void subscribe() {
    _authRepository.appState.stream.listen((event) async {
      if (event == AppAuthStateEnum.auth) {
        await _profileRepository.setUser(_authRepository
            .currentUser!.uid); // await cuz maret depends on user
        _socialRepository.initial();
        await _marketRepository.nftService
            .loadNftCollection()
            .then((value) => _marketRepository.subscribeOnMarketStream());

        emit(AppAuthState());
      }
      if (event == AppAuthStateEnum.unAuth) {
        _profileRepository.posts.clear();
        _socialRepository.posts.clear();
        _favouritesRepository.posts.clear();
        emit(AppUnAuthState());
      }
      if (event == AppAuthStateEnum.wait) emit(AppInitial());
      if (event == AppAuthStateEnum.noInternet) emit(NoInternetState());
    });
  }
}
