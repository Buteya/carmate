import 'package:carmate/components/forminput.dart';
import 'package:carmate/models/productcar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../components/badroute.dart';
import '../../components/customtitle.dart';
import '../../components/myappdrawer.dart';
import '../../models/user.dart';

class CreateProductCarScreen extends StatefulWidget {
  const CreateProductCarScreen({super.key});

  @override
  State<CreateProductCarScreen> createState() => _CreateProductCarScreenState();
}

class _CreateProductCarScreenState extends State<CreateProductCarScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _carManufacturerController =
      TextEditingController();
  final TextEditingController _carNameController = TextEditingController();
  final TextEditingController _engineTypeController = TextEditingController();
  final TextEditingController _carEngineCCController = TextEditingController();
  final TextEditingController _carFuelTypeController = TextEditingController();
  final TextEditingController _carMileageController = TextEditingController();
  final TextEditingController _carPriceController = TextEditingController();
  final TextEditingController _carRentPerHrController = TextEditingController();
  final TextEditingController _carTypeController = TextEditingController();
  final TextEditingController _carDescriptionController =
      TextEditingController();
  final TextEditingController _yearOfManufactureController =
      TextEditingController();
  final TextEditingController _chasisNumberController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  String? imageAvailable;
  String? carImage = '';
  User? currentUser;
  bool _isLoading = false;
  bool _carImagePicked = true;
  final uuid = const Uuid();

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    try {
      currentUser = Provider.of<User>(context, listen: false).users.last;
      imageAvailable = currentUser?.imageUrl;
      print(currentUser?.username);
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      _isLoading = false;
    });
    super.initState();
  }

  @override
  void dispose() {
    _carManufacturerController.dispose();
    _carNameController.dispose();
    _engineTypeController.dispose();
    _carEngineCCController.dispose();
    _carFuelTypeController.dispose();
    _carMileageController.dispose();
    _carPriceController.dispose();
    _carRentPerHrController.dispose();
    _carTypeController.dispose();
    _carDescriptionController.dispose();
    _yearOfManufactureController.dispose();
    _chasisNumberController.dispose();
    _statusController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _addProductCar() {
    final carProducts = Provider.of<ProductCar>(context, listen: false);
    final id = uuid.v4();
    if (currentUser?.id != null) {
      carProducts.add(
        ProductCar(
          carImage: carImage!,
          userId: currentUser!.id,
          id: id,
          manufacturer: _carManufacturerController.text,
          carName: _carNameController.text,
          engineType: _engineTypeController.text,
          engineCC: _carEngineCCController.text,
          fuelType: _carFuelTypeController.text,
          mileage: _carMileageController.text,
          price: int.tryParse(_carPriceController.text)!,
          rentPerHr: int.tryParse(_carRentPerHrController.text)!,
          carType: _carTypeController.text,
          description: _carDescriptionController.text,
          yearOfManufacture: _yearOfManufactureController.text,
          status: _statusController.text,
          quantity: int.tryParse(_quantityController.text)!,
          chasisNumber: _chasisNumberController.text,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.deepPurple,
          content: Text(
            'Product $id has been added successfully!!!',
            style: GoogleFonts.roboto(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ),
      );
      setState(() {
        carImage = '';
      });
    } else {
      print('no current user');
    }
    for (final product in carProducts.productCars) {
      print(product.id);
      print(product.userId);
      print(product.carImage);
      print(product.description);
      print(product.price);
      print(product.rentPerHr);
      print(product.yearOfManufacture);
    }
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
                ),
                drawer: Drawer(
                  child: MyAppDrawer(
                    imageAvailable: imageAvailable,
                    currentUser: currentUser,
                    mounted: mounted,
                  ),
                ),
                body: SingleChildScrollView(
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Add Product Car',
                            style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.displayLarge,
                              fontSize: 48,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Create a new car product, with the required details captured. '
                            'Ensuring all the fields are filled and with the proper appropriate details.',
                            style: GoogleFonts.roboto(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Card(
                            child: carImage!.isEmpty
                                ? const Icon(
                                    Icons.image_rounded,
                                    size: 60,
                                  )
                                : ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0),
                                    ),
                                    child: Image.network(carImage!)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final pickedImage = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (pickedImage != null) {
                                setState(() {
                                  print(pickedImage.name);
                                  print(pickedImage.path);
                                  carImage = pickedImage.path;
                                  print(carImage);
                                });
                                for (final user in currentUser!.users) {
                                  print('image ${user.imageUrl}');
                                }
                              } else {
                                // Handle the case where the user canceled image selection
                                // (e.g., show a message or revert to a default image)
                              }
                            },
                            label: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("pick Image"),
                                Icon(Icons.camera),
                              ],
                            ),
                          ),
                        ),
                        _carImagePicked == false
                            ? const Text(
                                'please pick car image',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              )
                            : const SizedBox(),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              child: Container(
                                margin: const EdgeInsets.all(30.0),
                                child: Column(
                                  children: [
                                    FormInput(
                                      onChangedFunction: (value) =>
                                      _statusController.text =
                                      value!,
                                      labelText: 'Status',
                                      hintText:
                                      'Enter car status, e.g in-stock',
                                      validationFunction: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "please enter car status";
                                        }
                                        return null;
                                      },
                                      obscureText: false,
                                    ),
                                    FormInput(
                                      onChangedFunction: (value) =>
                                      _chasisNumberController.text =
                                      value!,
                                      labelText: 'Chasis Number',
                                      hintText:
                                      'Enter car chasis number',
                                      validationFunction: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "please enter car chasis number";
                                        }
                                        return null;
                                      },
                                      obscureText: false,
                                    ),
                                    FormInput(
                                      onChangedFunction: (value) =>
                                      _quantityController.text =
                                      value!,
                                      labelText: 'Quantity',
                                      hintText:
                                      'Enter number of cars, e.g 1',
                                      validationFunction: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "please enter number of cars";
                                        }
                                        return null;
                                      },
                                      obscureText: false,
                                    ),
                                    FormInput(
                                      onChangedFunction: (value) =>
                                          _yearOfManufactureController.text =
                                              value!,
                                      labelText: 'Year Of Manufacturer',
                                      hintText:
                                          'Enter car year of manufacturer, e.g 2007',
                                      validationFunction: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "please enter year of car manufacturer";
                                        } else if (value.length > 4) {
                                          return "Year cannot have 5 characters";
                                        }
                                        return null;
                                      },
                                      obscureText: false,
                                    ),
                                    FormInput(
                                      onChangedFunction: (value) =>
                                          _carManufacturerController.text =
                                              value!,
                                      labelText: 'Manufacturer',
                                      hintText:
                                          'Enter car manufacturer name,e.g Toyota',
                                      validationFunction: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "please enter car manufacturer name";
                                        } else if (value.length > 15) {
                                          return 'Manufacturer`s name is limited to 15 characters';
                                        }
                                        return null;
                                      },
                                      obscureText: false,
                                    ),
                                    FormInput(
                                      onChangedFunction: (value) =>
                                          _carNameController.text = value!,
                                      labelText: 'Car Name',
                                      hintText:
                                          'Enter name of the car,e.g Impreza',
                                      validationFunction: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "please enter name of the car";
                                        } else if (value.length > 15) {
                                          return 'Car name is limited to 15 characters';
                                        }
                                        return null;
                                      },
                                      obscureText: false,
                                    ),
                                    FormInput(
                                      onChangedFunction: (value) =>
                                          _engineTypeController.text = value!,
                                      labelText: 'Engine type',
                                      hintText:
                                          'Enter the type of engine, eg.v6',
                                      validationFunction: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "please enter the type of engine";
                                        } else if (value.length > 6) {
                                          return 'Engine type is limited to 6 characters';
                                        }
                                        return null;
                                      },
                                      obscureText: false,
                                    ),
                                    FormInput(
                                      onChangedFunction: (value) =>
                                          _carEngineCCController.text = value!,
                                      labelText: 'Engine CC',
                                      hintText:
                                          'Enter the car engine in cc, e.g 2500cc',
                                      validationFunction: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "please enter the car engine cc";
                                        } else if (value.length > 6) {
                                          return 'Engine cc characters are limited to 6';
                                        }
                                        return null;
                                      },
                                      obscureText: false,
                                    ),
                                    FormInput(
                                      onChangedFunction: (value) =>
                                          _carFuelTypeController.text = value!,
                                      labelText: 'Fuel Type',
                                      hintText: 'Enter car fuel type,eg.petrol',
                                      validationFunction: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "please enter car fuel type";
                                        }
                                        return null;
                                      },
                                      obscureText: false,
                                    ),
                                    FormInput(
                                      onChangedFunction: (value) =>
                                          _carMileageController.text = value!,
                                      labelText: 'Mileage',
                                      hintText: 'Enter car mileage,e.g 30000km',
                                      validationFunction: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "please enter car mileage";
                                        }
                                        return null;
                                      },
                                      obscureText: false,
                                    ),
                                    FormInput(
                                      onChangedFunction: (value) =>
                                          _carPriceController.text = value!,
                                      labelText: 'Price',
                                      hintText: 'Enter car price, eg 1000000',
                                      validationFunction: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "please enter car price";
                                        }
                                        return null;
                                      },
                                      obscureText: false,
                                    ),
                                    FormInput(
                                      onChangedFunction: (value) =>
                                          _carRentPerHrController.text = value!,
                                      labelText: 'Rent Per Hr',
                                      hintText: 'Enter car rent per hr,e.g 500',
                                      validationFunction: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "please enter car rent per hr";
                                        }
                                        return null;
                                      },
                                      obscureText: false,
                                    ),
                                    FormInput(
                                      onChangedFunction: (value) =>
                                          _carTypeController.text = value!,
                                      labelText: 'Car Type',
                                      hintText: 'Enter car type, e.g Sedan',
                                      validationFunction: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "please enter car type";
                                        }
                                        return null;
                                      },
                                      obscureText: false,
                                    ),
                                    TextFormField(
                                      maxLines: null,
                                      onChanged: (value) =>
                                          _carDescriptionController.text =
                                              value,
                                      decoration: const InputDecoration(
                                        labelText: 'Description',
                                        hintText:
                                            'Enter car description, e.g A good car: Reliable, efficient, safe, comfortable, stylish, and fun. 🚗',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "please enter car description";
                                        } else if (value.length > 240) {
                                          return 'Description is limited to 240 characters';
                                        }
                                        return null;
                                      },
                                      obscureText: false,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            // Validate will return true if the form is valid, or false if
                                            // the form is invalid.
                                            if (_formKey.currentState!
                                                    .validate() &&
                                                carImage!.isNotEmpty) {
                                              setState(() {
                                                _carImagePicked = true;
                                              });
                                              _addProductCar();
                                              _formKey.currentState?.reset();
                                            } else {
                                              setState(() {
                                                _carImagePicked = false;
                                              });
                                            }
                                          },
                                          child:
                                              const Text("Create Product Car")),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }
}
