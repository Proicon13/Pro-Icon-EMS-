part of 'main_cubit.dart';

enum MainSections { programs, autoSessions, start, users, settings }

extension MainSectionsX on MainSections {
  Widget get view {
    switch (this) {
      case MainSections.programs:
        return const HomeView();
      case MainSections.autoSessions:
        return const Center(
          child: Text(
            "auto sessions",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        );
      case MainSections.users:
        return const UsersView();
      case MainSections.settings:
        return const SettingsView();
      case MainSections.start:
        return const SizedBox.shrink();
    }
  }
}

class MainState extends Equatable {
  final MainSections currentSection;

  const MainState({this.currentSection = MainSections.programs});

  MainState copyWith({MainSections? currentSection}) {
    return MainState(currentSection: currentSection ?? this.currentSection);
  }

  @override
  List<Object> get props => [currentSection];
}
