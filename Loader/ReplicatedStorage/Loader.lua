local Player = game:GetService('Players').LocalPlayer

local MainModelZX = workspace:WaitForChild('MainModelZX')


local HumanoidRootPart

local ModelsVisible = {}
local ModelsPosition = {}
local Models = {}




for indexModel, realModel in pairs(MainModelZX:GetDescendants()) do
    if realModel:IsA('Model') then
        Models[indexModel] = realModel
        ModelsVisible[indexModel] = true

        local realModelPosition = realModel:GetModelCFrame().Position
	    ModelsPosition[indexModel] = realModelPosition
    end
end



local function Loadout()

end

local function CharacterAdded(Character)
	if Character then
		HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
	end
end

CharacterAdded(Player.Character)
Player.CharacterAdded:Connect(CharacterAdded)


while true do

    wait()
end







