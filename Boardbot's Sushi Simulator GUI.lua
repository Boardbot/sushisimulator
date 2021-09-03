-- Made by Boardbot#7385

-- anti afk
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)


plr = game.Players.LocalPlayer
plrWorkspace = game.Workspace[plr.Name]
paymentMethodGlobal = 0
paymentMethodGlobalAuto = 0
counterToUse = "Counter 1"
globalItemToBuy = "Vegetables"
sinkProxy = game.Workspace.Game.Sink1.Base.Attachment.ProximityPrompt
cookFoodCheckbox = false

-- check if there are zero of an ingredient (no longer used)
function FindAmount(text)
    if tostring(string.find(text, "0")) == "6" then return true else return false end
end

--autobuy function
function AutoBuy(ingredientAmount, arg2)
    if ingredientAmount <= 10 then
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
    if cookFoodGlobal == true and plr.Character.HumanoidRootPart.CFrame ~= counterProxy.Parent.Parent.Parent.StandHere.CFrame and washDishesGlobal ~= true then
        plr.Character.HumanoidRootPart.CFrame = counterProxy.Parent.Parent.Parent.StandHere.CFrame * CFrame.Angles(0, math.rad(90), 0)
    end

    fireproximityprompt(counterProxy, 1)
end

function doWashing(washDishes)
    if washDishesGlobal == true and plr.Character.HumanoidRootPart.CFrame ~= sinkProxy.Parent.Parent.Parent.StandHere.CFrame and cookFoodGlobal ~= true then
        plr.Character.HumanoidRootPart.CFrame = sinkProxy.Parent.Parent.Parent.StandHere.CFrame * CFrame.Angles(0, math.rad(270), 0)
    end
    
    fireproximityprompt(sinkProxy, 1)
end

-- check if shop is closed or open. will use this in the future to add an option to stop cooking while the shop is closed
function isShopClosed(theTime)
    timeTable = string.split(theTime, ":")
    minsAndAMPM = string.split(timeTable[2], " ")
    hour = timeTable[1]
    mins = minsAndAMPM[1]
    AMPM = minsAndAMPM[2]
    
    if AMPM == "PM" and hour ~= "12" then
        addMins = 720
    else
        addMins = 0
    end
    
    if hour == "12" and AMPM == "AM" then 
        convertHoursToMins = 0 
    else 
        convertHoursToMins = tonumber(hour) * 60 
    end
    
    totalMins = convertHoursToMins + tonumber(mins) + addMins
    
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
local AutoBuySettings = TaskCategory:Sector("Auto-Restock (When Ingredient Amount is Low)")
local CreditSector = CreditCategory:Sector("Credits")

TaskSector:Cheat("Checkbox", "Cook Food", function(cookFood)
    cookFoodGlobal = cookFood
    cookFoodCheckbox = cookFood
    
    while cookFoodGlobal == true do
        wait()
        doCooking(cookFoodGlobal)
    end
end)

TaskSector:Cheat("Checkbox", "Wash Dishes", function(washDishes) 
    washDishesGlobal = washDishes
    washDishesCheckbox = washDishes
    
    while washDishesGlobal == true do 
        wait()
        doWashing(washDishesGlobal)
    end
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
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(-6, 37, -17)
                wait(0.5)
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(-6, 37, -11)
                wait(0.5)
            until plr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Seated
            
            repeat wait() until game.Players.LocalPlayer.attributes.Energy.Value >= 198 or rest == false or restGlobal == false
            plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
            wait(0.1)

            if tempCook == true and onlyCookDuringClosedGlobal ~= true then
                doCooking(tempCook)
            elseif tempWash == true and onlyWashDuringClosedGlobal ~= true then
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

TaskSettingsSector:Cheat("Checkbox", "Only Cook While Shop is Open", function(onlyCookDuringClosed)
    onlyCookDuringClosedGlobal = onlyCookDuringClosed
    
    while onlyCookDuringClosedGlobal == true do 
        wait()
        if isShopClosed(game.Workspace.Time.SurfaceGui.TextLabel.Text) == false and cookFoodCheckbox == true then 
            cookFoodGlobal = true 
            doCooking(cookFoodGlobal)
        end
        
        if isShopClosed(game.Workspace.Time.SurfaceGui.TextLabel.Text) == true or cookFoodCheckbox == false then
            cookFoodGlobal = false 
        end
    end
end)

TaskSettingsSector:Cheat("Checkbox", "Only Wash Dishes While Shop is Closed", function(onlyWashDuringClosed)
    onlyWashDuringClosedGlobal = onlyWashDuringClosed
    
    while onlyWashDuringClosedGlobal == true do 
        wait()
        if isShopClosed(game.Workspace.Time.SurfaceGui.TextLabel.Text) == true and washDishesCheckbox == true then 
            washDishesGlobal = true 
            doWashing(washDishesGlobal)
        end
        
        if isShopClosed(game.Workspace.Time.SurfaceGui.TextLabel.Text) == false or washDishesCheckbox == false then
            washDishesGlobal = false 
        end
    end
end)

TaskSettingsSector:Cheat("Label", "")

-- manual quick buy
QuickBuySettings:Cheat("Dropdown", "Ingredient", function(itemToBuy)
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
QuickBuySettings:Cheat("Label", " ")
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
	    buyVegGlobal = buyVeg
	    while buyVegGlobal == true do 
	        wait(0.1)
	        AutoBuy(game:GetService("ReplicatedStorage").Settings.Stock.Vegetable.Value, 1 + paymentMethodGlobalAuto)
	    end
end)

AutoBuySettings:Cheat(
	"Checkbox", -- Type
	"Regular Fish", -- Name
	function(buyReg) -- Callback function
	    buyRegGlobal = buyReg
	    while buyRegGlobal == true do 
	        wait(0.1)
	        AutoBuy(game:GetService("ReplicatedStorage").Settings.Stock.Fish.Value, 5 + paymentMethodGlobalAuto)
	    end
end)

AutoBuySettings:Cheat(
	"Checkbox", -- Type
	"Premium Fish", -- Name
	function(buyPrem) -- Callback function
	    buyPremGlobal = buyPrem
	    while buyPremGlobal == true do 
	        wait(0.1)
	        AutoBuy(game:GetService("ReplicatedStorage").Settings.Stock.PremFish.Value, 13 + paymentMethodGlobalAuto)
	    end
end)

AutoBuySettings:Cheat(
	"Checkbox", -- Type
	"Rice", -- Name
	function(buyRice) -- Callback function
	    buyRiceGlobal = buyRice
	    while buyRiceGlobal == true do 
	        wait(0.1)
	        AutoBuy(game:GetService("ReplicatedStorage").Settings.Stock.Rice.Value, 3 + paymentMethodGlobalAuto)
	    end
end)

AutoBuySettings:Cheat(
	"Checkbox", -- Type
	"Soya Sauce", -- Name
	function(buySoya) -- Callback function
	    buySoyaGlobal = buySoya
	    while buySoyaGlobal == true do 
	        wait(0.1)
	        AutoBuy(game:GetService("ReplicatedStorage").Settings.Stock.SoyaSauce.Value, 9 + paymentMethodGlobalAuto)
	    end
end)

AutoBuySettings:Cheat(
	"Checkbox", -- Type
	"Coffee Bags", -- Name
	function(buyCoffee) -- Callback function
	    buyCoffeeGlobal = buyCoffee
	    while buyCoffeeGlobal == true do 
	        wait(0.1)
	        AutoBuy(game:GetService("ReplicatedStorage").Settings.Stock.Coffee.Value, 11 + paymentMethodGlobalAuto)
	    end
end)

-- fin
CreditSector:Cheat("Label", "Everything in this GUI is made by Boardbot#7385")
CreditSector:Cheat("Label", "Feel free to contact me if you have questions or concerns")
