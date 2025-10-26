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

#if !FOREVER
[Setting category="Render distance"
	name="Async rendering"
	if="Setting_ZClip"
	description="Enables the viewport's async rendering option. This allows the render distance limit to work when some UI is shown."]
#endif
bool Setting_ZClipAsyncRender = false;

void LimitRenderDistance()
{
#if FOREVER
	//NOTE: For TMF, we don't use GetCurrent here, but FindCurrent (a more expensive operation).
	//      This is to make sure we always have an accurate up-to-date camera at this point in time.
	//      It's possible for this to get called while the camera is already destroyed.
	auto camera = Camera::FindCurrent();
#else
	auto camera = Camera::GetCurrent();
#endif
	if (camera is null) {
		return;
	}

	if (!Setting_ZClip) {
#if FOREVER
		// TMF expects FarZ to be reset to its default
		camera.FarZ = 50000;
#endif
		return;
	}

	camera.FarZ = Setting_ZClipDistance;

#if !FOREVER
	if (Setting_ZClipAsyncRender && GetApp().Editor is null) {
		cast<CVisionViewport>(GetApp().Viewport).AsyncRender = true;
	}
#endif
}
