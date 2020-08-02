class PasswordRecord {
  String appName;
  String key;
  String value;

  PasswordRecord(this.appName, this.key, this.value);

  PasswordRecord.fromJson(Map<String, dynamic> jsonMap) {
    this.appName = jsonMap["appName"];
    this.key = jsonMap["key"];
    this.value = jsonMap["value"];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    "appName": appName,
    "key": key,
    "value": value
  };
}