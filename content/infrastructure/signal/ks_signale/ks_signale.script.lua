function data()

	return {
		updateFn = function(captureParams, params)

		local isLeft = params.mw_ks_trackpos == 1
        local sideSuffix = isLeft and "left" or "right"
        local offset_x = params.mw_ks_offset_x and params.mw_ks_offset_x or 0
        local offset_y = isLeft and 2.15 or -2.15
        local offset_z = 0
        local optikOffset_y = -0.36+offset_y
        local optikOffset_y_green = 0
        local signOffset_x = 0
        local signOffset_y = 0
        local signOffset_z = 0
        local optikOffset_z = 0
        local optikOffset_z_green = 0
        local lichtOffset_y_green = 0
        local lichtOffset_z_green = 0
        local lichtOffset_z_red = 0
        local offset_z_mast = 0
        local mastSelected = params.mw_ks_mast and params.mw_ks_mast or false
        local mastVSelected = params.mw_ks_vmast and params.mw_ks_vmast or false
        local optikSelected = params.mw_ks_optik or 1
        local lichtSelected = params.mw_ks_asig_licht or params.mw_ks_bsig_licht or params.mw_ks_masig_licht or params.mw_ks_masig_asig_licht or params.mw_ks_vlicht
        local showGreenLight = (optikSelected ~= 1 or lichtSelected ~= 1) 
        local isLed = params.mw_ks_led and params.mw_ks_led == 2 or false
        local ledSuffix = isLed and "_led" or ""
        local statusWiederholer = params.mw_ks_wiederholer or 1
        local statusVkb = params.mw_ks_vkb or 1
        local hasKennlicht = false
        local hasPostMaSign = false
        local hasPostVSign = false
        local hasPostHSmallSign = false
        local hasPostHWideSign = false
        local offset = -(offset_x - 1)        
        local mast
        local mastOptikType
        -- light mesh definition
        local licht_hp0 = "hp0"
        local licht_hp0_hp0 = "hp0_hpo"
        local licht_ks1 = "ks1"
        local licht_ks1b = "ks1b"
        local licht_ks2 = "ks2"
        local licht_ks2_vsig = "ks2_vsig"
        local licht_ks2_ks2_vsig = "ks2_ks2_vsig"
        local licht_sh1 = "sh1"
        local licht_oben = "licht_oben"
        local licht_unten = "licht_unten"
        local greenLight = licht_hp0
        local redLight = licht_hp0

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
        
        if ksOptik[optikSelected] ~= 3 and ksOptik[optikSelected] ~= 6 then
            mastOptikType = ksOptik[3]
        else
            mastOptikType = optikType
        end

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


        -- led signal red light
        lichtOffset_z_red = optikOffset_z

        -- lights and their positions
        if lichtSelected == 1 then -- Hp0
      	    redLight = licht_hp0_hp0 -- no animation when hp0
        elseif lichtSelected == 5 then -- Sh1
            lichtOffset_y_green = 0
            lichtOffset_z_green = 0
        end
        
        if optikSelected == 1 then -- Asig
            if lichtSelected == 2 then -- Ks1
                greenLight = licht_ks1
                if isLed == false then
                    lichtOffset_y_green = -0.15
                    lichtOffset_z_green = -0.05
                end
            elseif lichtSelected == 3 then -- Sh1
                greenLight = licht_sh1
            elseif lichtSelected == 4 then -- Kennlicht
                greenLight = licht_oben
                hasKennlicht = true
            elseif lichtSelected == 5 then -- Dunkelschaltung
                showGreenLight = false
            end
        elseif optikSelected == 2 then -- Bsig
            if lichtSelected == 2 then -- Ks1
                greenLight = licht_ks1
                if isLed == false then
                    lichtOffset_y_green = -0.15
                    lichtOffset_z_green = -0.05
                end
            elseif lichtSelected == 3 then
                showGreenLight = false
            end
        elseif optikSelected == 3 or optikSelected == 5 then -- MAsig / MASig Esig
            hasPostMaSign = true
            if lichtSelected == 2 then -- Ks1
                greenLight = licht_ks1
            elseif lichtSelected == 3 then -- Ks1b
                greenLight = licht_ks1b
            elseif lichtSelected == 4 then -- Ks2
                greenLight = licht_ks2
            elseif lichtSelected == 5 then -- Kennlicht
                greenLight = licht_oben
            elseif lichtSelected == 6 then -- Dunkelschaltung
                showGreenLight = false
            end
        elseif optikSelected == 4 then -- MAsig Asig
            hasPostMaSign = true
            if lichtSelected == 2 then -- Ks1
                greenLight = licht_ks1
            elseif lichtSelected == 3 then -- Ks1b
                greenLight = licht_ks1b
            elseif lichtSelected == 4 then -- Ks2
                greenLight = licht_ks2
            elseif lichtSelected == 5 then -- Sh1
                greenLight = licht_sh1
            elseif lichtSelected == 6 then -- Kennlicht
                greenLight = licht_oben
            elseif lichtSelected == 7 then -- Dunkelschaltung
                showGreenLight = false
            end
        elseif optikSelected == 6 then -- Vsig
            redLight = licht_ks2_vsig
            signalType = "WAYPOINT"
            lichtOffset_z_green = lichtOffset_z_green+0.05

            if lichtSelected == 1 then -- Ks 1
                greenLight = licht_ks1
                if isLed then
                    lichtOffset_y_green = lichtOffset_y_green-0.15
                    lichtOffset_z_green = lichtOffset_z_green-0.2
                end
            elseif lichtSelected == 2 then -- Ks1b
                greenLight = licht_ks1b
                if isLed then
                    lichtOffset_y_green = lichtOffset_y_green-0.15
                    lichtOffset_z_green = lichtOffset_z_green-0.2
                end
            elseif lichtSelected == 3 then -- Ks2
                redLight = licht_ks2_ks2_vsig
                showGreenLight = false
            elseif lichtSelected == 4 then -- Kennlicht
                redLight = licht_ks2_ks2_vsig
                showGreenLight = false
                hasKennlicht = true
            elseif lichtSelected == 5 then -- Dunkelschaltung
                showGreenLight = false
            end
        end

        -- signs
        if optikSelected <= 2 then -- Asig, BkSig
            hasPostHSmallSign = true
            if mastSelected == 4 then
                signOffset_y = -0.425
                signOffset_z = 0.8
            elseif mastSelected >= 5 then
                signOffset_x = -0.075
                signOffset_y = 0.55
                signOffset_z = 0.6
                if mastSelected == 6 then
                    signOffset_z = 0.3
                end
            end
            signOffset_x = signOffset_x-0.17
            signOffset_y = signOffset_y-0.575
            signOffset_z = signOffset_z+2.05
        elseif optikSelected >= 3 and optikSelected <= 5 then -- MASig
            hasPostHWideSign = true
            if mastSelected <= 3 then
                signOffset_y = isLeft and 1.1 or 0
                signOffset_z = 0.3
            elseif mastSelected == 4 then
                signOffset_y = isLeft and 1.55 or -0.425
                signOffset_z = 0.8
            elseif mastSelected >= 5 then
                signOffset_x = -0.075
                signOffset_y = 0.55
                signOffset_z = 0.6
                if mastSelected == 6 then
                    signOffset_z = 0.3
                end
            end
            signOffset_x = signOffset_x-0.16
            signOffset_y = signOffset_y-0.55
            signOffset_z = signOffset_z+1.6
        elseif optikSelected == 6 then -- Vsig
            if statusWiederholer == 1 then
                hasPostVSign = true
                signOffset_x = -0.16
                signOffset_z = 2
                if mastVSelected == 1 then
                    signOffset_y = isLeft and 0.6 or -0.6
                elseif mastVSelected == 2 then
                    signOffset_y = isLeft and 1.0 or -1.0
                elseif mastVSelected >= 3 then
                    signOffset_x = -0.23
                    signOffset_y = 0
                    signOffset_z = 2.5
                end
            end
        end

        -- zza
        --[[
					-- zza oben
					{						
						materials = { "ks_signale/misc/ks_signal_misc.mtl", },
						mesh = "ks_signale/halter/ks_zsa_halter_oben.msh",						
						transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -0.36, -2.5, 6.34, 1, },
					},
					{				7		
						materials = { "ks_signale/misc/ks_signal_misc.mtl", "ks_signale/misc/ks_zsa_scheibe.mtl", },
						mesh = "ks_signale/misc/ks_zsa.msh",						
						transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -0.36, -2.5, 6.53, 1, },
					},
					-- zza unten
					{						
						materials = { "ks_signale/misc/ks_signal_misc.mtl", },
						mesh = "ks_signale/halter/ks_zsa_halter.msh",						
						transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -0.19, -2.5, 4.37, 1, },
					},
					{						
						materials = { "ks_signale/misc/ks_signal_misc.mtl", "ks_signale/misc/ks_zsa_scheibe.mtl", },
						mesh = "ks_signale/misc/ks_zsa.msh",						
						transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -0.9, -2.5, 4.55, 1, },
					},
]]

		-- build it
		local edgeModels = {}
        table.insert(edgeModels, {
            edgeOffset = offset,
            model = {
               id = resolve(redLight .. ledSuffix .. ".mdl"),
            	transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -0.45, optikOffset_y, lichtOffset_z_red, 1 }
            }
        })
        if optikSelected ~= 6 and statusWiederholer ~= 1 then 
            table.insert(edgeModels, {
                edgeOffset = offset,
                model = {
                   id = resolve(pzbMagnet),
                	transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, -1.05, 0.02, 1 }
                }
            })
        end
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
               id = resolve("optiken_" .. optikType .. ledSuffix .. ".mdl"),
            	transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -0.45, optikOffset_y, optikOffset_z, 1 }
         	}
        })
        if hasPostHSmallSign then
            table.insert(edgeModels, {
                edgeOffset = offset,
                model = {
                   id = resolve("schild_hsig_schmal.mdl"),
                	transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, signOffset_x, offset_y+signOffset_y, signOffset_z, 1 }
             	}
            })
        elseif hasPostHWideSign then
            table.insert(edgeModels, {
                edgeOffset = offset,
                model = {
                   id = resolve("schild_hsig.mdl"),
                	transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, signOffset_x, offset_y+signOffset_y, signOffset_z, 1 }
             	}
            })
        elseif hasPostVSign then
            table.insert(edgeModels, {
                edgeOffset = offset,
                model = {
                   id = resolve("schild_vsig.mdl"),
                	transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, signOffset_x, offset_y+signOffset_y, signOffset_z, 1 }
             	}
            })
        end
        if hasPostMaSign then
            table.insert(edgeModels, {
                edgeOffset = offset,
                model = {
                   id = resolve("schild_msig.mdl"),
                	transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, signOffset_x, offset_y+signOffset_y, signOffset_z-0.85, 1 }
             	}
            })
        end
        if statusVkb > 1 or hasKennlicht then
            if statusVkb == 2 or hasKennlicht then
                table.insert(edgeModels, {
                    edgeOffset = offset,
                    model = {
                   	    id = resolve(licht_oben .. ".mdl"),
                        transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -0.45, optikOffset_y, optikOffset_z, 1 }
             		}
             	})
            end
            if optikSelected == 6 then -- Vsig
                table.insert(edgeModels, {
                    edgeOffset = offset,
                    model = {
                   	    id = resolve("optik_licht_oben.mdl"),
                        transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -0.45, optikOffset_y, optikOffset_z, 1 }
             		}
             	})
            end
        elseif statusWiederholer >= 2 then
            if statusWiederholer == 2 then
                table.insert(edgeModels, {
                	edgeOffset = offset,
                    model = {
                   	    id = resolve(licht_unten .. ".mdl"),
                        transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -0.45, optikOffset_y, optikOffset_z, 1 }
             		}
             	})
            end
            if optikSelected == 6 then -- Vsig
                table.insert(edgeModels, {
                	edgeOffset = offset,
                    model = {
                   	    id = resolve("optik_licht_unten.mdl"),
                        transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -0.45, optikOffset_y, optikOffset_z, 1 }
             		}
             	})
            end
        end
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
