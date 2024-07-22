import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BadRoute extends StatefulWidget {
  const BadRoute({
    super.key,
  });

  @override
  State<BadRoute> createState() => _BadRouteState();
}

class _BadRouteState extends State<BadRoute> {
  bool _isLoading = false;

  @override
  void initState() {
    executeAfterDelay();
    super.initState();
  }

  Future<void> executeAfterDelay() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    // Your code here (e.g., UI updates, data processing)

    if (mounted) {
      Navigator.pushReplacementNamed(context, '/signup');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Scaffold(
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('...redirecting to signup'),
                  SizedBox(
                    width: 10,
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          )
        : Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '404',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      color: Colors.deepPurple,
                    ),
                  ),
                  Text(
                    "user not found!!!",
                    style: GoogleFonts.roboto(
                      fontSize: 17,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
