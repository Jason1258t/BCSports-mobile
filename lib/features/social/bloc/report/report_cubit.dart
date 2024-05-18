import 'package:bcsports_mobile/features/social/data/report_repository.dart';
import 'package:bcsports_mobile/models/social/report.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  final ReportRepository reportRepository;

  ReportCubit(this.reportRepository) : super(ReportInitial());

  report({required String postId, required String type}) async {
    emit(ReportLoading());

    try {
      final userEmail = FirebaseAuth.instance.currentUser!.email!;
      await reportRepository.sendReport(
          ReportModel(postId: postId, userEmail: userEmail, type: type));
      emit(ReportSuccess());
    } catch (e) {
      emit(ReportFailure());
    }
  }
}
