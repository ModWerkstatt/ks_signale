function data()

    return {
	    updateFn = function(captureParams, params)

--[[           local isLeft = params.mw_trackpos == 1
            local sideSuffix = isLeft and "left" or "right"
            local offset_x = params.mw_offset_x and params.mw_offset_x or 0
            local offset_y = isLeft and 2.85 or -2.15
            local offset_z = 0
            local optikOffset_y
            local optikOffset_z
            local mastSelected = params.mw_mast
            local optikSelected = params.mw_optik
            local lichtSelected = params.mw_light

            local offset = (params and params.mw_offset) and (params.mw_offset * -1) or 0

            -- signal type
            local signalType = params.mw_waypoint == 1 and "WAYPOINT" or "PATH_SIGNAL"

            -- models
            local pzbMagnet = "mw_signalkomponenten::/infrastructure/signal/mw_signalkomponenten/ks_pzb_1000.mdl"
            local hvKompaktMast = {
		        [1] = "amhl_hoch_" .. sideSuffix .. "_mast.mdl",
		        [2] = "amhl_" .. sideSuffix .. "_mast.mdl",
		        [3] = "fm_5_2_mast.mdl",
		        [4] = "fm_5_8_mast.mdl",
		        [5] = "fm_6_4_mast.mdl",
	        }
            local hvKompaktOptik = {
                [1] = "optiken_asig.mdl",
                [2] = "optiken_esig.mdl",
                [3] = "optiken_bsig.mdl",
                [4] = "optiken_vsig.mdl",
            }
            local hvKompaktLights = {
                [1] = "hp0.mdl",
                [2] = "hp1.mdl",
                [3] = "hp2.mdl",
                [4] = "sh1.mdl",
            }
            local mast = hvKompaktMast[mastSelected and mastSelected or 1]
            local optik = hvKompaktOptik[optikSelected and optikSelected or 1]
            local greenLight = hvKompaktLights[lichtSelected and lichtSelected or 2]
            local redLight = "hp0.mdl"

            -- Asig has Hp00
            if optikSelected == 1 then
                redLight = "hp00.mdl"
            end

            if lichtSelected == 1 then
                redLight = "hp0_hp0.mdl"
                if optikSelected == 1 then
                    redLight = "hp00_hp00.mdl"
                end
            end

            -- if Vsig
            if optikSelected == 4 then
                mast = "amhl_vsig_" .. sideSuffix .. "_mast.mdl"
                if lichtSelected == 1 then
                    greenLight = "vr0_vr0.mdl"
                elseif lichtSelected == 2 then
                    greenLight = "vr1.mdl"
                elseif lichtSelected == 3 then
                    greenLight = "vr2.mdl"
                end
                redLight = "vr0.mdl"
            end


            if mastSelected == 1 then
                optikOffset_y = 2
                optikOffset_z = 7.0
            elseif mastSelected == 2 then
                optikOffset_y = 2
                optikOffset_z = 5.8
            elseif mastSelected == 3 then
                optikOffset_z = 5.1
            elseif mastSelected == 4 then
                optikOffset_z = 5.7
            elseif mastSelected == 5 then
                optikOffset_z = 6.3
            end
            optikOffset_y = -0.36+offset_y


		    -- build it
		    local edgeModels = {}
            table.insert(edgeModels, {
                edgeOffset = offset,
                model = {
                    id = resolve(redLight),
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
                    transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, offset_y, 0, 1 }
                }
            })
            table.insert(edgeModels, {
                edgeOffset = offset,
                model = {
                    id = resolve(optik),
                    transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -0.45, optikOffset_y, optikOffset_z, 1 }
                }
            })
            if optikSelected ~= 1 or lichtSelected  ~= 1 then -- if Hp0 is selected, no extra light
                table.insert(edgeModels, {
                    edgeOffset = offset,
                    model = {
                        id = resolve(greenLight),
                        transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -0.45, optikOffset_y, optikOffset_z, 1 }
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
debugPrint(result)]]
            local edgeModels = {}
            table.insert(edgeModels, {
                model = {
                    id = resolve("mw_signalkomponenten::/infrastructure/signal/mw_signalkomponenten/ks_pzb_1000.mdl"),
                    transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, -1.05, 0.02, 1 }
                }
            })
            local result = {}
		    result.signal = {
			    soundevent = "",
			    type = "PATH_SIGNAL",
		    }
            result.edgeModels = edgeModels
		    result.cost = 20000
		    result.maintenanceCost = 5000
		    return result
	    end
    }

end
