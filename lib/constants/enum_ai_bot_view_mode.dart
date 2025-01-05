enum EnumAiBotViewMode {
  all,
  published,
  myFavorite,
}

String getModeTitle(EnumAiBotViewMode mode) {
  String result = "";
  switch (mode) {
    case EnumAiBotViewMode.all:
      result = "All";
      break;
    case EnumAiBotViewMode.published:
      result = "Published";
      break;
    default:
      result = "My favorite";
      break;
  }
  return result;
}
