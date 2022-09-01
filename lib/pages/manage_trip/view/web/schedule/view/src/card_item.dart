import 'package:flutter/material.dart';
import 'package:gtm/pages/manage_trip/view/web/schedule/models/schedule.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    this.onBeforeAdd,
    this.onAfterAdd,
    this.selected = false,
    required this.animation,
    required this.item,
    this.onRemove,
    required this.index,
  }) : super(key: key);

  final Animation<double> animation;
  final VoidCallback? onBeforeAdd;
  final VoidCallback? onAfterAdd;
  final Schedule item;
  final bool selected;
  final VoidCallback? onRemove;
  final int index;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline4!;
    if (selected) {
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    }
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizeTransition(
        sizeFactor: animation,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 80.0,
                child: Card(
                  //   color: Colors.primaries[item % Colors.primaries.length],
                  child: Center(
                    child: Column(
                      children: [],
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: onBeforeAdd,
              icon: Icon(Icons.add),
              label: const Text('Before Seq'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: onRemove,
                icon: Icon(Icons.delete),
                label: const Text('Delete'),
              ),
            ),
            ElevatedButton.icon(
              onPressed: onAfterAdd,
              icon: Icon(Icons.add),
              label: const Text('After Seq'),
            ),
          ],
        ),
      ),
    );
  }
}
