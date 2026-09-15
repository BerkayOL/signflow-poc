Sign Language Messaging PoC — UI & Architecture Specification

1. Goal

Build a small Flutter test app / PoC, not a full product.

The PoC must prove this exact flow:

Chat → open sign-language composer → type or select words → preview → send → render sign-language message bubble in chat

The UI should stay visually close to the provided proposal screenshots, but be implemented with modern 2026 Flutter standards, clean boundaries, and maintainable code.

This project is intentionally small. Do not add unrelated product features.

2. Scope

In scope

Single chat screen

Sign-language composer panel that opens from the chat composer

Bottom-sheet / keyboard-like interaction

Three mode tabs visually present:

Metin → İşaret

İşaret + T9

TİD → ASL

For the first UI milestone, only Metin → İşaret needs to be fully interactive

Text entry using an in-app Turkish Q keyboard

Quick-select / suggestion chips

TİD language selector

Preview action

Preview card

Send action

Sent sign-language message bubble

Placeholder sign animation/media for the first milestone

Architecture ready for later AI/API integration

Cubit for presentation state

data / domain / presentation separation

Out of scope for now

Authentication

Firebase

Push notifications

Real multi-user networking

Group chat

Video calling

Full TİD dictionary

Full ASL conversion

AI generation in the first UI milestone

Cloud storage

Analytics

Offline sync

Complex navigation

Design system package extraction

Over-engineered generic frameworks

3. Core Product Flow

Default chat

User sees a lightweight chat screen.

Bottom composer:

Mesaj yaz...  [Sign icon]  [Send]

Pressing the sign icon opens the sign composer.

Sign composer — edit state

The composer is attached to the bottom of the chat and visually behaves like a keyboard panel.

Structure:

┌────────────────────────────────┐
│ Metin→İşaret | İşaret+T9 | TİD→ASL │
├────────────────────────────────┤
│ Merhaba                     ➤  │
├────────────────────────────────┤
│ Şuraya çevir   [TİD ▼] [Önizle] │
├────────────────────────────────┤
│ Q W E R T Y U I O P Ğ Ü        │
│ A S D F G H J K L Ş İ          │
│ Z X C V B N M Ö Ç ⌫            │
│ 123        boşluk               │
└────────────────────────────────┘

Preview state

After pressing Önizle, replace keyboard content with a preview panel:

┌────────────────────────────────┐
│ 👁 ÖNİZLE · TİD                │
│ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│                                │
│       [avatar / video]         │
│                                │
│           MERHABA              │
│                                │
│ [MERHABA]                      │
│                                │
│ ↻ Tekrar oluştur   ➤ Gönder    │
└────────────────────────────────┘

Sent state

Pressing Gönder adds a sign-language message bubble to the chat.

Example:

┌──────────────────────────────┐
│ TİD                          │
│ [preview thumbnail]   ▶      │
│ MERHABA   NASIL   SEN   ?    │
│                        14:02 │
└──────────────────────────────┘

4. UI Direction

Visual language

Use the proposal screenshots as the primary visual reference.

Target qualities:

Deep purple / indigo sign composer

Light chat background

Rounded cards

Soft borders

Clear spacing hierarchy

Compact controls

Large enough touch targets

Modern typography

High contrast

Smooth state transitions

No visual clutter

Recommended visual tokens

These are app-local constants, not a giant design system.

class AppColors {
  static const composer = Color(0xFF1C184A);
  static const composerSurface = Color(0xFF2E286D);
  static const primary = Color(0xFF5747F5);
  static const success = Color(0xFF23D76B);
  static const chatBackground = Color(0xFFF3F3FF);
  static const bubbleBackground = Color(0xFFEDEBFF);
  static const textPrimary = Color(0xFF171526);
  static const textOnDark = Color(0xFFFFFFFF);
}

Do not spread raw colors across widgets.

Shape

Major panel radius: 24

Cards: 16

Buttons: 12–14

Chips: 8–10

Spacing

Use a tiny spacing scale:

4 / 8 / 12 / 16 / 20 / 24

Avoid arbitrary spacing values everywhere.

5. Architecture

Use a small but real clean architecture.

lib/
├── app/
│   ├── app.dart
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_spacing.dart
│   │   └── app_theme.dart
│   └── di/
│       └── injector.dart
│
├── core/
│   ├── error/
│   │   ├── app_exception.dart
│   │   └── failure.dart
│   └── utils/
│       └── text_normalizer.dart
│
├── features/
│   ├── chat/
│   │   ├── data/
│   │   │   └── repositories/
│   │   │       └── mock_chat_repository.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── chat_message.dart
│   │   │   └── repositories/
│   │   │       └── chat_repository.dart
│   │   └── presentation/
│   │       ├── cubit/
│   │       │   ├── chat_cubit.dart
│   │       │   └── chat_state.dart
│   │       ├── pages/
│   │       │   └── chat_page.dart
│   │       └── widgets/
│   │           ├── chat_app_bar.dart
│   │           ├── chat_message_list.dart
│   │           ├── text_message_bubble.dart
│   │           ├── sign_message_bubble.dart
│   │           └── chat_input_bar.dart
│   │
│   └── sign_composer/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── mock_sign_datasource.dart
│       │   ├── models/
│       │   │   └── sign_asset_model.dart
│       │   └── repositories/
│       │       └── sign_repository_impl.dart
│       │
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── sign_asset.dart
│       │   │   ├── sign_preview.dart
│       │   │   └── sign_sequence.dart
│       │   ├── repositories/
│       │   │   └── sign_repository.dart
│       │   └── usecases/
│       │       ├── build_sign_preview.dart
│       │       └── search_signs.dart
│       │
│       └── presentation/
│           ├── cubit/
│           │   ├── sign_composer_cubit.dart
│           │   └── sign_composer_state.dart
│           ├── widgets/
│           │   ├── sign_composer_panel.dart
│           │   ├── sign_mode_tabs.dart
│           │   ├── sign_text_field.dart
│           │   ├── sign_action_row.dart
│           │   ├── sign_keyboard.dart
│           │   ├── sign_keyboard_key.dart
│           │   ├── sign_suggestion_chips.dart
│           │   ├── sign_preview_panel.dart
│           │   └── sign_preview_card.dart
│           └── mappers/
│               └── sign_ui_mapper.dart
│
└── main.dart

This is enough. Do not create more layers unless a concrete need appears.

6. Dependency Rule

The direction must remain:

presentation
    ↓
domain
    ↑
data

Domain

Must not import:

Flutter widgets

Dio

JSON serialization

local storage implementation

UI classes

Presentation

May know:

Cubit

domain entities

use cases

Must not contain:

HTTP logic

JSON parsing

API URLs

repository implementations

Data

May know:

remote/local datasource

DTO/model

repository implementation

Data converts models into domain entities.

7. Cubit Design

Do not make one giant app-wide Cubit.

Use two focused Cubits.

ChatCubit

Responsibilities:

hold chat messages

send normal message

append sign message

Suggested state:

final class ChatState extends Equatable {
  final List<ChatMessage> messages;
  final bool isSignComposerOpen;
}

SignComposerCubit

Responsibilities:

current composer mode

typed text

selected sign chips

selected target sign language

preview lifecycle

preview result

errors

Suggested state model:

enum SignComposerMode {
  textToSign,
  signT9,
  tidToAsl,
}

enum SignComposerStatus {
  editing,
  loadingPreview,
  previewReady,
  sending,
  failure,
}

State should remain immutable.

Do not put TextEditingController, BuildContext, widget keys, or media controllers inside Cubit.

8. Domain Models

SignAsset

class SignAsset {
  final String id;
  final String label;
  final String languageCode;
  final String? previewAssetPath;
  final String? previewUrl;
}

SignSequence

class SignSequence {
  final String sourceText;
  final List<SignAsset> signs;
  final String languageCode;
}

SignPreview

class SignPreview {
  final SignSequence sequence;
  final String mediaSource;
  final SignPreviewSourceType sourceType;
}

ChatMessage

Use a sealed hierarchy or typed enum.

For example:

sealed class ChatMessage {}

class TextChatMessage extends ChatMessage {}

class SignChatMessage extends ChatMessage {}

Avoid Map<String, dynamic> in presentation.

9. Repository Contract

The domain contract must already be suitable for future real AI integration.

abstract interface class SignRepository {
  Future<List<SignAsset>> searchSigns(String query);

  Future<SignPreview> createPreview({
    required String text,
    required String targetLanguage,
  });
}

For milestone 1:

SignRepository
      ↓
MockSignRepository
      ↓
local placeholder result

For milestone 2:

SignRepository
      ↓
SignRepositoryImpl
      ↓
RemoteSignDataSource
      ↓
AI / backend API

The UI must not change when mock data is replaced by a real API.

10. Placeholder Strategy

Yes, placeholders are explicitly allowed for the first UI milestone.

Use a local placeholder asset for the preview area.

Example mapping:

MERHABA     → assets/mock_signs/merhaba.mp4
YARDIM      → assets/mock_signs/yardim.mp4
GÖRÜŞÜRÜZ   → assets/mock_signs/gorusuruz.mp4
fallback    → assets/mock_signs/placeholder.mp4

If actual videos are not ready yet, use a static placeholder card first.

Do not block UI work on AI integration.

11. Custom Keyboard

For visual parity with the proposal, use a small in-app Turkish Q keyboard.

It is not an OS-level keyboard extension.

Keys:

Q W E R T Y U I O P Ğ Ü
A S D F G H J K L Ş İ
Z X C V B N M Ö Ç ⌫
123        boşluk

Behavior:

letter → append to current text

backspace → remove final grapheme safely

space → append one space

submit/send icon → preview or submit according to design

input is held by Cubit

Keyboard must be isolated in its own widget tree.

Do not put the entire keyboard inside sign_composer_panel.dart.

12. Suggested Chips

Show 3–5 contextual chips.

Initial mock suggestions:

MERHABA
NASIL
SEN
YARDIM
YARIN
GÖRÜŞÜRÜZ

Selecting a chip:

adds it to selected signs

updates previewable sequence

may update source text where appropriate

Keep mock rules simple.

No NLP engine is needed in milestone 1.

13. Preview State

Preview must feel like a real product even while using mock media.

Include:

ÖNİZLE · TİD

progress / playback bar placeholder

avatar/video frame

current sign word

selected word chips

helper note

Tekrar oluştur

Gönder

Transition:

editing
→ loadingPreview
→ previewReady

Use subtle animation:

AnimatedSwitcher

AnimatedSize

FadeTransition

Do not add heavy animation libraries for this PoC unless required.

14. Error States

The test app should still show professional behavior.

At minimum support:

empty input

unsupported word

preview loading failure

media load failure

Example user-facing messages:

"Önizlemek için bir metin yaz."
"Bu ifade için henüz bir işaret bulunamadı."
"Önizleme oluşturulamadı. Tekrar deneyin."

No raw exception strings in UI.

15. File Size / Code Quality Rules

This project must stay intentionally modular.

Preferred limits

widgets: ideally < 180 lines

Cubit: ideally < 220 lines

state: < 150 lines

page: ideally < 200 lines

repository implementation: < 200 lines

These are guidance, not artificial hard limits.

If a file starts handling more than one clear responsibility, split it.

Never create

700-line chat_page.dart

500-line sign_composer.dart

giant utils.dart

giant constants.dart

giant global Cubit

repository logic inside widgets

16. Dependency Suggestions

Keep dependencies minimal.

Recommended:

flutter_bloc:
equatable:
get_it:
video_player:

Later, when real API integration begins:

dio:

Optional only if there is a concrete need:

freezed:
json_serializable:

Do not add code generation just for fashion in this small PoC.

17. DI

Use get_it only for:

repositories

datasources

use cases

Do not register simple widgets.

Example conceptual graph:

SignComposerCubit
      ↓
BuildSignPreview
      ↓
SignRepository
      ↓
MockSignRepository

Later:

SignRepository
      ↓
SignRepositoryImpl
      ↓
RemoteSignDataSource

18. Milestones

Milestone 1 — UI Skeleton

Build:

theme

chat page

fake messages

chat input

sign composer open/close

tabs

input

language selector

custom keyboard

preview placeholder

send button

No real AI/API.

Milestone 2 — Mock Product Flow

Build:

Cubit state transitions

suggestion chips

mock repository

preview generation delay

sign message bubble

replay preview

Flow must be fully demonstrable.

Milestone 3 — Real AI/API Spike

Only after UI is accepted.

Replace mock preview source with real remote datasource.

Do not rewrite presentation.

Expected flow:

SignComposerCubit
→ use case
→ repository
→ remote datasource
→ backend / AI provider
→ preview result

Milestone 4 — Polish

Only if needed:

loading skeleton

better animations

keyboard haptics

media error fallback

small accessibility pass

19. Acceptance Criteria

The PoC is complete when:

App opens directly to chat.

Sign icon opens the composer.

Composer visually resembles the supplied proposal.

User can type using the custom Turkish keyboard.

User can select suggestion chips.

Önizle changes the panel into preview state.

Placeholder/local preview media is displayed.

Gönder appends a sign-language message bubble.

Sent bubble can be tapped to replay/open preview.

Closing composer returns to normal chat input.

No feature file becomes a giant mixed-responsibility file.

Data/domain/presentation boundaries remain intact.

Replacing mock data with a remote API requires no UI rewrite.

20. Non-Goals / Guardrails for Codex

Do not:

build a backend yet

invent Firebase integration

implement auth

add routing libraries for one screen

build OS keyboard extensions

create a design system package

implement ASL logic yet

call external AI APIs yet

add hundreds of mock signs

refactor beyond the required scope

introduce abstractions with only theoretical future value

When choosing between:

clever architecture

simple clean architecture

Choose simple clean architecture.

When choosing between:

more features

a polished core interaction

Choose the polished core interaction.

21. Implementation Order for Codex

Follow this exact order:

1. Inspect current project.
2. Do not modify unrelated files.
3. Add minimal dependencies.
4. Add app theme/tokens.
5. Add domain entities/contracts.
6. Add mock data layer.
7. Add Cubits/states.
8. Build ChatPage shell.
9. Build chat bubbles.
10. Build sign composer editing state.
11. Build custom keyboard.
12. Build preview state.
13. Wire preview → send.
14. Add small transitions.
15. Run analyzer/tests.
16. Fix warnings.
17. Report changed files and architecture decisions.

22. Definition of “Professional” for This PoC

Professional does not mean large.

For this project, professional means:

clear responsibilities

predictable state

testable business logic

replaceable data source

consistent visual language

small files

no duplication

no business logic in widgets

no premature infrastructure

smooth main interaction

easy AI integration in the next phase

The result should look like a real product slice, while remaining a deliberately small test application.