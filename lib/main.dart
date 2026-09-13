import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/case_provider.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/cases_screen.dart';
import 'screens/add_entry_screen.dart';
import 'screens/unpack/unpack_prompt_screen.dart';
import 'screens/unpack/name_need_screen.dart';
import 'screens/unpack/select_needs_screen.dart';
import 'screens/unpack/mindfulness_prompt_screen.dart';
import 'screens/unpack/mindfulness_timer_screen.dart';

void main() {
  runApp(const PettyUniversityApp());
}

class PettyUniversityApp extends StatelessWidget {
  const PettyUniversityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CaseProvider()..loadFromStorage(),
      child: MaterialApp(
        title: 'pettyUniversity',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        initialRoute: '/home',

        onGenerateRoute: (settings) {
          if (settings.name == '/entry') {
            final args = settings.arguments as AddEntryScreenArgs?;
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => AddEntryScreen(
                caseId: args?.caseId,
                isReadOnly: args?.isReadOnly ?? false,
              ),
            );
          }
          return null; // fall through to the `routes` map for everything else
        },

        routes: {
          '/home': (_) => const HomeScreen(),
          '/cases': (_) => const CasesScreen(),
          '/unpack/prompt': (_) => const UnpackPromptScreen(),
          '/unpack/name-need': (_) => const NameNeedScreen(),
          '/unpack/select-needs': (_) => const SelectNeedsScreen(),
          '/unpack/mindfulness-prompt': (_) => const MindfulnessPromptScreen(),
          '/mindfulness/timer': (_) => const MindfulnessTimerScreen(),
        },
      ),
    );
  }
}
