return Def.ActorFrame {

	LoadActor("GLOW 5x2")..{
		Name="PumpGlow";
		Frames = { { Frame = 5 } };
		InitCommand=cmd(diffusealpha,0);
		PressCommand=cmd(finishtweening;diffusealpha,1;zoom,0.9;linear,0.2;zoom,1.13;diffusealpha,0);
	};
	

}