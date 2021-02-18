
class Fonibo {

  int id;
  String title;
  String createdAt;

	Fonibo.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		title = map["title"],
		createdAt = map["createdAt"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['title'] = title;
		data['createdAt'] = createdAt;
		return data;
	}
}
