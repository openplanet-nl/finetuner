#if !FOREVER
[Setting category="Decals"
	name="Override texture decals settings"
	description="Disabling the override will not take effect until the map is exited."]
bool Setting_Decals = false;

[Setting category="Decals"
	name="3D Decals"
	description="Decals utilized for 3D grass and bushes. Will only be applied after the map is exited."
	if="Setting_Decals"]
bool Setting_3dDecals = true;

#if MP4
[Setting category="Decals"
	name="2D Decals"
	description="Decals utilized for certain texture details. Will only be applied after the map is exited."
	if="Setting_Decals"]
bool Setting_2dDecals = true;
#endif

void SetDecals()
{
#if TMNEXT
	GetSystemConfig().Display.Decals_3D__TextureDecals_ = Setting_Decals ? Setting_3dDecals : true;
#else
	GetSystemConfig().Display.TextureDecals_3D = Setting_Decals ? Setting_3dDecals : true;
#endif

#if MP4
	GetSystemConfig().Display.TextureDecals_2D = Setting_Decals ? Setting_2dDecals : true;
#endif
}
#endif
