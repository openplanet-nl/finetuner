[Setting category="SkyDome"]
bool Setting_SkyDome = false;

[Setting category="SkyDome"
	if="Setting_SkyDome"]
bool Setting_SkyDomeDouble = false;

string g_originalSkyDome = "";

void SkyDome()
{
	auto map = GetApp().RootMap;
	if (map is null) {
		return;
	}

	CSceneMobil@ mobilSkyDome;
	bool isStadium = map.CollectionName == "Stadium";
	auto scene = GetApp().GameScene;
	for (uint i = 0; i < scene.Mobils.Length; i++) {
		auto mobil = scene.Mobils[i];
		if (
			(isStadium && mobil.IdName == "SkyDome") ||
			(!isStadium && i == 1)
		) {
			@mobilSkyDome = mobil;
			break;
		}
	}

	string desiredSkyDomePath = Setting_SkyDomeDouble
		? "GameData/Sky/Media/Solid/SkyDomeDouble.Solid.Gbx"
		: "GameData/Sky/Media/Solid/SkyDome.Solid.Gbx";

	CSystemFidFile@ fidDesiredSkyDome = Fids::GetGame(skyDomePath);
	if (fidDesiredSkyDome.Nod !is null) {
		fidDesiredSkyDome.Preload();
	}
	@mobilSkyDome.Solid = cast<CPlugSolid>(Fids::Preload(fidDesiredSkyDome));
}
