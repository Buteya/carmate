import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../components/badroute.dart';
import '../../components/customtitle.dart';
import '../../components/myappdrawer.dart';
import '../../models/productcar.dart';
import '../../models/user.dart';

class ProductDisplayMainScreen extends StatefulWidget {
  const ProductDisplayMainScreen({super.key});

  @override
  State<ProductDisplayMainScreen> createState() =>
      _ProductDisplayMainScreenState();
}

class _ProductDisplayMainScreenState extends State<ProductDisplayMainScreen> {
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
            : DefaultTabController(
              length: 2,
              child: Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: const CustomTitle(
                      color: Colors.deepPurpleAccent,
                    ),
                    bottom: const TabBar(
                      tabs: [
                        Tab(icon: Icon(Icons.car_rental_sharp)),
                        Tab(icon: Icon(Icons.shopping_cart)),
                      ],
                    ),
                  ),
                  drawer: Drawer(
                    child: MyAppDrawer(
                        imageAvailable: imageAvailable,
                        currentUser: currentUser,
                        mounted: mounted),
                  ),
                  body: TabBarView(
                    children: [
                      //tabview 1
                      SingleChildScrollView(
                        child: Consumer<ProductCar>(
                            builder: (context, car, productCarIndex) {
                          return SizedBox(
                            height: 690,
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Two products per row
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                itemCount: car.productCars.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: (){
                                      if(mounted){
                                        Navigator.pushNamed(context, '/singleproductdisplay',arguments: index);
                                      }
                                    },
                                    child: Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ClipRRect(
                                            borderRadius: const BorderRadius.vertical(
                                              top: Radius.circular(12.0),
                                            ), // Adjust the radius as needed
                                            child: Image.network(
                                              car.productCars[index].carImage,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Text(
                                            car.productCars[index].carName,
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'KSH ${NumberFormat.decimalPatternDigits(
                                              locale:
                                                  'en_US', // Specify the desired locale
                                              // decimalDigits:
                                              //     2, // Set the number of decimal places
                                            ).format(
                                              car.productCars[index].price,
                                            )}',
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          );
                        }),
                      ),
                      //tabview 2
                      const Text('No orders yet')
                    ],
                  ),
                ),
            );
  }
}
