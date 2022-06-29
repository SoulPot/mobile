# SoulPot Mobile App

## Installation

### Stores link
> App Store (iOS) [SoulPot](https://apps.apple.com/us/app/soulpot/id1631439638)

> Play Store (Android) [SoulPot](https://play.google.com/store/apps/details?id=com.sokaii.soulpot)

### From source code

> **Need Flutter SDK min 3.0.2** (see offcial [Flutter documentation](https://docs.flutter.dev/get-started/install))

1. Clone this repository: ``` git clone https://github.com/SoulPot/mobile SoulPot```
2. Go to the repo directory ``` cd SoulPot ```
3. Install flutter needed packages: ``` flutter pub get ```
4. Run the app directly: ``` flutter run --no-sound-null-safety ```

## Build to deploy

Run flutter command:
#### Android
Generate an app bundle to upload to the [Play Store Console](https://play.google.com/console)

``` flutter build appbundle --no-sound-null-safety ```

#### iOS:
Generate a ``` Runner .xcarchive ``` file to upload to [App Store Connect](https://appstoreconnect.apple.com)

``` flutter build ipa --no-sound-null-safety ```
