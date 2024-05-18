import 'package:bcsports_mobile/models/social/report.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';


class ReportRepository {
  Future<void> sendReport(ReportModel report) async {
    final reportColl = FirebaseCollections.reportCollection;
    await reportColl.add({
      "user_id": report.userEmail,
      "post_id": report.postId,
      "report_type": report.type
    });
  }
}
