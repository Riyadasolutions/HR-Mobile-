class ChartsParameters {
  String? _fromDate;
  String? _toDate;



  setDates({
    required String? fromDate,
    required String? toDate,
  }){
    _fromDate = fromDate;
    _toDate = toDate;
  }
  ChartsParameters({
     String? fromDate,
     String? toDate,
  })  : _fromDate = fromDate,
        _toDate = toDate;

  String? get toDate => _toDate??'';

  String? get fromDate => _fromDate??'';

  Map<String, dynamic> toJson (){
    Map<String, dynamic> data = {};
    if( (fromDate??'').isNotEmpty) {data['date_from'] = _fromDate;}
    if( (toDate??'').isNotEmpty) {data['date_to'] = _toDate;}
    return data;

  }
}
