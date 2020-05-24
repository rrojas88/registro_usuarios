import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:registro_usuarios/src/providers/configuraciones.dart';
import 'package:registro_usuarios/src/models/usuario_model.dart';



class UsuariosProvider with ChangeNotifier {

  final _urlBase = Configuraciones.urlBase;
  final _urlCreateUsers = Configuraciones.urlCreateUsers;

  Future<List> createUser( UsuarioModel usuario ) async {

    final url = '$_urlBase$_urlCreateUsers';
    String dataString = usuarioModelToJson(usuario);
    //print('Data JSON enviada');
    //print(dataString);

    List<dynamic> resp = [ false, '' ];

    try {
      final response = await http.post(url, body: dataString );
      String respBody = response.body;
      final decodedData = json.decode( respBody );
      print(decodedData);

      resp = [ false, respBody ];

    } catch ( err ) {
      //print('Error en el AJAX');
      print( err.toString() );
      resp = [ true, err.toString() ];
    }

    return resp;
  }

}