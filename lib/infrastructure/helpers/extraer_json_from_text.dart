String? extraerJSON(String texto) {
  try {
    int inicio = texto.indexOf('{');
    int fin = texto.lastIndexOf('}');

    String jsonExtraido = texto.substring(inicio, fin + 1);

    return jsonExtraido;
  } catch (e) {
    return null;
  }
}
