import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_comments_state.dart';

class PostCommentsCubit extends Cubit<PostCommentsState> {
  PostCommentsCubit() : super(PostCommentsInitial());
}
