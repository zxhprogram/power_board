import 'package:flutter/material.dart'
    hide Colors, Form, showDialog, AlertDialog, FormField, TextField, Theme;
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:power_app/api/GithubApi.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart'
    show
        Colors,
        TextExtension,
        FormController,
        Gap,
        FormTableLayout,
        KeyboardDisplay,
        Icons,
        IconExtension,
        FormKey,
        TextField,
        WidgetExtension,
        PrimaryButton,
        AlertDialog,
        showDialog,
        OutlineButton,
        ButtonDensity,
        GhostButton,
        Form,
        FormField,
        Theme;

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: Colors.white,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: .all(.circular(25))),
                  clipBehavior: .hardEdge,
                  child: Image.asset('assets/imgs/power-logo.png'),
                ),
                Text(
                  'Power App',
                  style: TextStyle(color: Colors.blue),
                ).h3.semiBold.italic,
              ],
            ),
            Row(
              children: [
                OutlineButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        final FormController controller = FormController();
                        return AlertDialog(
                          title: const Text('Edit profile'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Make changes to your profile here. Click save when you\'re done',
                              ),
                              const Gap(16),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 400,
                                ),
                                child: Form(
                                  controller: controller,
                                  child: const FormTableLayout(
                                    rows: [
                                      FormField<String>(
                                        key: FormKey(#name),
                                        label: Text('Name'),
                                        child: TextField(
                                          initialValue:
                                              'Thito Yalasatria Sunarya',
                                          autofocus: true,
                                        ),
                                      ),
                                      FormField<String>(
                                        key: FormKey(#username),
                                        label: Text('Username'),
                                        child: TextField(
                                          initialValue: '@sunaryathito',
                                        ),
                                      ),
                                    ],
                                  ),
                                ).withPadding(vertical: 16),
                              ),
                            ],
                          ),
                          actions: [
                            PrimaryButton(
                              child: const Text('Save changes'),
                              onPressed: () {
                                // Return the form values and close the dialog.
                                Navigator.of(context).pop(controller.values);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  trailing: const Icon(
                    Icons.search,
                  ).iconSmall().iconMutedForeground(),
                  child: Row(
                    spacing: 16,
                    children: [
                      const Text('Search documentation...').muted().normal(),
                      const KeyboardDisplay.fromActivator(
                        activator: SingleActivator(
                          LogicalKeyboardKey.keyF,
                          control: true,
                        ),
                      ).xSmall.withOpacity(0.8),
                    ],
                  ),
                ),

                GhostButton(
                  density: ButtonDensity.icon,
                  onPressed: () {
                    GithubApi.fetch();
                  },
                  child: FaIcon(
                    FontAwesomeIcons.envelope,
                    color: theme.colorScheme.secondaryForeground,
                  ).iconLarge(),
                ),

                GhostButton(
                  density: ButtonDensity.icon,
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    }
                  },
                  child: FaIcon(
                    FontAwesomeIcons.userGear,
                    color: theme.colorScheme.secondaryForeground,
                  ).iconLarge(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
