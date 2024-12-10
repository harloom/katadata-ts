# KATADATA-ILHAM_TEST

Use: Flutter 3.16.9

## How to Setup ENV

1. add File .env and .env.dev

DEV - SAMPLE
```
APP=DEV
BASE_URL=https://jsonplaceholder.typicode.com

```
PRODUCTION - SAMPLE
```
APP=PRODUCTION
BASE_URL=https://jsonplaceholder.typicode.com

```


# How to run the App

1. Development
```
make run-dev

or 

flutter run --flavor development -t lib/main_dev.dart

```

2. Production
```
make run-prod

or 

flutter run --flavor production -t lib/main.dart

```

# How to build the App
1. Development
```
make build-apk-dev

or 

flutter build apk --release --flavor development -t lib/main_dev.dart
flutter build apk --release --flavor f -t lib/main.dart

```

2. Production
```
make build-apk-prod

or 

flutter build apk --release --flavor production -t lib/main.dart
flutter build appbundle --flavor production --target=lib/main.dart

```

![Alt text](screenshoot/1.png?raw=true "1")
![Alt text](screenshoot/2.png?raw=true "2")
![Alt text](screenshoot/3.png?raw=true "3")
![Alt text](screenshoot/4.png?raw=true "4")
![Alt text](screenshoot/5.png?raw=true "5")
