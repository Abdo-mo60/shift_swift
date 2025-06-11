class PicModel {
  final String picUrl;

  PicModel({required this.picUrl});
  factory PicModel.fromJson(json) {
    return PicModel(picUrl: (json['data']==null)?'':json['data']);
  }
}
