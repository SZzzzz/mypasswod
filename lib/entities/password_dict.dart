class PasswordDict {
  Map<String, String> _sMap;

  PasswordDict.fromJson(Map<String, dynamic> jsonMap) {
    this._sMap = new Map();
    jsonMap.forEach((key, value) {
      this._sMap[key] = value;
    });
  }

  String encode(String key) {
    return _sMap[key];
  }
}