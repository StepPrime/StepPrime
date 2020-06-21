local player = Var "Player" or GAMESTATE:GetMasterPlayerNumber()

local function Beat(self)
	-- too many locals
	local this = self:GetChildren()
	local playerstate = GAMESTATE:GetPlayerState( player )
	
	local songposition = playerstate:GetSongPosition() -- GAMESTATE:GetSongPosition()
	
	local beat = songposition:GetSongBeat() * songposition:GetCurScroll(player); -- GAMESTATE:GetSongBeat()
	
	local part = beat%1
	part = clamp(part,0,0.5)
	local eff = scale(part,0,0.5,1,0)
	if (songposition:GetDelay() or false) and part == 0 then eff = 0 end
	if beat < 0 then
		eff = 0
	end
	this.Glow:diffusealpha(eff);

	-- Freedom/Dark
	this.Base:diffusealpha(GetCurNSAlpha(player));
	if playerstate:GetPlayerOptions('ModsLevel_Current' ):Dark() == 1 then
		this.Glow:visible(false);
	else
		this.Glow:visible(true);
	end;
end;

return Def.ActorFrame {
	-- COMMANDS --
	InitCommand=cmd(SetUpdateFunction,Beat);
	NOTESKIN:LoadActor(Var "Button", "Ready Receptor")..{
		Name="Base";
		Frames={
			{ Frame = 0, Delay = 0 }
		};
	};
	NOTESKIN:LoadActor(Var "Button", "Ready Receptor")..{
		Name="Glow";
		Frames= {
			{ Frame = 1, Delay = 0 }
		};
		InitCommand=cmd(blend,'BlendMode_Add');
		PressCommand=cmd(finishtweening;linear,0.05;zoom,0.9;linear,0.1;zoom,1);
	};
	
	NOTESKIN:LoadActor(Var "Button", "Ready Receptor")..{
		Name="PumpGlow";
		Frames = { { Frame = 2 } };
		InitCommand=cmd(diffusealpha,0);
		PressCommand=cmd(finishtweening;diffusealpha,1;zoom,1;linear,0.2;zoom,1.2;diffusealpha,0);
	};
}