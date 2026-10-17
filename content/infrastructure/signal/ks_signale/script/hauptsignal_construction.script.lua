function data()

    return {
	    checkEnabledFn = function(capturedParams, params)
            return params[capturedParams.key] < capturedParams.threshold and "Enabled" or "Hidden"
        end,
    }

end
