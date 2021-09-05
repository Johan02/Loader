local LoaderModule = {}

local LoadedOutModels = Instance.new('Folder', game.ReplicatedStorage)
LoadedOutModels.Name = 'LoadedOutModels'


function LoaderModule.LoadOut(Model)

    if Model.PrimaryPart then
        Model.Parent = LoadedOutModels
    end
              
end


return LoaderModule