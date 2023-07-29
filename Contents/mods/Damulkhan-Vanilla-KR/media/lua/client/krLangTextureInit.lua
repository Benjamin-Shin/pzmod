
--Replacing logo on main screen
if MainScreen then
	local old_getTexture = nil;
	local function getTexture2(filename, ...)
		if filename == "media/ui/PZ_Logo_New.png" then
			filename = "media/ui/PZ_Logo_New_KR.png"
		end
		return old_getTexture(filename, ...)
	end
	local old_new = MainScreen.new
	function MainScreen:new(...) --injection (permanent)
		local is_getTexture_patched = nil;
		old_getTexture = getTexture;
		local old_useTextureFiltering = useTextureFiltering;
		useTextureFiltering = function(bool, ...) --injection in injection (tempry)
			if not is_getTexture_patched then
				getTexture = getTexture2 --injection in injection in injection (tempry)
				is_getTexture_patched = true
			end
			return old_useTextureFiltering(bool, ...)
		end
		local o = old_new(self, ...)
		getTexture = old_getTexture
		useTextureFiltering = old_useTextureFiltering
		return o
	end
end



