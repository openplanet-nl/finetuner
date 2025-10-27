class Toggle
{
	bool m_prev;

	Toggle(bool init) { m_prev = init; }
	bool Check(bool current)
	{
		bool ret = current != m_prev;
		m_prev = current;
		return ret;
	}
}

void Main()
{
	Meta::StartWithRunContext(Meta::RunContext::NetworkAfterMainLoop, NetworkAfterMainLoop);
}

void NetworkAfterMainLoop()
{
	while (true) {
		LimitRenderDistance();
		yield();
	}
}

void Render()
{
#if TMNEXT
	if (Setting_OverlayScaling) { OverlayScaling(); }
#endif
	LevelOfDetail();
	SkyDome();

	if (Setting_FPS && Setting_FPSWhenClosed) {
		RenderFPS();
	}
}

void RenderInterface()
{
	if (Setting_FPS && !Setting_FPSWhenClosed) {
		RenderFPS();
	}
}

void RenderMenu()
{
	if (UI::BeginMenu("\\$9cf" + Icons::Wrench + "\\$z Finetuner")) {
		if (UI::MenuItem(Icons::PictureO + " Render distance", Setting_ZClipShortcut.ToString(), Setting_ZClip)) {
			Setting_ZClip = !Setting_ZClip;
		}
		if (UI::MenuItem(Icons::Cube + " Level of detail", Setting_LODShortcut.ToString(), Setting_LOD)) {
			Setting_LOD = !Setting_LOD;
		}
		if (UI::MenuItem(Icons::LineChart + " FPS", Setting_FPSShortcut.ToString(), Setting_FPS)) {
			Setting_FPS = !Setting_FPS;
		}
		UI::EndMenu();
	}
}
