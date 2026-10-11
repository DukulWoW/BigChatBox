# BigChatBox v7.0.0 - I intend to live forever

## All versions

### New
- WoW Forever support. BigChatBox now loads on the Forever client with its own TOC.
- The setup wizard, the built-in styles and the two help windows now also work on TBC Anniversary, Mists of Pandaria Classic and Classic Era.

### Change
- Patch notes now show only the notes for the current version.
- Restart Setup keeps your snippets, saved styles and chat history; only settings are reset.
- Chat messages from BigChatBox use its blue name tag, and the lockdown messages are translated.
- A message with several lines (multiline box or a multi-line snippet): a line starting with / stops the send, so commands are never posted as text. Lines over 255 characters are split instead of cut off, and more than 10 messages asks first.
- The whisper name suggestions keep the realm for players on other realms, so the whisper reaches the right person.
- History tab: Wipe Entire History now says it also clears Recent Whispers, and no longer reloads the UI.
- Scroll bars and sliders use the modern style on every client. The mouse wheel over a slider scrolls the page instead of changing the value.
- BigChatBox is now licensed under the GPLv3; the logo and icon are All Rights Reserved.

### Fixed
- Picking a key that is already in use now binds the action you were setting, not always the multiline box. The setup wizard asks first too.
- /bcb reset and Shift+Alt+click now keep the box at the default position after a reload.
- Renaming or creating a snippet can no longer overwrite another snippet with the same name; the name turns red instead.
- Dragging the history length slider no longer deletes history; the new length applies from the next message.
- A language chosen in BigChatBox now wins over the game client's language, and English can be chosen on any client.
- After a reload the box no longer opens as a whisper or channel with nobody to send to.
- Hovering a link in the box shows the exact item (item level, upgrades, random suffix).
- Width and height sliders no longer size the box twice when the scale is not 100%.
- Chinese, Japanese or Korean fonts no longer stick after switching back to another language.
- Snippet share strings keep a backslash followed by n or t.
- The snippet Import button says Import, and the Reset All help text says what it resets.
- Sending many messages no longer slows down over a session once the History tab has been opened.
- Settings, snippets and whisper history are ready right after login, even when a whisper arrives in the first second.
- Clicking a player name in chat during combat, a keystone or an arena no longer opens BigChatBox next to Blizzard's box.
- Font previews in the two font menus no longer show each other's fonts.
- Changing channel from the main box's menu now also updates the multiline box.
- Blizzard's chat box no longer flashes on screen every time BigChatBox sends a message.

## Classic only

### Change
- The version no longer shows rc1.
- BigChatBox no longer pauses in combat on Classic: that pause is only needed for Retail's and Forever's chat restrictions.

### Fixed
- The settings sliders show their track and the +/- buttons again.
- The multiline section is hidden in the Features tab, since the multiline box is not on Classic yet.
- Key bindings are no longer saved again at every login, and never during combat.

## WoW Forever only

### Fixed
- Pressing Enter now opens BigChatBox instead of Blizzard's chat box.
- BigChatBox's windows (settings, help, patch notes, setup) line up inside the Forever window frame.
