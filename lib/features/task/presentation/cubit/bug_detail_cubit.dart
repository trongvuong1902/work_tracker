import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../zentao/domain/models/zentao_bug_detail.dart';
import '../../../zentao/domain/zentao_repository.dart';

part 'bug_detail_state.dart';
part 'bug_detail_cubit.freezed.dart';

/// Loads the live Zentao bug view (comment/action history + attachments) for a
/// bug-linked task's detail screen. Kept separate from [TaskDetailCubit] so
/// the local task loads instantly and the network-bound bug detail streams in
/// after (or fails independently without blocking the task).
@injectable
class BugDetailCubit extends Cubit<BugDetailState> {
  BugDetailCubit(this._zentaoRepository) : super(const BugDetailState());

  final ZentaoRepository _zentaoRepository;

  Future<void> load(int zentaoBugId) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final detail = await _zentaoRepository.getBugDetail(zentaoBugId);
    if (detail == null) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: "Couldn't load bug details from Zentao.",
        ),
      );
      return;
    }
    emit(state.copyWith(isLoading: false, detail: detail));
  }
}
