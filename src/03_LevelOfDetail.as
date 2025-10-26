[Setting category="LOD"
	name="Override level of detail distance scale"]
bool Setting_LOD = false;

[Setting category="LOD"
	name="Level of detail distance scale"
	description="Scales the distance at which model LODs respond to: a higher multiplier uses low-poly LODs more quickly."
	if="Setting_LOD"
	step=0.1]
float Setting_LODScale = 1.0f;

void LevelOfDetail()
{
	Setting_LODScale = Math::Clamp(Setting_LODScale, 0.1f, 100.0f);
	GetSystemConfig().Display.GeomLodScaleZ = Setting_LOD ? Setting_LODScale : 1.0f;
}
