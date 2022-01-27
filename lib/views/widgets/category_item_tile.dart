import 'package:expanse_manager/app/extensions/color_extension.dart';
import 'package:expanse_manager/app/models/CategoryResponse.dart';
import 'package:flutter/material.dart';

class CategoryItemTile extends StatefulWidget {
  const CategoryItemTile({Key? key, required this.category}) : super(key: key);
  final Category category;
  @override
  State<CategoryItemTile> createState() => _CategoryItemTileState();
}

class _CategoryItemTileState extends State<CategoryItemTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.drawer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(widget.category.name.toString()),
      subtitle: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 3,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: widget.category.color != null
                  ? HexColor.fromHex(widget.category.color ?? "ffffff")
                  : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              widget.category.name ?? "",
              style: TextStyle(fontSize: 9),
            ),
          ),
        ],
      ),
    );
  }
}
