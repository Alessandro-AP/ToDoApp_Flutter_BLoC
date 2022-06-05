// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `TODO List`
  String get app_title {
    return Intl.message(
      'TODO List',
      name: 'app_title',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get bottomsheet_hint {
    return Intl.message(
      'Search',
      name: 'bottomsheet_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a text to search for`
  String get bottomsheet_label {
    return Intl.message(
      'Please enter a text to search for',
      name: 'bottomsheet_label',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a search term`
  String get bottomsheet_validator {
    return Intl.message(
      'Please enter a search term',
      name: 'bottomsheet_validator',
      desc: '',
      args: [],
    );
  }

  /// `I have to do...`
  String get addsheet_hint {
    return Intl.message(
      'I have to do...',
      name: 'addsheet_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the description of the task`
  String get addsheet_label {
    return Intl.message(
      'Please enter the description of the task',
      name: 'addsheet_label',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a description`
  String get addsheet_validator {
    return Intl.message(
      'Please enter a description',
      name: 'addsheet_validator',
      desc: '',
      args: [],
    );
  }

  /// `No tasks`
  String get todo_list_empty {
    return Intl.message(
      'No tasks',
      name: 'todo_list_empty',
      desc: '',
      args: [],
    );
  }

  /// `Loading in progress...`
  String get todo_list_loading {
    return Intl.message(
      'Loading in progress...',
      name: 'todo_list_loading',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete_todo {
    return Intl.message(
      'Delete',
      name: 'delete_todo',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr', countryCode: 'FR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
