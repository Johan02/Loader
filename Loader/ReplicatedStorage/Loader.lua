local Player = game:GetService('Players').LocalPlayer

local MainModelZX = workspace:WaitForChild('LoadObjects')

local RenderDistance = 500


local HumanoidRootPart

local ModelsVisible = {}
local ModelsPosition = {}
local Models = {}
local LastModelLoaded = 0



for indexModel, realModel in pairs(MainModelZX:GetDescendants()) do
	if realModel:IsA('Model') then
		Models[indexModel] = realModel
		ModelsVisible[indexModel] = true

		local realModelPosition = realModel:GetModelCFrame().Position
		ModelsPosition[indexModel] = {realModelPosition.X, realModelPosition.Y, realModelPosition.Z}
	elseif realModel:IsA('BasePart') and realModel.Parent:IsA('Folder') then
		Models[indexModel] = realModel
		ModelsVisible[indexModel] = true

		local realModelPosition = realModel.CFrame.Position
		ModelsPosition[indexModel] = {realModelPosition.X, realModelPosition.Y, realModelPosition.Z}
		
	end
end


local function Loadout(realIndexModel, Visible)
	for indexModel, realModel in pairs(Models) do
		if realIndexModel == indexModel then
			for indexVisibleModel, visibleModel in pairs(ModelsVisible) do
				if indexVisibleModel == realIndexModel then


					if Visible == true then
						ModelsVisible[realIndexModel] = Visible
						Models[realIndexModel].Parent = MainModelZX
					elseif Visible == false then
						ModelsVisible[realIndexModel] = Visible
						Models[realIndexModel].Parent = nil
					end


					--[[if ModelsVisible[realIndexModel] == true then
						
						ModelsVisible[realIndexModel] = false
						Models[realIndexModel].Parent = nil
						
					
					end]]
				end
			end
		end
	end

end

local function SingleLoadout(realIndexModel, Visible)
	if Visible == true and ModelsVisible[realIndexModel] == false then
		ModelsVisible[realIndexModel] = Visible
		Models[realIndexModel].Parent = MainModelZX
	elseif Visible == false and ModelsVisible[realIndexModel] == true then
		ModelsVisible[realIndexModel] = Visible
		Models[realIndexModel].Parent = nil
	end
end

local function GetDistance(LastIndexModelLoaded)
	if not HumanoidRootPart then return	end
	for indexModel, modelPosition in pairs(ModelsPosition) do
		local realModelPosition = Vector3.new(modelPosition[1], modelPosition[2], modelPosition[3])
		if (HumanoidRootPart.Position - realModelPosition).Magnitude > RenderDistance then
			--print(indexModel)
			SingleLoadout(indexModel, false)
		elseif (HumanoidRootPart.Position - realModelPosition).Magnitude <= RenderDistance then
			SingleLoadout(indexModel, true)
		end
	end
end

local function CharacterAdded(Character)
	if Character then
		HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
	end
end

CharacterAdded(Player.Character)
Player.CharacterAdded:Connect(CharacterAdded)


while true do

	local DistanceConfirmedAndIndexModel, VisibleStatus = GetDistance(LastModelLoaded)

	--[[if HumanoidRootPart and DistanceConfirmedAndIndexModel and LastModelLoaded ~= DistanceConfirmedAndIndexModel then
		print(LastModelLoaded)
		print(DistanceConfirmedAndIndexModel)
		LastModelLoaded = DistanceConfirmedAndIndexModel
		Loadout(DistanceConfirmedAndIndexModel,VisibleStatus)
	end]]
	wait()

end