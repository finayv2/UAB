getgenv().BypassMode = true
getgenv().Executed = false


if not syn then print("Exploit not supported") return end


rconsoleclear()

for i,v in pairs(getconnections(game:GetService("ScriptContext").Error)) do
    v:Disable()
end

rconsolename("Universal Anticheat Bypass - finay#1197 (346165398846046208)")

rconsoleprint('\nUniversal Anticheat Bypass - Scanning Instances...\n')

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall

setreadonly(mt, false)

for i,v in pairs(getnilinstances()) do
    if v:IsA("LocalScript") or v:IsA("ModuleScript") then
        if not string.find(decompile(v, 30), "Synapse X generated script.") then
            if getgenv().BypassMode then
                for p,connection in pairs(getconnections(v.Changed)) do
                    connection:Disable()
                end
            end
            rconsoleprint('@@RED@@')
            rconsoleprint('\n'.. v.ClassName .. ' Detected in NIL : '.. v.Name)
        end
    end
end

local Whitelisted = {
    [1] = "Frame_MessageLogDisplay";
    [2] = "MessageLogDisplay";
    [3] = "Logo"
}

--GetDescendants

local DetectedScripts = {}

for I,V in pairs(game:GetChildren()) do
    if V.Name == "Workspace" or V.Name == "Players" or V.Name == "ReplicatedFirst" or V.Name == "StarterPlayer" or V.Name == "StarterPack" or V.Name == "StarterGui" or V.Name == "ReplicatedStorage" then
        for i,v in pairs(V:GetDescendants()) do
            if string.find(string.lower(v.Name), "anti") or string.match(string.lower(v.Name), "exploit") or string.match(string.lower(v.Name), "kick") or string.match(string.lower(v.Name), "log") or string.match(string.lower(v.Name), "cheat") then
                if v.Name == "MessageLogDisplay" or v.Name == "Frame_MessageLogDisplay" or v.Name == "Logo" then
                else
                    if getgenv().BypassMode then
                        for p,connection in pairs(getconnections(v.Changed)) do
                            connection:Disable()
                        end
                    end
                    rconsoleprint('@@RED@@')
                    rconsoleprint('\n'.. v.ClassName .. ' Detected in '.. v.Parent.Name .. ' : '.. v.Name)

                    if v:IsA("LocalScript") then
                        DetectedScripts[#DetectedScripts + 1] = v      
                    end 

                end
            end
        end
    end
end

--rconsolewarn
rconsoleprint('@@WHITE@@')

rconsoleprint('@@WHITE@@')

hookfunction(game.Players.LocalPlayer.Kick, newcclosure(function(Player, ...)
    local KickReason = {...}

    rconsoleprint('@@YELLOW@@')

    rconsoleprint(''..getcallingscript().Name..' Attempted To Kick you reason: '.. '"' .. unpack(KickReason)..'"')
end))

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local Method = getnamecallmethod()


    if Method == "Kick" then
        rconsoleprint('@@WHITE@@')

        rconsolewarn(''..getcallingscript().Name..' Attempted To Kick you reason: '.. '"' .. unpack(args)..'"')

        return wait(9e9)
    end



    if string.find(string.lower(self.Name), "anti") or string.match(string.lower(self.Name), "exploit") or string.match(string.lower(self.Name), "kick") or string.match(string.lower(self.Name), "log") or string.match(string.lower(self.Name), "cheat") then
        if not checkcaller() then
            if not self.Name == "Frame_MessageLogDisplay" or not self.Name == "sex" then
                rconsoleprint('@@WHITE@@')

                rconsolewarn(''..self.Name..' Fired With Trigger Word args: '.. unpack(args))

                if getgenv().BypassMode then
                    return wait(9e9)
                end
            end
        end
    end

    return oldNamecall(self, unpack(args))
end)

OldHook = hookfunction(Instance.new'RemoteEvent'.FireServer, newcclosure(function(Remote, ...)
    local HookArgs = {...}

    rconsoleprint('@@YELLOW@@')
    rconsolewarn(''..Remote.Name..' Fired With .FireServer args: '.. unpack(HookArgs))

    if getgenv().BypassMode then
        return wait(9e9)
    end
    
    return OldHook(Remote, unpack(HookArgs))
end))

VeryOlderHook = hookfunction(Instance.new'RemoteFunction'.InvokeServer, newcclosure(function(Remote, ...)
    local InvokeHookArgs = {...}

    rconsoleprint('@@YELLOW@@')
    rconsolewarn(''..Remote.Name..' Fired With .InvokeServer args: '.. unpack(InvokeHookArgs))

    if getgenv().BypassMode then
        return wait(9e9)
    end
    
    return VeryOlderHook(Remote, unpack(InvokeHookArgs))
end))

rconsoleprint('\nUniversal Anticheat Bypass - Scanning Complete!\n\n')

for i,v in pairs(game:GetService("JointsService"):GetChildren()) do
    if v:IsA("RemoteEvent") then
        rconsolewarn('Universal Anticheat Bypass - Bypassed Adnois Anticheat')
        v:Destroy()
    end
end

if getgenv().BypassMode then

    for i = 1, #DetectedScripts do
        DetectedScripts[i].Disabled = true
        DetectedScripts[i]:Remove()
    end

    if #DetectedScripts >= 1 then
        rconsoleprint('\nUniversal Anticheat Bypass - Bypass Successful\n\n')
    else
        rconsoleprint('\nUniversal Anticheat Bypass - Nothing to Bypass\n\n')
    end
end

getgenv().Executed = true
