enum ShortcutMode
{
	Toggle,
	Hold,
	InverseHold,
}

class Shortcut
{
	[Setting name="Use shortcut"] bool Enabled = false;
	[Setting] ShortcutMode Mode = ShortcutMode::Toggle;
	[Setting] VirtualKey Key;

	string ToString() { return Enabled ? tostring(Key) : ""; }

	bool GetNewValue(bool currentValue, bool down, VirtualKey key)
	{
		if (Enabled && key == Key) {
			switch (Mode) {
			case ShortcutMode::Toggle: if (down) { return !currentValue; } break;
			case ShortcutMode::Hold: return down;
			case ShortcutMode::InverseHold: return !down;
			}
		}
		return currentValue;
	}
}

[Setting category="Shortcuts" name="Render distance"]
Shortcut Setting_ZClipShortcut;

[Setting category="Shortcuts" name="LOD"]
Shortcut Setting_LODShortcut;

[Setting category="Shortcuts" name="FPS"]
Shortcut Setting_FPSShortcut;

UI::InputBlocking OnKeyPress(bool down, VirtualKey key)
{
	Setting_ZClip = Setting_ZClipShortcut.GetNewValue(Setting_ZClip, down, key);
	Setting_LOD = Setting_LODShortcut.GetNewValue(Setting_LOD, down, key);
	Setting_FPS = Setting_FPSShortcut.GetNewValue(Setting_FPS, down, key);
	return UI::InputBlocking::DoNothing;
}
