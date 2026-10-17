function data()

    return {
	    checkEnabledFn = function(capturedParams, params)
            if params[capturedParams.key] == 3 or params[capturedParams.key] == 5 then
                return "Enabled"
            else return "Hidden"
            end
        end
    }

end
