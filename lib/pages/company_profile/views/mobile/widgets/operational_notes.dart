import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gtm/_shared/shared.dart';

class MCompanyProfileOperationalNotes extends StatelessWidget {
  const MCompanyProfileOperationalNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getButton(),
      body: SingleChildScrollView(
          child: SizedBox(
        height: 2500,
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Search', prefixIcon: Icon(Icons.search)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    ElevatedButton(onPressed: () {}, child: const Text('Add')),
              )
            ],
          ),
          Container(
            height: spacing44,
            color: AppColors.defaultColor,
            child: Row(children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Dep Flight Following',
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const MCompanyProfilePage()),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(AppImages.editPersonDetails),
                ),
              ),
              const Icon(
                Icons.expand_less,
                color: Colors.white,
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightBlueGrey,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(4)),
                      height: 48,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Always send movement on time to the customer'),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text('Add')),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            height: spacing44,
            color: AppColors.defaultColor,
            child: Row(children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Dep Flight Following',
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const MCompanyProfilePage()),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(AppImages.editPersonDetails),
                ),
              ),
              const Icon(
                Icons.expand_less,
                color: Colors.white,
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightBlueGrey,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(4)),
                      height: 48,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Always send movement on time to the customer'),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text('Add')),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            height: spacing44,
            color: AppColors.defaultColor,
            child: Row(children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Dep Flight Following',
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const MCompanyProfilePage()),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(AppImages.editPersonDetails),
                ),
              ),
              const Icon(
                Icons.expand_less,
                color: Colors.white,
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightBlueGrey,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(4)),
                      height: 48,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Always send movement on time to the customer'),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text('Add')),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            height: spacing44,
            color: AppColors.defaultColor,
            child: Row(children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Dep Flight Following',
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const MCompanyProfilePage()),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(AppImages.editPersonDetails),
                ),
              ),
              const Icon(
                Icons.expand_less,
                color: Colors.white,
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightBlueGrey,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(4)),
                      height: 48,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Always send movement on time to the customer'),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text('Add')),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            height: spacing44,
            color: AppColors.defaultColor,
            child: Row(children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Dep Flight Following',
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const MCompanyProfilePage()),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(AppImages.editPersonDetails),
                ),
              ),
              const Icon(
                Icons.expand_less,
                color: Colors.white,
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightBlueGrey,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(4)),
                      height: 48,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Always send movement on time to the customer'),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text('Add')),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            height: spacing44,
            color: AppColors.defaultColor,
            child: Row(children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Dep Flight Following',
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const MCompanyProfilePage()),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(AppImages.editPersonDetails),
                ),
              ),
              const Icon(
                Icons.expand_less,
                color: Colors.white,
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightBlueGrey,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(4)),
                      height: 48,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Always send movement on time to the customer'),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text('Add')),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ]),
      )),
    );
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
