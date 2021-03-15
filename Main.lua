rconsoleclear()

getgenv().BypassMode = true

local bluec, redc, yellowc, whitec = function(...) rconsoleprint('@@BLUE@@') rconsoleprint(...) end, function(...) rconsoleprint('@@RED@@') rconsoleprint(...) end, function(...) rconsoleprint('@@YELLOW@@') rconsoleprint(...) end, function(...) rconsoleprint('@@WHITE@@') rconsoleprint(...) end

for i,v in pairs(getconnections(game:GetService("ScriptContext").Error)) do v:Disable() end

rconsolename("Universal Anticheat Bypass - finay#1197 (346165398846046208)")

whitec('Universal Anticheat Bypass - Scanning Instances...\n\n')

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall

setreadonly(mt, false)

local DetectedScripts = {}
local DetectedRemotes = {}

for i,v in pairs(getnilinstances()) do
    if v:IsA("LocalScript") or v:IsA("ModuleScript") then
        if not string.find(decompile(v, 30), "Synapse X generated script.") then
            if getgenv().BypassMode then
                for p,connection in pairs(getconnections(v.Changed)) do
                    connection:Disable()
                end
            end

            DetectedScripts[#DetectedScripts + 1] = v    

            redc(v.ClassName .. ' Detected in NIL : '.. v.Name.. "\n")
        end
    elseif v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
        redc(v.ClassName .. ' Detected in NIL : '.. v.Name.. "\n")

        DetectedRemotes[#DetectedRemotes + 1] = v.Name
    end
end

for I,V in pairs(game:GetChildren()) do
    if V.Name == "Workspace" or V.Name == "Players" or V.Name == "ReplicatedFirst" or V.Name == "StarterPlayer" or V.Name == "StarterPack" or V.Name == "StarterGui" or V.Name == "ReplicatedStorage" then
        for i,v in pairs(V:GetDescendants()) do
            if string.find(string.lower(v.Name), "anti") or string.match(string.lower(v.Name), "exploit") or string.match(string.lower(v.Name), "kick") or string.match(string.lower(v.Name), "log") or string.match(string.lower(v.Name), "cheat") then
                if v.Name == "MessageLogDisplay" or v.Name == "Frame_MessageLogDisplay" or v.Name == "Logo" or v.Name == "Dialogue" then
                else
                    if not string.match(string.lower(v.Name), "logo") then
                        if getgenv().BypassMode then
                            for p,connection in pairs(getconnections(v.Changed)) do
                                connection:Disable()
                            end
                        end

                        redc(v.ClassName .. ' Detected in '.. v:GetFullName() .. ' : '.. v.Name .. "\n")

                        if v:IsA("LocalScript") then
                            DetectedScripts[#DetectedScripts + 1] = v    
                        elseif v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                            DetectedRemotes[#DetectedRemotes + 1] = v.Name
                        end  
                    end

                end
            end
        end
    end
end

function CheckNilRemotes(Instance)
    for i,v in pairs(DetectedRemotes) do
        if Instance.Name == v then
            return true
        end
    end
end

hookfunction(game.Players.LocalPlayer.Kick, newcclosure(function(Player, ...)
    local KickReason = {...}

    yellowc('\n'..getcallingscript():GetFullName()..' Attempted To Kick you reason: '.. '"' .. unpack(KickReason)..'"')

    return wait(9e9)
end))

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local Method = getnamecallmethod()


    if Method == "Kick" then
        if not checkcaller() then
            whitec('\n'..getcallingscript():GetFullName()..' Attempted To Kick you reason: '.. '"' .. unpack(args)..'"')

            return wait(9e9)
        end
    end


    if Method == "GetPropertyChangedSignal" then
        if not checkcaller() then
            whitec("niggP")
            if args[1] == "Disabled" then
                whitec('\n'..getcallingscript():GetFullName() ..' Attempted To Call Signal '.. '"' .. args[1] ..'"') 

                return
            end
        end
    end


    if Method == "FireServer" and string.find(string.lower(self.Name), "anti") or string.match(string.lower(self.Name), "exploit") or string.match(string.lower(self.Name), "kick") or string.match(string.lower(self.Name), "log") or string.match(string.lower(self.Name), "cheat") or CheckNilRemotes(self) then
        if not checkcaller() then
            if self.Name == "Frame_MessageLogDisplay" or self.Name == "sex" then
            else
                yellowc('\n'.. self.Name ..' Fired With Trigger Word args: '.. '"' .. unpack(args)..'"')

                if getgenv().BypassMode then
                    redc('\nBlocked '.. self.Name .. " From Firing!")
                    return wait(9e9)
                end
            end
        end
    end

    return oldNamecall(self, unpack(args))
end)

FireHook, InvokeHook = hookfunction(Instance.new'RemoteEvent'.FireServer, newcclosure(function(Remote, ...)
    local HookArgs = {...}

    yellowc(Remote.Name..' Fired With .FireServer args: '.. unpack(HookArgs))

    if getgenv().BypassMode then
        return wait(9e9)
    end
    
    return FireHook(Remote, unpack(HookArgs))
end)), hookfunction(Instance.new'RemoteFunction'.InvokeServer, newcclosure(function(Remote, ...)
    local InvokeHookArgs = {...}

    yellowc(Remote.Name..' Fired With .InvokeServer args: '.. unpack(InvokeHookArgs))

    if getgenv().BypassMode then
        return wait(9e9)
    end
    
    return InvokeHook(Remote, unpack(InvokeHookArgs))
end))


whitec('\nUniversal Anticheat Bypass - Scanning Complete!\n\n')

for i,v in pairs(game:GetService("JointsService"):GetChildren()) do
    if v:IsA("RemoteEvent") then
        bluec('Universal Anticheat Bypass - Bypassed Adnois Anticheat')
        v:Destroy()
    end
end

if getgenv().BypassMode then

    for i = 1, #DetectedScripts do
        if DetectedScripts[i]:IsA("LocalScript") then
            DetectedScripts[i].Disabled = true
        end
        DetectedScripts[i]:Remove()
    end

    if #DetectedScripts >= 1 then
        bluec('\n\nUniversal Anticheat Bypass - Bypass Successful\n')
    end

end

if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("LocalScript") then

    hookfunction(game.GetDescendants, function()
        if not checkcaller() then
            return {}
        end
    end)
    
    bluec('\nUniversal Anticheat Bypass - Cystral AC\n')
end
