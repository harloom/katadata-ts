flutter pub get

run-prod:
	flutter run --flavor production -t lib/main.dart

run-dev:
	flutter run --flavor development -t lib/main_dev.dart

build-apk-dev:
	fvm flutter build apk --release --flavor development --no-tree-shake-icons -t lib/main_dev.dart
    # fvm flutter build apk --debug --flavor development -t lib/main_dev.dart
    # fvm flutter build apk --debug --flavor development --target=lib/main_dev.dart
build-apk-prod:
	flutter build apk --release --flavor production -t lib/main.dart


.PHONY: run-dev run-prod build-apk-dev build-apk-prod
