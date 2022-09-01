import 'package:flutter/material.dart';
import 'package:gtm/pages/manage_trip/view/web/schedule/models/typedef_remove.dart';

class ListModel<Schedule> {
  ListModel({
    required this.listKey,
    required this.removedItemBuilder,
    Iterable<Schedule>? initialItems,
  }) : _items = List<Schedule>.from(initialItems ?? <Schedule>[]);

  final GlobalKey<AnimatedListState> listKey;
  final RemovedItemBuilder<Schedule> removedItemBuilder;
  final List<Schedule> _items;

  AnimatedListState? get _animatedList => listKey.currentState;

  void insert(int index, Schedule item) {
    _items.insert(index, item);
    _animatedList!.insertItem(index);
  }

  Schedule removeAt(int index) {
    final Schedule removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList!.removeItem(
        index,
        (BuildContext context, Animation<double> animation) {
          return removedItemBuilder(
            removedItem,
            context,
            animation,
            index,
          );
        },
      );
    }
    return removedItem;
  }

  List<Schedule> get list => _items;

  int get length => _items.length;

  Schedule operator [](int index) => _items[index];

  int indexOf(Schedule item) => _items.indexOf(item);
}
