class PicModel {
  final String picUrl;

  PicModel({required this.picUrl});
  factory PicModel.fromJson(json) {
    print('json[data] ${json['data']}');
    return PicModel(picUrl: (json['data']==null)?'':json['data']);
  }
}
