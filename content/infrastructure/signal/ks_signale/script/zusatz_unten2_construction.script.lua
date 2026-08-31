function data()

    return {
	    checkEnabledFn = function(capturedParams, params)
            if params[capturedParams.key] == 2 or params[capturedParams.key] == 5 or params[capturedParams.key] == 6 then
                return "Enabled"
            end
            return "Disabled"
        end,
    }

end
