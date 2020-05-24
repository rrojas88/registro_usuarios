import 'package:flutter/material.dart';


bool validateEmail( String email ){

  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp   = new RegExp(pattern);

  bool emailOk = ( regExp.hasMatch( email ) ) ? true : false;
  
  return emailOk;
}
