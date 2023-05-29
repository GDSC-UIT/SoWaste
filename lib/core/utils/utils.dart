bool isUrl(String urlString) {
  return Uri.parse(urlString).isAbsolute;
}
