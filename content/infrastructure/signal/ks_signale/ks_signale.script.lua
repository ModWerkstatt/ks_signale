function data()

	return {
		updateFn = function(captureParams, params)

			local isLeft = params.mw_ks_trackpos == 1
         local sideSuffix = isLeft and "left" or "right"
         local offset_x = params.mw_ks_offset_x and params.mw_ks_offset_x or 0
         local offset_y = isLeft and 2.85 or -2.15
         local offset_z = 0
         local optikOffset_y = -0.36+offset_y
         local optikOffset_z = 0
         local offset_z_mast = 0
         local mastSelected = params.mw_ks_mast
         local optikSelected = params.mw_ks_optik
         local lichtSelected = params.mw_ks_licht

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

         local ksMast = {
		   	[1] = "mast_amhk_" .. sideSuffix .. ".mdl",
		      [2] = "mast_amshk_" .. mastOptikType .. "_" .. sideSuffix .. ".mdl", -- msig oder vsig
		      [3] = "mast_amnk_" .. sideSuffix .. ".mdl",
		      [4] = "mast_amhl_" .. sideSuffix .. ".mdl",		      
		      [5] = "mast_fm_5_8.mdl",
		      [6] = "mast_fm_5_2_" .. mastOptikType .. ".mdl", -- msig oder vsig
		      [7] = "mast_fm_4_6.mdl",
	      }
         local ksLights = {
            [1] = "hp0.mdl",
            [2] = "ks1.mdl",
            [3] = "ks1b.mdl",
            [4] = "ks2.mdl",
            [5] = "sh1.mdl",
            [6] = "kennlicht.mdl",
         }
         local mast = ksMast[mastSelected and mastSelected or 1]
         local optik = ksOptik[optikSelected and optikSelected or 1]
         local greenLight = ksLights[lichtSelected and lichtSelected or 2]
         local redLight = "hp0.mdl"
         
         if lichtSelected == 1 then
      		redLight = "hp0_hp0.mdl"
      	end

         if mastSelected == 1 then     -- Amhk
            optikOffset_z = 5.4
         elseif mastSelected == 2 then -- Amshk
            optikOffset_z = 6.1
         elseif mastSelected == 3 then -- Amnk
            optikOffset_z = 5.4
				offset_z_mast = -0.6
         elseif mastSelected == 4 then -- Amhl
            optikOffset_z = 7.0
         elseif mastSelected == 5 then -- Fm 5,8
            optikOffset_y = 0.35
            optikOffset_z = 5.7
         elseif mastSelected == 6 then -- Fm 5,2
            optikOffset_y = 0.35
            optikOffset_z = 5.1
				offset_z_mast = -0.6
         elseif mastSelected == 7 then -- Fm 4,6
         	optikOffset_z = 4.8
         	optikOffset_y = optikOffset_y + 0.25
				offset_z_mast = -0.6
         end


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
debugPrint(result)
			return result
		end
	}

end