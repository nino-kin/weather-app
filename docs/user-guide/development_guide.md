# Development Guide

## Quick Links

- [LottieFiles](https://app.lottiefiles.com/?utm_medium=web&utm_source=getting-started)

## Adding a package dependency to an app

### Case 1: Define packages in pubspec.yaml

For example, if you want to install the `css_colors` package, you need to define it in pubspec.yaml.

1. Depend on it
  - Open the `pubspec.yaml` file located inside the app folder, and add `css_colors`: under `dependencies`.
2. Install it
  - From the terminal: Run `flutter pub get`.
3. Import it
  - Add a corresponding import statement in the Dart code.
4. Stop and restart the app, if necessary
  - If the package brings platform-specific code (Kotlin/Java for Android, Swift/Objective-C for iOS), that code must be built into your app. Hot reload and hot restart only update the Dart code, so a full restart of the app might be required to avoid errors like MissingPluginException when using the package.

### Case 2: Using `flutter pub add`

```bash
flutter pub add
```

This command adds the specified packages to the pubspec.yaml as dependencies, and then retrieves the dependencies to resolve pubspec.yaml.

For example:

```bash
flutter pub add http
flutter pub add geolocator
flutter pub add geocoding
flutter pub add lottie
```

You can find the following packages in the pubspec.yaml.

```yaml
dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.2
  http: ^1.1.0
  geolocator: ^10.1.0
  geocoding: ^2.1.1
  lottie: ^2.6.0
```

If you want to remove a specified package, you can use the following command:

```bash
flutter pub remove <package name>
```

For example,

```bash
flutter pub remove css_colors
```
