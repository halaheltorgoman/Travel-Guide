import 'package:flutter/material.dart';
import 'package:travelguide/restaurants_screens/restaurant_details.dart';

import '../models/restaurants_models.dart';

class RestaurantsPage extends StatelessWidget {
  const RestaurantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Choose a Restaurant'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(
                text: "Breakfast",
              ),
              Tab(
                text: "Lunch",
              ),
              Tab(
                text: 'Dinner',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
                itemCount: Restaurants().restaurant.length,
                itemBuilder: (context, index) {
                  if (Restaurants().restaurant[index].category ==
                      Categories.breakfast) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RestaurantsDetails(
                                restaurant: Restaurants().restaurant[index],
                              ),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[100]),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Restaurants()
                                          .restaurant[index]
                                          .restaurantName,
                                      maxLines: 2,
                                      overflow: TextOverflow.visible,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    const Text(
                                      'Click here for more details',
                                      maxLines: 2,
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    const Divider(),
                                    // rating
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Rate Stars',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                        const Spacer(),
                                        Icon(
                                          size: 15,
                                          Icons.star,
                                          color: Restaurants()
                                                      .restaurant[index]
                                                      .restaurantRate >
                                                  0
                                              ? Colors.blue
                                              : Colors.grey[300],
                                        ),
                                        Icon(
                                          size: 15,
                                          Icons.star,
                                          color: Restaurants()
                                                      .restaurant[index]
                                                      .restaurantRate >
                                                  1
                                              ? Colors.blue
                                              : Colors.grey[400],
                                        ),
                                        Icon(
                                          size: 15,
                                          Icons.star,
                                          color: Restaurants()
                                                      .restaurant[index]
                                                      .restaurantRate >
                                                  2
                                              ? Colors.blue
                                              : Colors.grey[400],
                                        ),
                                        Icon(
                                          size: 15,
                                          Icons.star,
                                          color: Restaurants()
                                                      .restaurant[index]
                                                      .restaurantRate >
                                                  3
                                              ? Colors.blue
                                              : Colors.grey[400],
                                        ),
                                        Icon(
                                          size: 15,
                                          Icons.star,
                                          color: Restaurants()
                                                      .restaurant[index]
                                                      .restaurantRate >
                                                  4
                                              ? Colors.blue
                                              : Colors.grey[400],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: SizedBox(
                                    height: 100,
                                    child: Image.network(
                                      Restaurants()
                                          .restaurant[index]
                                          .restaurantImage,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox(
                    height: 0,
                    width: 0,
                  );
                }),
            ListView.builder(
                itemCount: Restaurants().restaurant.length,
                itemBuilder: (context, index) {
                  if (Restaurants().restaurant[index].category ==
                      Categories.lunch) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RestaurantsDetails(
                                restaurant: Restaurants().restaurant[index],
                              ),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[100]),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Restaurants()
                                          .restaurant[index]
                                          .restaurantName,
                                      maxLines: 2,
                                      overflow: TextOverflow.visible,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    const Text(
                                      'Click here for more details',
                                      maxLines: 2,
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    const Divider(),
                                    // rating
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Rate',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                        const Spacer(),
                                        Icon(
                                          size: 15,
                                          Icons.star,
                                          color: Restaurants()
                                                      .restaurant[index]
                                                      .restaurantRate >
                                                  0
                                              ? Colors.blue
                                              : Colors.grey[300],
                                        ),
                                        Icon(
                                          size: 15,
                                          Icons.star,
                                          color: Restaurants()
                                                      .restaurant[index]
                                                      .restaurantRate >
                                                  1
                                              ? Colors.blue
                                              : Colors.grey[400],
                                        ),
                                        Icon(
                                          size: 15,
                                          Icons.star,
                                          color: Restaurants()
                                                      .restaurant[index]
                                                      .restaurantRate >
                                                  2
                                              ? Colors.blue
                                              : Colors.grey[400],
                                        ),
                                        Icon(
                                          size: 15,
                                          Icons.star,
                                          color: Restaurants()
                                                      .restaurant[index]
                                                      .restaurantRate >
                                                  3
                                              ? Colors.blue
                                              : Colors.grey[400],
                                        ),
                                        Icon(
                                          size: 15,
                                          Icons.star,
                                          color: Restaurants()
                                                      .restaurant[index]
                                                      .restaurantRate >
                                                  4
                                              ? Colors.blue
                                              : Colors.grey[400],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: SizedBox(
                                    height: 100,
                                    child: Image.network(
                                      Restaurants()
                                          .restaurant[index]
                                          .restaurantImage,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox(
                    height: 0,
                    width: 0,
                  );
                }),
            ListView.builder(
                itemCount: Restaurants().restaurant.length,
                itemBuilder: (context, index) {
                  if (Restaurants().restaurant[index].category ==
                      Categories.dinner) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RestaurantsDetails(
                                restaurant: Restaurants().restaurant[index],
                              ),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[100]),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Restaurants()
                                          .restaurant[index]
                                          .restaurantName,
                                      maxLines: 2,
                                      overflow: TextOverflow.visible,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    const Text(
                                      'Click here for more details',
                                      maxLines: 2,
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    const Divider(),
                                    // rating
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Rate',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                        const Spacer(),
                                        Icon(
                                          size: 15,
                                          Icons.star,
                                          color: Restaurants()
                                                      .restaurant[index]
                                                      .restaurantRate >
                                                  0
                                              ? Colors.blue
                                              : Colors.grey[300],
                                        ),
                                        Icon(
                                          size: 15,
                                          Icons.star,
                                          color: Restaurants()
                                                      .restaurant[index]
                                                      .restaurantRate >
                                                  1
                                              ? Colors.blue
                                              : Colors.grey[400],
                                        ),
                                        Icon(
                                          size: 15,
                                          Icons.star,
                                          color: Restaurants()
                                                      .restaurant[index]
                                                      .restaurantRate >
                                                  2
                                              ? Colors.blue
                                              : Colors.grey[400],
                                        ),
                                        Icon(
                                          size: 15,
                                          Icons.star,
                                          color: Restaurants()
                                                      .restaurant[index]
                                                      .restaurantRate >
                                                  3
                                              ? Colors.blue
                                              : Colors.grey[400],
                                        ),
                                        Icon(
                                          size: 15,
                                          Icons.star,
                                          color: Restaurants()
                                                      .restaurant[index]
                                                      .restaurantRate >
                                                  4
                                              ? Colors.blue
                                              : Colors.grey[400],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: SizedBox(
                                    height: 100,
                                    child: Image.network(
                                      Restaurants()
                                          .restaurant[index]
                                          .restaurantImage,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox(
                    height: 0,
                    width: 0,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
