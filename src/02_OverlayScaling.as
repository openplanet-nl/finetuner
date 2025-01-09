[Setting category="Overlay scaling"
	name="Override overlay scaling"
	description="Disabling the override will not take effect until the game scene is reloaded."]
bool Setting_OverlayScaling = false;

[Setting category="Overlay scaling"
	name="Adapt ratio"
	if="Setting_OverlayScaling"]
EHmsOverlayAdaptRatio Setting_OverlayScalingRatio = EHmsOverlayAdaptRatio::ShrinkToKeepRatio;

void OverlayScaling()
{
	auto viewport = GetApp().Viewport;
	for (uint i = 0; i < viewport.Overlays.Length; i++) {
		viewport.Overlays[i].m_AdaptRatio = Setting_OverlayScalingRatio;
	}
}
