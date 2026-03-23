import 'package:equatable/equatable.dart';



final List<NewsEntity> dummyNews = [
  NewsEntity(id: 1,image: "https://media.istockphoto.com/id/119926339/photo/resort-swimming-pool.jpg?s=612x612&w=0&k=20&c=9QtwJC2boq3GFHaeDsKytF4-CavYKQuy1jBD2IRfYKc=", title: "Overseas adventure travel in italy", desc: "Rome is the capital city and most populated comune of Italy. It is also the administrative centre of the Lazio region and of the Metropolitan City of Rome",),
  NewsEntity(id: 2,image: "https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aG90ZWx8ZW58MHx8MHx8fDA%3D",title: "Al Diyafa News",desc: "Rome is the capital city and most populated comune of Italy. It is also the administrative centre of the Lazio region and of the Metropolitan City of Rome"),
  NewsEntity(id: 3,image: "https://cdn.secretplaces.com/images/hotel-media/2341-18.jpg",  title: "Al Koot Heritage News",  desc: "Rome is the capital city and most populated comune of Italy. It is also the administrative centre of the Lazio region and of the Metropolitan City of Rome"),
  NewsEntity(id: 4,image: "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2c/b0/c1/4c/boutique-hotels.jpg?w=1200&h=-1&s=1",  title: "Grand Lily News",  desc: "Rome is the capital city and most populated comune of Italy. It is also the administrative centre of the Lazio region and of the Metropolitan City of Rome"),
];



class NewsEntity extends Equatable {
  final int _id;


  final String _image;

  final String _title;
  final String _desc;


  @override
  List<Object> get props => [
    _id,
    _image,
    _title,
  ];

  String get title => _title;
  String get desc => _desc;





  String get image => _image;

  int get id => _id;

  const NewsEntity({
    required int id,
    required String image,
    required String title,
    required String desc,
  })  : _id = id,
        _image = image,
        _title = title,
        _desc = desc;
}
