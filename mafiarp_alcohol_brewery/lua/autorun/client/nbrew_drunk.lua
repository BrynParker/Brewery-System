--#NoSimplerr#
NBrew_Drunkness = 0
NBrew_PassOutNext = 0
hook.Add( "CalcView", "NBrew_ScreenSway", function( ply, origin, angle, fov )
	if NBrew_Drunkness == 0 then return end
	local cycle = math.sin( CurTime() )  * NBrew_Drunkness
	angle.roll = angle.roll + cycle * 60
	angle.yaw = angle.yaw + cycle * 30

end)

hook.Add( "RenderScreenspaceEffects", "DrunkEffect", function()
	if NBrew_Drunkness == 0 then return end
	DrawMotionBlur( NBrew_Drunkness, math.min(NBrew_Drunkness * 0.5,0.75), 0.1 )
	DrawSharpen( NBrew_Drunkness * 0.5 , 10 * NBrew_Drunkness)
end )

hook.Add( "CreateMove", "NBrew_MoveChange", function(cmd)
	if NBrew_Drunkness == 0 or (LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP and not LocalPlayer():InVehicle())  then return end
	cmd:SetSideMove(cmd:GetSideMove() + cmd:GetForwardMove() * math.sin( CurTime()  * 2) * NBrew_Drunkness * 0.4 )
end )

hook.Add("Tick","NBrew_Client_Tick",function()
	if NBrew_Drunkness == 0  then return end
	NBrew_Drunkness = NBrew_Drunkness - FrameTime() * 0.004
	if NBrew_Drunkness <= 0 then
		NBrew_Drunkness = 0
	end
	if NBrew_Drunkness > 1.2 and NBrew_PassOutNext < CurTime() then
		NBrew_Drunkness = 1.2
		NBrew_PassOutNext = CurTime() + 30
		LocalPlayer():ScreenFade(SCREENFADE.OUT,Color(0,0,0),10,5)
		timer.Simple(14.5,function()
			net.Start("NBrew_Passing_out")
			net.SendToServer()
			NBrew_Drunkness = 0.2
			LocalPlayer():ScreenFade(SCREENFADE.IN,Color(0,0,0),10,1)
		end)
	end
end)

net.Receive("NBrew_SoberUp",function()
	NBrew_Drunkness = 0
end)