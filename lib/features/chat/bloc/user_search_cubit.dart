import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_search_state.dart';

class UserSearchCubit extends Cubit<UserSearchState> {
  UserSearchCubit() : super(UserSearchInitial());
}
