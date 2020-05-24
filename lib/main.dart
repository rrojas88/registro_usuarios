import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:registro_usuarios/src/providers/usuarios_provider.dart';
import 'package:registro_usuarios/src/pages/intro_page.dart';
import 'package:registro_usuarios/src/pages/registro_usuario_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (context) => UsuariosProvider() )
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('es', 'ES'),
        ],
        
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'intro',
        routes: {
          'intro': (context) => IntroPage(),
          'registro_usuario': (context) => RegistroUsuario()
        }
      ),
    );
  }

}
