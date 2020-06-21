local player = Var "Player" or GAMESTATE:GetMasterPlayerNumber()

local function Beat(self)
	-- too many locals
	local this = self:GetChildren()
	local playerstate = GAMESTATE:GetPlayerState( player )
	local songposition = playerstate:GetSongPosition() -- GAMESTATE:GetSongPosition()
	
	local beat = songposition:GetSongBeat(); -- GAMESTATE:GetSongBeat()
	
	local part = beat%1
	part = clamp(part,0,1)
	local eff = scale(part,0,0.5,1,0)
	if (songposition:GetDelay() or false) and part == 0 then eff = 0 end
	if beat < 0 then
		eff = 0
	end
	eff = scale(eff,0,1,0,0.6)
	this.Glow:diffusealpha(eff);
	
	if playerstate:GetPlayerOptions('ModsLevel_Preferred' ):Dark() == 1 then
		this.Glow:diffusealpha(0);
		this.Base:diffusealpha(0);
	end;
end


return Def.ActorFrame {
	InitCommand=cmd(SetUpdateFunction,Beat);
	LoadActor("BASE 1x2")..{
		Name="Base";
		InitCommand=cmd(pause;setstate,0;zoom,0.97);
	};
	
	
	NOTESKIN:LoadActor(Var "Button", "Ready Receptor")..{
		Name="PumpGlow";
		Frames = { { Frame = 2 } };
		InitCommand=cmd(diffusealpha,0);
		PressCommand=cmd(finishtweening;diffusealpha,1;zoom,0.9;linear,0.2;zoom,1;diffusealpha,0);
	};
	
	LoadActor("BASE 1x2")..{
		Name="Glow";
		InitCommand=cmd(pause;setstate,1;blend,"BlendMode_Add";zoom,0.97);

	};
}