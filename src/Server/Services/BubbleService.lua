--!native
--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local BubbleService = Knit.CreateService {
  Name = "BubbleService";
}

function BubbleService:KnitStart()
    self._data = Knit.GetService("DataService")
    return
end

function BubbleService:Bubble(player: Player): nil
    self._data:IncrementValue(player, "Bubbles", 1)
	return
end

function BubbleService.Client:Bubble(player: Player): nil
	return self.Server:Bubble(player)
end

return BubbleService