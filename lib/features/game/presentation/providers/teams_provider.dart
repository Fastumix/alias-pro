import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeamsNotifier extends StateNotifier<List<String>> {
  TeamsNotifier() : super(const ['Буревісники', 'Єдинороги', 'Чмоні']);

  void addTeam(String name) {
    state = [...state, name];
  }

  void removeTeam(int index) {
    final list = List<String>.from(state);
    list.removeAt(index);
    state = list;
  }

  void renameTeam(int index, String newName) {
    if (newName.trim().isEmpty) return;
    final list = List<String>.from(state);
    list[index] = newName.trim();
    state = list;
  }
}

final teamsProvider = StateNotifierProvider<TeamsNotifier, List<String>>(
  (ref) => TeamsNotifier(),
);
