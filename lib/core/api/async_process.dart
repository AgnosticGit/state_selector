import 'package:state_selector/core/api/failure.dart';

class AsyncProcess {
  bool loading = false;
  Failure? failure;

  bool get hasFailure => failure != null;

  Map<String, dynamic> toJson() {
    return {
      'loading': loading,
      'failure': failure,
    };
  }
}
