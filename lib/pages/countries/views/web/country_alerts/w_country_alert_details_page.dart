import 'package:country_repository/country_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/theme/app_colors.dart';

class WCountryAlertDetailsPage extends StatefulWidget {
  final Alert alert;

  const WCountryAlertDetailsPage({required this.alert, Key? key})
      : super(key: key);

  @override
  State<WCountryAlertDetailsPage> createState() =>
      _WCountryAlertDetailsPageState();
}

class _WCountryAlertDetailsPageState extends State<WCountryAlertDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Alert alert = widget.alert;
    String category;
    String type;
    if (alert.category != null) {
      category = alert.category!.join(',');
    } else {
      category = '';
    }
    if (alert.type != null) {
      type = alert.type!.join(',');
    } else {
      type = '';
    }
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              Text(category),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: getListTileWithWidget(
                        Row(
                          children: [
                            Checkbox(value: false, onChanged: (val) {}),
                            const Text('UFN'),
                            const Icon(Icons.info),
                          ],
                        ),
                        key: 'Flight Category',
                        value: category,
                        key2: 'Services',
                        value2: type,
                      ),
                    ),
                  ],
                ),
                getListTile(
                  key: 'Category',
                  value: 'No Data',
                ),
                getListTile(
                  key: 'Notes',
                  value: 'No Data',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getListTile({
    String key = '',
    String value = '',
    String key2 = '',
    String value2 = '',
  }) {
    return Row(
      children: [
        () {
          if (key.isNotEmpty) {
            return Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            key + ':',
                            style:
                                const TextStyle(color: AppColors.charcoalGrey),
                          ))),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(value,
                              style: const TextStyle(
                                  color: AppColors.brownGrey)))),
                ],
              ),
            );
          } else {
            return Expanded(child: Container());
          }
        }(),
        () {
          if (key2.isNotEmpty) {
            return Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            key2 + ':',
                            style:
                                const TextStyle(color: AppColors.charcoalGrey),
                          ))),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(value2,
                              style: const TextStyle(
                                  color: AppColors.brownGrey)))),
                ],
              ),
            );
          } else {
            return Expanded(child: Container());
          }
        }(),
        Expanded(child: Container())
      ],
    );
  }

  getListTileWithWidget(
    Widget widget, {
    String key = '',
    String value = '',
    String key2 = '',
    String value2 = '',
  }) {
    return Row(
      children: [
        () {
          if (key.isNotEmpty) {
            return Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            key + ':',
                            style:
                                const TextStyle(color: AppColors.charcoalGrey),
                          ))),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(value,
                              style: const TextStyle(
                                  color: AppColors.brownGrey)))),
                ],
              ),
            );
          } else {
            return Expanded(child: Container());
          }
        }(),
        () {
          if (key2.isNotEmpty) {
            return Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            key2 + ':',
                            style:
                                const TextStyle(color: AppColors.charcoalGrey),
                          ))),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(value2,
                              style: const TextStyle(
                                  color: AppColors.brownGrey)))),
                ],
              ),
            );
          } else {
            return Expanded(child: Container());
          }
        }(),
        Expanded(
            child: Row(
          children: [widget],
              mainAxisAlignment: MainAxisAlignment.center,
        ))
      ],
    );
  }
}
