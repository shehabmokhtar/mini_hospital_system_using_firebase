class Doctor_Model {
  String? name;
  String? profileImage;
  String? ID;

  Doctor_Model({
    this.name,
    this.profileImage,
    this.ID,
  });

  Doctor_Model.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    profileImage = json['profileImage'];
    ID = json['ID'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profileImage': profileImage,
      'ID': ID,
    };
  }
}
