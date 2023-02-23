class SuggestionsModel {
  final int id;
  final String? image;
  final String? text;
  final String? endData;
  final String? logo;
  final String? color;

  SuggestionsModel.fromJson(Map json)
      : id = json['id'],
        image = json['image'],
        text = json['text'],
        endData = json['endData'],
        color = json['color'],
        logo = json['logo'];

  Map toJson() {
    return {
      'id': id,
      'image': image ?? '',
      'text': text ?? '',
      'endData': endData ?? '',
      'color': color ?? '',
      'logo': logo ?? '',
    };
  }
}
