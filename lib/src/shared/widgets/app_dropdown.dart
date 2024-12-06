import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class AppDropdown extends HookWidget {
  final String labelText;
  final List<String> items;
  final bool isActive;
  final String initialSelectedValue;
  final ValueChanged<String> onChanged;

  const AppDropdown({
    super.key,
    required this.labelText,
    required this.items,
    this.isActive = false,
    required this.initialSelectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final selectedValue = useState(initialSelectedValue);
    final active = useState<bool>(isActive);
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    useEffect(() {
      if (active.value) {
        controller.forward();
      } else {
        controller.reverse();
      }
      return null;
    }, [active.value]);

    void selectValue(String value) {
      selectedValue.value = value;
      active.value = !active.value;
      onChanged(value);
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            labelText,
            fontSize: 12,
          ),
          const SizedBox(height: 7),
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: BorderSide(
                color: theme.inversePrimary.withOpacity(.25),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            onTap: () {
              active.value = !active.value;
            },
            minVerticalPadding: 0,
            minLeadingWidth: 0,
            minTileHeight: 40,
            title: AppText(
              selectedValue.value,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: theme.onSurface,
            ),
            trailing: SvgAsset(arrowDown),
          ),
          const SizedBox(height: 7),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: active.value
                ? Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: theme.tertiary.withOpacity(.1),
                    ),
                    child: SizeTransition(
                      sizeFactor: controller,
                      axis: Axis.vertical,
                      child: Column(
                        children: items.map((item) {
                          return ListTile(
                            minVerticalPadding: 0,
                            minLeadingWidth: 0,
                            minTileHeight: 37,
                            hoverColor: theme.inversePrimary.withOpacity(.25),
                            onTap: () => selectValue(item),
                            title: AppText(
                              item,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: theme.inversePrimary,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
