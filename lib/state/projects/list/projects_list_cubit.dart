import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pechkin_flutter/models/index.dart';
import 'package:pechkin_flutter/shared/loadState.dart';

class ProjectListState {
  final List<ProjectItem> projects;
  final String loadState;
  final String error;

  ProjectListState({required this.projects, required this.loadState, required this.error});

  // empty
  factory ProjectListState.empty() {
    return ProjectListState(projects: [], loadState: LoadState.none, error: '');
  }

  //copyWith
  ProjectListState copyWith({List<ProjectItem>? projects, String? loadState, String? error}) {
    return ProjectListState(
      projects: projects ?? this.projects,
      loadState: loadState ?? this.loadState,
      error: error ?? this.error
    );
  }

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'projects': projects.map((x) => x.toMap()).toList(),
      'loadState': loadState,
      'error': error
    };
  }

  //fromMap
  factory ProjectListState.fromMap(Map<String, dynamic> map) {
    return ProjectListState(
      projects: List<ProjectItem>.from(map['projects']?.map((x) => ProjectItem.fromMap(x))),
      loadState: map['loadState'],
      error: map['error']
    );
  }
}

class ProjectListCubit extends Cubit<ProjectListState> {
  ProjectListCubit() : super(ProjectListState.empty());

  load() {
    emit(ProjectListState(projects: [], loadState: LoadState.loading, error: ''));
  }
}

final projectListCubit = ProjectListCubit();
