import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class MCompanyProfileFlightCategory extends StatelessWidget {
  const MCompanyProfileFlightCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: getButton(),
        body: SingleChildScrollView(
            child: Card(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
              SizedBox(
                height: 300,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.search),
                              ),
                              controller: TextEditingController()
                                ..text = 'Search',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {}, child: const Text('Add')),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.cancel_outlined),
                        ),
                        controller: TextEditingController()
                          ..text = 'State/Military',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.cancel_outlined),
                        ),
                        controller: TextEditingController()
                          ..text = 'Private NonRevenue Part91',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.cancel_outlined),
                        ),
                        controller: TextEditingController()
                          ..text = 'Non Scheduled Commercial Part135',
                      ),
                    ),
                  ],
                ),
              )
            ]))));
  }

  getButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(spacing8),
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.powderBlue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(spacing6),
                )),
                minimumSize: MaterialStateProperty.all<Size?>(
                    const Size(spacing128, spacing48)),
              ),
              onPressed: () {},
              child: const Text(cancel)),
        ),
        Padding(
          padding: const EdgeInsets.all(spacing8),
          child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(spacing6),
                )),
                minimumSize: MaterialStateProperty.all<Size?>(
                    const Size(spacing128, spacing48)),
              ),
              onPressed: () {},
              child: const Text('Save')),
        )
      ],
    );
  }
}
