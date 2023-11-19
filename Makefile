.PHONY: get
get:
	@fvm flutter pub get

.PHONY: build
build:
	@dart run build_runner build --delete-conflicting-outputs

.PHONY: locale
locale:
	@fvm flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart --source-dir assets/translations

.PHONY: watch
watch:
	@dart run build_runner watch --delete-conflicting-outputs

.PHONY: test
test:
	@fvm flutter test --coverage --test-randomize-ordering-seed random

.PHONY: fix
fix:
	@dart fix --apply

.PHONY: check-fix
check-fix:
	@dart fix --dry-run

.PHONY: analyze
analyze:
	@dart analyze lib test

.PHONY: format
format:
	@dart format --set-exit-if-changed lib test

.PHONY: prepare
prepare: fix format analyze