-- printf wrapper
function et.G_Printf(...)
	et.G_Print(string.format(unpack(arg)))
end

spawnGroupRed = 1
spawnGroupBlue = 1

-- called when game inits
function et_InitGame( levelTime, randomSeed, restart )
	--et.G_Printf("cpd_block Mapscript Loaded: et_InitGame")
	--et.G_Printf("VMnum=%d VMname=mapscript\n", et.FindSelf())
	et.RegisterModname("mapscript")
	
	spawnGroupBlue = 1
	
	game.SpawnGroup(TEAM_BLUE, 1, 1)
	game.SpawnGroup(TEAM_BLUE, 2, 0)
	game.SpawnGroup(TEAM_BLUE, 3, 0)
	
	spawnGroupRed = 1
	
	game.SpawnGroup(TEAM_RED, 1, 1)
	game.SpawnGroup(TEAM_RED, 2, 0)
	game.SpawnGroup(TEAM_RED, 3, 0)
	
	game.SetDefender(TEAM_RED)	--Red is defending
	game.SetTimeLimit(15)		--15 min
	
	LTFFlagOwner = TEAM_RED
	HallsFlagLocked = 1
	UCGFlagOwner = TEAM_FREE
	UCGFlagLocked = 1
end

--First Phase
--Gate
FPGateHurtLast = 0

function FPGateHurt(self, inflictor, attacker)
	if ((game.Leveltime() - FPGateHurtLast) < 5000) then
		return 0
	end
	FPGateHurtLast = game.Leveltime()
	et.G_Printf("The Upper Door is taking damage!\n")
end

function FPGateShieldTrigger(self, other)
	et.G_Printf("The Upper Door Shield has dissolved!\n")
end

function FPGateTrigger(self, other)
	et.G_Printf("The Upper Door has been destroyed!\n")
	PhaseOne_End()
end

function PhaseOne_End()
	et.G_Printf("The Lower Fortress has fallen!\n")
	
	spawnGroupRed = 2
	game.SpawnGroup(TEAM_RED, 1, 0)
	game.SpawnGroup(TEAM_RED, 2, 1)
	game.SpawnGroup(TEAM_RED, 3, 0)
	
	spawnGroupBlue = 2
	game.SpawnGroup(TEAM_BLUE, 1, 0)
	game.SpawnGroup(TEAM_BLUE, 2, 1)
	game.SpawnGroup(TEAM_BLUE, 3, 0)
end


--Upper Citadel
--Gate
UCGateHurtLast = 0
function UCGateHurt(self, inflictor, attacker)
	if ((game.Leveltime() - UCGateHurtLast) < 5000) then
		return 0
	end
	UCGateHurtLast = game.Leveltime()
	et.G_Printf("The Upper Citadel Gate is taking damage!\n")
end

function UCGateShieldTrigger(self, other)
	et.G_Printf("The Upper Citadel Gate Shield has dissolved!\n")
end

function UCGateTrigger(self, other)
	et.G_Printf("The Upper Citadel Gate has been destroyed!\n")
	PhaseTwo_End()
end

function PhaseTwo_End()
	et.G_Printf("The Lower Fortress has fallen!\n")
	
	spawnGroupRed = 3
	game.SpawnGroup(TEAM_RED, 1, 0)
	game.SpawnGroup(TEAM_RED, 2, 0)
	game.SpawnGroup(TEAM_RED, 3, 1)
	
	spawnGroupBlue = 3
	game.SpawnGroup(TEAM_BLUE, 1, 0)
	game.SpawnGroup(TEAM_BLUE, 2, 0)
	game.SpawnGroup(TEAM_BLUE, 3, 1)
end

-- Final objective
-- Flag
function EOShieldTrigger(self, other)
	et.G_Printf("The Final Objective Shield has dissolved!\n")
end

function CapFlagUse(self, other, activator)
	et.G_Printf("Objective Captured!\n")
	et.G_Print("Blue team is the winner\n")
	game.SetWinner(TEAM_BLUE)
	et.G_Print("Ending the round\n")
	game.EndRound()
end
