function data()

	return {
		updateFn = function(captureParams, params)

		local isLeft = params.mw_ks_trackpos == 1
        local sideSuffix = isLeft and "left" or "right"
        local offset_x = params.mw_ks_offset_x and params.mw_ks_offset_x or 0
        local offset_y = isLeft and 2.85 or -2.15
        local offset_z = 0
        local optikOffset_y = -0.36+offset_y
        local optikOffset_y_green = 0
        local optikOffset_z = 0
        local optikOffset_z_green = 0
        local lichtOffset_y_green = 0
        local lichtOffset_z_green = 0
        local offset_z_mast = 0
        local mastSelected = params.mw_ks_mast and params.mw_ks_mast or false
        local mastVSelected = params.mw_ks_vmast and params.mw_ks_vmast or false
        local optikSelected = params.mw_ks_optik or 1
        local lichtSelected = params.mw_ks_asig_licht or params.mw_ks_bsig_licht or params.mw_ks_masig_licht or params.mw_ks_masig_asig_licht or params.mw_ks_vlicht
        local showGreenLight = (optikSelected ~= 1 or lichtSelected ~= 1) 
        local isLed = params.mw_ks_led and params.mw_ks_led == 1
        local ledSuffix = isLed and "_led" or ""

        local offset = -(offset_x - 1)

		-- signal type
        local signalType = params.mw_ks_waypoint == 1 and "WAYPOINT" or "PATH_SIGNAL"
        if params.mw_ks_waypoint == 2 and params.mw_ks_oneway == 1 then
            signalType = "ONE_WAY_PATH_SIGNAL"
        end

        -- models
        local pzbMagnet = "mw_signalkomponenten::/infrastructure/signal/mw_signalkomponenten/ks_pzb_1000.mdl"

        local ksOptik = {
            [1] = "asig",
            [2] = "bksig",
            [3] = "msig",
            [4] = "msig_asig",
            [5] = "msig_esig",
            [6] = "vsig",
        }
        local optikType = ksOptik[optikSelected and optikSelected or 1]
        local mastOptikType
        if optikType ~= "msig" and optikType ~= "vsig" then
            mastOptikType = "msig"
        elseif optikType == "vsig" then
            mastOptikType = "vsig"
        else mastOptikType = optikType
        end

        local mast
        if mastVSelected then
            local ksVMast = {
                [1] = "mast_amhk_vsig_" .. sideSuffix .. ".mdl",
                [2] = "mast_amhl_vsig_" .. sideSuffix .. ".mdl",              
                [3] = "mast_fm_5_2_vsig.mdl",
                [4] = "mast_fm_4_6_vsig.mdl",
            }
            mast = ksVMast[mastVSelected and mastVSelected or 1]
        else
            local ksMast = {
                [1] = "mast_amhk_" .. sideSuffix .. ".mdl",
                [2] = "mast_amshk_" .. mastOptikType .. "_" .. sideSuffix .. ".mdl",
                [3] = "mast_amnk_" .. sideSuffix .. ".mdl",
                [4] = "mast_amhl_" .. sideSuffix .. ".mdl",              
                [5] = "mast_fm_5_8.mdl",
                [6] = "mast_fm_5_2_" .. mastOptikType .. ".mdl",
                [7] = "mast_fm_4_6.mdl",
            }
            mast = ksMast[mastSelected and mastSelected or 1]
        end
        local optik = ksOptik[optikSelected and optikSelected or 1]
        local greenLight = "hp0"
        local redLight = "hp0"


        -- poles and their variants
        if mastSelected then
            if mastSelected == 1 then     -- Amhk
                optikOffset_z = 5.2
                offset_z_mast = -0.2
                optikOffset_y = optikOffset_y + 0.35
            elseif mastSelected == 2 then -- Amshk
                optikOffset_z = 5.9
                offset_z_mast = -0.2
                optikOffset_y = optikOffset_y + 0.35
            elseif mastSelected == 3 then -- Amnk
                optikOffset_z = 4.7
		        offset_z_mast = -0.7
                optikOffset_y = optikOffset_y + 0.35
            elseif mastSelected == 4 then -- Amhl
                optikOffset_z = 6.15
                optikOffset_y = optikOffset_y + 0.35
            elseif mastSelected == 5 then -- Fm 5,8
                optikOffset_y = optikOffset_y + 0.35
                optikOffset_z = 6.0
            elseif mastSelected == 6 then -- Fm 5,2
                optikOffset_y = optikOffset_y + 0.35
                optikOffset_z = 5.5
		        offset_z_mast = -0.6
            elseif mastSelected == 7 then -- Fm 4,6
             	optikOffset_z = 4.8
             	optikOffset_y = optikOffset_y + 0.35
		        offset_z_mast = -0.6
            end
        elseif mastVSelected then
            if mastVSelected == 1 then     -- Amhk
                optikOffset_z = 5.7
                offset_z_mast = -0.2
                optikOffset_y = optikOffset_y + 0.35
            elseif mastVSelected == 2 then -- Amhl
                optikOffset_z = 5.35
                optikOffset_y = optikOffset_y + 0.35
            elseif mastVSelected == 3 then -- Fm 5,2
                optikOffset_z = 5.35
		        offset_z_mast = -0.6
             	optikOffset_y = optikOffset_y + 0.35
            elseif mastVSelected == 4 then -- Fm 4,6
                optikOffset_z = 4.65
             	optikOffset_y = optikOffset_y + 0.35
                offset_z_mast = -0.6
            end
        end

        -- lights and their positions
        if lichtSelected == 1 then -- Hp0
      	    redLight = "hp0_hp0" -- no animation when hp0
        elseif lichtSelected == 5 then -- Sh1
            lichtOffset_y_green = 0
            lichtOffset_z_green = 0
        end
        
        if optikSelected == 1 then -- Asig
            if lichtSelected == 2 then -- Ks1
                lichtOffset_y_green = -0.15
                lichtOffset_z_green = -0.05
                greenLight = "ks1"
            elseif lichtSelected == 3 then -- Sh1
                greenLight = "sh1"
            elseif lichtSelected == 4 then -- Kennlicht
                greenLight = "kennlicht_oben"
            elseif lichtSelected == 5 then -- Dunkelschaltung
                showGreenLight = false
            end
        elseif optikSelected == 2 then -- Bsig
            if lichtSelected == 2 then -- Ks1
                lichtOffset_y_green = -0.15
                lichtOffset_z_green = -0.05
                greenLight = "ks1"
            elseif lichtSelected == 3 then
                showGreenLight = false
            end
        elseif optikSelected == 3 or optikSelected == 5 then -- MAsig / MASig Esig
            if lichtSelected == 2 then -- Ks1
                greenLight = "ks1"
            elseif lichtSelected == 3 then -- Ks1b
                greenLight = "ks1b"
            elseif lichtSelected == 4 then -- Ks2
                greenLight = "ks2"
            elseif lichtSelected == 5 then -- Kennlicht
                greenLight = "kennlicht_oben"
            elseif lichtSelected == 6 then -- Dunkelschaltung
                showGreenLight = false
            end
        elseif optikSelected == 4 then -- MAsig Asig
            if lichtSelected == 2 then -- Ks1
                greenLight = "ks1"
            elseif lichtSelected == 3 then -- Ks1b
                greenLight = "ks1b"
            elseif lichtSelected == 4 then -- Ks2
                greenLight = "ks2"
            elseif lichtSelected == 5 then -- Sh1
                greenLight = "sh1"
            elseif lichtSelected == 6 then -- Kennlicht
                greenLight = "kennlicht_oben"
            elseif lichtSelected == 7 then -- Dunkelschaltung
                showGreenLight = false
            end
        elseif optikSelected == 6 then -- Vsig
            redLight = "ks2_vsig"
            signalType = "WAYPOINT"
            if lichtSelected == 1 then -- Ks 1
                greenLight = "ks1"
            elseif lichtSelected == 2 then -- Ks1b
                greenLight = "ks1b"
            elseif lichtSelected == 3 then -- Ks2
                greenLight = "ks2"
            elseif lichtSelected == 4 then -- Kennlicht
                greenLight = "kennlicht_oben"
            elseif lichtSelected == 5 then -- Dunkelschaltung
                showGreenLight = false
            end
        end


		-- build it
		local edgeModels = {}
        table.insert(edgeModels, {
            edgeOffset = offset,
            model = {
               id = resolve(redLight .. ledSuffix .. ".mdl"),
            	transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -0.45, optikOffset_y, optikOffset_z, 1 }
            }
        })
        table.insert(edgeModels, {
            edgeOffset = offset,
            model = {
               id = resolve(pzbMagnet),
            	transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, -1.05, 0.02, 1 }
            }
        })
        table.insert(edgeModels, {
            edgeOffset = offset,
            model = {
               id = resolve(mast),
               transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, offset_y, offset_z_mast, 1 }
            }
        })
        table.insert(edgeModels, {
            edgeOffset = offset,
            model = {
               id = resolve("optiken_" .. optikType .. ".mdl"),
            	transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -0.45, optikOffset_y, optikOffset_z, 1 }
         	}
        })
        if showGreenLight then -- if Hp0 or Dunkelschaltung is selected, no extra light
         	table.insert(edgeModels, {
            	edgeOffset = offset,
               model = {
               	id = resolve(greenLight .. ledSuffix .. ".mdl"),
                  transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -0.45, optikOffset_y+lichtOffset_y_green, optikOffset_z+lichtOffset_z_green, 1 }
         		}
         	})
        end

        -- result
        local result = {}
		   result.signal = {
			   soundevent = "",
				type = signalType,
		   }
        result.edgeModels = edgeModels
		result.cost = 20000
		result.maintenanceCost = 5000
debugPrint(result)
		return result

	end
	}

end
