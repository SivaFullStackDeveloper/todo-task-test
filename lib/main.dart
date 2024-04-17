import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Flutter Bloc library
import 'package:hydrated_bloc/hydrated_bloc.dart'; // Import Hydrated Bloc library for state persistence
import 'package:path_provider/path_provider.dart'; // Import path_provider for accessing device directories
import '../todo_bloc/todo_events.dart'; // Import todo events
import 'home_screen.dart'; // Import home screen widget
import 'observer_bloc.dart'; // Import observer bloc
import 'todo_bloc/todo_bloc.dart'; // Import todo bloc

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set up Hydrated Bloc storage with temporary directory for state persistence
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  // Set up TodoObserver to observe state changes
  Bloc.observer = TodoObserver();

  // Run the application
  runApp(const MainApp());
}

// Main application widget
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      // Define app theme
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          background: Colors.white,
          onBackground: Colors.black,
          primary: Colors.redAccent,
          onPrimary: Colors.white,
          secondary: Colors.lightGreen,
          onSecondary: Colors.white,
        ),
      ),
      // Set the home screen wrapped in TodoBlocProvider
      home: BlocProvider<TodoBloc>(
        create: (context) => TodoBloc()..add(TodoStarted()),
        child: const HomeScreen(),
      ),
    );
  }
}
