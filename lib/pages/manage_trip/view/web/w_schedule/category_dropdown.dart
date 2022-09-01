import 'package:flight_category_repository/flight_category_repository.dart';
import 'package:flutter/material.dart';

class CategoryDropdown extends StatefulWidget {
  final String customerId;
  final int? categoryId;
  final Function selectedItemHandler;
  const CategoryDropdown(
      {required this.customerId,
      this.categoryId,
      required this.selectedItemHandler,
      Key? key})
      : super(key: key);

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  late List<FlightCategory> _categories = <FlightCategory>[];
  FlightCategory? _selectedCategory;

  @override
  void didChangeDependencies() {
    // _tripDetail = widget.tripDetail;
    _loadData();
    super.didChangeDependencies();
  }

  _loadData() async {
    _categories = await FlightCategoryRepository()
        .getFlightCategories(customerId: widget.customerId);
    setState(() {});
    if (widget.categoryId != null) {
      var index = _categories.indexWhere(
          (element) => element.flightCategoryId == widget.categoryId);
      //("${widget.categoryId} ===  $index");
      _selectedCategory = _categories[index];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // if (_categories.isEmpty) return Container();
    return DropdownButton<FlightCategory>(
      isExpanded: true,
      underline: const SizedBox(),
      style: const TextStyle(overflow: TextOverflow.ellipsis),
      icon: const Icon(Icons.expand_more_rounded),
      hint: const Text("Select Category"),
      items: _categories.map((item) {
        return DropdownMenuItem<FlightCategory>(
          child: Wrap(
            children: [
              Text(item.category),
            ],
          ),
          value: item,
        );
      }).toList(),
      value: _selectedCategory,
      onChanged: (value) {
        _selectedCategory = value!;
        setState(() {});
        widget.selectedItemHandler(value);
      },
    );
  }
}
