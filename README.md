<div align="center">
  <img src="https://media.forgecdn.net/attachments/description/1462648/description_21471a9a-0b37-4165-a8ac-e2ec08454d77.png" />
  <br><br>
  <h1>BigChatBox</h1>
  <b>By Dukul</b>
  <br><br>
  <img src="https://media.forgecdn.net/attachments/1537/406/0exznxv-png.png" />
</div>

# ℹ️ About

BigChatBox replaces and enhances the default World of Warcraft chat input box with a fully customizable, movable, and resizable chat experience designed specifically for the Midnight expansion (12.0+).

Style your chat box exactly how you want with custom borders, textures, fonts, transparency, scaling, snippets, autocomplete, history tools, and LibSharedMedia support.

BigChatBox was built with Blizzard's new Midnight addon restrictions in mind and safely adapts during combat and competitive content.

---

## ⬇️ Downloads

You can download BigNoteBox from the official sources below:

- <a href="https://addons.wago.io/addons/bigchatbox" target="_blank">Wago</a>
- <a href="https://www.curseforge.com/wow/addons/bigchatbox" target="_blank">CurseForge</a>

## ⚠️ Warning

BigNoteBox is only distributed through the official links above.

If you download it from any other website, it is **not official, not maintained, and may be modified or unsafe**.

---

# ✨ Features

## 🎨 Customization
- Move, scale, and resize the chat input box
- Visual anchor editor (`/bcb edit`)
- Change:
  - Borders
  - Background textures
  - Fonts
  - Font size
  - Transparency
  - Brightness
- Live preview window while editing
- Save and share styles with friends

---

## 🧩 Media Support
Supports:
- LibSharedMedia
- SharedMedia
- Borders/textures/fonts from other addons

Compatible with addons such as:
- Platynator
- LS: Borders
- Other LSM-compatible addons

---

## 💬 Chat Features
- Click channel name to quickly switch channels
- Right-click quick menu
- Whisper history
- Last five whispers remembered
- Up/down history scrolling
- Full multiline chat editor
- Optional custom multiline styling

---

## ⚡ Autocomplete
Autocomplete support for:
- Slash commands
- `/w` whispers
- Guild members
- Friends
- Battle.net friends
- Real ID friends
- `!snippets`

Use:
- `TAB` to cycle suggestions
- `ENTER` to confirm

---

## 🧠 Snippets System
Create reusable quick messages using `!snippet` commands.

Example:
```text id="snippet1"
!guild
```

Can automatically expand into:
```text
Please join my good guild! Whisper for invite!
```

Supports:
- Forced channels
- Channel-independent posting
- Fast repeated messaging

---

## 📜 History System
- Stores previously typed messages
- Reopen previous text instantly
- Delete history entries individually
- Configurable history size:
  - 0 to 1000 lines

---

## 🧱 Modular Features
Turn features on or off individually:
- Snippets
- Autocomplete
- Whisper suggestions
- History
- More

Use only the parts you want.

---

# 🌍 Language Support

Translated into:
- English
- Deutsch
- Français
- Español
- Português
- Italiano
- 日本語
- 한국어
- 简体中文
- 繁體中文

---

# ⚠️ Midnight (12.0+) Combat Restrictions

## Why does BigChatBox pause during combat / M+ etc. (Midnight 12.0+)

With the Midnight expansion (12.0), Blizzard introduced major changes to how addons interact with the game during combat. This initiative, called Addon Disarmament, limits what addons can do with combat information.

## What changed?

Combat-related data is now "secret values". Addons can display this information but cannot read or process it in their code.

Many UI frames are now protected during combat. In instanced content (M+ keystones, arenas, rated battlegrounds) the restrictions are even stricter. Any addon that modifies or hooks into these protected frames risks spreading taint, which can completely break game functionality. Not just the addon, but core game features like targeting, casting spells, and using abilities.

## How does this affect BigChatBox?

WoW's default chat input (ChatFrame1EditBox) is a protected frame because it processes secure slash commands like /target, /cast, and /focus. BigChatBox hooks into this frame to intercept chat input. During combat and instanced competitive content, these hooks can cause taint that would block your entire chat system.

To protect you, BigChatBox automatically pauses during combat and during M+ keystones, arenas, and rated battlegrounds. Blizzard's default chat input takes over seamlessly. When combat ends or the content finishes, BigChatBox resumes automatically.

## Why not just fix it?
This is not a bug! This is a fundamental restriction in WoW's security model. Every addon that modifies protected frames during combat faces the same limitation. Blizzard designed these restrictions to prevent addons from automating combat decisions, and the chat editbox falls within that protected scope.

## The bottom line
BigChatBox pauses during combat and during timed competitive instances (M+, arenas, rated BGs). You can still chat normally during those activities by using Blizzard's built-in chat input instead. BigChatBox resumes automatically when combat ends or the activity completes.