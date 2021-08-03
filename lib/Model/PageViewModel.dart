class PageViewModel{
  var _id;
  String _imgurl;

  PageViewModel(this._id, this._imgurl);

  String get imgurl => _imgurl;

  get id => _id;
}