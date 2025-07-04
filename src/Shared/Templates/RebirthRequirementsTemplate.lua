--!native
--!strict

local WinRequirements = {
  [1] = 750,
  [2] = 1250,
  [3] = 2000,
  [4] = 6000,
  [5] = 12_000,
  [6] = 30_000,
  [7] = 50_000,
  [8] = 90_000,
  [9] = 110_000,
  [10] = 140_000,
  [11] = 175_000,
  [12] = 250_000,
  [13] = 290_000,
  [14] = 325_000,
  [15] = 400_000,
  [16] = 490_000,
  [17] = 580_000,
  [18] = 700_000,
  [19] = 950_000,
  [20] = 1_250_000,
  [21] = 1_450_000,
  [22] = 2_125_000,
  [23] = 2_650_000,
  [24] = 3_900_000,
  [25] = 4_725_000,
  [26] = 6_600_000,
  [27] = 8_650_000,
  [28] = 10_500_000,
  [29] = 13_175_000,
  [30] = 15_000_000,
  [31] = 17_650_000,
  [32] = 19_250_000,
  [33] = 24_500_000,
  [34] = 28_850_000,
  [35] = 31_500_000,
}

local base = WinRequirements[35]
local growthFactor = 1.15

local mt = {
  __index = function(_, index)
      if type(index) ~= "number" or index < 1 then
          return nil
      end
      
      if index <= 35 then
          return WinRequirements[index]
      else
          local exponentialGrowth = base * (growthFactor ^ (index - 35))
          return math.floor(exponentialGrowth)
      end
  end
}

setmetatable(WinRequirements, mt)

return WinRequirements