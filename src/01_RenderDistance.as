[Setting category="Render distance"
	name="Enable render distance limit"]
bool Setting_ZClip = false;

[Setting category="Render distance"
	name="Render distance"
	if="Setting_ZClip"
	min=10 max=2500
	afterrender="Setting_RenderZClipDistanceBlocks"]
float Setting_ZClipDistance = 180;

void Setting_RenderZClipDistanceBlocks()
{
	int blocks = int(Math::Ceil(Setting_ZClipDistance / 32.0f));
	UI::TextDisabled(
		Math::Round(Setting_ZClipDistance) + " meters is approximately " +
		blocks + (blocks == 1 ? " block" : " blocks")
	);
}

[Setting category="Render distance"
	name="Async rendering"
	if="Setting_ZClip"
	description="Enables the viewport's async rendering option. This allows the render distance limit to work when some UI is shown."]
bool Setting_ZClipAsyncRender = false;

void LimitRenderDistance()
{
	auto camera = Camera::GetCurrent();
	if (camera is null) {
		return;
	}

	camera.FarZ = Setting_ZClipDistance;

	if (Setting_ZClipAsyncRender && GetApp().Editor is null) {
		cast<CVisionViewport>(GetApp().Viewport).AsyncRender = true;
	}
}
