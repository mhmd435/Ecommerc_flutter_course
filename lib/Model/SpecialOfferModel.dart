class SpecialOfferModel{
  var _id;
  String _productName;
  var _price;
  var _off_price;
  var _off_precent;
  String _imgUrl;

  SpecialOfferModel(this._id, this._productName, this._price, this._off_price,
      this._off_precent, this._imgUrl);

  String get imgUrl => _imgUrl;

  get off_precent => _off_precent;

  get off_price => _off_price;

  get price => _price;

  String get productName => _productName;

  get id => _id;
}