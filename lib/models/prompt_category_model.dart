import 'package:flutter/material.dart';
import 'package:lumena_ai/l10n/l10n_extensions.dart';
import 'package:lumena_ai/models/models.dart';

class PromptCategoryModel {
  final String label;
  final List<PromptModel> prompts;

  PromptCategoryModel({required this.label, required this.prompts});

  static List<PromptCategoryModel> getPromptCategories(BuildContext context) {
    return [
      PromptCategoryModel(
        label: context.t.pranksCategoryLabel,
        prompts: [
          PromptModel(
            label: context.t.homelessPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/pranks/homeless-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/pranks/homeless-after.png',
            text: context.t.homelessPromptText,
          ),
          PromptModel(
            label: context.t.plumberPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/pranks/plumber-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/pranks/plumber-after.png',
            text: context.t.plumberPromptText,
          ),
          PromptModel(
            label: context.t.damagedCarPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/pranks/damaged-car-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/pranks/damaged-car-after.png',
            text: context.t.damagedCarPromptText,
          ),
          PromptModel(
            label: context.t.dirtyToiletsPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/pranks/dirty-toilets-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/pranks/dirty-toilets-after.png',
            text: context.t.dirtyToiletsPromptText,
          ),
          PromptModel(
            label: context.t.brokenTvPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/pranks/broken-tv-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/pranks/broken-tv-after.png',
            text: context.t.brokenTvPromptText,
          ),
        ],
      ),
      PromptCategoryModel(
        label: context.t.relationshipsCategoryLabel,
        prompts: [
          PromptModel(
            label: context.t.aiGirlfriendPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/relationships/ai-girlfriend-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/relationships/ai-girlfriend-after.png',
            text: context.t.aiGirlfriendPromptText,
          ),
          PromptModel(
            label: context.t.aiBoyfriendPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/relationships/ai-boyfriend-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/relationships/ai-boyfriend-after.png',
            text: context.t.aiBoyfriendPromptText,
          ),
        ],
      ),
      PromptCategoryModel(
        label: context.t.fashionCategoryLabel,
        prompts: [
          PromptModel(
            label: context.t.changeHairstylePromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/fashion/change-hairstyle-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/fashion/change-hairstyle-after.png',
            text: context.t.changeHairstylePromptText,
          ),
          PromptModel(
            label: context.t.tattooTryOnPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/fashion/tattoo-tryon-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/fashion/tattoo-tryon-after.png',
            text: context.t.tattooTryOnPromptText,
          ),
          PromptModel(
            label: context.t.outfitTryOnPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/fashion/outfit-tryon-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/fashion/outfit-tryon-after.png',
            text: context.t.outfitTryOnPromptText,
          ),
        ],
      ),
      PromptCategoryModel(
        label: context.t.transformationCategoryLabel,
        prompts: [
          PromptModel(
            label: context.t.muscularPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/transformation/muscular-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/transformation/muscular-after.png',
            text: context.t.muscularPromptText,
          ),
          PromptModel(
            label: context.t.professionalPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/transformation/professional-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/transformation/professional-after.png',
            text: context.t.professionalPromptText,
          ),
          PromptModel(
            label: context.t.manToWomanPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/transformation/man-to-woman-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/transformation/man-to-woman-after.png',
            text: context.t.manToWomanPromptText,
          ),
          PromptModel(
            label: context.t.womanToManPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/transformation/woman-to-man-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/transformation/woman-to-man-after.png',
            text: context.t.womanToManPromptText,
          ),
          PromptModel(
            label: context.t.animalToHumanPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/transformation/animal-to-human-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/transformation/animal-to-human-after.png',
            text: context.t.animalToHumanPromptText,
          ),
        ],
      ),
      PromptCategoryModel(
        label: context.t.avatarsCategoryLabel,
        prompts: [
          PromptModel(
            label: context.t.iosMemojiPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/avatars/ios-memoji-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/avatars/ios-memoji-after.png',
            text: context.t.iosMemojiPromptText,
          ),
          PromptModel(
            label: context.t.snapchatBitmojiPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/avatars/snapchat-bitmoji-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/avatars/snapchat-bitmoji-after.png',
            text: context.t.snapchatBitmojiPromptText,
          ),
          PromptModel(
            label: context.t.pixelArtPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/avatars/pixel-art-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/avatars/pixel-art-after.png',
            text: context.t.pixelArtPromptText,
          ),
          PromptModel(
            label: context.t.minecraftAvatarPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/avatars/minecraft-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/avatars/minecraft-after.png',
            text: context.t.minecraftAvatarPromptText,
          ),
        ],
      ),
      PromptCategoryModel(
        label: context.t.environmentCategoryLabel,
        prompts: [
          PromptModel(
            label: context.t.strangerThingsPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/environment/stranger-things-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/environment/stranger-things-after.png',
            text: context.t.strangerThingsPromptText,
          ),
          PromptModel(
            label: context.t.minecraftEnvironmentPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/environment/minecraft-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/environment/minecraft-after.png',
            text: context.t.minecraftEnvironmentPromptText,
          ),
          PromptModel(
            label: context.t.legoPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/environment/lego-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/environment/lego-after.png',
            text: context.t.legoPromptText,
          ),
        ],
      ),
      PromptCategoryModel(
        label: context.t.filtersCategoryLabel,
        prompts: [
          PromptModel(
            label: context.t.fisheyeLensPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/filters/fisheye-lens-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/filters/fisheye-lens-after.png',
            text: context.t.fisheyeLensPromptText,
          ),
          PromptModel(
            label: context.t.oldPhotoRestorePromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/filters/old-photo-restore-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/filters/old-photo-restore-after.png',
            text: context.t.oldPhotoRestorePromptText,
          ),
          PromptModel(
            label: context.t.woolPromptLabel,
            beforeImagePath:
                'https://www.trylumena.app/prompts/filters/wool-before.png',
            afterImagePath:
                'https://www.trylumena.app/prompts/filters/wool-after.png',
            text: context.t.woolPromptText,
          ),
        ],
      ),
    ];
  }
}
