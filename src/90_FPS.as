[Setting category="FPS"
	name="Display FPS on overlay"]
bool Setting_FPS = false;

[Setting category="FPS"
	name="Also display FPS when overlay is closed"]
bool Setting_FPSWhenClosed = false;

[Setting category="FPS"
	name="Background color"
	color]
vec4 Setting_FPSBackgroundColor = vec4(0, 0, 0, 0.5f);

[Setting category="FPS"
	name="Text color"
	color]
vec4 Setting_FPSTextColor = vec4(1);

[Setting category="FPS"
	name="Color text based on thresholds"]
bool Setting_FPSColored = false;

[Setting category="FPS"
	name="Bad FPS threshold"
	if="Setting_FPSColored"]
uint Setting_FPSThresholdBad = 25;

[Setting category="FPS"
	name="Text color for bad FPS"
	color
	if="Setting_FPSColored"]
vec4 Setting_FPSTextColorBad = vec4(1, 0, 0, 1);

[Setting category="FPS"
	name="Warning FPS threshold"
	if="Setting_FPSColored"]
uint Setting_FPSThresholdWarning = 55;

[Setting category="FPS"
	name="Text color for warning FPS"
	color
	if="Setting_FPSColored"]
vec4 Setting_FPSTextColorWarning = vec4(1, 1, 0, 1);

void RenderFPS()
{
	float fps = GetApp().Viewport.AverageFps;

	int windowFlags = UI::WindowFlags::NoTitleBar
		| UI::WindowFlags::NoResize
		| UI::WindowFlags::AlwaysAutoResize
		| UI::WindowFlags::NoFocusOnAppearing
		| UI::WindowFlags::NoNav;

	UI::PushStyleColor(UI::Col::WindowBg, Setting_FPSBackgroundColor);

	vec4 textColor = Setting_FPSTextColor;
	if (Setting_FPSColored) {
		if (uint(fps) < Setting_FPSThresholdBad) {
			textColor = Setting_FPSTextColorBad;
		} else if (uint(fps) < Setting_FPSThresholdWarning) {
			textColor = Setting_FPSTextColorWarning;
		}
	}
	UI::PushStyleColor(UI::Col::Text, textColor);

	UI::SetNextWindowPos(5, 30, UI::Cond::FirstUseEver);
	if (UI::Begin("Finetuner FPS", windowFlags)) {
		string text = Text::Format(fps < 10 ? "%.1f" : "%.0f", fps);
		UI::Text(text);
	}
	UI::End();

	UI::PopStyleColor(2);
}
