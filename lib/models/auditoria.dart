class Auditoria {
  final int? id;
  final String action;

  Auditoria({this.id, required this.action});

  // Convertir un objeto Auditoria a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'action': action,
    };
  }

  // Crear un objeto Auditoria a partir de un Map
  factory Auditoria.fromMap(Map<String, dynamic> map) {
    return Auditoria(
      id: map['id'],
      action: map['action'],
    );
  }
}
