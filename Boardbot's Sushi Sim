

plr = game.Players.LocalPlayer
plrWorkspace = game.Workspace[plr.Name]

function doCooking(cookFood)
    --find counter
    for i, v in pairs (game.Workspace.Game:GetDescendants()) do
        if v:IsA("Part") and v.Position.x == 14 then
            counterProxy = v.Parent.Base.Attachment.ProximityPrompt
        end
    end
    
    if cookFood == true then
        plr.Character.HumanoidRootPart.CFrame = CFrame.new(14, 37, 36);
    end
    
    while cookFoodGlobal == true do
        wait()
        fireproximityprompt(counterProxy, 1)
    end
end

function doWashing(washDishes)

    if washDishes == true then
        plr.Character.HumanoidRootPart.CFrame = CFrame.new(-3, 37, 24)
    end
    
    while washDishesGlobal == true do
        wait()
        fireproximityprompt(game:GetService("Workspace").Game.Sink1.Base.Attachment.ProximityPrompt, 1)
    end

end
local Finity = loadstring(game:HttpGet("https://raw.githubusercontent.com/Boardbot/sushisimulator/main/sushiUI"))()

local FinityWindow = Finity.new(true)
FinityWindow.ChangeToggleKey(Enum.KeyCode.RightControl)

local TaskCategory = FinityWindow:Category("Auto-Task")

local TaskSector = TaskCategory:Sector("Tasks")

TaskSector:Cheat("Checkbox", "Wash Dishes", function(washDishes) 
    washDishesGlobal = washDishes
    doWashing(washDishesGlobal)
    
end)

TaskSector:Cheat("Checkbox", "Cook Food", function(cookFood)
    cookFoodGlobal = cookFood
    doCooking(cookFoodGlobal)
    
end)

TaskSector:Cheat("Checkbox", "Rest when No Energy", function(rest)
    
    restGlobal = rest
    
    while restGlobal == true do 
        wait()
        if game.Players.LocalPlayer.attributes.Energy.Value <= 1 then
            tempCook = cookFoodGlobal
            tempWash = washDishesGlobal
            cookFoodGlobal = false
            washDishesGlobal = false
            print(tempWash, tempCook, cookFoodGlobal, washDishesGlobal, washDishes, cookFood)
            repeat
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(-11, 37, -24)
                wait(1)
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(-7, 37, -23)
                wait(1)
            until plr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Seated
            
            repeat wait() until game.Players.LocalPlayer.attributes.Energy.Value >= 198 or rest == false or restGlobal == false
            plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
            wait(0.1)
            cookFoodGlobal = cookFood
            washDishesGlobal = washDishes
            
            cookFoodGlobal = tempCook
            washDishesGlobalh = tempWash
            cookFood = tempCook
            washDishes = tempCook
            
            if tempCook == true then
                doCooking(tempCook)
            elseif tempWash == true then
                doWashing(tempWash)
            end
            
        end
    end
    
    
        
    
end)


