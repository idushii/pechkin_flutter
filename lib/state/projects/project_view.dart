import 'package:pechkin_flutter/index.dart';

class ProjectViewState {
  final ProjectItemFull project;
  final String loadState;
  final String error;

  ProjectViewState({required this.project, required this.loadState, required this.error});

  // empty
  factory ProjectViewState.empty() {
    return ProjectViewState(project: ProjectItemFull.empty(), loadState: LoadState.none, error: '');
  }

  //copyWith
  ProjectViewState copyWith({ProjectItemFull? project, String? loadState, String? error}) {
    return ProjectViewState(
        project: project ?? this.project, loadState: loadState ?? this.loadState, error: error ?? this.error);
  }

  // toMap
  Map<String, dynamic> toMap() {
    return {'project': project.toMap(), 'loadState': loadState, 'error': error};
  }

  //fromMap
  factory ProjectViewState.fromMap(Map<String, dynamic> map) {
    return ProjectViewState(
        project: ProjectItemFull.fromMap(map['project']),
        loadState: map['loadState'],
        error: map['error']);
  }

  // toString
  @override
  String toString() => 'ProjectViewState(project: $project, loadState: $loadState, error: $error)';
}

class ProjectViewCubit extends Cubit<ProjectViewState> {
  ProjectViewCubit() : super(ProjectViewState.empty());

  load(int id) async {
    emit(ProjectViewState(project: ProjectItemFull.empty(), loadState: LoadState.loading, error: ''));
    final res = await Api.getProject(id);
    if (res.data != null) {
      emit(ProjectViewState(project: res.data!, loadState: LoadState.success, error: ''));
    } else {
      emit(ProjectViewState(project: ProjectItemFull.empty(), loadState: LoadState.error, error: res.error!));
    }
  }

}