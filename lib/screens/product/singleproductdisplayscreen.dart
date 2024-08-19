import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../components/badroute.dart';
import '../../components/customtitle.dart';
import '../../components/myappdrawer.dart';
import '../../models/productcar.dart';
import '../../models/user.dart';

class SingleProductDisplayScreen extends StatefulWidget {
  const SingleProductDisplayScreen({super.key});

  @override
  State<SingleProductDisplayScreen> createState() =>
      _SingleProductDisplayScreenState();
}

class _SingleProductDisplayScreenState
    extends State<SingleProductDisplayScreen> {
  User? currentUser;
  String? imageAvailable = '';
  final bool _isLoading = false;
  String? image = '';

  @override
  void initState() {
    try {
      currentUser = Provider.of<User>(context, listen: false).users.last;
      print(Provider.of<User>(context, listen: false).users.length);
    } catch (e) {
      print(e.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return currentUser == null
        ? const BadRoute()
        : _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const CustomTitle(
                    color: Colors.deepPurpleAccent,
                  ),
                  actions: [
                    Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context); // Navigate back
                          },
                        );
                      },
                    ),
                  ],
                ),
                drawer: Drawer(
                  child: MyAppDrawer(
                      imageAvailable: imageAvailable,
                      currentUser: currentUser,
                      mounted: mounted),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Provider.of<ProductCar>(context, listen: false)
                            .productCars[(ModalRoute.of(context)!
                                .settings
                                .arguments as int)]
                            .carName,
                        style: GoogleFonts.roboto(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          label: const Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("add to cart"),
                              Icon(Icons.add_shopping_cart)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          child: Image.network(
                              Provider.of<ProductCar>(context, listen: false)
                                  .productCars[(ModalRoute.of(context)!
                                      .settings
                                      .arguments as int)]
                                  .carImage),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Description",
                          style: GoogleFonts.roboto(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          Provider.of<ProductCar>(context, listen: false)
                              .productCars[(ModalRoute.of(context)!
                                  .settings
                                  .arguments as int)]
                              .description,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Price",
                          style: GoogleFonts.roboto(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          Provider.of<ProductCar>(context, listen: false)
                              .productCars[(ModalRoute.of(context)!
                                  .settings
                                  .arguments as int)]
                              .price
                              .toString(),
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Rent per hour",
                          style: GoogleFonts.roboto(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          Provider.of<ProductCar>(context, listen: false)
                              .productCars[(ModalRoute.of(context)!
                                  .settings
                                  .arguments as int)]
                              .rentPerHr
                              .toString(),
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Manufacturer",
                          style: GoogleFonts.roboto(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          Provider.of<ProductCar>(context, listen: false)
                              .productCars[(ModalRoute.of(context)!
                                  .settings
                                  .arguments as int)]
                              .manufacturer,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Status",
                          style: GoogleFonts.roboto(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          Provider.of<ProductCar>(context, listen: false)
                              .productCars[(ModalRoute.of(context)!
                                  .settings
                                  .arguments as int)]
                              .status,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Type of car",
                          style: GoogleFonts.roboto(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          Provider.of<ProductCar>(context, listen: false)
                              .productCars[(ModalRoute.of(context)!
                                  .settings
                                  .arguments as int)]
                              .carType,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Fuel",
                          style: GoogleFonts.roboto(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          Provider.of<ProductCar>(context, listen: false)
                              .productCars[(ModalRoute.of(context)!
                                  .settings
                                  .arguments as int)]
                              .fuelType,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Type of engine",
                          style: GoogleFonts.roboto(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          Provider.of<ProductCar>(context, listen: false)
                              .productCars[(ModalRoute.of(context)!
                                  .settings
                                  .arguments as int)]
                              .engineType,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Engine cc",
                          style: GoogleFonts.roboto(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          Provider.of<ProductCar>(context, listen: false)
                              .productCars[(ModalRoute.of(context)!
                                  .settings
                                  .arguments as int)]
                              .engineCC
                              .toString(),
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}
