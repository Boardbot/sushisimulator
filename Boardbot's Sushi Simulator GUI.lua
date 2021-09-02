-- Made by Boardbot#7385

plr = game.Players.LocalPlayer
plrWorkspace = game.Workspace[plr.Name]
paymentMethodGlobal = 0
paymentMethodGlobalAuto = 0
counterToUse = "Counter 1"
globalItemToBuy = "Vegetables"
sinkProxy = game.Workspace.Game.Sink1.Base.Attachment.ProximityPrompt

-- get all ingredient counters
soyaCounter = game:GetService("Workspace").CounterSoyaSauce.Imp.SurfaceGui.SoyaSauce
platesCounter = game:GetService("Workspace").CounterPlates.Imp.SurfaceGui.Plates
riceCounter = game:GetService("Workspace").CounterRice.Imp.SurfaceGui.Rice
vegCounter = game:GetService("Workspace").CounterVegi.Imp.SurfaceGui.Vegetable
--coffeeCounter
-- regFishCounter
-- premFishCounter

-- get fish counters
-- i know that there  are ingredient values in replicated storage but i wrote this code before realizing that and i'm too lazy to change it so sorry
for i, v in pairs(game.Workspace:GetChildren()) do
    if v.Name == "CounterFish" then 
        
        if v.Imp.SurfaceGui:FindFirstChild("Fish") then
            regFishCounter = v.Imp.SurfaceGui.Fish
        elseif v.Imp.SurfaceGui:FindFirstChild("PremFish") then 
            premFishCounter = v.Imp.SurfaceGui.PremFish
        end
    end
end

-- get coffee counters
for i, v in pairs(game.Workspace.Game:GetDescendants()) do 
    if v:IsA("TextLabel") and v.Name == "Coffee" and v.Parent.Parent.Parent:FindFirstChild("ClickDetector") == nil then
        coffeeCounter = v
    end
end

-- check if there are zero of an ingredient
function FindAmount(text)
    if tostring(string.find(text, "0")) == "6" then return true else return false end
end

--autobuy function
function AutoBuy(ingredientCounter, arg2)
    if FindAmount(ingredientCounter.Text) then
        game.ReplicatedStorage.BuyStockEvent:FireServer(93273987, arg2)
    end
end
    

-- Find all sushi counters
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
    
-- default counter is counter 1
counterProxy = counter1.Base.Attachment.ProximityPrompt


function doCooking(cookFood)
    if cookFoodGlobal == true then
        plr.Character.HumanoidRootPart.CFrame = counterProxy.Parent.Parent.Parent.StandHere.CFrame
    end
    
    while cookFoodGlobal == true do
        wait()
        fireproximityprompt(counterProxy, 1)
    end
end

function doWashing(washDishes)
    if washDishesGlobal == true then
        plr.Character.HumanoidRootPart.CFrame = sinkProxy.Parent.Parent.Parent.StandHere.CFrame
    end
    
    while washDishesGlobal == true do
        wait()
        fireproximityprompt(sinkProxy, 1)
    end
end

-- check if shop is closed or open. will use this in the future to add an option to stop cooking while the shop is closed
function isShopClosed(theTime)
    timeTable = string.split(currentTime, ":")
    minsAndAMPM = string.split(timeTable[2], " ")
    hour = timeTable[1]
    mins = minsAndAMPM[1]
    AMPM = minsAndAMPM[2]
    
    if AMPM == "PM" then
        addMins = 720
    elseif AMPM == "AM" then
        addMins = 0
    end
    
    totalMins = (tonumber(hour) * 60) + tonumber(mins) + addMins
    
    if totalMins >= 1380 or totalMins < 600 then
        return true
    else 
        return false
    end
end

-- uilib
local Finity = loadstring(game:HttpGet("https://raw.githubusercontent.com/Boardbot/sushisimulator/main/sushiUI"))()

local FinityWindow = Finity.new(true)
FinityWindow.ChangeToggleKey(Enum.KeyCode.RightControl)

local TaskCategory = FinityWindow:Category("Main")
local CreditCategory = FinityWindow:Category("Credits")


local TaskSector = TaskCategory:Sector("Tasks")
local TaskSettingsSector = TaskCategory:Sector("Task Settings")
local QuickBuySettings = TaskCategory:Sector("Quick-Buy Settings")
local AutoBuySettings = TaskCategory:Sector("Auto-Stock (when ingredient reaches zero)")
local CreditSector = CreditCategory:Sector("Credits")

TaskSector:Cheat("Checkbox", "Cook Food", function(cookFood)
    cookFoodGlobal = cookFood
    doCooking(cookFoodGlobal)
end)

TaskSector:Cheat("Checkbox", "Wash Dishes", function(washDishes) 
    washDishesGlobal = washDishes
    doWashing(washDishesGlobal)
end)

-- todo: check if player is sitting at sitting spots
TaskSector:Cheat("Checkbox", "Rest when No Energy", function(rest)
    restGlobal = rest
    while restGlobal == true do 
        wait()
        if game.Players.LocalPlayer.attributes.Energy.Value <= 1 then
            tempCook = cookFoodGlobal
            tempWash = washDishesGlobal
             
            repeat
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(-11, 37, -24)
                wait(1)
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(-7, 37, -23)
                wait(1)
            until plr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Seated
            
            repeat wait() until game.Players.LocalPlayer.attributes.Energy.Value >= 198 or rest == false or restGlobal == false
            plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
            wait(0.1)
            
            
            
            
            if tempCook == true then
                doCooking(tempCook)
            elseif tempWash == true then
                doWashing(tempWash)
            end
            
        end
    end
end)

TaskSector:Cheat("Label", "")

-- choose the counter to cook at 
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

-- choose sink to wash at
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

-- i'll add this later
--[[TaskSettingsSector:Cheat("Checkbox", "Stop Cooking While Shop Closed", function(stopCookAtNight)
    
    while stopCookAtNight == true do 
        currentTime = game:GetService("Workspace").Time.SurfaceGui.TextLabel.Text
        if isShopClosed(currentTime) == true then 
            cookFoodGlobal = false
            
    end
    
end)--]]

TaskSettingsSector:Cheat("Label", "")
TaskSettingsSector:Cheat("Label", "")

-- manual quick buy
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

QuickBuySettings:Cheat("Label", "(for Quick-Buy)")

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

QuickBuySettings:Cheat("Label", "")
QuickBuySettings:Cheat("Label", "")
QuickBuySettings:Cheat("Label", "")
QuickBuySettings:Cheat("Label", " ")

--auto buy and stuff
AutoBuySettings:Cheat("Dropdown", "Payment Method", function(paymentMethodAuto)
    if paymentMethodAuto == "Own Wallet" then
        paymentMethodGlobalAuto = 0
    else
        paymentMethodGlobalAuto = 1
    end
end, { 
    options = {
        "Own Wallet",
        "Business Bank"
    }
})

AutoBuySettings:Cheat("Label", "(for Auto-Buy)")

AutoBuySettings:Cheat(
	"Checkbox", -- Type
	"Vegetables", -- Name
	function(buyVeg) -- Callback function
	    
	    while buyVeg == true do 
	        wait(0.1)
	        AutoBuy(vegCounter, 1 + paymentMethodGlobalAuto)
	    end
end)

AutoBuySettings:Cheat(
	"Checkbox", -- Type
	"Regular Fish", -- Name
	function(buyReg) -- Callback function
	    while buyReg == true do 
	        wait(0.1)
	        AutoBuy(regFishCounter, 5 + paymentMethodGlobalAuto)
	    end
end)

AutoBuySettings:Cheat(
	"Checkbox", -- Type
	"Premium Fish", -- Name
	function(buyPrem) -- Callback function
	    while buyPrem == true do 
	        wait(0.1)
	        AutoBuy(premFishCounter, 13 + paymentMethodGlobalAuto)
	    end
end)

AutoBuySettings:Cheat(
	"Checkbox", -- Type
	"Rice", -- Name
	function(buyRice) -- Callback function
	    while buyRice == true do 
	        wait(0.1)
	        AutoBuy(riceCounter, 3 + paymentMethodGlobalAuto)
	    end
end)

AutoBuySettings:Cheat(
	"Checkbox", -- Type
	"Soya Sauce", -- Name
	function(buySoya) -- Callback function
	    while buySoya == true do 
	        wait(0.1)
	        AutoBuy(soyaCounter, 9 + paymentMethodGlobalAuto)
	    end
end)

AutoBuySettings:Cheat(
	"Checkbox", -- Type
	"Coffee Bags", -- Name
	function(buyCoffee) -- Callback function
	    while buyCoffee == true do 
	        wait(0.1)
	        AutoBuy(coffeeCounter, 11 + paymentMethodGlobalAuto)
	    end
end)


-- fin
CreditSector:Cheat("Label", "Everything in this GUI is made by Boardbot#7385")
CreditSector:Cheat("Label", "Feel free to contact me if you have questions or concerns")
