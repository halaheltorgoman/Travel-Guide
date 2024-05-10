class Restaurant {
  final String restaurantName;
  final String restaurantImage;
  final int restaurantRate;
  final Categories category;
  final String restaurantDetails;
  final double averagePrice;

  Restaurant({
    required this.restaurantDetails,
    required this.restaurantImage,
    required this.restaurantName,
    required this.category,
    required this.restaurantRate,
    required this.averagePrice,
  });
}

enum Categories {
  breakfast,
  lunch,
  dinner,
}

/*

  the models

  */

class Restaurants {
  final List<Restaurant> _restaurants = [
    Restaurant(
      restaurantName: 'abu kamal',
      restaurantDetails:
          'A famous restaurant with several branches, famous for making the famous popular breakfast in Alexandria.',
      restaurantRate: 4,
      averagePrice: 25,
      category: Categories.dinner,
      restaurantImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXa09iA-MriFFze4N3vvUeHzv5iHQhc5bcIZeQ5hJFxw&s',
    ),
    Restaurant(
      restaurantName: 'Kebda Elfallah',
      restaurantDetails:
          'A famous restaurant with several branches, famous for making the famous popular breakfast in Alexandria.',
      restaurantRate: 5,
      averagePrice: 100,
      category: Categories.lunch,
      restaurantImage:
          'https://menuegypt.com/restaurants_menus/Kabda-Elfalah_menu_1.jpg?1502642750',
    ),
    Restaurant(
      restaurantName: 'Carlos Cafe',
      restaurantDetails:
          'It is a simple, informal and cozy café and restaurant that offers its customers a high level of service and high quality food and drinks.',
      restaurantRate: 4,
      averagePrice: 50,
      category: Categories.breakfast,
      restaurantImage: 'https://www.infoeg.com/uploads/pages/346888-logo.jpg',
    ),
    Restaurant(
      restaurantName: 'Elbaraka',
      restaurantDetails:
          'It is a restaurant in Alexandria that serves fast fried food, and ensures the highest possible quality in serving food.',
      restaurantRate: 5,
      averagePrice: 110,
      category: Categories.lunch,
      restaurantImage:
          'https://egmenu.com/wp-content/uploads/%D9%84%D9%88%D8%AC%D9%88-%D8%A7%D9%84%D8%A8%D8%B1%D9%83%D8%A9-%D8%A8%D8%B1%D9%88%D8%B3%D8%AA%D8%AF-%D8%AA%D8%B4%D9%8A%D9%83%D9%86.webp',
    ),
    Restaurant(
      restaurantName: 'Khwater Demshqia',
      restaurantDetails:
          'A famous restaurant with several branches, famous for making the famous popular breakfast in Alexandria.',
      restaurantRate: 5,
      averagePrice: 80,
      category: Categories.lunch,
      restaurantImage:
          'https://play-lh.googleusercontent.com/sM9w4VOGM_daNBrjJr0nqEqEwVMxgG8Tgwb0Ja1pkUdENPoJ6QogBZFsO_6kjgsAHiA',
    ),
  ];

  /*

  getter

  */

  List<Restaurant> get restaurant => _restaurants;
}
