import 'package:craftybay/presentation/ui/utility/color_palette.dart';
import 'package:flutter/material.dart';

class sizePicker extends StatefulWidget {
  const sizePicker({Key? key, required this.sizes, required this.onSelected, required this.initialSelected}) : super(key: key);

  final List<String> sizes;
  final Function(int selected) onSelected;
  final int initialSelected;

  @override
  State<sizePicker> createState() => _sizePickerState();
}

class _sizePickerState extends State<sizePicker> {
  int _selectedSizeIndex = 0;

  @override
  void initState() {
    _selectedSizeIndex = widget.initialSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: widget.sizes.length,
      itemBuilder: (context,index){
        return InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: (){
              _selectedSizeIndex = index;
              widget.onSelected(index);
              if(mounted){
                setState(() {
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                  color: _selectedSizeIndex == index ? AppColors.primaryColor : null
              ),
              alignment: Alignment.center,
              child: Text(widget.sizes[index]),
            )
        );
      }, separatorBuilder: (BuildContext context, int index) {
      return const SizedBox(width: 8);
    },);
  }
}