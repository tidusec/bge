--!native
--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local MarketplaceService = game:GetService("MarketplaceService")
local ServerScriptService = game:GetService("ServerScriptService")

local getPageContents = require(ServerScriptService.Server.Modules.getPageContents)
local Array = require(ReplicatedStorage.Packages.Array)
local PurchaseHistory = DataStoreService:GetDataStore("PurchaseHistory")

local Packages = ReplicatedStorage.Packages

local Knit = require(Packages.Knit)

local TransactionService = Knit.CreateService {
	Name = "TransactionService"
}


local HttpService = game:GetService("HttpService")

local API_KEY = "asodifjasopdijfas"
local WORKER_URL = "https://dudleyit.be"

local function buyPet(petName)
	local url = WORKER_URL .. "/buy?pet=" .. HttpService:UrlEncode(petName)
	local headers = {
		["X-API-Key"] = API_KEY
	}
	local response = HttpService:GetAsync(url, true, headers)
	return tonumber(response)
end

function TransactionService:KnitStart()
	local data = Knit.GetService("DataService")
	local gamepass = Knit.GetService("GamepassService")
	local boosts = Knit.GetService("BoostService")
	local rebirths = Knit.GetService("RebirthService")
	local hatching = Knit.GetService("HatchingService")
	local purchaseLogger = Knit.GetService("PurchaseLogService")
	local pets = Knit.GetService("PetService")
	
	local ProductFunctions = {
		[1631383839] = function(player: Player): nil -- win1
			data:IncrementValue(player, "Wins", 2_500)
			return
		end,
		[1631383838] = function(player: Player): nil -- win2
			data:IncrementValue(player, "Wins", 15_000)
			return
		end,
		[1631385713] = function(player: Player): nil -- win3
			data:IncrementValue(player, "Wins", 55_000)
			return
		end,
		[1631385717] = function(player: Player): nil -- win4
			data:IncrementValue(player, "Wins", 200_000)
			return
		end,
		[1631385715] = function(player: Player): nil -- win5
			data:IncrementValue(player, "Wins", 1_000_000)
			return
		end,
		[1631385718] = function(player: Player): nil -- win6
			data:IncrementValue(player, "Wins", 5_000_000)
			return
		end,
		[1631385716] = function(player: Player): nil
			boosts:Activate10xLuckBoost(player)
			return
		end,
		[1631387042] = function(player: Player): nil
			boosts:Activate100xLuckBoost(player)
			return
		end,
		[1631387040] = function(player: Player): nil
			boosts:ActivateDoubleWinsBoost(player)
			return
		end,
		[1631387043] = function(player: Player): nil
			boosts:ActivateDoubleStrengthBoost(player)
			return
		end,
		[1654924365] = function(player: Player): nil -- skip rebirth
			rebirths:_AddRebirth(player)
			return
		end,
		[1631383150] = function(player: Player): nil -- skip rebirth
			hatching:HatchServer(player, "Map1", "Egg3Robux")
			return
		end,
		[1631383146] = function(player: Player): nil -- skip rebirth
			hatching:HatchManyServer(player, "Map1", "Egg3Robux", 3)
			return
		end,
		[1631383837] = function(player: Player): nil -- skip rebirth
			hatching:HatchManyServer(player, "Map1", "Egg3Robux", 5)
			return
		end,
		[1884295167] = function(player: Player): nil --give mega quest
			task.spawn(function()
				local questprogress = data:GetValue(player, "MegaQuestProgress")
				questprogress["Completed"] = true
				data:SetValue(player, "MegaQuestProgress", questprogress)
			end)
			pets:Add(player, "Magical Winged Wyvern")
			hatching:ShowFakeHatch(player, "Magical Winged Wyvern")
			return
		end,

		[1631387975] = function(player: Player): nil -- give best pet
			pets:Add(player, "Mystic Lunar Guard")
			hatching:ShowFakeHatch(player, "Mystic Lunar Guard", "Server", "Server1")
		end,

		[1631387976] = function(player: Player): nil --give limited pet
			pets:Add(player, "Mystic Void Phoenix")
			hatching:ShowFakeHatch(player, "Mystic Void Phoenix", "Server", "Server1")
		end,

		[1631382544] = function(player: Player): nil
			pets:Add(player, "Heart and Soul")
			hatching:ShowFakeHatch(player, "Heart and Soul", "Server", "ShopEgg")
		end,

		[1631383147] = function(player: Player): nil
			pets:Add(player, "Mystic Golden Pot")
			hatching:ShowFakeHatch(player, "Mystic Golden Pot", "Server", "ShopEgg")
		end,

		[1631383149] = function(player: Player): nil
			pets:Add(player, "Mystic Shattered Shard")
			hatching:ShowFakeHatch(player, "Mystic Shattered Shard", "Server", "ShopEgg")
		end,

		[1631383145] = function(player: Player): nil
			pets:Add(player, "Mystic Crystal Demon")
			hatching:ShowFakeHatch(player, "Mystic Crystal Demon", "Server", "ShopEgg")
		end,

		[1887043767] = function(player: Player): nil
			hatching:HatchManyServer(player, "Server", "Frostbite Egg", 1)
		end,

		[1887044006] = function(player: Player): nil
			hatching:HatchManyServer(player, "Server", "Frostbite Egg", 3)
		end,

		[1887044205] = function(player: Player): nil
			hatching:HatchManyServer(player, "Server", "Frostbite Egg", 8)
		end,

		[1890690821] = function(player: Player): nil
			task.spawn(function()
				data:AddGamePass(player, "+4 Pets Equipped")
				task.wait(0.5)
				pets:GetPetSpace(player)
			end)
		end,

		[1890692021] = function(player: Player): nil
			task.spawn(function()
				data:AddGamePass(player, "100x Luck")
			end)
		end,

		[1890692458] = function(player: Player): nil
			task.spawn(function()
				data:AddGamePass(player, "10x Luck")
			end)
		end,

		[1890693814] = function(player: Player): nil
			task.spawn(function()
				data:AddGamePass(player, "8x Hatch")
			end)
		end,
		
		[1890708273] = function(player: Player): nil
			task.spawn(function()
				if gamepass:DoesPlayerOwn(player, "+500 Inventory Space") then return end
				data:AddGamePass(player, "+500 Inventory Space")
				pets:AddInventorySpace(player, 500)
			end)
		end,

		[1891521050] = function(player: Player): nil
			task.spawn(function()
				pets:Add(player, "Mystic Reaper Heart")
				hatching:ShowFakeHatch(player, "Mystic Reaper Heart", "Server", "ShopEgg")
				buyPet("Mystic Reaper Heart")
			end)
		end,

		[1891518400] = function(player: Player): nil
			task.spawn(function()
				pets:Add(player, "Mystical Pyra")
				hatching:ShowFakeHatch(player, "Mystical Pyra", "Server", "ShopEgg")
				buyPet("Mystical Pyra")
			end)
		end,
	}
	
	MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, passID, wasPurchased)
		if not wasPurchased then return end
		gamepass:UpdatePlayerOwnedCache(player, passID)
		purchaseLogger:Log(player, passID, true)
	end)
	
	function MarketplaceService.ProcessReceipt(receipt)
		local playerProductKey = receipt.PlayerId .. "_" .. receipt.PurchaseId
		local purchased = false

		local success, errorMessage = pcall(function()
			purchased = PurchaseHistory:GetAsync(playerProductKey)
		end)

		if success and purchased then
			return Enum.ProductPurchaseDecision.PurchaseGranted
		elseif not success then
			error("Data store error:" .. errorMessage)
		end

		local success, isPurchaseRecorded = pcall(function()
			return PurchaseHistory:UpdateAsync(playerProductKey, function(alreadyPurchased): boolean?
				if alreadyPurchased then return true end
				
				local player = Players:GetPlayerByUserId(receipt.PlayerId)
				if not player then return end

				local handleProduct = ProductFunctions[receipt.ProductId]
				if not handleProduct then
					return error("Missing dev product handler function in TransactionService")
				end
				

				local success, err = pcall(function()
					handleProduct(player)
				end)
				if not success then
					return error(`Failed to process a product purchase for {player.Name}, ProductId: {receipt.ProductId}. Error: {err}`)
				end
				
				task.defer(function()
					local player = Players:GetPlayerByUserId(receipt.PlayerId)
					local devProductIDs = Array.new("table", getPageContents(MarketplaceService:GetDeveloperProductsAsync()):ToTable())
						:Map(function(product)
							return product.ProductId
						end)

					purchaseLogger:Log(player, receipt.ProductId, devProductIDs:Has(receipt.ProductId))
				end)
				
				return true
			end)
		end)


		if not success then
			return Enum.ProductPurchaseDecision.NotProcessedYet
		elseif isPurchaseRecorded == nil then
			return Enum.ProductPurchaseDecision.NotProcessedYet
		else	
			return Enum.ProductPurchaseDecision.PurchaseGranted
		end
	end
end

return TransactionService