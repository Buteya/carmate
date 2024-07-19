import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BadRoute extends StatelessWidget {
  const BadRoute({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
