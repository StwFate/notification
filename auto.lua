--{{AUTO SWING TO TREE}}

local speaker = game.Players.LocalPlayer
char = speaker.Character
root = char.HumanoidRootPart
getgenv().Pickup = game:GetService("ReplicatedStorage").Events.Pickup

--{{VARIABLES}}



local swingtable = {

}

function swings()
spawn(function()
for i,v in pairs(game:GetService("Workspace").Resources:GetChildren()) do
    if v.Name == "Sun Tree" or v.Name == "Big Sun Tree" then
        if v then
            if (v.Reference.Position - root.Position).magnitude < 25 then
                table.insert(swingtable,v.Reference)
                table.insert(swingtable,v.Trunk)
                table.insert(swingtable,v.Foliage)
                local times = domathforsuntree()
                game:GetService("ReplicatedStorage").Events.SwingTool:FireServer(swingtable)
                for i=1,times do
                    wait(0.5)
                game:GetService("ReplicatedStorage").Events.SwingTool:FireServer(swingtable)
                end
            end
        end
    end
end
end)
end

function near()
    local maxdist = math.huge
    local target = nil
    
    for i,v in pairs(game:GetService("Workspace").Resources:GetChildren()) do
        if v.Name == "Sun Tree" or v.Name == "Big Sun Tree" then
            local dist = (root.Position - v.Reference.Position).magnitude
            if dist < maxdist then
                maxdist = dist
                target = v
                if (v.Reference.Position - root.Position).magnitude < (root.Position - target.Reference.Position).magnitude then
                    target = v
                end
            end
        end
    end
    return target
end

local autoswingtable = {}

function domathforsuntree()
    local m = near()

                local value = m.Health
                local a1,a2,a3,a4,a5,a6
                a1 = 1
                a2 = m.Health.Value
                a3 = 20
                repeat
                a1 = a1 + 1
                a2 = a2 - 20
                until a2 == 0
                return a1

end

function autoswing()
    local times = domathforsuntree()
   local target = near()
   table.insert(autoswingtable, target.Foliage)
   table.insert(autoswingtable, target.Trunk)
   table.insert(autoswingtable, target.Reference)
   root.CFrame = root.CFrame + Vector3.new(0,20000,0)
   wait(0.2)
   root.CFrame = autoswingtable[3].CFrame + Vector3.new(0,25,0)
   for i=1,times do
       game:GetService("ReplicatedStorage").Events.SwingTool:FireServer(autoswingtable)
       wait(0.5)
    end
end

autoswing()