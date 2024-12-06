import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });
  final String icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      decoration: const BoxDecoration(
        color: Color(0XFF22699D),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(
              icon,
              height: 47,
              width: 47,
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: GoogleFonts.ubuntu(
                color: const Color(0XFFFFFFFF),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.ubuntu(
                color: const Color(0XFF87C1EB),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
