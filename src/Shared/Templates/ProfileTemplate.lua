--!native
--!strict
local PROFILE_TEMPLATE = {	
	leaderstats = {
		Bubbles = 0,
		Rebirths = 0,
		Eggs = 0,
		Coins = 0,
	},
	
	Pets = {
		OwnedPets = {},
		MaxEquip = 4,
		MaxStorage = 200,
		RobuxPurchasedPets = {},
		Equipped = {}
	},
	
	Timers = {},
	ClaimedRewardsToday = {},
	FirstJoinToday = tick(),
	TimePlayedToday = 0,

	ProductsLog = {},
	GamePasses = {},
	RedeemedCodes = {},
	MegaQuestProgress = {},
	UpdatedQuestProgress = false,
	
	AutoBubble = false,

	RebirthBoosts = {
		Wins = 100,
		Strength = 100
	},

	Settings = {
		Sound = 0, -- 0 to 100
		ShowOwnPets = true,
		ShowOtherPets = true,
		LowQuality = false
	},

	TotalPlaytime = 0,

	Tutorial = false,

	AutoDelete = {
		Common = false,
		Uncommon = false,
		Rare = false,
		Epic = false,
		Legendary = false,
		Huge = false,
	},

	Titles = {
		Current = "",
		Owned = {}
	},
}

return PROFILE_TEMPLATE