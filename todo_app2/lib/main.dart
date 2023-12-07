import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app2/layouts/HomePage.dart';
import 'package:todo_app2/shared/style/blocObserver.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MainWidget());
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => const HomePage(),
      },
    );
  }
}
