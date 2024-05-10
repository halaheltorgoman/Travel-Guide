class Hotels {
  final String hotelName;
  final String hotelImage;
  final String hotelDescription;
  final double price;
  final Cities city;
  final bool breakFast;
  final int days;
  final int beds;
  bool isAvailable;

  Hotels({
    required this.hotelName,
    required this.hotelImage,
    required this.hotelDescription,
    required this.price,
    required this.city,
    required this.breakFast,
    required this.days,
    required this.beds,
    this.isAvailable = true,
  });
}

enum Cities { alexandria, cairo }

/*

  the models

  */

class Reserve {
  final List<Hotels> _hotels = [
    // alexandria hotels
    Hotels(
      hotelName: 'Regency Hotel Alexandria',
      hotelImage:
          'https://cf.bstatic.com/xdata/images/hotel/max1024x768/82132128.jpg?k=2705719416bda2b919ff8ef054a8d1a767967e16d63e67bf08ddd62f64b60464&o=&hp=1',
      hotelDescription:
          'Comfortable hotel, overlooking the sea, inside the city, clean, with the latest air conditioning technology, and has wifi internet.',
      price: 1000,
      city: Cities.alexandria,
      breakFast: true,
      days: 2,
      beds: 3,
      isAvailable: false,
    ),
    Hotels(
      hotelName: 'Steigenberger Cecil Hotel',
      hotelImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsV1fDBO-hu4Vd3yPrsr_XmA4c4LDQ_MOqxuDWkziW8g&s',
      hotelDescription:
          'Comfortable hotel, overlooking the sea, inside the city, clean, with the latest air conditioning technology, and has wifi internet.',
      price: 1500,
      city: Cities.alexandria,
      breakFast: true,
      days: 2,
      beds: 4,
    ),
    Hotels(
      hotelName: 'San Stefano Hotel',
      hotelImage:
          'https://www.urtrips.com/wp-content/uploads/2018/07/Alexandria-Hotels-5-Stars-6-Copy.jpg',
      hotelDescription:
          'Comfortable hotel, overlooking the sea, inside the city, clean, with the latest air conditioning technology, and has wifi internet.',
      price: 1500,
      city: Cities.alexandria,
      breakFast: true,
      days: 3,
      beds: 4,
    ),
    Hotels(
      hotelName: 'Four Seasons Hotel',
      hotelImage:
          'https://lh3.googleusercontent.com/proxy/BneYtplyoFSq4pY2xJ8h_4pIrYW6EqAJ3Mpktl3K1I43EOKk4mtXLX0-tWvjUgvb29Ne_uMS5KWRzqZ-IxkiXaileFbQp58OT8v4N2jXkt1XSI3XBkivzKZg93sORPN2Xm8TAue3',
      hotelDescription:
          'Comfortable hotel, overlooking the sea, inside the city, clean, with the latest air conditioning technology, and has wifi internet.',
      price: 1500,
      city: Cities.alexandria,
      breakFast: true,
      days: 2,
      beds: 4,
    ),
    // cairo hotels
    Hotels(
      hotelName: 'Hilton Hotel Alexandria',
      hotelImage:
          'https://cf.bstatic.com/xdata/images/hotel/max1024x768/490791247.jpg?k=8077592942f4969caa9d00d451e9d3d4530c99061c25ffcf39d52d9afa799a72&o=&hp=1',
      hotelDescription:
          'Comfortable hotel, overlooking the sea, inside the city, clean, with the latest air conditioning technology, and has wifi internet.',
      price: 1000,
      city: Cities.alexandria,
      breakFast: true,
      days: 2,
      beds: 3,
      isAvailable: false,
    ),
    Hotels(
      hotelName: 'Tolip hotel Alexandria',
      hotelImage:
          'https://q-xx.bstatic.com/xdata/images/hotel/max500/28182728.jpg?k=b7b107638878a121863a56a40fb3470435c0959a77692a3fbdc8da3f7446ebfc&o=',
      hotelDescription:
          'Comfortable hotel, overlooking the sea, inside the city, clean, with the latest air conditioning technology, and has wifi internet.',
      price: 1000,
      city: Cities.alexandria,
      breakFast: true,
      days: 2,
      beds: 3,
      isAvailable: false,
    ),
  ];

  /*

  G E T T E R

  */

  List<Hotels> get hotels => _hotels;
}
