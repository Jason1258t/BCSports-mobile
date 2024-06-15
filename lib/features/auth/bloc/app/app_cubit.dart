import 'package:bcsports_mobile/features/auth/data/auth_repository.dart';
import 'package:bcsports_mobile/features/chat/data/chat_repository.dart';
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
  final ChatRepository _chatRepository;

  AppCubit(
    AuthRepository authRepository,
    ProfileRepository profileRepository,
    SocialRepository socialRepository,
    FavouritePostsRepository favouritePostsRepository,
    MarketRepository marketRepository,
    ChatRepository chatRepository,
  )   : _authRepository = authRepository,
        _profileRepository = profileRepository,
        _socialRepository = socialRepository,
        _favouritesRepository = favouritePostsRepository,
        _marketRepository = marketRepository,
        _chatRepository = chatRepository,
        super(AppInitial()) {
    subscribe();
  }

  void subscribe() {
    _authRepository.appState.stream.listen((event) async {
      if (event == AppAuthStateEnum.auth) {
        await _authorizeApp();
        emit(AppAuthState());
      }
      if (event == AppAuthStateEnum.unAuth) {
        _unAuth();
        emit(AppUnAuthState());
      }
      if (event == AppAuthStateEnum.wait) emit(AppInitial());
      if (event == AppAuthStateEnum.noInternet) emit(NoInternetState());
    });
  }

  Future<void> _authorizeApp() async {
    await _profileRepository.setUser(
        _authRepository.currentUser!.uid); // await cuz market depends on user

    _socialRepository.initial();
    await _marketRepository.nftService.loadNftCollection();
    _marketRepository.subscribeOnMarketStream();
    _chatRepository.init();
  }

  Future _unAuth() async {
    _profileRepository.posts.clear();
    _socialRepository.posts.clear();
    _favouritesRepository.posts.clear();
  }
}
