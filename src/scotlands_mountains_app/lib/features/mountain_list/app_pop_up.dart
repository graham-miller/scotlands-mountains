import 'package:flutter/material.dart';

class AppPopUp {
  static open(
      {required String title,
      required String content,
      required BuildContext context,
      String? actionLabel,
      Function? action,
      Duration duration = const Duration(seconds: 4)}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
              ),
            ),
            Text(
              content,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                action == null
                    ? FilledButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).clearSnackBars();
                        },
                        child: const Text('Close'),
                      )
                    : TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).clearSnackBars();
                        },
                        child: const Text('Close'),
                      ),
                action == null
                    ? const SizedBox.shrink()
                    : FilledButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          action();
                        },
                        child: Text(actionLabel!),
                      )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
