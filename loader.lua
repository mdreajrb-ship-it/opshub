local GITHUB_BASE = "https://raw.githubusercontent.com/mdreajrb-ship-it/opshub/refs/heads/main/"

-- PlaceIds
local MAIN_PLACE_ID  = 126884695634066   -- العالم العادي
local TRADE_PLACE_ID = 129954712878723   -- عالم التريد

-- اسم الملف اللي يشتغل في كل عالم (غيّره لو رفعت ملف التريد باسم ثاني)
local SCRIPT_BY_PLACE = {
    [MAIN_PLACE_ID]  = "full_stage_4.lua",
    [TRADE_PLACE_ID] = "bootha.lua",
}

local success, err = pcall(function()
    local LucideIcons = loadstring(game:HttpGet(GITHUB_BASE .. "full_stage_3.lua"))()

    local Library = loadstring(game:HttpGet(GITHUB_BASE .. "full_stage_2.lua"))()
    Library.ShowCustomCursor = false

    pcall(function()
        game:GetService("RunService"):UnbindFromRenderStep("ShowCursor")
    end)
    game:GetService("UserInputService").MouseIconEnabled = true

    local isTrade = game.PlaceId == TRADE_PLACE_ID

    local Window = Library:CreateWindow({
        Title = "Exotic Hub",
        Footer = isTrade and "v50" or "v193",
        Size = UDim2.fromOffset(620, 480),
        AutoShow = true,
        ShowCustomCursor = false
    })

    -- اختيار السكربت حسب العالم، وإذا العالم غير معروف يشغّل الرئيسي
    local fileName = SCRIPT_BY_PLACE[game.PlaceId] or SCRIPT_BY_PLACE[MAIN_PLACE_ID]
    print("[Loader] PlaceId:", game.PlaceId, "->", fileName)

    local chunk, loadErr = loadstring(game:HttpGet(GITHUB_BASE .. fileName))
    if not chunk then
        error("Failed to compile " .. fileName .. ": " .. tostring(loadErr))
    end

    chunk({
        IsPremium = function() return true end,
        RegisterReset = function() end,
        Library = Library,
        Window = Window,
        Icons = LucideIcons
    })

    print("[+] Exotic Hub loaded successfully from GitHub!")
end)

if not success then
    warn("[Loader Error] Failed to initialize Exotic Hub: " .. tostring(err))
end
