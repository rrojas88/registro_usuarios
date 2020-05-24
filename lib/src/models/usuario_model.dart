import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
    String nombre;
    String apellido;
    String tipoDocumento;
    String documento;
    String correo;
    String celular;
    String fechaNacimiento;
    String pathFoto;

    UsuarioModel({
        this.nombre,
        this.apellido,
        this.tipoDocumento,
        this.documento,
        this.correo,
        this.celular,
        this.fechaNacimiento,
        this.pathFoto,
    });

    factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        nombre:           json["nombre"],
        apellido:         json["apellido"],
        tipoDocumento:    json["tipo_documento"],
        documento:        json["documento"],
        correo:           json["correo"],
        celular:          json["celular"],
        fechaNacimiento:  json["fecha_nacimiento"],
        pathFoto:         json["pathFoto"],
    );

    Map<String, dynamic> toJson() => {
        "nombre":           nombre,
        "apellido":         apellido,
        "tipo_documento":   tipoDocumento,
        "documento":        documento,
        "correo":           correo,
        "celular":          celular,
        "fecha_nacimiento": fechaNacimiento,
        "pathFoto":         pathFoto,
    };
}
