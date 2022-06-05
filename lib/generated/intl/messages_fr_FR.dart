// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr_FR locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'fr_FR';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addsheet_hint":
            MessageLookupByLibrary.simpleMessage("Je dois faire..."),
        "addsheet_label": MessageLookupByLibrary.simpleMessage(
            "Veuillez introduire le descriptif de la tâche"),
        "addsheet_validator": MessageLookupByLibrary.simpleMessage(
            "Veuillez entrer un descriptif"),
        "app_title": MessageLookupByLibrary.simpleMessage("Liste des tâches"),
        "bottomsheet_hint": MessageLookupByLibrary.simpleMessage("Recherche"),
        "bottomsheet_label": MessageLookupByLibrary.simpleMessage(
            "Veuillez saisir un texte à rechercher"),
        "bottomsheet_validator": MessageLookupByLibrary.simpleMessage(
            "Veuillez entrer un critère de recherche"),
        "delete_todo": MessageLookupByLibrary.simpleMessage("Supprimer"),
        "todo_list_empty": MessageLookupByLibrary.simpleMessage("Aucune tâche"),
        "todo_list_loading":
            MessageLookupByLibrary.simpleMessage("Chargement en cours...")
      };
}
