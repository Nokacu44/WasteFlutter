import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdr/classes/NavigatorService.dart';
import 'package:gdr/providers/entity_provider.dart';
import 'package:gdr/providers/map_provider.dart';
import 'package:gdr/providers/status_messages_provider.dart';
import 'package:provider/provider.dart';
import 'screens/inventory_page.dart';
import 'screens/game_page.dart';

void main() {
  // Disable landscape mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Entities>(create: (_) => Entities()),
      ChangeNotifierProvider<Maps>(create: (_) => Maps()),
      ChangeNotifierProvider<StatusMessages>(create: (_) => StatusMessages()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigatorService.navigatorKey,
      onGenerateRoute: (settings) {
        if (settings.name == '/inventory') {
          return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const InventoryPage());
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const GamePage(),
        /*'/inventory': (context) => const InventoryPage(), toglierlo da qui
        ed inserirlo nella MaterialApp fa in modo di non avere alcuna animazione
        */
      },
    );
  }
}
