import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Helper pour créer un RichText à partir d'une string avec des marqueurs
///
/// Utilise ** pour marquer les parties à mettre en surbrillance
/// Exemple: "Profitez de **Lumena PRO** **GRATUITEMENT**"
///
/// Utilise [text] pour marquer les liens cliquables
/// Exemple: "J'accepte les [Conditions] et la [Politique]"
class RichTextHelper {
  static TextSpan parseHighlightedText(
    String text, {
    required TextStyle baseStyle,
    required TextStyle highlightStyle,
  }) {
    final parts = <TextSpan>[];
    final regex = RegExp(r'\*\*(.*?)\*\*');
    int lastIndex = 0;

    for (final match in regex.allMatches(text)) {
      // Ajouter le texte avant le match
      if (match.start > lastIndex) {
        parts.add(
          TextSpan(
            text: text.substring(lastIndex, match.start),
            style: baseStyle,
          ),
        );
      }

      // Ajouter le texte surligné
      parts.add(TextSpan(text: match.group(1), style: highlightStyle));

      lastIndex = match.end;
    }

    // Ajouter le texte restant
    if (lastIndex < text.length) {
      parts.add(TextSpan(text: text.substring(lastIndex), style: baseStyle));
    }

    return TextSpan(children: parts);
  }

  /// Parse un texte avec des liens cliquables marqués par [texte]
  ///
  /// Exemple:
  /// ```dart
  /// parseTextWithLinks(
  ///   "J'accepte les [Conditions] et la [Politique].",
  ///   baseStyle: TextStyle(color: Colors.black),
  ///   linkStyle: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
  ///   onLinkTap: (linkText) {
  ///     if (linkText == 'Conditions') {
  ///       // Ouvrir les conditions
  ///     } else if (linkText == 'Politique') {
  ///       // Ouvrir la politique
  ///     }
  ///   },
  /// )
  /// ```
  static TextSpan parseTextWithLinks(
    String text, {
    required TextStyle baseStyle,
    required TextStyle linkStyle,
    required Function(String linkText) onLinkTap,
  }) {
    final parts = <TextSpan>[];
    final regex = RegExp(r'\[(.*?)\]');
    int lastIndex = 0;

    for (final match in regex.allMatches(text)) {
      // Ajouter le texte avant le lien
      if (match.start > lastIndex) {
        parts.add(
          TextSpan(
            text: text.substring(lastIndex, match.start),
            style: baseStyle,
          ),
        );
      }

      // Ajouter le lien cliquable
      final linkText = match.group(1)!;
      parts.add(
        TextSpan(
          text: linkText,
          style: linkStyle,
          recognizer: TapGestureRecognizer()..onTap = () => onLinkTap(linkText),
        ),
      );

      lastIndex = match.end;
    }

    // Ajouter le texte restant
    if (lastIndex < text.length) {
      parts.add(TextSpan(text: text.substring(lastIndex), style: baseStyle));
    }

    return TextSpan(children: parts);
  }
}
