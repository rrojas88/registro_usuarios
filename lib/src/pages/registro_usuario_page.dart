import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:registro_usuarios/src/utils/utils.dart' as utils;
import 'package:registro_usuarios/src/models/usuario_model.dart';
import 'package:registro_usuarios/src/providers/usuarios_provider.dart';


class RegistroUsuario extends StatefulWidget {
  @override
  _RegistroUsuarioState createState() => _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<RegistroUsuario> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String _nombre;
  String _apellido;
  String _tipo_documento;
  bool _ver_error_tipo_documento = false;
  String _documento;
  String _correo;
  String _celular;
  String _fecha;
  TextEditingController _ctrlFecha = new TextEditingController();

  File foto;
  String pathFoto;

  bool _enviando = false;

  bool _verRespuesta = false;
  String _response = '';

  List<String> _tiposDocumento = ['Cédula de ciudadanía', 'Tarjeta de identidad', 'Registro civil', 'Cédula de extranjería', 'Otro'];


  final usuarioProv = new UsuariosProvider();
  UsuarioModel usuario = new UsuarioModel();


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double ancho = size.width * 0.9;
    double margenIzqDer = size.width * 0.05;

    final _informacion = Text('Registro de Usuario',
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: Colors.orange)
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Container(
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

                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      _imgFondo(),
                      SizedBox(height: 12.0),
                      _informacion,
                      SizedBox(height: 20.0),
                      _inputNombre(),
                      SizedBox(height: 20.0),
                      _inputApellido(),
                      SizedBox(height: 20.0),
                      _inputTipoDocumento(),
                      SizedBox(height: 20.0),
                      _inputDocumento(),
                      SizedBox(height: 20.0),
                      _inputCorreo(),
                      SizedBox(height: 20.0),
                      _inputCelular(),
                      SizedBox(height: 20.0),
                      _inputFecha( context ),
                      SizedBox(height: 20.0),
                      _imgFoto(),
                      SizedBox(height: 40.0),
                      _btnRegistrar( context ),
                      SizedBox(height: 20.0),

                      ( _verRespuesta ) ? _showResponse() : Container()

                    ],
                  ),
                )
              ),

              _footer()
            ],
          )

        ),
      ),
    );
  }


  Widget _imgFondo(){
    return Image(
      image: AssetImage('assets/usuarios.png'),
      height: 140.0,
      fit: BoxFit.cover,
    );
  }

  Widget _inputNombre() {
    return TextFormField(
      initialValue: usuario.nombre,
      decoration: InputDecoration(
        labelText: 'Nombre',
        labelStyle: TextStyle( color: Colors.orange ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide( color: Colors.orange )
        )
      ),
      validator: ( value ){
        if( value.isEmpty ){
          return 'Por favor ingrese el nombre';
        }
      },
      onSaved: (value) {
        usuario.nombre = value;
        //setState(() {   });
      } 
    );
  }

  Widget _inputApellido() {
    return TextFormField(
      initialValue: usuario.apellido,
      decoration: InputDecoration(
        labelText: 'Apellido',
        labelStyle: TextStyle( color: Colors.orange ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide( color: Colors.orange )
        )
      ),
      validator: ( value ){
        if( value.isEmpty ){
          return 'Por favor ingrese el apellido';
        }
      },
      onSaved: (value) {
        usuario.apellido = value;
        //setState(() {   });
      } 
    );
  }


  List<DropdownMenuItem<String>> getListaTiposDocumentos () {
    List<DropdownMenuItem<String>> lista = new List();
    _tiposDocumento.forEach(( tipo ){
      lista.add( DropdownMenuItem(
        child:Text( tipo ) ,
        //key: ,
        value: tipo,
        )
      );
    });
    return lista;
  }
  Widget _inputTipoDocumento() {

    final _error_tipo_documento = Text('Por favor seleccione un tipo de documento',
      style: TextStyle( 
        color: Color.fromRGBO(208, 31, 90, 1.0), 
        fontSize: 12.0 
        )
    );

    return Column(
      // Centrado "A la Izq" en Columna
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('Tipo de documento', 
              style: TextStyle( color:Colors.orange ) 
            ),
            SizedBox( width: 24.0 ),
            Expanded(
              child: DropdownButton(
                items: getListaTiposDocumentos(),
                onChanged: ( valor ){
                  _tipo_documento = valor;
                  usuario.tipoDocumento = _tipo_documento;
                  setState(() {  });
                },
                value: _tipo_documento,
                //value: usuario.tipoDocumento,
                hint: Text('Seleccione..'),
              ),
            )
          ],
        ),
        ( _ver_error_tipo_documento ) ? _error_tipo_documento : Container()
      ],
    );
  }


  Widget _inputDocumento() {
    return TextFormField(
      initialValue: usuario.documento,
      keyboardType: TextInputType.numberWithOptions(),
      decoration: InputDecoration(
        labelText: 'Documento de identidad',
        labelStyle: TextStyle( color: Colors.orange ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide( color: Colors.orange )
        )
      ),
      validator: ( value ){
        if( value.isEmpty ){
          return 'Por favor ingrese el documento de identidad';
        }
      },
      onSaved: (value) {
        usuario.documento = value;
      } 
    );
  }

  Widget _inputCorreo() {
    return TextFormField(
      initialValue: usuario.correo,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Correo',
        labelStyle: TextStyle( color: Colors.orange ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide( color: Colors.orange )
        )
      ),
      validator: ( value ){
        if( value.isEmpty ){
          return 'Por favor ingrese el correo electrónico';
        }
        if( ! utils.validateEmail(value) ){
          return 'Por favor ingrese un correo válido';
        }

      },
      onSaved: (value) {
        usuario.correo = value;
      } 
    );
  }

  Widget _inputCelular() {
    return TextFormField(
      initialValue: usuario.celular,
      keyboardType: TextInputType.numberWithOptions(),
      decoration: InputDecoration(
        labelText: 'Celular',
        labelStyle: TextStyle( color: Colors.orange ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide( color: Colors.orange )
        )
      ),
      validator: ( value ){
        if( value.isEmpty ){
          return 'Por favor ingrese el número celular';
        }
      },
      onSaved: (value) {
        usuario.celular = value;
      } 
    );
  }

  Widget _inputFecha(BuildContext context) {
    return TextFormField(
      controller: _ctrlFecha,
      //initialValue: usuario.fechaNacimiento,
      decoration: InputDecoration(
        labelText: 'Fecha de nacimiento',
        labelStyle: TextStyle( color: Colors.orange ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide( color: Colors.orange )
        )
      ),
      onTap: (){
        // Quitar foco del input:
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
      validator: ( value ){
        if( value.isEmpty ){
          return 'Por favor ingrese la fecha de nacimiento';
        }
      },
      onSaved: (value) {
        usuario.fechaNacimiento = value;
      } 
    );
  }
  void _selectDate(BuildContext context) async {
    DateTime valorDateTime = await showDatePicker(
      context: context, 
      initialDate: new DateTime(1920), 
      firstDate: new DateTime(1920), 
      lastDate: new DateTime.now(),
      locale: Locale('es', 'ES')
    );
    if( valorDateTime != null ){
      String valor = valorDateTime.toString();
      _fecha = valor;
      List vfecha = _fecha.split(' ');
      //print('Seleccionada Fecha: ${vfecha[0]}');
      _ctrlFecha.text = vfecha[0];

      setState(() {  });
    }
  }


  Widget _imgFoto(){
    return Container(
      width: 180.0,
      child: Column(
        children: <Widget>[
          Image(
            image: AssetImage(foto?.path ?? 'assets/sin-imagen.jpg'),
            height: 140.0,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10.0),
          IconButton(
            icon: Icon(Icons.camera_alt, size: 48.0, color: Colors.orange ), 
            onPressed: () => _tomarFoto()
          )
        ],
      )
    );
  }
  void _tomarFoto() async {
    foto = await ImagePicker.pickImage(
      source: ImageSource.camera
    );
    if( foto != null ){
      usuario.pathFoto = foto.path;
    }
    setState(() {  });
  }


  Widget _btnRegistrar(BuildContext context) {
    return RaisedButton.icon(
      icon: Icon( Icons.check ),
      label: Text('Registrar'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.orange,
      textColor: Colors.white,
      onPressed: ( _enviando ) ? null : _submit
      //onPressed: (){ _submit( context ); }
    );
  }

  Widget _footer() {
    return Container(
      /// ======== Pie de Pagina
      decoration: BoxDecoration(color: Colors.orange),
      padding: EdgeInsets.all(12.0),
      width: double.infinity,
      margin: EdgeInsetsDirectional.only( bottom: 40.0 ),
      child: Text(
        '® Powered Robinson',
        style: TextStyle(color: Colors.white),
      )
    );
  }


  void _submit()  async {
    print('........... SUBMIT .................');
 
    _ver_error_tipo_documento = ( _tipo_documento == '' || _tipo_documento == null )? true : false;
    setState(() {   });

    bool respForm = formKey.currentState.validate();

    if( ! respForm ) return;
    /*
    print(usuario);
    print('Nombre: ${usuario.nombre}');
    print('tipoDocumento: ${usuario.tipoDocumento}');
    print('correo: ${usuario.correo}');
    print('celular: ${usuario.celular}');
    print('fechaNacimiento: ${usuario.fechaNacimiento}');
    print('pathFoto: ${usuario.pathFoto}');*/

    formKey.currentState.save();

    setState(() {
      _enviando = true;
    });

    List resp = await usuarioProv.createUser( usuario );

    //if( resp[0] ){ // Si hay error
      _verRespuesta = true;
      _response = resp[ 1 ];

      setState(() {  });
    //}

    setState(() {
      _enviando = false;
    });

  }

  Widget _showResponse(){
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(252, 229, 152, 1.0)
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.close, size: 48.0, color: Colors.orange ), 
            onPressed: (){
              _verRespuesta = false;
              setState(() {  });
            }
          ),
          Text('Respuesta del Servidor', 
            style: TextStyle( fontSize: 22.0, color: Colors.orange ),   
          ),
          Text( _response )
        ],
      ),
    );
  }


}
