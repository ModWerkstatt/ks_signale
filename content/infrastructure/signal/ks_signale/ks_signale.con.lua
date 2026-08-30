function data()

    return {
		availability = {
			yearFrom = 1993,
			yearTo = 0,
		},
        constructionType = "ASSET_TRACK",
        description = {
            name = _("Ks-Signale"),
            description = _("Ks-signale Desc"),
            icon = "icons/ks_signale_icon_small.tga",
            previewIcon = "icons/ks_signale_assets_preview@2x.tga",
        },
        menuCategory = {
            categories = {
                {
                    category = "rail_tools",
                    order = 720,
                },
            },
        },
		soundConfig = {
			builderAudioRes = "::/gui/construction/sound/buildoze_construction_small.builder_audio",
			soundSet = {
				name = "",
			},
		},
        updateScript = {
            fileName = "ks_signale.script@updateFn",
            params = {
            },
        },
		isEdgeObject = true,
	    buildMode = "MULTI",
	    skipCollision = true,
	    autoRemovable = false,
	      snapping = {
		    rail = true,
		    road = false,
		    water = false
	      },
	    order = 1,
        params = {
            -- Zusatzanzeiger oben
            -- Mast
            -- Optik
            -- Licht (Kennlicht)
            -- Wiederholer (nur bei Vsig)
            -- VKB
            -- Zusatzanzeiger unten
            -- Zusatzanzeiger unten 2
		    {
			    key = "mw_zusatz_oben",
			    name = _("ZusatzObenType"),
			    values = { _("ohne"), _("aus"), _("Zs3_3"), _("Zs3_4"), _("Zs3_5"), _("Zs3_6"), _("Zs3_7"), _("Zs3_8"), _("Zs3_9"), _("Zs3_10"), _("Zs3_11"), _("Zs3_12"), _("Zs3_13"), _("Zs3_14"), _("Zs3_15"), _("Zs3_3_tafel"), _("Zs3_4_tafel"), _("Zs3_5_tafel"), _("Zs3_6_tafel"), _("Zs3_7_tafel"), _("Zs3_8_tafel"), _("Zs3_9_tafel"), _("Zs3_10_tafel"), _("Zs3_11_tafel"), _("Zs3_12_tafel"), _("Zs3_13_tafel"), _("Zs3_14_tafel"), _("Zs3_15_tafel"), _("Zs6"),  _("Zs6_tafel"), _("Zs2_F"), _("Zs2_L"), _("Zs2_M"), _("Zs2_P"), _("Zs2_R"), _("Zs2_S"), _("Zs2_U"), },
			    defaultIndex = 1,
			    tooltip = _("tooltip_zusatz_oben"),
                uiType = "ComboBox",
		    },
		    {
			    key = "mw_mast",
			    name = _("MastType"),
			    values = { _("Amhk"), _("Amnk"), _("Amhl"), _("Fm 4,6"), _("Amshk"), _("Fm 5,8"), _("Fm 5,2"), },
			    defaultIndex = 1,
			    tooltip = _("tooltip_mast"),
                uiType = "ComboBox",
		    },
            {
			    key = "mw_optik",
			    name = _("OptikType"),
			    values = { _("Asig"), _("Esig"), _("Bksig"), _("Msig"), _("MAsig"), _("MEsig"), _("Vsig"), },
			    defaultIndex = 1,
			    tooltip = _("tooltip_optik"),
                uiType = "ComboBox",
		    },
		    {
			    key = "mw_licht",
			    name = _("LichtType"),
			    values = { _("Hp0"), _("Ks1"), _("Ks1b"), _("Ks2"), _("Sh1"), _("Kennlicht"), },
			    defaultIndex = 2,
			    tooltip = _("tooltip_licht"),
                uiType = "Button",
		    },
		    {
			    key = "mw_wiederholer",
			    name = _("WiederholerType"),
			    values = { "1", "2", },
			    defaultIndex = 1,
			    tooltip = _("tooltip_wiederholer"),
                uiType = "CheckBox",
		    },
		    {
			    key = "mw_vkb",
			    name = _("VKBType"),
			    values = { "1", "2", },
			    defaultIndex = 1,
			    tooltip = _("tooltip_vkb"),
                uiType = "CheckBox",
		    },
		    {
			    key = "mw_zusatz_unten1",
			    name = _("ZusatzUnten1Type"),
			    values = { _("ohne"), _("aus"),  _("Zs3_3"), _("Zs3_4"), _("Zs3_5"), _("Zs3_6"), _("Zs3_7"), _("Zs3_8"), _("Zs3_9"), _("Zs3_10"), _("Zs3_11"), _("Zs3_12"), _("Zs3_13"), _("Zs3_14"), _("Zs3_15"), _("Zs3_3_tafel"), _("Zs3_4_tafel"), _("Zs3_5_tafel"), _("Zs3_6_tafel"), _("Zs3_7_tafel"), _("Zs3_8_tafel"), _("Zs3_9_tafel"), _("Zs3_10_tafel"), _("Zs3_11_tafel"), _("Zs3_12_tafel"), _("Zs3_13_tafel"), _("Zs3_14_tafel"), _("Zs3_15_tafel"), _("Zs6"),  _("Zs6_tafel"), _("Zs2_F"), _("Zs2_L"), _("Zs2_M"), _("Zs2_P"), _("Zs2_R"), _("Zs2_S"), _("Zs2_U"), _("Zs13"), },
			    defaultIndex = 1,
			    tooltip = _("tooltip_zusatz_unten1"),
                uiType = "ComboBox",
		    },
		    {
			    key = "mw_zusatz_unten2",
			    name = _("ZusatzUnten2Type"),
			    values = { _("ohne"), _("aus"),  _("Zs3_3"), _("Zs3_4"), _("Zs3_5"), _("Zs3_6"), _("Zs3_7"), _("Zs3_8"), _("Zs3_9"), _("Zs3_10"), _("Zs3_11"), _("Zs3_12"), _("Zs3_13"), _("Zs3_14"), _("Zs3_15"), _("Zs3_3_tafel"), _("Zs3_4_tafel"), _("Zs3_5_tafel"), _("Zs3_6_tafel"), _("Zs3_7_tafel"), _("Zs3_8_tafel"), _("Zs3_9_tafel"), _("Zs3_10_tafel"), _("Zs3_11_tafel"), _("Zs3_12_tafel"), _("Zs3_13_tafel"), _("Zs3_14_tafel"), _("Zs3_15_tafel"), _("Zs6"),  _("Zs6_tafel"), _("Zs2_F"), _("Zs2_L"), _("Zs2_M"), _("Zs2_P"), _("Zs2_R"), _("Zs2_S"), _("Zs2_U"), },
			    defaultIndex = 1,
			    tooltip = _("tooltip_zusatz_unten2"),
                uiType = "ComboBox",
                checkEnabledScript = {
                    fileName = "script/zusatz_unten2_construction.script@checkEnabledFn",
                    params = {
                          key = "mw_mast",
                          threshold = 5,
                    },
                },
		    },
			{
				key = "mw_trackpos",
				name = _("TrackPos"),
				values = { _("left"), _("right") },
                tooltip = _("tooltip_trackpos"),
				defaultIndex = 2,
                uiType = "Button",
			},
			{
				key = "mw_waypoint",
				name = _("Waypoint"),
				values = { _("Yes"), _("No") },
				defaultIndex = 2,
                tooltip = _("tooltip_waypoint"),
                postConstructionModifiable = true,
			},
			{
				key = "mw_oneway",
				name = _("OneWay"),
				values = { _("Yes"), _("No") },
				defaultIndex = 2,
				tooltip = _("tooltip_oneway"),
                postConstructionModifiable = true,
                checkEnabledScript = {
                    fileName = "mw_signalkomponenten::/infrastructure/signal/mw_signalkomponenten/script/oneway_construction.script@checkEnabledFn",
                    params = {
                          key = "mw_waypoint",
                          threshold = 1,
                    },
                },
			},
            {
				key = "mw_offset",
				name = _("Offset"),
				uiType = "Slider",
                values = { _("0m"), _("1m"), _("2m"), _("3m"), _("4m"), _("5m"), _("6m"), _("7m"), _("8m"), _("9m"), _("10m"), _("11m"), _("12m"), _("13m"), _("14m"), _("15m"), _("16m"), _("17m"), _("18m"), _("19m"), _("20m"), },
				defaultIndex = 9,
				tooltip = _("tooltip_offset"),
                postConstructionModifiable = true,
			},
	    },
    }
end
