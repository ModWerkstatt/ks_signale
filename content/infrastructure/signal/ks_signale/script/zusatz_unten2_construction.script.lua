function data()

    return {
	    checkEnabledFn = function(capturedParams, params)
            return params[capturedParams.key] < capturedParams.threshold and "Disabled" or "Enabled"
        end,
    }

end
