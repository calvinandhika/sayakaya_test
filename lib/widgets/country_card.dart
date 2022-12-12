import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sayakaya_test/const/colors.dart';
import 'package:sayakaya_test/const/router.dart';
import 'package:sayakaya_test/models/country_model.dart';
import 'package:sayakaya_test/screens/country_detail_screen.dart';

class CountryCard extends StatelessWidget {
  final CountryModelData countryData;

  const CountryCard({super.key, required this.countryData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('$countryRoute/${countryData.country}');
        // context.read
      },
      child: Card(
        color: kBlueColor,
        child: SizedBox(
          width: double.infinity,
          height: 120,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: CachedNetworkImage(
                    imageUrl: countryData.countryInfo.flag,
                    progressIndicatorBuilder: (context, url, progress) {
                      return const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          countryData.country,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          countryData.continent,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Long: ${countryData.countryInfo.long.toString()}',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Lat: ${countryData.countryInfo.lat.toString()}',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Today\'s Cases:\n${NumberFormat.decimalPattern().format(countryData.result.todayCases)}',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Active:\n${NumberFormat.decimalPattern().format(countryData.result.active)}',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
