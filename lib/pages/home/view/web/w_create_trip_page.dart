import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gtm/theme/app_colors.dart';
import 'package:gtm/_shared/widgets/_common/components.dart';

class CreateTripPage extends StatelessWidget {
  const CreateTripPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87.withOpacity(0.3),
        body: Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * .4,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300, minWidth: 200),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 100,
                                  decoration: const BoxDecoration(color: AppColors.defaultColor),
                                ),
                                const Padding(
                                  padding: paddingLarge,
                                  child: Text('Create Trip'),
                                ),
                                // const Spacer(),
                                InkWell(
                                  child: const Padding(
                                    padding: paddingLarge,
                                    child: Icon(Icons.cancel),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                            // Center(
                            //   child: Text('Frosted', style: Theme.of(context).textTheme.bodyMedium),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ))));
  }
}
