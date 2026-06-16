import 'package:O2morny/shared/models/app_colors.dart';
import 'package:flutter/material.dart';

class AppDropDownField<T> extends StatefulWidget {
  final T? selected;
  final List<T> lst;
  final ValueChanged<T> onSelect;

  final String Function(T item) displayText;
  final Object? Function(T item) value;

  final String hint;
  final String? Function(T?)? onValidated;

  const AppDropDownField({
    super.key,
    required this.selected,
    required this.lst,
    required this.onSelect,
    required this.displayText,
    required this.value,
    this.hint = "Select Item",
    required this.onValidated,
  });

  @override
  State<AppDropDownField<T>> createState() => AppDropDownFieldState<T>();
}

class AppDropDownFieldState<T> extends State<AppDropDownField<T>> {
  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: widget.selected,
      validator: widget.onValidated,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: widget.lst.isEmpty
                  ? null
                  : () async {
                      showBottomSheet(
                        context,
                        onItemSelected: (item) {
                          field.didChange(item);
                          widget.onSelect(item);
                        },
                      );
                    },
              child: Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: field.hasError ? Colors.red : AppColors.PrimaryBlue,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.selected == null
                            ? (widget.lst.isEmpty ? "Loading..." : widget.hint)
                            : widget.displayText(widget.selected!),
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),

            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 6),
                child: Text(
                  field.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }

  void showBottomSheet(
    BuildContext context, {
    required ValueChanged<T> onItemSelected,
  }) {
    final searchController = TextEditingController();

    List<T> filtered = List.from(widget.lst);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search...",
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.PrimaryBlue,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        labelStyle: const TextStyle(
                          color: AppColors.PrimaryBlue,
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: AppColors.PrimaryBlue,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: AppColors.PrimaryGold,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setModalState(() {
                          filtered = widget.lst.where((item) {
                            return widget
                                .displayText(item)
                                .toLowerCase()
                                .contains(value.toLowerCase());
                          }).toList();
                        });
                      },
                    ),
                  ),

                  Expanded(
                    child: ListView.separated(
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (_, index) {
                        final item = filtered[index];

                        final isSelected =
                            widget.selected != null &&
                            widget.value(widget.selected!) ==
                                widget.value(item);

                        return ListTile(
                          leading: CircleAvatar(
                            radius: 18,
                            child: Text(
                              widget
                                  .displayText(item)
                                  .substring(0, 1)
                                  .toUpperCase(),
                            ),
                          ),
                          title: Text(
                            widget.displayText(item),
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : null,
                          onTap: () {
                            Navigator.pop(context);
                            onItemSelected(item);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
