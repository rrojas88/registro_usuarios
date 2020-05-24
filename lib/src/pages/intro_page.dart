
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  bool _acepta = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double ancho = size.width * 0.9;
    double margenIzqDer = size.width * 0.05;
    
    final _bienvenido = Text('Bienvenido a mi App !',
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: Colors.orange)
    );

    final _descripcion = Text('Podrás registrar usuarios si aceptas los términos y condiciones de uso',
      style: TextStyle( fontSize: 20.0 ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: Container(
        /// ======== Fondo Naranja
        decoration: BoxDecoration(
          color: Colors.orange,
        ),
        width: double.infinity,

        child: Column(
          children: <Widget>[
            Container(
              /// ======== Fondo Blanco
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0)
              ),
              width: ancho,
              margin: EdgeInsets.only(left: margenIzqDer, right: margenIzqDer),
              padding: EdgeInsets.all(20.0),

              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  _bienvenido,
                  SizedBox(height: 20.0),
                  _descripcion,
                  SizedBox(height: 20.0),
                  _inputAceptaTerminos(),
                  SizedBox(height: 20.0),
                  _btnContinuar(),
                  
                ],
              )
            ),

            _footer()
          ],
        )
      ),
    );
  }

  Widget _footer() {
    return Container(
      /// ======== Pie de Pagina
      decoration: BoxDecoration(color: Colors.orange),
      padding: EdgeInsets.all(12.0),
      width: double.infinity,
      //height: double.infinity,
      child: Text(
        '® Powered Robinson',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _inputAceptaTerminos() {
    return SwitchListTile(
      title: Text('Acepto términos y condiciones'),
      activeColor: Colors.orange,
      value: _acepta, 
      onChanged: ( valor ){
        _acepta = valor; 
        setState(() { });
      }
    );
  }

  Widget _btnContinuar() {
    return RaisedButton.icon(
      icon: Icon( Icons.keyboard_arrow_right ),
      label: Text('Continuar'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.orange,
      textColor: Colors.white,
      onPressed: ( ! _acepta ) ? null : _goToFormUser 
    );
  }

  void _goToFormUser(){
    Navigator.pushNamed(context, 'registro_usuario');
  }

}
