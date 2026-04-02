import 'package:flutter/material.dart';
import 'package:geo_weather_logger_app/domain/settings_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Appearance',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),

          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: Text(
              settings.isDarkMode ? 'Dark theme active' : 'Light theme active',
            ),
            secondary: Icon(
              settings.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: colorScheme.primary,
            ),
            value: settings.isDarkMode,
            onChanged: (value) {
              settings.toggleTheme(value);
            },
          ),

          const Divider(height: 32),

          Text(
            'Display',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),

          SwitchListTile(
            title: const Text('Temperature Unit'),
            subtitle: Text(
              settings.isCelsius ? 'Celsius (°C)' : 'Fahrenheit (°F)',
            ),
            secondary: Icon(Icons.thermostat, color: colorScheme.primary),
            value: settings.isCelsius,
            onChanged: (value) {
              settings.toggleTemperatureUnit(value);
            },
          ),

          const Divider(height: 32),

          Text(
            'Data',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),

          ListTile(
            leading: const Icon(Icons.restore, color: Colors.red),
            title: const Text(
              'Reset All Settings',
              style: TextStyle(color: Colors.red),
            ),
            subtitle: const Text('Restore all settings to their defaults'),
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Reset Settings?'),
                  content: const Text(
                    'This will reset all settings to their default values. '
                    'Dark mode will be turned off, temperature unit will '
                    'revert to Celsius, and the layout will return to grid view.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        settings.resetAllSettings();
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Settings have been reset'),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
