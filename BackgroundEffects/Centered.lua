local Color1 = color(Var "Color1");
local stretchBG = PREFSMAN:GetPreference("StretchBackgrounds")



local t = Def.ActorFrame {
	LoadActor(Var "File1") .. {
		OnCommand=function(self)
			self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y)
			
			if stretchBG then
				self:SetSize(SCREEN_WIDTH,SCREEN_HEIGHT)
			else
				self:scaletofit(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
			end

			self:diffuse(Color1)
			self:effectclock("music")
			self:loop(false)
			
		end;
		GainFocusCommand=cmd(play);
		LoseFocusCommand=cmd(pause);
	};
};


return t;
