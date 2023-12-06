class Cities_Model {
  String? name;

  Cities_Model({
    this.name,
  });

  Cities_Model.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
