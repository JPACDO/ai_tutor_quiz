String? extraerJSON(String texto) {
  int inicio = texto.indexOf('{');
  int fin = texto.lastIndexOf('}');

  String jsonExtraido = texto.substring(inicio, fin + 1);

  return jsonExtraido;
}
