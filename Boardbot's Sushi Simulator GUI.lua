-- Made by Boardbot#7385

plr = game.Players.LocalPlayer
plrWorkspace = game.Workspace[plr.Name]
paymentMethodGlobal = 0
counterToUse = "Counter 1"
globalItemToBuy = "Vegetables"
sinkProxy = game.Workspace.Game.Sink1.Base.Attachment.ProximityPrompt

-- Find all counters
for i,v in pairs(game.Workspace.Game:GetDescendants()) do
    if v:IsA("Part") and v.Position.x == 14 and v.Parent:FindFirstChild("Using") then
        counter1 = v.Parent
    end
    if v:IsA("Part") and v.Position.x == 3 and v.Parent:FindFirstChild("Using") then
        counter2 = v.Parent
    end
    if v:IsA("Part") and v.Position.x == 11 and v.Parent:FindFirstChild("Using") then
        counter3 = v.Parent
    end
    if v:IsA("Part") and v.Position.x == 0 and v.Parent:FindFirstChild("Using") then
        counter4 = v.Parent
    end
end
    
counterProxy = counter1.Base.Attachment.ProximityPrompt

function doCooking(cookFood)
    if cookFood == true then
        plr.Character.HumanoidRootPart.CFrame = counterProxy.Parent.Parent.Parent.StandHere.CFrame
    end
    
    while cookFoodGlobal == true do
        wait()
        fireproximityprompt(counterProxy, 1)
    end
end

function doWashing(washDishes)
    if washDishes == true then
        plr.Character.HumanoidRootPart.CFrame = sinkProxy.Parent.Parent.Parent.StandHere.CFrame
    end
    
    while washDishesGlobal == true do
        wait()
        fireproximityprompt(sinkProxy, 1)
    end
end

local Finity = loadstring(game:HttpGet("https://raw.githubusercontent.com/Boardbot/sushisimulator/main/sushiUI"))()

local FinityWindow = Finity.new(true)
FinityWindow.ChangeToggleKey(Enum.KeyCode.RightControl)

local TaskCategory = FinityWindow:Category("Main")
local CreditCategory = FinityWindow:Category("Credits")


local TaskSector = TaskCategory:Sector("Tasks")
local TaskSettingsSector = TaskCategory:Sector("Settings")
local QuickBuySettings = TaskCategory:Sector("Quick-Buy Settings")
local CreditSector = CreditCategory:Sector("Credits")

TaskSector:Cheat("Checkbox", "Cook Food", function(cookFood)
    cookFoodGlobal = cookFood
    doCooking(cookFoodGlobal)
end)

TaskSector:Cheat("Checkbox", "Wash Dishes", function(washDishes) 
    washDishesGlobal = washDishes
    doWashing(washDishesGlobal)
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

TaskSector:Cheat("Label", "")

TaskSettingsSector:Cheat("Dropdown", "Select Cooking Counter", function(counterSetting)
    if counterSetting == "Counter 1" then 
        counterProxy = counter1.Base.Attachment.ProximityPrompt
    elseif counterSetting == "Counter 2" then 
        counterProxy = counter2.Base.Attachment.ProximityPrompt
    elseif counterSetting == "Counter 3" then 
    counterProxy = counter3.Base.Attachment.ProximityPrompt
    elseif counterSetting == "Counter 4" then 
    counterProxy = counter4.Base.Attachment.ProximityPrompt
    end
end, {
    options = {
        "Counter 1",
        "Counter 2",
        "Counter 3",
        "Counter 4"
    }
})

TaskSettingsSector:Cheat("Dropdown", "Select Sink", function(sinkSetting)
    if sinkSetting == "Sink 1" then
        sinkProxy = game.Workspace.Game.Sink1.Base.Attachment.ProximityPrompt
    elseif sinkSetting == "Sink 2" then
        sinkProxy = game.Workspace.Game.Sink2.Base.Attachment.ProximityPrompt
    end
end, {
    options = {
        "Sink 1",
        "Sink 2"
    }
})

QuickBuySettings:Cheat("Dropdown", "Item", function(itemToBuy)
    globalItemToBuy = itemToBuy
end, {
    options = {
        "Vegetables",
        "Regular Fish",
        "Premium Fish",
        "Rice",
        "Soya Sauce",
        "Coffee Bags"
    }
})

QuickBuySettings:Cheat("Dropdown", "Payment Method", function(paymentMethod)
    if paymentMethod == "Own Wallet" then
        paymentMethodGlobal = 0
    else
        paymentMethodGlobal = 1
    end
end, { 
    options = {
        "Own Wallet",
        "Business Bank"
    }
})

QuickBuySettings:Cheat("Label", "")

QuickBuySettings:Cheat("Button", "", function()
    
    if globalItemToBuy == "Vegetables" then
        game.ReplicatedStorage.BuyStockEvent:FireServer(93273987, 1 + paymentMethodGlobal)
    elseif globalItemToBuy == "Regular Fish" then
        game.ReplicatedStorage.BuyStockEvent:FireServer(93273987, 5 + paymentMethodGlobal)
    elseif globalItemToBuy == "Premium Fish" then
        game.ReplicatedStorage.BuyStockEvent:FireServer(93273987, 13 + paymentMethodGlobal)
    elseif globalItemToBuy == "Rice" then
        game.ReplicatedStorage.BuyStockEvent:FireServer(93273987, 3 + paymentMethodGlobal)
    elseif globalItemToBuy == "Soya Sauce" then
        game.ReplicatedStorage.BuyStockEvent:FireServer(93273987, 9 + paymentMethodGlobal)
    elseif globalItemToBuy == "Coffee Bags" then
        game.ReplicatedStorage.BuyStockEvent:FireServer(93273987, 11 + paymentMethodGlobal)

    end
    
end, "Press to Buy Item")

CreditSector:Cheat("Label", "Everything in this GUI is made by Boardbot#7385")
CreditSector:Cheat("Label", "Feel free to contact me if you have questions or concerns")
