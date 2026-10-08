local G = ...
if type(G) ~= "table" or type(G.IsPremium) ~= "function" then
    warn("[EXO] Loader context missing")
    return
end
if tostring(game.GameId) ~= "7436755782" or tostring(game.PlaceId) ~= "129954712878723" then
    return
end
print("[Trade] exo start > ")
if _G.is_running_trade then
    warn("[Trade] Already running")
    return
end
_G.is_running_trade = true
local V = {}
V.LocalizationService = game:GetService("LocalizationService")
V.UserInputService = game:GetService("UserInputService")
V.HttpService = game:GetService("HttpService")
V.ReplicatedStorage = game:GetService("ReplicatedStorage")
V.Workspace = game:GetService("Workspace")
V.TeleportService = game:GetService("TeleportService")
V.Players = game:GetService("Players")
V.TextChatService = game:GetService("TextChatService")
V.Modules = V.ReplicatedStorage:WaitForChild("Modules")
V.LocalPlayer = V.Players.LocalPlayer
V.Character = V.LocalPlayer.Character or V.LocalPlayer.CharacterAdded:Wait()
V.Backpack = V.LocalPlayer:WaitForChild("Backpack")
V.PlayerGui = V.LocalPlayer:WaitForChild("PlayerGui")
print("Loading x0")
V.GameEvents = V.ReplicatedStorage:WaitForChild("GameEvents")
V.FavItem = V.GameEvents:WaitForChild("Favorite_Item")
V.BuyGearStock = V.GameEvents:FindFirstChild("BuyGearStock")
V.BuySeedStock = V.GameEvents:FindFirstChild("BuySeedStock")
V.BuyDailySeedShopStock = V.GameEvents:FindFirstChild("BuyDailySeedShopStock")
V.BuyPetEgg = V.GameEvents:FindFirstChild("BuyPetEgg")
V.BuyEventShopStock = V.GameEvents:FindFirstChild("BuyEventShopStock")
V.BuyCosmeticItem = V.GameEvents:FindFirstChild("BuyCosmeticItem")
V.BuyCosmeticCrate = V.GameEvents:FindFirstChild("BuyCosmeticCrate")
V.BuyCosmeticShopFence = V.GameEvents:FindFirstChild("BuyCosmeticShopFence")
V.channel =(V.TextChatService:WaitForChild("TextChannels")):WaitForChild("RBXGeneral")
print("Exo Loaded x3")
V.fails = 0 function V.safeRequire(G)
    local y, Z = pcall(require, G)
    if not y or Z == nil then
        warn("[SafeRequire] Failed to load:", G)
        V.fails = V.fails + 1
        return nil
    end
    return Z
end
V.TradeWorldController = V.safeRequire(V.Modules.TradeControllers.TradeWorldController)
V.DataService = V.safeRequire(V.ReplicatedStorage.Modules.DataService)
V.SeedData = V.safeRequire(V.ReplicatedStorage.Data.SeedData)
V.DailySeedShopData = V.safeRequire(V.ReplicatedStorage.Data.DailySeedShopData)
V.SeedShopData = V.safeRequire(V.ReplicatedStorage.Data.SeedShopData)
V.GearShopData = V.safeRequire(V.ReplicatedStorage.Data.GearShopData)
V.PetEggData = V.safeRequire(V.ReplicatedStorage.Data.PetEggData)
V.EventShopData = V.safeRequire(V.ReplicatedStorage.Data.EventShopData)
V.CosmeticShopTabData = V.safeRequire(V.ReplicatedStorage.Data.CosmeticShopTabData)
V.GearData = V.safeRequire(V.ReplicatedStorage.Data.GearData)
V.CosmeticRegistry = V.safeRequire(V.ReplicatedStorage.Data.CosmeticRegistry)
V.FenceSkinRegistry = V.safeRequire(V.ReplicatedStorage.Data.FenceSkinRegistry)
V.GrowableData = V.safeRequire(V.ReplicatedStorage.Data.GrowableData)
V.PetUtilities = V.safeRequire(V.ReplicatedStorage.Modules.PetServices.PetUtilities)
V.PetList = V.safeRequire(V.ReplicatedStorage.Data.PetRegistry.PetList)
V.PetRegistry = V.safeRequire(V.ReplicatedStorage.Data.PetRegistry)
V.MutationHandler = V.safeRequire(V.Modules.MutationHandler)
V.PetMutationRegistry = V.safeRequire(V.ReplicatedStorage.Data.PetRegistry.PetMutationRegistry)
V.ReplicationReceiver = V.safeRequire(V.ReplicatedStorage.Modules.ReplicationReciever)
V.Calculate_Weight = V.safeRequire(V.ReplicatedStorage.Calculate_Weight)
V.FindItemImage = V.safeRequire(V.ReplicatedStorage.Modules.ItemImageFinder)
V.TradeBoothController = V.safeRequire(V.Modules.TradeBoothControllers.TradeBoothController) function Addcantsleep()
    local G = getconnections or get_signal_cons
    if G then
        for G, V in pairs((G)(V.LocalPlayer.Idled)) do
            if V.Disable then
                V.Disable(V)
            elseif V.Disconnect then
                V.Disconnect(V)
            end
        end
    end
end
pcall(function()
    Addcantsleep()
end)
V.CoreGui = game:GetService("CoreGui")
V.WEBHOOK_URL = ""
V.PROXY_URL = ""
V.invite_link_url = "https://exotichub.app/join"
V.invite_link_short = "exotichub.app/join"
local y = G.Library
local Z = G.Window
V.AppName = "Exotic Hub"
V.CurentV = "v50"
local j = {}
local i = {}
j.dev_tools = true
j.is_pro = G.IsPremium() == true
j.webhook_category = { tradesold = "tradesold"}
j.allowpro = {}
if j.allowpro[V.LocalPlayer.Name] then
end
j.TEXT_LISTING = ""
j.TEXT_LISTING_REMOVE = ""
j.TEXT_HATCH_SYSTEM = ""
j.TEXT_CRAFT_TEAMS = ""
j.TEXT_TEAM_SYSTEM = ""
j.TEXT_TRADING_SHOPS = ""
j.event_seeding_active = false
j.event_seeding_list = {}
j.alt_Plants_Physical = nil
j.RNG_EGG_OVERRIDE = 0
j.WAS_PRO_END = false
j.is_dc = false
j.sales_made = 0
V.LocalPlayer.CameraMaxZoomDistance = 350
j.GetCheckIfPro = function()
    return G.IsPremium() == true
end
if V.fails > 0 then
    warn("[EXO] --<> Important data not loaded. Please rejoin!")
end
i.GetOverlayParent = function()
    if type(gethui) == "function" then
        local G, V = pcall(gethui)
        if G and typeof(V) == "Instance" then
            return V
        end
    end
    local G = V.CoreGui
    if type(cloneref) == "function" then
        local V, y = pcall(cloneref, G)
        if V and y then
            G = y
        end
    end
    return G
end
i.ShowFailNotification = function(G, V)
    local y = i.GetOverlayParent()
    if not y then
        return false
    end
    G = tostring(G or "")
    if G == "" then
        return false
    end
    V = tonumber(V) or 4
    task.spawn(function()
        local Z = y:FindFirstChild("ModuleFailNotify")
        if Z then
            Z:Destroy()
        end
        local j = Instance.new("ScreenGui")
        j.Name = "ModuleFailNotify"
        j.IgnoreGuiInset = true
        j.ResetOnSpawn = false
        j.DisplayOrder = 2147483647
        j.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        pcall(function()
            j.OnTopOfCoreBlur = true
        end)
        if type(syn) == "table" and type(syn.protect_gui) == "function" then
            pcall(syn.protect_gui, j)
        end
        local i = pcall(function()
            j.Parent = y
        end)
        if not i then
            j:Destroy()
            return
        end
        local c = Instance.new("Frame")
        c.Name = "NotifyFrame"
        c.AnchorPoint = Vector2.new(.5, 0)
        c.Position = UDim2.new(.5, 0, 0, - 60)
        c.Size = UDim2.fromOffset(380, 50)
        c.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
        c.BorderSizePixel = 0
        c.ZIndex = 999999999
        c.Parent = j
        local J = Instance.new("UICorner")
        J.CornerRadius = UDim.new(0, 8)
        J.Parent = c
        local T = Instance.new("UIStroke")
        T.Color = Color3.fromRGB(70, 70, 70)
        T.Thickness = 1.5
        T.Parent = c
        local d = Instance.new("TextLabel")
        d.BackgroundTransparency = 1
        d.Size = UDim2.new(1, - 20, 1, 0)
        d.Position = UDim2.fromOffset(10, 0)
        d.Font = Enum.Font.GothamMedium
        d.RichText = true
        d.Text = G
        d.TextColor3 = Color3.fromRGB(255, 255, 255)
        d.TextSize = 16
        d.TextWrapped = true
        d.ZIndex = 999999999
        d.Parent = c
        c:TweenPosition(UDim2.new(.5, 0, 0, 25), "Out", "Quad", .25, true)
        task.wait(V)
        if not j.Parent then
            return
        end
        c:TweenPosition(UDim2.new(.5, 0, 0, - 60), "In", "Quad", .25, true)
        task.wait(.3)
        if j.Parent then
            j:Destroy()
        end
    end)
    return true
end
j.Notify = function(G, V)
    G = tostring(G or "")
    if G == "" then
        return false
    end
    local Z = tonumber(V) or 2.5
    if y and type(y.Notify) == "function" then
        local V = pcall(function()
            y:Notify(G, Z)
        end)
        if V then
            return true
        end
    end
    return i.ShowFailNotification(G, Z)
end
j.user_country = ""
j.Region = { FetchCurrentRegion = function()
    task.spawn(function()
        local G = ""
        local y, Z = pcall(function()
            return V.LocalizationService:GetCountryRegionForPlayerAsync(V.LocalPlayer)
        end)
        if y and(Z and Z ~= "") then
            G = tostring(Z)
            j.user_country = G
        end
    end)
end}
j.Region.FetchCurrentRegion()
local c = { dd_list_pets = nil}
local J = {}
local T = {}
local d = {}
local u = {}
local q = {}
local g = {}
local E = {}
local a = {}
local H = {}
j.show_expire_key = false
j.expire_key_text = ""
j.InventoryDataBind = {}
i.PetDataLocal = {}
i.GetFooterInfo = function(G)
    local y = string.format("%s (%s)", V.invite_link_short, V.CurentV)
    if not G then
        y = string.format("<b><font color=\'#FFFB03\'>%s</font></b> (%s)", V.invite_link_short, V.CurentV)
    end
    return y
end
j.GetProMessage = function()
    local G = string.format("\240\159\148\146 <stroke th=\'0.1\' joins=\'round\' sizing=\'fixed\' color=\'#8C1600\'><font color=\'#FA2B00\'> Premium Feature - Join discord server to get Key.</font></stroke>")
    return G
end
j.PET_COUNT = {}
j.all_pets_data_list = {}
j.all_pets_names_list = {}
j.all_pets_names_list_keyval = {}
j.craft_data_GearEventWorkbench = {}
j.egg_hatch_time_left = 0
j.TEXT_SCANNER = ""
j.TEXT_MANUAL_BUY = ""
j.TEXT_BOOTH_SETUP = ""
j.TEXT_REJOIN = ""
j.TEXT_TRADE_SIGN = ""
j.is_manual_buying = false
j.is_manual_server_searching = false
j.is_buying_from_listing = false
j.is_booth_claiming = false
j.is_rejoin_searching = false
j.last_tp_fail_reason = ""
j.booth_hop_block_until = 0
j.booth_claim_attempts = 0
j.booth_claim_success = 0
j.booth_claim_failed = 0
j.booth_claim_cooldown_until = 0
j.booth_reclaim_cooldown_until = 0
j.booth_hop_blocks = 0
j.booth_customer_blocks = 0
j.booth_own_buy_blocks = 0
j.rejoin_started_at = 0
j.next_rejoin_at = 0
j.rejoin_attempts = 0
j.rejoin_failed = 0
j.rejoin_teleports = 0
j.trade_sign_used = 0
j.trade_sign_missing = 0
j.trade_sign_next_use = 0
j.BigData = {}
j.RequireDataSync_Save = false
local r = { lbl_status_listing = nil;
lbl_finder_pet_details = nil;
lbl_pet_details = nil, lbl_manual_buy_status = nil;
lbl_booth_setup_status = nil}
j.player_userid = V.LocalPlayer.UserId
if not j.player_userid then
    warn("Invalid player detected.")
    return
end
local Y = { finder = { find_petlist = {}, find_weight = 1, find_mutation = {}, find_enabled = false;
find_tp = false;
find_tp_every_mins = 10};
showcase = { fruit_list = {};
pet_list = {}};
sameserver_buyonly = false;
show_player_stats = true;
scantargetpets = {};
manual_min_weight = .1;
manual_max_base_weight = 0;
manual_min_visual_weight = 0;
manual_max_visual_weight = 0;
manual_mutations = {};
manual_showbaseweight = true, fixkgbug_easter = false, find_settings = {}, auto_list_enabled = false, listing_petlist = {}, listing_mutations = {}, listing_min_level = 1;
listing_max_level = 1, listing_min_weight = .9, listing_max_weight = 2.86;
listing_token_price = 99;
listing_auto_unfav = false;
skin_booth_list = {}, auto_claim_booth = false, auto_equip_big_pet = false;
teleport_to_booth = false;
teleport_distance = 30, booth_reclaim_better = false, booth_hop_after_buy_secs = 120, booth_rejoin_retry_secs = 60, trade_sign_enabled = false;
trade_sign_use_every_secs = 8;
joinnewserver = false;
rejoin_mins = 15, sold_webhook = "";
enable_auto_reconnect = false;
autoreconnect_tries = 0, was_auto_reconnect = false, auto_promote_listing = false;
removelistingpetsfilter = {}, sellfruit = { fruit_list_allow = {}, is_fruit_enabled = false, fruit_price = 30;
fruit_min_weight = .03, fruit_max_weight = 67.67, fruit_mutations = {};
fruit_auto_fav = false};
trading_shops = { seed = { enabled = true;
selected = {}, guard_enabled = false;
min_sheckles = 0}, gear = { enabled = true, selected = {}, guard_enabled = false, min_sheckles = 0};
egg = { enabled = true;
selected = {};
guard_enabled = false;
min_sheckles = 0};
props = { enabled = false;
selected = {};
guard_enabled = false, min_sheckles = 0}, events = {}}}
local e = "exotichub99"
if not isfolder(e) then
    makefolder(e)
end
local s = e ..("/" ..(j.player_userid .. "gagtrading1.json"))
local N = function()
    local G, y = pcall(function()
        return V.HttpService:JSONEncode(Y)
    end)
    if G then
        writefile(s, y)
    else
    end
end
local function W(G)
    if G then
        N()
        return
    end
    j.RequireDataSync_Save = true
end
local function X()
    if not isfile(s) then
        return
    end
    local G = readfile(s)
    if not G or G == "" then
        return
    end
    local y, Z = pcall(V.HttpService.JSONDecode, V.HttpService, G)
    if not y then
        return
    end
    local function j(G, V)
        for V, y in pairs(V) do
            local Z = G[V]
            if type(y) == "table" and type(Z) == "table" then
                j(Z, y)
            else
                G[V] = y
            end
        end
        return G
    end
    j(Y, Z)
end
X()
j.rejoin_started_at = os.clock()
j.next_rejoin_at = os.clock() +(((tonumber(Y.rejoin_mins) or 15)) * 60)
task.spawn(function()
    while true do
        task.wait(1)
        if j.RequireDataSync_Save then
            j.RequireDataSync_Save = false
            N()
        end
    end
end)
if type(G.RegisterReset) == "function" then
    G.RegisterReset(function()
        j.is_pro = false
    end)
end
i.JsonPrint = function(G)
    if V.HttpService then
        warn(V.HttpService:JSONEncode(G))
    end
end
i.log = function(G)
    if G then
        print(G)
    else
        warn("(log) error passed val nil")
    end
end
i.shortenMutation = function(G)
    if not G or G == "" then
        return ""
    end
    local V = G:gsub("[%[%]]", "")
    local y =(V:sub(1, 2)):upper()
    return "[" ..(y .. "]")
end
i.CopyToClipBoard = function(G)
    if setclipboard then
        setclipboard(G);
        (game:GetService("StarterGui")):SetCore("SendNotification", { Title = "Text";
        Text = " Copied to clipboard!";
        Duration = 2})
    else
        j.Notify("\226\157\140 Clipboard copy not supported", 3)
    end
end
i.fruitCalculateWeight = function(G, y)
    local Z, j = pcall(function()
        local Z = V.Calculate_Weight.Calculate_Weight(G, y)
        if Z then
            return Z
        end
        return 0
    end)
    if not Z then
        warn("Error Weight: ", j)
        return 0
    end
    return j or 0
end
j.ItemTypes = { Pet = "Pet", Egg = "Egg";
Fruit = "Fruit", Seed = "Seed", Gear = "Gear";
Fence = "Fence";
Fences = "Fences";
RandomSeed = "RandomSeed";
Holdable = "Holdable";
SeedPack = "Seed Pack", PetEgg = "PetEgg", CosmeticCrate = "CosmeticCrate";
Crate = "Crate", Cosmetic = "Cosmetic", Currency = "Currency", Food = "Food", TradeBoothSkin = "TradeBoothSkin"}
j.AssetCache = {}
j.EggsNoIcons = {["Premium Night Egg"] = 75473533691044,["Night Egg"] = 110540585737631}
j.GetAssetId = function(G, y)
    if not G or not y then
        return 0, false
    end
    local Z = y ..(":" .. G)
    local i = j.AssetCache[Z]
    if i then
        return i, true
    end
    local c = j.EggsNoIcons[G]
    if c then
        return c, true
    end
    local J, T = pcall(function()
        return V.FindItemImage(G, y)
    end)
    if not J or not T then
        j.AssetCache[Z] = 0
        return 0, false
    end
    local d = tonumber(string.match(T, "%d+")) or 0
    local u = false
    if d == 6937742258 then
        d = 0
        u = true
    end
    j.AssetCache[Z] = d
    return d, true, u
end
local function h(G)
    local V = tonumber(G)
    if not V or V < 0 then
        return 0
    end
    return math.floor(V)
end
a.time = {}
a.time = { GetMinsFromSecs = function(G)
    return h(G) / 60
end, GetSecsFromMin = function(G)
    return h(G) * 60
end, GetSecsFromHours = function(G)
    return h(G) * 3600
end;
GetHoursFromSecs = function(G)
    return h(G) / 3600
end;
FormatMS = function(G)
    local V = h(G)
    return string.format("%02d:%02d", math.floor(V / 60), V % 60)
end;
FormatHMS = function(G)
    local V = h(G)
    local y = math.floor(V / 3600)
    local Z = math.floor(((V % 3600)) / 60)
    local j = V % 60
    return string.format("%02d:%02d:%02d", y, Z, j)
end;
FormatSmart = function(G)
    local V = h(G)
    if V >= 3600 then
        local G = math.floor(V / 3600)
        local y = math.floor(((V % 3600)) / 60)
        local Z = V % 60
        return string.format("%02d:%02d:%02d", G, y, Z)
    else
        return string.format("%02d:%02d", math.floor(V / 60), V % 60)
    end
end;
FormatText = function(G)
    local V = h(G)
    if V < 60 then
        return tostring(V) .. "s"
    elseif V < 3600 then
        return string.format("%dm %ds", math.floor(V / 60), V % 60)
    else
        return string.format("%dh %dm", math.floor(V / 3600), math.floor(((V % 3600)) / 60))
    end
end}
i.FormatWeight = function(G, V)
    local y = tonumber(G) or 0
    V = V or 2
    if y ~= y then
        return 0
    end
    if y == math.huge then
        return y
    end
    if y == - math.huge then
        return y
    end
    local Z = 10 ^ V
    return math.floor(y * Z + .5) / Z
end
i.FormatHugeNumbers = function(G, V)
    G = tonumber(G)
    V = tonumber(V) or 2
    if not G or G ~= G or G == math.huge or G == - math.huge then
        return "0"
    end
    local y = { "";
    "K";
    "M";
    "B";
    "T";
    "Qa";
    "Qi", "Sx";
    "Sp", "Oc";
    "No";
    "Dc", "Ud";
    "Dd";
    "Td";
    "Qad";
    "Qid";
    "Sxd";
    "Spd";
    "Ocd";
    "Nod"}
    local Z = math.abs(G)
    if Z < 1000 then
        if G % 1 == 0 then
            return tostring(math.floor(G))
        end
        return(string.format("%." ..(V .. "f"), G)):gsub("%.?0+$", "")
    end
    local j = math.floor(math.log(Z, 1000)) + 1
    if j > # y then
        return string.format("%." ..(V .. "e"), G)
    end
    local i = 1000 ^((j - 1))
    local c = G / i
    local J = tonumber(string.format("%." ..(V .. "f"), c))
    if J and(math.abs(J) >= 1000 and j < # y) then
        j = j + 1
        i = 1000 ^((j - 1))
        c = G / i
    end
    local T = string.format("%." ..(V .. "f"), c)
    T = T:gsub("%.?0+$", "")
    return T .. y[j]
end
i.FormatNumber = function(G)
    local V = tonumber(G) or 0
    if V == math.huge then
        return "Infinity"
    end
    if V == - math.huge then
        return "-Infinity"
    end
    if V ~= V then
        return "NaN"
    end
    local y = string.format("%.0f", math.floor(V))
    local Z, j = y:match("^([%-]?)(%d+)$")
    if not j then
        return y
    end
    local i =((j:reverse()):gsub("(%d%d%d)", "%1,")):reverse()
    return Z .. i:gsub("^,", "")
end
i.Vector3ToCFrame = function(G)
    if not G then
        return nil
    end
    return CFrame.new(G)
end
i.StringToVector3 = function(G)
    if not G then
        return nil
    end
    local V, y, Z = G:match("([^,]+),([^,]+),([^,]+)")
    if not V or not y or not Z then
        return nil
    end
    return Vector3.new(tonumber(V), tonumber(y), tonumber(Z))
end
i.IsTimeUp = function(G, V)
    if not G or not V then
        return true
    end
    return(os.clock() - G) >= V
end
i.SendChat = function(G)
    pcall(function()
        V.channel:SendAsync(G)
    end)
end
i.MakeMessageForPromote = function(G, V)
    local y = { "selling {ITEM}", "selling {ITEM} cheap";
    "{ITEM} for sale";
    "got {ITEM} in booth", "buy {ITEM} rn";
    "{ITEM} listed", "selling {ITEM} for tokens", "{ITEM} listed under market price";
    "cheapest {ITEM} in server", "selling {ITEM} low price", "lowest price on {ITEM}", "undercutting everyone on {ITEM}", "selling {ITEM} need tokens asap", "quick selling {ITEM}", "flash sale on {ITEM}", "{ITEM} cheap, need gone", "who wants {ITEM}? need tokens";
    "clearing out {ITEM}, cheap", "{ITEM} fs", "huge {ITEM} fs";
    "selling {ITEM} fr cheap", "got a {ITEM} up";
    "{ITEM} for sale no overpay", "selling {ITEM} cheap no cap";
    "taking offers on {ITEM} in booth", "selling {ITEM} atm";
    "anyone need {ITEM}?";
    "who looking for {ITEM}?";
    "anyone buying {ITEM} rn?";
    "u guys need {ITEM}?", "looking for {ITEM}? check booth", "who wants a cheap {ITEM}?";
    "best price on {ITEM} here", "grab this {ITEM} b4 its gone", "fresh {ITEM} listed", "selling {ITEM} (good price)", "huge {ITEM} for cheap";
    "don\'t miss this {ITEM}", "selling {ITEM} (clean)"}
    local Z = { "\240\159\148\165", "\240\159\146\142";
    "\240\159\146\184";
    "\240\159\164\145", "\226\154\161";
    "\240\159\145\128";
    "\226\156\168";
    "\226\128\188\239\184\143"}
    local j = {}
    if G then
        for G, V in pairs(G) do
            table.insert(j, G)
        end
    end
    if V then
        for G, V in pairs(V) do
            table.insert(j, G)
        end
    end
    if # j == 0 then
        return "selling stuff check booth"
    end
    local i = math.random(1, # j)
    local c = j[i]
    local J = math.random(1, # y)
    local T = y[J]
    local d = string.gsub(T, "{ITEM}", c)
    if math.random(1, 100) <= 30 then
        local G = Z[math.random(1, # Z)]
        d = d ..(" " .. G)
    end
    return d
end
j.failed_tp = false
j.DetectTeleport = function()
    local G = game:GetService("TeleportService")
    G.TeleportInitFailed:Connect(function(G, y, Z)
        if G ~= V.LocalPlayer then
            return
        end
        print("--TeleportInitFailed")
        j.failed_tp = true
        j.last_tp_fail_reason = tostring(Z or y or "Teleport failed")
    end)
end
j.DetectTeleport()
i.Color3ToHex = function(G)
    if typeof(G) ~= "Color3" then
        G = Color3.fromRGB(255, 255, 0)
    end
    return string.format("#%02X%02X%02X", math.clamp(math.floor(G.R * 255), 0, 255), math.clamp(math.floor(G.G * 255), 0, 255), math.clamp(math.floor(G.B * 255), 0, 255))
end
j.StringToColor = function(G, V)
    G = tostring(G or "")
    V = tostring(V or "#151515")
    local function y(G, V, y)
        G = tonumber(G) or 0
        if G < V then
            return V
        end
        if G > y then
            return y
        end
        return G
    end
    local function Z(G)
        G =(tostring(G or "")):gsub("#", "")
        local V, y, Z = G:match("^(%x%x)(%x%x)(%x%x)$")
        return tonumber(V or "15", 16), tonumber(y or "15", 16), tonumber(Z or "15", 16)
    end
    local function j(G, V, Z)
        return string.format("#%02X%02X%02X", y(math.floor(G + .5), 0, 255), y(math.floor(V + .5), 0, 255), y(math.floor(Z + .5), 0, 255))
    end
    local function i(G, V, y)
        G =((G % 360)) / 360
        local function Z(G, V, y)
            if y < 0 then
                y = y + 1
            end
            if y > 1 then
                y = y - 1
            end
            if y < .16666666666667 then
                return G +(((V - G)) * 6) * y
            end
            if y < .5 then
                return V
            end
            if y < .66666666666667 then
                return G +(((V - G)) *((.66666666666667 - y))) * 6
            end
            return G
        end
        if V == 0 then
            local G = y * 255
            return G, G, G
        end
        local j = y < .5 and y *((1 + V)) or(y + V) - y * V
        local i = 2 * y - j
        return Z(i, j, G + .33333333333333) * 255, Z(i, j, G) * 255, Z(i, j, G - .33333333333333) * 255
    end
    local function c(G, V, y)
        local function Z(G)
            G = G / 255
            if G <= .03928 then
                return G / 12.92
            end
            return((((G + .055)) / 1.055)) ^ 2.4
        end
        return(.2126 * Z(G) + .7152 * Z(V)) + .0722 * Z(y)
    end
    local function J(G, V, y, Z, j, i)
        local J = c(G, V, y)
        local T = c(Z, j, i)
        if J < T then
            J, T = T, J
        end
        return((J + .05)) /((T + .05))
    end
    local T = 0
    for V = 1, # G, 1 do
        T =(((T * 131) + string.byte(G, V))) % 2147483647
    end
    local d, u, q = Z(V)
    local g = T % 360
    local E = .72
    local a = { .62;
    .68, .74;
    .8}
    local H, r, Y = 255, 255, 255
    local e = 0
    for G, V in ipairs(a) do
        local y, Z, j = i(g, E, V)
        local c = J(y, Z, j, d, u, q)
        if c > e then
            H, r, Y = y, Z, j
            e = c
        end
    end
    while e < 4.5 do
        H = H +(((255 - H)) * .18)
        r = r +(((255 - r)) * .18)
        Y = Y +(((255 - Y)) * .18)
        e = J(H, r, Y, d, u, q)
    end
    local s = H * .18
    local N = r * .18
    local W = Y * .18
    return { Text = j(H, r, Y), Stroke = j(s, N, W);
    Contrast = e}
end
i.StringToColor3 = function(G)
    local V = "#FFFF00"
    if type(G) ~= "string" or G == "" then
        return V
    end
    local y, Z = pcall(function()
        local V = 0
        for y = 1, # G, 1 do
            V =((V * 31 + string.byte(G, y))) % 2147483647
        end
        local y =((V % 360)) / 360
        local Z = .75 +(((math.floor(V / 360) % 20)) / 100)
        local j = .85 +(((math.floor(V / 7200) % 12)) / 100)
        return i.Color3ToHex(Color3.fromHSV(y, Z, j))
    end)
    return y and Z or V
end
i.EggDataSet = {}
i.EggRarity = {}
i.EggColors = {}
i.GetEggRarityList = function()
    local G = { Prismatic = 8;
    Divine = 7;
    Mythical = 6, Legendary = 5;
    Rare = 4;
    Uncommon = 3;
    Common = 2;
    Unknown = 1}
    return G
end
i.EggToColor = function(G)
    G = tostring(G or "")
    local V = i.EggColors and i.EggColors[G]
    if typeof(V) ~= "Color3" then
        V = Color3.fromRGB(255, 255, 255)
    end
    local function y(G)
        return string.format("#%02X%02X%02X", math.clamp(math.floor(G.R * 255), 0, 255), math.clamp(math.floor(G.G * 255), 0, 255), math.clamp(math.floor(G.B * 255), 0, 255))
    end
    local Z, j, c = V:ToHSV()
    local J
    local T
    if j < .08 then
        J = Color3.fromRGB(230, 230, 230)
        T = Color3.fromRGB(20, 20, 20)
    else
        J = Color3.fromHSV(Z, math.clamp(j, .55, .9), math.clamp(math.max(c, .82), 0, 1))
        T = Color3.fromHSV(Z, math.clamp(j, .7, 1), .18)
    end
    return y(J), y(T)
end
i.RarityLayoutMap = { Common = 1;
Uncommon = 2;
Rare = 3;
Legendary = 4, Mythical = 5;
Divine = 6;
Prismatic = 7, Transcendent = 8}
i.RarityToColor = function(G)
    G = tostring(G or "")
    local V = { Common = { Text = "#E6E6E6";
    Stroke = "#111111"}, Uncommon = { Text = "#8CFF3D";
    Stroke = "#183300"}, Rare = { Text = "#4FA3FF";
    Stroke = "#001B4D"}, Legendary = { Text = "#FFF45A";
    Stroke = "#4A3A00"}, Mythical = { Text = "#D86BFF";
    Stroke = "#3A004D"}, Divine = { Text = "#FF8A3D";
    Stroke = "#4A1600"}, Prismatic = { Text = "#FF4D4D";
    Stroke = "#4A0000"}, Transcendent = { Text = "#8D6BFF", Stroke = "#16004A"};
    Epic = { Text = "#C98CFF", Stroke = "#2B004A"}}
    local y = V[G]
    if not y then
        return "#FFFFFF", "#111111"
    end
    return y.Text, y.Stroke
end
d.GetAllPetData = function()
    for G, V in pairs(V.PetList) do
        table.insert(j.all_pets_names_list, G)
        j.all_pets_names_list_keyval[G] = true
        j.all_pets_data_list[G] = { hunger = tonumber(V.DefaultHunger);
        rarity = V.Rarity or ""}
    end
end
d.GetAllPetData()
d.GetPetDataUsingName = function(G)
    if not G then
        return nil
    end
    return j.all_pets_data_list[G]
end
i.FetchEggData = function()
    i.EggDataSet = {}
    local G = i.GetEggRarityList()
    for G, V in pairs(V.PetRegistry.PetEggs) do
        local y = {}
        i.EggRarity[G] = V.EggRarity
        i.EggColors[G] = V.Color or Color3.fromRGB(255, 255, 255)
        if V.RarityData and V.RarityData.Items then
            for G, V in pairs(V.RarityData.Items) do
                table.insert(y, { petname = G, odds = V.ItemOdd or 0})
            end
        end
        table.sort(y, function(G, V)
            return G.odds < V.odds
        end)
        table.insert(i.EggDataSet, { name = G;
        rarity = V.EggRarity or "Unknown";
        pets = y, color = V.Color or Color3.fromRGB(255, 255, 255)})
    end
    table.sort(i.EggDataSet, function(V, y)
        local Z = string.find(V.name, "Premium")
        local j = string.find(y.name, "Premium")
        if Z and not j then
            return true
        end
        if not Z and j then
            return false
        end
        local i = G[V.rarity] or 0
        local c = G[y.rarity] or 0
        if i ~= c then
            return i > c
        end
        return V.name < y.name
    end)
end
i.FetchEggData()
i.AllPetPassiveData = {}
i.PetDataAll = {}
i.GetAllPetDataPassives = function()
    for G, V in pairs(V.PetList) do
        local y = V.Passives or {}
        i.AllPetPassiveData[G] = y
        i.PetDataAll[G] = V
    end
end
i.GetAllPetDataPassives()
i.GetPetPassivesTable = function(G)
    return i.AllPetPassiveData[G]
end
i.GetPetDataInfo = function(G)
    return i.PetDataAll[G]
end
i.PetToEggNames = {}
i.FakeEgg = {}
i.EggNameToPet = {}
i.AllEggNamesList = {}
i.AllEggNamesKeyVal = {}
i.PetDataAndInfo = {}
i.GetAllEggNames = function()
    for G, V in pairs(V.PetRegistry.PetEggs) do
        table.insert(i.AllEggNamesList, G)
        i.AllEggNamesKeyVal[G] = true
        local y = V.RarityData
        if y then
            local V = y.Items
            if G == "Fake Egg" then
                if V then
                    for V, y in pairs(V) do
                        local Z = d.GetPetDataUsingName(V)
                        local j = Z and Z.rarity or ""
                        local c = { rarity = j, eggname = G}
                        i.PetDataAndInfo[V] = c
                        i.FakeEgg[V] = G
                    end
                end
                continue
            end
            if V then
                local y = {}
                for V, Z in pairs(V) do
                    i.PetToEggNames[V] = G
                    local j = d.GetPetDataUsingName(V)
                    local c = j and j.rarity or ""
                    local J = { rarity = c;
                    eggname = G}
                    i.PetDataAndInfo[V] = J
                    local T = Z.ItemOdd or 0
                    local u = i.GetPetDataInfo(V)
                    local q = ""
                    if u then
                        q = u.Icon
                    end
                    local g = { petname = V, odds = T;
                    icon = q}
                    table.insert(y, g)
                end
                i.EggNameToPet[G] = y
            end
        end
    end
end
i.GetAllEggNames()
i.GetPetDetails = function(G)
    return i.PetDataAndInfo[G]
end
i.GetEggNameUsingPetName = function(G)
    if i.PetToEggNames[G] then
        return i.PetToEggNames[G]
    end
    if i.FakeEgg[G] then
        return i.FakeEgg[G]
    end
    return "Unknown"
end
i.formatDuration = function(G)
    if not G then
        return 0
    end
    local V = 86400
    local y = 3600
    local Z = 60
    G = tonumber(G) or 0
    local j = math.floor(G / V)
    local i = G % V
    local c = math.floor(i / y)
    i = i % y
    local J = math.floor(i / Z)
    local T = math.floor(i % Z)
    if j > 0 then
        return string.format("%dd:%dh:%dm:%ds", j, c, J, T)
    elseif c > 0 then
        return string.format("%dh:%dm:%ds", c, J, T)
    elseif J > 0 then
        return string.format("%dm:%ds", J, T)
    else
        return string.format("%ds", T)
    end
end
j.PlayerSecrets = { EggRecoveryChance = 0;
PetSellEggRefundChance = 0, PetEggHatchAgeBonus = 0;
PetEggHatchSizeBonus = 0, PetPassiveBonus = 0;
SessionTime = 0;
SellSilverFruitRewardChance = 0, Grow_Amount = 0}
local l = {}
u.GetSessionTime = function()
    local G = "SessionTime"
    local y = tonumber(V.LocalPlayer:GetAttribute(G)) or 0
    return y
end
i.CloneArray = function(G)
    local V = {}
    for G, y in ipairs(G) do
        V[G] = y
    end
    return V
end
j.SeedRarity = {}
local function B()
    local G = {}
    for V, y in pairs(V.SeedData) do
        if y.SeedName then
            local Z = y.SeedName
            local i = y.SeedRarity
            if V == "Easter Chocolate Coconut" and Z == "Chocolate Coconut" then
                Z = V
            end
            Z = Z:gsub("%s+Seed$", "")
            j.SeedRarity[Z] = i
            table.insert(G, Z)
        end
    end
    for G, V in ipairs(G) do
        l[V] = false
    end
end
B()
j.GetSeedRarity = function(G)
    return j.SeedRarity[G] or "Common"
end
j.IsSeed = function(G)
    return l[tostring(G or "")] ~= nil
end
j.SingleHarvestPlants = {}
j.BuildSingleHarvestPlants = function()
    local G, y = pcall(function()
        j.SingleHarvestPlants = {}
        if not V.GrowableData or type(V.GrowableData.GetAllPlantData) ~= "function" then
            return
        end
        local G = V.GrowableData:GetAllPlantData()
        if type(G) ~= "table" then
            return
        end
        for G, V in pairs(G) do
            local y = V and V.PlantData
            if y and y.GrowFruitTime == nil then
                j.SingleHarvestPlants[tostring(G)] = true
            end
        end
    end)
    if not G then
        warn("[SingleHarvestPlants] Failed to build:", y)
    end
    return j.SingleHarvestPlants
end
j.IsSingleHarvestPlant = function(G)
    return j.SingleHarvestPlants[tostring(G or "")] == true
end
j.BuildSingleHarvestPlants()
local function L(G)
    local V = {}
    for G, y in pairs(G) do
        table.insert(V, G)
    end
    table.sort(V, function(G, V)
        return G:lower() < V:lower()
    end)
    return V
end
local function m(G)
    local y = V.LocalPlayer
    local function Z(V)
        local y = V:FindFirstChild("HumanoidRootPart")
        if y then
            y.CFrame = G
        end
    end
    if y.Character then
        Z(y.Character)
    end
    y.CharacterAdded:Connect(function(G)
        G:WaitForChild("HumanoidRootPart")
        Z(G)
    end)
end
local function K(G, y)
    if not V.PetUtilities then
        return G
    end
    local Z = V.PetUtilities:CalculateWeight(G or 1, y or 1)
    return Z
end
i.UpdatePlayerStats = function()
    if not V.LocalPlayer then
        warn("UpdatePlayerStats called without a valid LocalPlayer")
        return
    end
    for G, y in pairs(j.PlayerSecrets) do
        local Z = V.LocalPlayer:GetAttribute(G)
        if Z ~= nil then
            j.PlayerSecrets[G] = Z
        else
            j.PlayerSecrets[G] = 0
        end
    end
end
i.ShopTeleportButtons = function()
    local G = V.LocalPlayer.PlayerGui.Teleport_UI.Frame
    if not G then
        return
    end
    for G, V in ipairs(G:GetChildren()) do
        if V:IsA("GuiButton") then
            V.Visible = true
        end
    end
end
i.ShopTeleportButtons()
local b = {}
local function S(G)
    local V = {}
    for G, y in pairs(G) do
        table.insert(V, G)
    end
    return V
end
j.GetAllMutations = function()
    if not V.MutationHandler then
        return {}
    end
    local G = V.MutationHandler.GetMutations()
    for G, V in pairs(G) do
        b[G] = false
    end
    return b
end
j.GetAllMutations()
local function z(G)
    if G == nil or(type(G) == "string" and G:match("^%s*$")) then
        return nil
    end
    local V = tonumber(G)
    if not V then
        return nil
    end
    if V % 1 ~= 0 then
        return nil
    end
    return V
end
local function f(G)
    if G == nil or(type(G) == "string" and G:match("^%s*$")) then
        return nil
    end
    local V = tonumber(G)
    if not V then
        return nil
    end
    return V
end
i.ShortName = function(G, V)
    V = V or 5
    if # G > V then
        return G:sub(1, V) .. "..."
    else
        return G
    end
end
j.hatched_pets = {}
i.GetPetDataUsingUUID = function(G, V)
    local y = V.Data[G]
    return y
end
i.cache_recent_pet_data = {}
E.AllBigDataKeys = {}
E.ReloadDataService = function()
    j.BigData = V.DataService:GetData()
    E.AllBigDataKeys = {}
    if # E.AllBigDataKeys == 0 then
        for G, V in pairs(j.BigData) do
            table.insert(E.AllBigDataKeys, G)
        end
    end
end
E.ReloadDataService()
E.data_key = {}
E.HatchDataWebhook = {}
E.DataSaveSlots = {}
E.GetBigDataUsingKey = function(G)
    return j.BigData[G]
end
j.InventoryDataBind = E.GetBigDataUsingKey("InventoryData")
E.DataSaveSlots = E.GetBigDataUsingKey("SaveSlots")
local function t(G)
    local V, y = pcall(function()
        local V
        local y = E.GetBigDataUsingKey("PetsData")
        if y and y.PetInventory.Data[G] then
            V = y.PetInventory.Data[G]
        else
        end
        if not V then
            return nil
        end
        return V
    end)
    if V then
        return y
    end
    warn("Error", y)
    return nil
end
T.AllMutationsList = {}
T.AllMutationListEnum = {}
T.GetAllMutationAsKeyPair = function()
    for G, V in pairs(V.PetMutationRegistry.PetMutationRegistry) do
        if V.AvaliableFromMutationMachine then
        end
        T.AllMutationsList[G] = false
        local y = V.EnumId
        T.AllMutationListEnum[y] = G
    end
    return T.AllMutationsList
end
T.GetAllMutationAsKeyPair()
local function M(G)
    for G, y in ipairs(G) do
        V.FavItem:FireServer(y)
    end
end
local function A(G)
    if not G then
        return
    end
    V.FavItem:FireServer(G)
end
i.FavItemCustom = function(G, y)
    if not G then
        return
    end
    local Z = G:GetAttribute("d")
    if Z and y then
        return
    end
    V.FavItem:FireServer(G)
end
local function x(G)
    local V = G:match("%d+")
    return tonumber(V) or 0
end
local function C()
    local G, y = pcall(function()
        local G = V.Character
        if not G or not G:IsA("Model") then
            return false
        end
        local y = G:FindFirstChildOfClass("Tool")
        if not y then
            return false
        end
        local Z =(y:GetAttribute("b") == "j")
        local j = y:GetAttribute("f")
        if Z and j then
            return true, j
        end
        return false
    end)
    if not G then
        warn("[IsFruitToolHeld] pcall error:", y)
        return false
    end
    return y
end
J.GetHeldTool = function()
    local G = V.LocalPlayer.Character or V.Character
    if not G or not G:IsA("Model") then
        return nil
    end
    return G:FindFirstChildOfClass("Tool")
end
J.GetToolByName = function(G)
    G = tostring(G or "")
    if G == "" then
        return nil
    end
    local y = J.GetHeldTool()
    if y and(y:IsA("Tool") and y.Name == G) then
        return y
    end
    for V, y in ipairs(V.Backpack:GetChildren()) do
        if y:IsA("Tool") and y.Name == G then
            return y
        end
    end
    return nil
end
J.IsToolHeldAny = function()
    local G, y = pcall(function()
        local G = V and V.Character
        if not G or not G:IsA("Model") then
            return false
        end
        return G:FindFirstChildOfClass("Tool") ~= nil
    end)
    if not G then
        warn("[IsToolHeldAny] Error:", y)
        return false
    end
    return y
end
J.IsPetFav = function(G)
    local V, y = pcall(function()
        if G:IsA("Tool") and G:GetAttribute("PetType") then
            local V = G:GetAttribute("d")
            if V then
                return true
            end
        end
        return false
    end)
    if V then
        return y
    else
        return false
    end
end
local function D(G)
    local y = V.LocalPlayer.Character or V.Character
    local Z = y and y:FindFirstChildOfClass("Humanoid")
    if not Z then
        return false
    end
    local j, i = pcall(function()
        Z:EquipTool(G)
    end)
    if not j then
        warn("\226\157\140 Failed to equip tool:", i)
        return false
    end
    task.wait(.2)
    return true
end
local function P()
    local G = V.Character:FindFirstChildOfClass("Humanoid")
    if not G then
        return
    end
    G:UnequipTools()
    task.wait(.1)
end
i.ContainsWords = function(G, V)
    local y = {}
    for G in string.gmatch(V, "%S+") do
        table.insert(y, G)
    end
    for V, y in ipairs(y) do
        if not string.find(G, y, 1, true) then
            return false
        end
    end
    return true
end
i.FormatTime = function(G)
    if not G or type(G) ~= "number" then
        return "0:00:00"
    end
    if G < 0 then
        G = 0
    end
    G = math.floor(G + .5)
    local V = math.floor(G / 3600)
    local y = math.floor(((G % 3600)) / 60)
    local Z = G % 60
    return string.format("%d:%02d:%02d", V, y, Z)
end
r.lbl_home_info = nil
i.UI = { updateHomeStats = function(G)
    if r.lbl_home_info then
        r.lbl_home_info:SetText(G)
    end
end}
i.fmt_time = function(G)
    local V = math.floor(G / 60)
    local y = math.floor(G % 60)
    return string.format("%02d:%02d", V, y)
end
i.UserDevice = { IsMobile = function()
    return V.UserInputService.TouchEnabled
end;
IsPC = function()
    return V.UserInputService.KeyboardEnabled and(V.UserInputService.MouseEnabled and not V.UserInputService.TouchEnabled)
end;
IsConsole = function()
    return V.UserInputService.GamepadEnabled and not V.UserInputService.KeyboardEnabled
end, Get = function()
    if V.UserInputService.TouchEnabled then
        return "Mobile"
    end
    if V.UserInputService.GamepadEnabled and not V.UserInputService.KeyboardEnabled then
        return "Console"
    end
    return "PC"
end;
Raw = function()
    return { Touch = V.UserInputService.TouchEnabled;
    Keyboard = V.UserInputService.KeyboardEnabled, Mouse = V.UserInputService.MouseEnabled, Gamepad = V.UserInputService.GamepadEnabled}
end}
J.IsFruitAndNotFav = function(G)
    local V, y = pcall(function()
        return G and(G:IsA("Tool") and(G:GetAttribute("b") == "j" and not G:GetAttribute("d")))
    end)
    return V and y
end
J.IsFruit = function(G)
    local V, y = pcall(function()
        return G and(G:IsA("Tool") and G:GetAttribute("b") == "j")
    end)
    return V and y
end
J.IsFavFruit = function(G)
    local V = G:GetAttribute("d")
    if V then
        return true
    end
    return false
end
J.GetFruitCount = function()
    local G = 0
    for V, y in ipairs(V.Backpack:GetChildren()) do
        if J.IsFruit(y) then
            G = G + 1
        end
    end
    local y = V.Character:FindFirstChildOfClass("Tool")
    if y then
        if J.IsFruit(y) then
            G = G + 1
        end
    end
    return G
end
J.GetIsFavPetUsingUUID = function(G)
    local y, Z = pcall(function()
        for V, y in ipairs(V.Backpack:GetChildren()) do
            if y:IsA("Tool") and y:GetAttribute("PetType") then
                local V = y:GetAttribute("PET_UUID")
                if V and V == G then
                    local G = y:GetAttribute("d")
                    if G then
                        return true
                    end
                end
            end
        end
        if V.Character then
            local y = V.Character:FindFirstChildOfClass("Tool")
            if y and(y:IsA("Tool") and y:GetAttribute("PetType")) then
                local V = y:GetAttribute("PET_UUID")
                if V and V == G then
                    local G = y:GetAttribute("d")
                    if G then
                        return true
                    end
                end
            end
        end
        return false
    end)
    if y then
        return Z
    else
        return false
    end
end
J.GetPetBiggestPet = function(G)
    local y = nil
    local Z = - 1
    local j = function(V)
        if V:IsA("Tool") and V:GetAttribute("PetType") then
            local j = V:GetAttribute("PET_UUID")
            if j then
                local i = t(j)
                if not i then
                    return
                end
                local c = i.PetType or ""
                local J = i.PetData
                if G then
                    if not G[c] then
                        return
                    end
                end
                local T = J.BaseWeight or 0
                if T > Z then
                    Z = T
                    y = V
                end
            end
        end
    end
    local i, c = pcall(function()
        for G, V in ipairs(V.Backpack:GetChildren()) do
            j(V)
        end
        if V.Character then
            local G = V.Character:FindFirstChildOfClass("Tool")
            if G then
                j(G)
            end
        end
        return y
    end)
    if i then
        return c
    else
        warn("Error in GetPetBiggestPet:", c)
        return nil
    end
end
J.BuildPetLookup = function()
    local G = {}
    local function y(V)
        if not V:IsA("Tool") then
            return
        end
        if not V:GetAttribute("PetType") then
            return
        end
        local y = V:GetAttribute("PET_UUID")
        if not y then
            return
        end
        local Z = t(y)
        if not Z then
            return
        end
        local j = Z.PetData
        if not j or j.IsFavorite then
            return
        end
        local i = Z.PetType
        if not i then
            return
        end
        G[i] =((G[i] or 0)) + 1
    end
    for G, V in ipairs(V.Backpack:GetChildren()) do
        y(V)
    end
    if V.Character then
        local G = V.Character:FindFirstChildOfClass("Tool")
        if G then
            y(G)
        end
    end
    return G
end
J.GetPetUsingName = function(G)
    local y = function(V)
        if V:IsA("Tool") and V:GetAttribute("PetType") then
            local y = V:GetAttribute("PET_UUID")
            if y then
                local V = t(y)
                if not V then
                    return nil
                end
                local Z = V.PetData
                local j = Z.IsFavorite
                if j then
                    return nil
                end
                local i = V.PetType
                if i == G then
                    return true
                end
            end
            return nil
        end
        return nil
    end
    local Z, j = pcall(function()
        for G, V in ipairs(V.Backpack:GetChildren()) do
            if y(V) then
                return V
            end
        end
        if V.Character then
            local G = V.Character:FindFirstChildOfClass("Tool")
            if G then
                if y(G) then
                    return G
                end
            end
        end
        return nil
    end)
    if Z then
        return j
    else
        warn("Error in GetPetUsingName:", j)
        return nil
    end
end
J.GetPetUsingUUID = function(G)
    local y, Z = pcall(function()
        for V, y in ipairs(V.Backpack:GetChildren()) do
            if y:IsA("Tool") and y:GetAttribute("PetType") then
                local V = y:GetAttribute("PET_UUID")
                if V and V == G then
                    return y
                end
            end
        end
        if V.Character then
            local y = V.Character:FindFirstChildOfClass("Tool")
            if y and(y:IsA("Tool") and y:GetAttribute("PetType")) then
                local V = y:GetAttribute("PET_UUID")
                if V and V == G then
                    return y
                end
            end
        end
        return nil
    end)
    if y then
        return Z
    else
        warn("Error in GetPetUsingUUID:", Z)
        return nil
    end
end
J.GetAllPetsUUIDS_Backpack = function()
    local G = {}
    for V, y in ipairs(V.Backpack:GetChildren()) do
        if y:IsA("Tool") and y:GetAttribute("PetType") then
            local V = y:GetAttribute("PET_UUID")
            local Z = y:GetAttribute("d")
            if V and not Z then
                table.insert(G, V)
            end
        end
    end
    if V.Character then
        local y = V.Character:FindFirstChildOfClass("Tool")
        if y and(y:IsA("Tool") and y:GetAttribute("PetType")) then
            local V = y:GetAttribute("PET_UUID")
            local Z = y:GetAttribute("d")
            if V and not Z then
                table.insert(G, V)
            end
        end
    end
    return G
end
J.GetAllPetsTools_Backpack = function()
    local G = {}
    for V, y in ipairs(V.Backpack:GetChildren()) do
        if y:IsA("Tool") and y:GetAttribute("PetType") then
            local V = y:GetAttribute("PET_UUID")
            if V then
                table.insert(G, y)
            end
        end
    end
    if V.Character then
        local y = V.Character:FindFirstChildOfClass("Tool")
        if y and(y:IsA("Tool") and y:GetAttribute("PetType")) then
            local V = y:GetAttribute("PET_UUID")
            if V then
                table.insert(G, y)
            end
        end
    end
    return G
end
J.GetAllFruitsInBackpack = function()
    local G = {}
    for V, y in ipairs(V.Backpack:GetChildren()) do
        if not J.IsFruit(y) then
            continue
        end
        table.insert(G, y)
    end
    local y = J.GetHeldTool()
    if J.IsFruit(y) then
        table.insert(G, y)
    end
    return G
end
j.bg_runs = 1
task.spawn(function()
    while true do
        task.wait(10)
        if not Y.fixkgbug_easter then
            continue
        end
        local G = J.GetAllFruitsInBackpack()
        for G, V in ipairs(G) do
            if V then
                D(V)
                task.wait()
            end
        end
        P()
        j.bg_runs = j.bg_runs + 1
        if j.bg_runs >= 2 then
            break
        end
    end
end)
J.GetFruitUsingNameList = function(G)
    local y = J.GetHeldTool()
    if y then
        if J.IsFruit(y) then
            local V = y:GetAttribute("f") or "-"
            if G[V] then
                return y
            end
        end
    end
    for V, y in ipairs(V.Backpack:GetChildren()) do
        if not J.IsFruit(y) then
            continue
        end
        local Z = y:GetAttribute("f") or "-"
        if G[Z] then
            return y
        end
    end
    return nil
end
J.GetRandomFruit = function()
    local G = J.GetHeldTool()
    if G then
        if J.IsFruit(G) then
            return G
        end
    end
    for G, V in ipairs(V.Backpack:GetChildren()) do
        if J.IsFruit(V) then
            return V
        end
    end
    return nil
end
i.compactStatusContainer = nil
i.compactStatusLabel = nil
i.updateCompactStatus = function(G)
    local y = 20
    local Z = .35
    local j = 18
    local c = 14
    local J = 1000
    local T = j
    local d = workspace.CurrentCamera
    if d then
        if d.ViewportSize.X < J then
            T = c
        end
    end
    if not i.compactStatusContainer or not i.compactStatusContainer.Parent then
        local G = V.LocalPlayer
        if not G then
            return
        end
        local j = V.PlayerGui
        local c = j:FindFirstChild("CompactStatusGui")
        if not c then
            c = Instance.new("ScreenGui")
            c.Name = "CompactStatusGui"
            c.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            c.ResetOnSpawn = false
            c.Parent = j
            c.DisplayOrder = 0
        end
        i.compactStatusContainer = c:FindFirstChild("CompactStatusContainer")
        if not i.compactStatusContainer then
            i.compactStatusContainer = Instance.new("Frame")
            i.compactStatusContainer.Name = "CompactStatusContainer"
            i.compactStatusContainer.Parent = c
            i.compactStatusContainer.BackgroundTransparency = 1
            i.compactStatusContainer.AnchorPoint = Vector2.new(1, .5)
            i.compactStatusContainer.Position = UDim2.new(1, - y, .5, 0)
            i.compactStatusContainer.Size = UDim2.new(Z, 0, 0, 0)
            i.compactStatusContainer.AutomaticSize = Enum.AutomaticSize.Y
        end
        i.compactStatusLabel = i.compactStatusContainer:FindFirstChild("CompactStatusDisplay")
        if not i.compactStatusLabel then
            for G, V in ipairs(i.compactStatusContainer:GetChildren()) do
                if V:IsA("TextLabel") then
                    V:Destroy()
                end
            end
            i.compactStatusLabel = Instance.new("TextLabel")
            i.compactStatusLabel.Name = "CompactStatusDisplay"
            i.compactStatusLabel.Parent = i.compactStatusContainer
            i.compactStatusLabel.Size = UDim2.new(1, 0, 1, 0)
            i.compactStatusLabel.AutomaticSize = Enum.AutomaticSize.Y
            i.compactStatusLabel.BackgroundTransparency = 1
            i.compactStatusLabel.RichText = true
            i.compactStatusLabel.Font = Enum.Font.SourceSansBold
            i.compactStatusLabel.TextColor3 = Color3.new(1, 1, 1)
            i.compactStatusLabel.TextSize = T
            i.compactStatusLabel.TextStrokeTransparency = .5
            i.compactStatusLabel.TextWrapped = true
            i.compactStatusLabel.ZIndex = 1
            i.compactStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
            i.compactStatusLabel.TextYAlignment = Enum.TextYAlignment.Top
        end
    elseif not i.compactStatusLabel or not i.compactStatusLabel.Parent then
        i.compactStatusLabel = i.compactStatusContainer:FindFirstChild("CompactStatusDisplay")
        if not i.compactStatusLabel then
            i.compactStatusContainer = nil
            return
        end
    end
    local u = table.concat(G, "\n")
    i.compactStatusLabel.Text = u
end
local O = nil
i.updateStatusList = function(G)
    local y = 18
    local Z = 14
    local j = 1000
    local i = y
    local c = workspace.CurrentCamera
    if c then
        if c.ViewportSize.X < j then
            i = Z
        end
    end
    if not O or not O.Parent then
        local G = V.LocalPlayer
        if not G then
            return
        end
        local y = V.PlayerGui
        local Z = y:FindFirstChild("StatusGui")
        if not Z then
            Z = Instance.new("ScreenGui")
            Z.Name = "StatusGui"
            Z.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            Z.ResetOnSpawn = false
            Z.Parent = y
            Z.DisplayOrder = 3
        end
        O = Z:FindFirstChild("StatusDisplay")
        if not O then
            O = Instance.new("TextLabel")
            O.Name = "StatusDisplay"
            O.Parent = Z
            O.Size = UDim2.new(.3, 0, .4, 0)
            O.AnchorPoint = Vector2.new(0, .5)
            O.Position = UDim2.new(0, 120, .65, 0)
            O.BackgroundTransparency = 1
            O.RichText = true
            O.Font = Enum.Font.SourceSansBold
            O.TextColor3 = Color3.new(1, 1, 1)
            O.TextSize = i
            O.TextStrokeTransparency = .5
            O.TextXAlignment = Enum.TextXAlignment.Left
            O.TextYAlignment = Enum.TextYAlignment.Top
        end
    end
    local J = table.concat(G, "\n")
    O.Text = J
end
g.Hop = { TeleportToJobId = function(G, y)
    local Z = game:GetService("Players")
    local j = V.TeleportService
    local i = Z.LocalPlayer
    G = tostring(G or "")
    y = tonumber(y) or game.PlaceId
    if G == "" then
        warn("[TeleportToJobId] Missing JobId")
        return false
    end
    if not y or y <= 0 then
        warn("[TeleportToJobId] Invalid PlaceId")
        return false
    end
    local c, J = pcall(function()
        j:TeleportToPlaceInstance(y, G, i)
    end)
    if not c then
        warn("[TeleportToJobId] Failed:", J)
        return false
    end
    return true
end, FindBestServer = function()
    local G = 55
    local y = 4
    local Z = game.PlaceId
    local j = nil
    local i = nil
    local c = - 1
    local J = nil
    local T = - 1
    for y = 1, y, 1 do
        local d = "https://games.roblox.com/v1/games/" ..(Z .. "/servers/Public?sortOrder=Desc&limit=100")
        if j then
            d = d ..("&cursor=" .. j)
        end
        local u, q = pcall(function()
            return V.HttpService:JSONDecode(game:HttpGet(d))
        end)
        if not u or not q or not q.data then
            warn("Fetch failed")
            break
        end
        for V, y in ipairs(q.data) do
            if y.id ~= game.JobId and y.maxPlayers > 0 then
                local V = y.playing or 0
                local Z = y.maxPlayers
                local j =((V / Z)) * 100
                if V >= Z then
                    continue
                end
                if j <= G then
                    if j > c then
                        c = j
                        i = y
                    end
                end
                if j > T then
                    T = j
                    J = y
                end
            end
        end
        j = q.nextPageCursor
        if not j then
            break
        end
        task.wait(.2)
    end
    if i then
        print(string.format("BEST \226\137\164 %d%%: %s (%d/%d | %.1f%%)", G, i.id, i.playing, i.maxPlayers, c))
        return i.id, i
    end
    if J then
        print(string.format("FALLBACK (closest non-full): %s (%d/%d | %.1f%%)", J.id, J.playing, J.maxPlayers, T))
        return J.id, J
    end
    warn("No suitable server found")
    return nil
end;
HopToNewServer = function()
    local G, V = g.Hop.FindBestServer()
    if not G or G == "" then
        warn("Invalid JobId")
        return false
    end
    if G == game.JobId then
        warn("Already in this server")
        return false
    end
    local y = game:GetService("Players")
    local Z = game:GetService("TeleportService")
    local j = y.LocalPlayer
    local i, c = pcall(function()
        Z:TeleportToPlaceInstance(game.PlaceId, G, j)
    end)
    if not i then
        warn("TeleportToPlaceInstance failed:", c)
        return false
    end
    return true
end;
HopToNewServerUsingJobid = function(G)
    local V = game:GetService("Players")
    local y = game:GetService("TeleportService")
    local Z = V.LocalPlayer
    if not G or G == "" then
        warn("[Hop] No valid JobId")
        return false
    end
    local j, i = pcall(function()
        y:TeleportToPlaceInstance(game.PlaceId, G, Z)
    end)
    if j then
        return true
    end
    warn("[Hop] Teleport failed, trying another:", i)
    task.wait(.5)
    warn("[Hop] All hop attempts failed")
    return false
end}
local F = { PositionXScale = .01, PositionYScale = .19;
SizeXScale = .5;
SizeYScale = .17, LineSpacing = 1;
StrokeColor = "#000000";
StrokeThickness = 1.3}
j.statsGui = nil
j.statsTextLabel = nil
q.uiplayerstats = nil
if q.uiplayerstats then
    task.cancel(q.uiplayerstats)
    q.uiplayerstats = nil
end
q.UpdatePlayerStatusUI = function()
    if Y.show_player_stats then
        if not j.statsGui or not j.statsGui.Parent then
            j.statsGui = Instance.new("ScreenGui")
            j.statsGui.Name = "SecretStatsGui"
            j.statsGui.ResetOnSpawn = false
            j.statsGui.DisplayOrder = 2
            j.statsGui.IgnoreGuiInset = true
            local G = Instance.new("Frame", j.statsGui)
            G.Name = "MainFrame"
            G.AnchorPoint = Vector2.new(0, 0)
            G.Position = UDim2.new(F.PositionXScale, 0, F.PositionYScale, 0)
            G.Size = UDim2.new(F.SizeXScale, 0, F.SizeYScale, 0)
            G.BackgroundColor3 = Color3.new(.1, .1, .1)
            G.BackgroundTransparency = 1
            G.BorderSizePixel = 0
            G.AutomaticSize = Enum.AutomaticSize.None
            local y = Instance.new("TextLabel", G)
            local function Z(G)
                local V = { Enum.Font.FredokaOne, Enum.Font.GothamBold, Enum.Font.Gotham;
                Enum.Font.SourceSans}
                for V, y in ipairs(V) do
                    local Z = pcall(function()
                        G.Font = y
                    end)
                    if Z then
                        return
                    end
                end
            end
            Z(y)
            y.Name = "StatsLabel"
            y.TextColor3 = Color3.new(1, 1, 1)
            y.TextXAlignment = Enum.TextXAlignment.Left
            y.TextYAlignment = Enum.TextYAlignment.Top
            y.BackgroundTransparency = 1
            y.Size = UDim2.new(1, 0, 1, 0)
            y.AutomaticSize = Enum.AutomaticSize.None
            y.TextScaled = true
            y.LineHeight = F.LineSpacing
            y.RichText = true
            j.statsTextLabel = y
            j.statsGui.Parent = V.PlayerGui
        end
        if j.statsTextLabel then
            local G = {}
            for y, Z in pairs(j.PlayerSecrets) do
                local j = V.LocalPlayer:GetAttribute(y) or 0
                local c = typeof(j) == "number" and string.format("%.2f", j) or tostring(j)
                local J = ""
                if c == "0.00" then
                    J = y ..(": " .. c)
                else
                    if y == "SessionTime" then
                        c = tostring(i.formatDuration(j))
                    end
                    J = y ..(": <b><font color=\'#39FF14\'>" ..(c .. "</font></b>"))
                end
                table.insert(G, J)
            end
            local y = table.concat(G, "\n")
            local Z = string.format("<stroke joins=\'round\' sizing=\'fixed\' color=\'%s\' thickness=\'%d\'>%s</stroke>", F.StrokeColor, F.StrokeThickness, y)
            j.statsTextLabel.Text = Z
        end
    else
        if j.statsGui and j.statsGui.Parent then
            j.statsGui:Destroy()
            j.statsGui = nil
            j.statsTextLabel = nil
            print("\240\159\146\171 destroyed")
        end
    end
end
q.uiplayerstats = task.spawn(function()
    while true do
        task.wait(.5)
        local G, V = pcall(function()
            q.UpdatePlayerStatusUI()
        end)
        if not G then
        end
    end
end)
local function v(G, V)
    if not G or not V then
        print("message or keywordText are nil")
        return false
    end
    local y = string.lower(G)
    for G in string.gmatch(V, "%a+") do
        local V = string.lower(G)
        if not string.find(y, V, 1, true) then
            return false
        end
    end
    return true
end
local function k()
    local G, y = pcall(function()
        return V.LocalPlayer.PlayerGui.Version_UI.Version
    end)
    if G and y then
        return y.Text
    else
        warn("Could not find the server version UI element.")
        return "Unknown"
    end
end
local p = {}
local function U(G)
    local V = string.match(G, "{(.-)}")
    return "{" ..(V .. "}")
end
local function Q()
    local G = {}
    for V, y in pairs(p) do
        table.insert(G, y)
    end
    table.sort(G)
    return G
end
local function o(G)
    local V = {}
    if not G then
        return V
    end
    for G, y in ipairs(G) do
        local Z = p[y]
        if Z then
            V[Z] = true
        end
    end
    return V
end
local function I()
    warn("Rejoin...")
    V.TeleportService:Teleport(game.PlaceId)
end
g.Inventory = { GetSettings = function()
    local G = E.GetBigDataUsingKey("Settings")
    return G
end, GetCurrentPetsInData = function()
    local G = {}
    local V = g.Inventory.GetPetInventory()
    for V, y in pairs(V) do
        local Z = y.IsFavorite
        if Z then
        end
        table.insert(G, V)
    end
    return G
end;
GetInventory = function()
    local G, V = pcall(function()
        local G = E.GetBigDataUsingKey("InventoryData")
        if not G then
            return {}
        end
        return G
    end)
    return G and V or {}
end;
GetPetInventory = function()
    local G, V = pcall(function()
        local G = E.GetBigDataUsingKey("PetsData")
        if not G then
            return {}
        end
        local V = G.PetInventory
        if not V or not V.Data then
            return {}
        end
        return V.Data
    end)
    return G and V or {}
end, GetEquippedPets = function()
    local G = E.GetBigDataUsingKey("PetsData")
    local V = G.EquippedPets
    return V
end, GetActivePetsAsKeyVal = function()
    local G = {}
    local V = E.GetBigDataUsingKey("PetsData")
    local y = V.EquippedPets
    for V, y in ipairs(y) do
        G[y] = true
    end
    return G
end, GetTotalOwnedPets = function()
    local G = E.GetBigDataUsingKey("PetsData")
    if not G then
        return 0
    end
    local V = G.PetInventory
    local y = 0
    if not V or not V.Data then
        return 0
    end
    for G, V in pairs(V.Data) do
        y = y + 1
    end
    return y
end, GetMaxEggsAndInventorySpaceCount = function()
    local G = E.GetBigDataUsingKey("PetsData")
    if not G then
        return 0, 0
    end
    local V = G.MutableStats
    if not V then
        return 0, 0
    end
    local y = tonumber(V.MaxEggsInFarm) or 0
    local Z = tonumber(V.MaxPetsInInventory) or 0
    return y, Z
end;
GetPetsInventoryCounts = function()
    local G, V, y = pcall(function()
        local G = E.GetBigDataUsingKey("PetsData")
        local V = G.PetInventory
        local y = G.MutableStats
        local Z = y.MaxPetsInInventory
        local j = 0
        for G, V in pairs(V.Data) do
            j = j + 1
        end
        return j, Z
    end)
    if G then
        return V, y
    end
    return 0, 0
end;
GetPetsCount_UI_TEXT = function()
    local G, V = pcall(function()
        local G = E.GetBigDataUsingKey("PetsData")
        local V = G.PetInventory
        local y = G.MutableStats
        local Z = y.MaxEggsInFarm
        local j = y.MaxEquippedPets
        local i = y.MaxPetsInInventory
        local c = 0
        local J = "#00FF2A"
        for G, V in pairs(V.Data) do
            c = c + 1
        end
        if c >= i then
            J = "#FF2C00"
        end
        local T = {}
        table.insert(T, string.format("Pets In Inventory: <font color=\'%s\'>%s</font> / %s\n", J, c, i))
        table.insert(T, string.format("Max Eggs Allowed: %s\n", Z))
        table.insert(T, string.format("Max Pets Equip Allowed: %s\n", j))
        return table.concat(T)
    end)
    if G then
        return V
    end
    return ""
end, GetEggsData = function()
    local G = E.GetBigDataUsingKey("SaveSlots")
    for G, V in pairs(G.AllSlots) do
        warn("Key: " .. G)
        i.JsonPrint(V)
        warn("-----------------------")
    end
end}
j.TradeData = function()
end
j.GetMyTokens = function()
    local G = E.GetBigDataUsingKey("TradeData")
    local V = G.Tokens or 0
    return V
end
j.GetMyTokens()
j.GetTradeLocks = function()
    local G = {}
    local V = E.GetBigDataUsingKey("TradeData")
    for V, y in pairs(V.TradeLocks) do
        for V, y in pairs(y) do
            G[V] = true
        end
    end
    return G
end
j.GetMyListingsPets = function()
    local G = E.GetBigDataUsingKey("TradeData")
    local V = {}
    local y = {}
    local Z = {}
    local j = 0
    for G, i in pairs(G.Listings) do
        local c = i.ItemType
        local J = i.ItemId or "-"
        if c and c == "Holdable" then
            continue
        end
        local T = t(J)
        if not T then
            continue
        end
        V[J] = true
        j = j + 1
        local d = T.PetType
        local u = { uuid = G, petname = d}
        table.insert(y, G)
        table.insert(Z, u)
    end
    return V, j, y, Z
end
j.GetMyListingsFruitsIDs = function()
    local G = E.GetBigDataUsingKey("TradeData")
    local V = {}
    for G, y in pairs(G.Listings) do
        local Z = y.ItemType
        if Z and Z == "Holdable" then
            table.insert(V, G)
        end
    end
    return V
end
j.GetMyListingsCount = function()
    local G = E.GetBigDataUsingKey("TradeData")
    local V = {}
    local y = {}
    local Z = 0
    for G, j in pairs(G.Listings) do
        local i = j.ItemId or "-"
        V[i] = true
        Z = Z + 1
        table.insert(y, G)
    end
    return V, Z, y
end
j.TradeData()
E.GetPlayerPetDataSnapshot = function()
    local G = {}
    local V, y = pcall(function()
        local V = E.GetBigDataUsingKey("PetsData")
        if not V then
            return {}
        end
        local y = V.PetInventory
        if not y or not y.Data then
            return {}
        end
        for V, y in pairs(y.Data) do
            G[V] = y
        end
        return G
    end)
    return V and y or {}
end
E.GetNewUUIDs = function(G, V)
    local y = {}
    local Z = {}
    for G, V in ipairs(G) do
        local Z = type(V) == "table" and V.uuid or V
        if Z then
            y[Z] = true
        end
    end
    for G, V in ipairs(V) do
        local j = type(V) == "table" and V.uuid or V
        if j and not y[j] then
            table.insert(Z, j)
        end
    end
    return Z
end
i.mutationConfig = { Rainbow = { color = 5793266, emoji = "\240\159\140\136"}, Dreadbound = { color = 9109504, emoji = "\226\155\147\239\184\143"}, Soulflame = { color = 16737792, emoji = "\240\159\148\165"};
Spectral = { color = 8900331, emoji = "\240\159\145\187"};
Nightmare = { color = 7340032, emoji = "\240\159\152\136"};
Ascended = { color = 16777215;
emoji = "\226\156\168"};
Inverted = { color = 33023, emoji = "\240\159\148\132"}, Shiny = { color = 16766720;
emoji = "\240\159\140\159"}, Radiant = { color = 16768350;
emoji = "\240\159\148\134"};
IronSkin = { color = 8421504;
emoji = "\240\159\155\161\239\184\143"}, Golden = { color = 16766720, emoji = "\240\159\146\176"}, Frozen = { color = 6736895, emoji = "\240\159\167\138"}, Windy = { color = 8355711, emoji = "\240\159\140\172\239\184\143"}, Tiny = { color = 12632256, emoji = "\240\159\144\156"}, Mega = { color = 1179647;
emoji = "\240\159\146\170"}, Shocked = { color = 16776960, emoji = "\226\154\161"};
Default = { color = 8421504;
emoji = "\226\157\147"}}
i.getWebhookSoldItemFruitNew = function(G, y)
    local Z = G.item_name or "Unknown"
    local j = G.price or 0
    local c = G.tokens or 0
    local J = i.FormatNumber(j)
    local T = i.FormatNumber(c)
    local d = i.mutationConfig.Default
    local u = os.date("!%Y-%m-%dT%H:%M:%SZ")
    local q = y and "||Exotic Hub||" or string.format("||%s||", V.LocalPlayer.Name)
    local g = string.format("%s ", Z)
    local E = string.format("\240\159\146\176 %s", g)
    local a = string.format("By User: %s\n```\240\159\146\176 Sold For: %s\n\226\156\168 Token Balance: %s```", q, J, T)
    local H = { username = "Exotic Hub", embeds = { { title = E, description = a;
    color = d.color, footer = { text = i.GetFooterInfo(true)};
    timestamp = u}}}
    return H
end
i.getWebhookSoldItemNew = function(G, y)
    local Z = G.found_mutation or ""
    local j = G.pet_name or "Unknown"
    local c = G.level or 0
    local J = G.nickname or ""
    local T = G.price or 0
    local d = G.weight or 0
    local u = G.tokens or 0
    local q = i.FormatNumber(T)
    local g = i.FormatNumber(u)
    local E = i.mutationConfig[Z] or i.mutationConfig.Default
    local a = os.date("!%Y-%m-%dT%H:%M:%SZ")
    local H = y and "||Exotic Hub||" or string.format("||%s||", V.LocalPlayer.Name)
    local r = string.format("%s %s(%s) [Age %s] [%s KG]", Z, j, J, c, d)
    local Y = string.format("\240\159\146\176 %s", r)
    local e = string.format("By User: %s\n```\240\159\146\176 Sold For: %s\n\226\156\168 Token Balance: %s```", H, q, g)
    local s = { username = "Exotic Hub", embeds = { { title = Y, description = e;
    color = E.color;
    footer = { text = i.GetFooterInfo(true)}, timestamp = a}}}
    return s
end
i.getWebhookSnipedItem = function(G, y)
    local Z = G.found_mutation or ""
    local j = G.pet_name or "Unknown"
    local c = G.level or 0
    local J = G.nickname or ""
    local T = G.price or 0
    local d = G.weight or 0
    local u = G.tokens or 0
    local q = i.FormatNumber(T)
    local g = i.FormatNumber(u)
    local E = i.mutationConfig[Z] or i.mutationConfig.Default
    local a = os.date("!%Y-%m-%dT%H:%M:%SZ")
    local H = y and "||Exotic Hub||" or string.format("||%s||", V.LocalPlayer.Name)
    local r = string.format("%s %s(%s) [Age %s] [%s KG]", Z, j, J, c, d)
    local Y = string.format("\240\159\142\175 Sniped: %s", r)
    local e = string.format("Sniped By: %s\n```\240\159\146\184 Cost: %s\n\226\156\168 Token Balance: %s```", H, q, g)
    local s = { username = "Exotic Hub";
    embeds = { { title = Y, description = e;
    color = E.color, footer = { text = i.GetFooterInfo(true)};
    timestamp = a}}}
    return s
end
i.SendLiveWebhook = function(G, y)
    if not y then
        return
    end
    local Z, j = pcall(function()
        local Z = V.HttpService:JSONEncode(G)
        local j =(syn and syn.request) or(http and http.request) or http_request or request or(fluxus and fluxus.request) or(krnl and krnl.request)
        if j then
            j({ Url = y;
            Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = Z})
        else
            V.HttpService:PostAsync(y, Z)
        end
    end)
    if not Z then
        warn("error: ", j)
    end
end
i.SendLiveWebhookPublicDiscord = function(G, y)
    local Z = ""
    local j = { api = "";
    payload = G, cat = y}
    pcall(function()
        local G = V.HttpService:JSONEncode(j)
        local y =(syn and syn.request) or(http and http.request) or http_request or request or(fluxus and fluxus.request) or(krnl and krnl.request)
        if y then
            y({ Url = Z;
            Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = G})
        else
            V.HttpService:PostAsync(Z, G)
        end
    end)
end
i.getWebhookSoldItem = function(G, y)
    local Z = G.found_mutation or "None"
    local j = G.pet_name or "Unknown"
    local c = G.level or 0
    local J = G.nickname or "None"
    local T = G.price or 0
    local d = G.weight or 0
    local u = G.tokens or 0
    local q = i.mutationConfig[Z] or i.mutationConfig.Default
    local g = "Exotic Hub " ..((V.CurentV or ""))
    local E = os.date("!%Y-%m-%dT%H:%M:%SZ")
    local a = string.format("%s (%s)", j, J)
    local H = string.format("%s %s", q.emoji, c)
    local r = string.format("||%s||", V.LocalPlayer.Name)
    if y then
        r = "||Exotic Hub||"
    end
    local Y = "\240\159\146\176 Item Sold! \240\159\146\176"
    local e = { username = "Exotic Hub", embeds = { { title = Y, description = "Seller: " .. r;
    color = q.color;
    fields = { { name = "Pet Name", value = a;
    inline = true};
    { name = "Level / Mut";
    value = H, inline = true};
    { name = "Price";
    value = tostring(T) .. " Token", inline = true};
    { name = "Weight";
    value = string.format("%s KG", tostring(d)), inline = true}, { name = "Current Tokens", value = tostring(u), inline = true}}, footer = { text = g}, timestamp = E}}}
    return e
end
H.webhook = { PostWebhook = function(G, y)
    if not y then
        return
    end
    local Z, j = pcall(function()
        local Z = V.HttpService:JSONEncode(G)
        local j =(syn and syn.request) or request
        if j then
            j({ Url = y, Method = "POST";
            Headers = {["Content-Type"] = "application/json"}, Body = Z})
        else
            V.HttpService:PostAsync(y, Z)
        end
    end)
    if not Z then
        warn("error: ", j)
    end
end, SendSuccess = function(G)
    local V = "Exotic Hub " .. i.GetFooterInfo(true)
    local y = os.date("!%Y-%m-%dT%H:%M:%SZ")
    local Z = { username = "Exotic Hub";
    embeds = { { title = "\226\156\133 Success", description = tostring(G or "Operation completed successfully.");
    color = 5763719;
    footer = { text = V}, timestamp = y}}}
    return Z
end;
SendError = function(G)
    local V = "Exotic Hub " .. i.GetFooterInfo(true)
    local y = os.date("!%Y-%m-%dT%H:%M:%SZ")
    local Z = { username = "Exotic Hub", embeds = { { title = "\226\157\140 Error";
    description = tostring(G or "An unexpected error occurred.");
    color = 15548997, footer = { text = V}, timestamp = y}}}
    return Z
end}
i.DoWeHaveABooth = function()
    local G = nil
    local y, Z = pcall(function()
        local y = V.Workspace.TradeWorld.Booths
        local Z = "@" .. V.LocalPlayer.Name
        for V, y in ipairs(y:GetChildren()) do
            local j = y:FindFirstChild("SurfaceGui", true)
            if j then
                local V = j.Parent
                local i = V:FindFirstChild("ProximityPrompt", true)
                if i then
                    local G = i.ActionText
                end
                local c = j:FindFirstChild("TextLabel")
                if c then
                    local V = c.Text
                    if string.find(V, Z) then
                        G = y
                        return true
                    end
                end
            end
        end
        return false
    end)
    if not y then
        warn("Error: ", Z)
    end
    return Z, G
end
i.GetBoothSkinToEquip = function()
    local G = Y.skin_booth_list or {}
    for G, V in pairs(G) do
        if V == true and(type(G) == "string" and G ~= "") then
            if not string.find(G, "\239\191\189", 1, true) then
                return G
            end
        end
        if type(V) == "string" and V ~= "" then
            if not string.find(V, "\239\191\189", 1, true) then
                return V
            end
        end
    end
    return "Default"
end
q.global_pet_search_cd = 0
q.is_random_teleporting = q.is_random_teleporting or false
q.already_tried_jobs = {}
g.finder = { UpdateStatusPetFound = function(G)
    if not r.lbl_finder_pet_details then
        return
    end
    r.lbl_finder_pet_details:SetText(G)
end;
GetIsEnabledFilter = function(G)
    local V = Y.find_settings[G]
    if not V then
        return false
    end
    if not V.enabled then
        return false
    end
    return true
end;
GetPetPriceFilter = function(G)
    local V = Y.find_settings[G]
    if not V then
        return 0
    end
    if not V.enabled then
        return 0
    end
    local y = tonumber(V.price) or 0
    return y
end, GetPlayerNameUsingUserid = function(G)
    if G then
        local y = V.Players:GetPlayerByUserId(G)
        if y then
            return y
        end
    end
    return nil
end;
FindNewListing = function(G)
    local V = {}
    if G then
        V = G
    else
        V = Y.finder.find_petlist or {}
    end
    if next(V) == nil then
        return false
    end
    for G, V in pairs(V) do
        task.wait()
        local y = Y.find_settings[G]
        if not y or y.enabled ~= true then
            continue
        end
        local Z = y.max_keep or 300
        if j.PET_COUNT[G] and j.PET_COUNT[G] >= Z then
            continue
        end
        print("Trying to find ", G)
        local c = os.clock()
        if c < q.global_pet_search_cd then
            local G = q.global_pet_search_cd - c
            print(string.format("[Finder] Waiting %.1fs global search cooldown", G))
            task.wait(G)
        end
        q.global_pet_search_cd = os.clock() + 10.7
        local J, T, d = g.finder.FindSellerUsingPetName(G)
        if J and T then
            if type(T) == "table" then
                local V = T.info
                local y = tonumber(V.Price) or 10000000
                local Z = V.JobId or "-"
                if Z == game.JobId then
                    j.Notify("[Snipe] Unable to tp to same server.")
                    return false
                end
                local c = g.finder.GetPetPriceFilter(G)
                if c >= y then
                    task.wait(4)
                    g.finder.TeleportToSeller(Z)
                    task.wait(3)
                    if j.failed_tp == true then
                        warn("Tp failed, server full or other error")
                        q.already_tried_jobs[Z] = true
                        j.failed_tp = false
                    end
                else
                    print("too expensive: ", y)
                end
                i.JsonPrint(Z)
                if q.already_tried_jobs[Z] then
                    continue
                end
            else
                if T == game.JobId then
                    j.Notify("[Snipe] Unable to tp to same server.")
                    return false
                end
                if q.already_tried_jobs[T] then
                    task.wait(11)
                    continue
                end
                task.wait(1)
                g.finder.TeleportToSeller(T)
                task.wait(4)
                if j.failed_tp == true then
                    warn("Tp failed, server full or other error")
                    q.already_tried_jobs[T] = true
                    j.failed_tp = false
                end
            end
        end
    end
    return false
end;
FindAndTeleport = function(G)
    local V = G or Y.finder.find_petlist or {}
    if next(V) == nil then
        if g.Booth and g.Booth.SetRejoinStatus then
            g.Booth.SetRejoinStatus("\226\157\140 No pets selected for rejoin search.")
        end
        return false
    end
    for G, V in pairs(V) do
        task.wait()
        if g.Booth and g.Booth.ShouldBlockServerHop then
            local G, V = g.Booth.ShouldBlockServerHop(false)
            if G then
                g.Booth.SetRejoinStatus("\226\143\179 " .. tostring(V or "Waiting before rejoin."))
                return false
            end
        end
        if g.Booth and g.Booth.WaitForSellerSearchCooldown then
            g.Booth.WaitForSellerSearchCooldown("Rejoin")
        else
            local G = os.clock()
            if G < q.global_pet_search_cd then
                task.wait(q.global_pet_search_cd - G)
            end
        end
        q.global_pet_search_cd = os.clock() + 10.7
        if g.Booth and g.Booth.SetRejoinStatus then
            g.Booth.SetRejoinStatus("\240\159\148\142 Searching listing server: " .. tostring(G))
        end
        local y, Z = g.finder.FindSellerUsingPetName(G)
        if not y or not Z then
            continue
        end
        local i = ""
        if type(Z) == "table" then
            i = Z.info and Z.info.JobId or ""
        else
            i = tostring(Z or "")
        end
        if i == "" or i == "-" then
            continue
        end
        if i == game.JobId then
            if g.Booth and g.Booth.SetRejoinStatus then
                g.Booth.SetRejoinStatus("\226\154\160\239\184\143 Found same server, skipping: " .. tostring(G))
            end
            continue
        end
        if q.already_tried_jobs[i] then
            continue
        end
        if g.Booth and g.Booth.SetRejoinStatus then
            g.Booth.SetRejoinStatus("\240\159\154\128 Rejoining through listing: " .. tostring(G))
        end
        j.failed_tp = false
        j.last_tp_fail_reason = ""
        local c, J = g.finder.TeleportToSeller(i)
        if c then
            j.rejoin_teleports += 1
            return true
        end
        q.already_tried_jobs[i] = true
        if g.Booth and g.Booth.SetRejoinStatus then
            g.Booth.SetRejoinStatus("\226\157\140 Rejoin teleport failed: " .. tostring(J or "Unknown"))
        end
    end
    return false
end, BuyListing = function(G, y, Z)
    local c = tostring(y or "")
    local J = tonumber(Z) or 0
    if not G then
        return false, "Seller missing"
    end
    if c == "" then
        return false, "Listing missing"
    end
    if j.is_buying_from_listing then
        return false, "Purchase already running"
    end
    j.is_buying_from_listing = true
    local function T(G, V)
        j.is_buying_from_listing = false
        if G == true and(g.Booth and g.Booth.BlockServerHopAfterBuy) then
            pcall(function()
                g.Booth.BlockServerHopAfterBuy("purchase")
            end)
        end
        return G, V
    end
    if J > 0 then
        local G = tonumber(j.GetMyTokens()) or 0
        if G < J then
            local V = J - G
            return T(false, "Need " ..(i.FormatHugeNumbers(V, 2) .. " more tokens"))
        end
    end
    local d = V.GameEvents and V.GameEvents:FindFirstChild("TradeEvents")
    local u = d and d:FindFirstChild("Booths")
    local q = u and u:FindFirstChild("BuyListing")
    if not q or not q:IsA("RemoteFunction") then
        return T(false, "Buy remote missing")
    end
    local E, a, H = pcall(function()
        return q:InvokeServer(G, c)
    end)
    if not E then
        return T(false, tostring(a or "Buy failed"))
    end
    if a == true then
        return T(true, tostring(H or "Bought"))
    end
    return T(false, tostring(H or "Purchase rejected"))
end;
GetBoothListings = function()
    local G = {}
    if not V.ReplicationReceiver then
        return G
    end
    local y, Z = pcall(function()
        local G = V.ReplicationReceiver.new("Booths")
        return G:GetDataAsync()
    end)
    if not y or type(Z) ~= "table" or type(Z.Booths) ~= "table" or type(Z.Players) ~= "table" then
        return G
    end
    local i = "Player_" .. tostring(j.player_userid)
    for V, y in pairs(Z.Booths) do
        local j = y and y.Owner
        if type(j) ~= "string" or j == "" or j == i then
            continue
        end
        local c = g.finder.GetPlayerNameUsingUserid(tonumber(string.match(j, "Player_(%d+)")))
        if not c then
            continue
        end
        local J = Z.Players[j]
        local d = J and J.Listings
        local u = J and J.Items
        if type(d) ~= "table" or type(u) ~= "table" then
            continue
        end
        for V, y in pairs(d) do
            if type(y) ~= "table" then
                continue
            end
            local Z = y.ItemType or y.Type
            local i = y.ItemId
            local J = u[i]
            if Z and Z ~= "Pet" then
                continue
            end
            if type(J) ~= "table" or type(J.PetData) ~= "table" then
                continue
            end
            local d = J.PetData
            local q = tonumber(d.Level) or 1
            local g = K(d.BaseWeight, 1) or 0
            local E = K(d.BaseWeight, q) or 0
            local a = tostring(d.MutationType or "")
            local H = T.AllMutationListEnum[a] or a
            if H == "Normal" then
                H = ""
            end
            G[tostring(V)] = { list_id = tostring(V);
            price = tonumber(y.Price) or 0;
            petnickname = d.Name, petname = J.PetType;
            pet_uuid = J.UUID, level = q, weight = g, mut = H or "";
            mutation_id = a;
            owner = c, owner_key = j, visualweight = E;
            fav = d.IsFavorite == true}
        end
    end
    return G
end, GetSellerSearchRemotes = function()
    local G = V.GameEvents and V.GameEvents:FindFirstChild("TradeEvents")
    local y = G and G:FindFirstChild("TokenRAPs")
    local Z = y and y:FindFirstChild("FindSellers")
    local j = y and y:FindFirstChild("TeleportToListing")
    if not Z or not Z:IsA("RemoteFunction") then
        return nil, nil, "Seller search missing"
    end
    if not j or not j:IsA("RemoteFunction") then
        return nil, nil, "Seller teleport missing"
    end
    return Z, j, ""
end;
GetMutationIdFromName = function(G)
    G = tostring(G or "")
    if G == "" or G == "Normal" then
        return "Normal"
    end
    for V, y in pairs(T.AllMutationListEnum or {}) do
        if tostring(y) == G then
            return V
        end
    end
    return G
end, BuildSellerPetData = function(G, V)
    return { PetType = G;
    PetData = { MutationType = g.finder.GetMutationIdFromName(V), BaseWeight = 1, Boosts = {}, LevelProgress = 0, Hunger = 0;
    Level = 0}, PetAbility = {}}
end, NormalizeSellerSearchResult = function(G, V)
    local y = { listingId = "";
    jobId = "", price = 0}
    local function Z(G, V)
        if type(G) ~= "table" then
            return ""
        end
        for V, y in ipairs(V) do
            local Z = G[y]
            if Z ~= nil and tostring(Z) ~= "" then
                return tostring(Z)
            end
        end
        return ""
    end
    local function j(G, V)
        if type(G) ~= "table" then
            return 0
        end
        for V, y in ipairs(V) do
            local Z = tonumber(G[y])
            if Z then
                return Z
            end
        end
        return 0
    end
    if type(G) == "string" then
        y.listingId = G
        y.jobId = G
    end
    if type(G) == "table" then
        local V = type(G.info) == "table" and G.info or {}
        y.listingId = Z(G, { "ListingId", "listingId", "ListingUUID", "listingUUID";
        "UUID";
        "Id";
        "id"})
        y.jobId = Z(G, { "JobId";
        "jobId", "JobID"})
        y.price = j(G, { "Price";
        "price"})
        if y.listingId == "" then
            y.listingId = Z(V, { "ListingId", "listingId";
            "ListingUUID";
            "listingUUID";
            "UUID", "Id", "id"})
        end
        if y.jobId == "" then
            y.jobId = Z(V, { "JobId";
            "jobId";
            "JobID"})
        end
        if y.price <= 0 then
            y.price = j(V, { "Price";
            "price"})
        end
    end
    if type(V) == "table" then
        if y.listingId == "" then
            y.listingId = Z(V, { "ListingId", "listingId", "ListingUUID";
            "listingUUID", "UUID", "Id";
            "id"})
        end
        if y.jobId == "" then
            y.jobId = Z(V, { "JobId", "jobId", "JobID"})
        end
        if y.price <= 0 then
            y.price = j(V, { "Price", "price"})
        end
    end
    return y
end, FindSellerUsingPetName = function(G)
    if type(G) ~= "string" or G == "" then
        return false, nil, "Pet missing"
    end
    local V, y, Z = g.finder.GetSellerSearchRemotes()
    if not V then
        return false, nil, Z
    end
    local j = g.finder.BuildSellerPetData(G, nil)
    local i, c, J, T = pcall(function()
        return V:InvokeServer("Pet", j)
    end)
    if not i then
        return false, nil, tostring(c or "Search failed")
    end
    return c, J, T
end, FindSellerUsingPetNameTimed = function(G, V, y)
    y = tonumber(y) or 11.5
    local Z = false
    local j, i, c = false, nil, "Search timed out"
    task.spawn(function()
        if type(G) ~= "string" or G == "" then
            j, i, c = false, nil, "Pet missing"
            Z = true
            return
        end
        local y, J, T = g.finder.GetSellerSearchRemotes()
        if not y then
            j, i, c = false, nil, T
            Z = true
            return
        end
        local d = g.finder.BuildSellerPetData(G, V)
        local u, q, E, a = pcall(function()
            return y:InvokeServer("Pet", d)
        end)
        if not u then
            j, i, c = false, nil, tostring(q or "Search failed")
            Z = true
            return
        end
        j, i, c = q, E, a
        Z = true
    end)
    local J = os.clock()
    while not Z and os.clock() - J < y do
        task.wait(.1)
    end
    if not Z then
        return false, nil, nil, "Search timed out"
    end
    return j, i, c, j and "" or tostring(c or "Not found")
end, ClickFindSellerPrompt = function()
    local G = V.PlayerGui
    local y = G and G:FindFirstChild("FindSellerPrompt")
    local Z = y and y:FindFirstChild("Yes", true)
    if not Z or not Z:IsA("GuiButton") or not Z.Visible then
        return false
    end
    local j = false
    local i = { Z.MouseButton1Click, Z.Activated}
    if type(getconnections) == "function" then
        for G, V in ipairs(i) do
            for G, V in ipairs(getconnections(V)) do
                pcall(function()
                    V:Fire()
                end)
                j = true
            end
        end
    end
    return j
end;
ClickFindSellerPromptFor = function(G)
    G = tonumber(G) or 4
    local V = os.clock()
    while os.clock() - V < G do
        if g.finder.ClickFindSellerPrompt() then
            return true
        end
        task.wait(.2)
    end
    return false
end, TeleportToSeller = function(G)
    if G == nil or G == "" then
        print("Listing id is missing")
        return false, "Listing missing"
    end
    local V, y, Z = g.finder.GetSellerSearchRemotes()
    if not y then
        print(Z)
        return false, Z
    end
    local j, i, c = pcall(function()
        return y:InvokeServer(G)
    end)
    if not j then
        print("tp error:", i)
        return false, tostring(i or "Teleport failed")
    end
    if i == false then
        return false, tostring(c or "Teleport rejected")
    end
    return true, tostring(c or "Teleport requested")
end, TeleportToSellerManual = function(G)
    if G == nil or G == "" then
        return false, "Listing missing"
    end
    local V, y, Z = g.finder.GetSellerSearchRemotes()
    if not y then
        return false, Z
    end
    j.failed_tp = false
    j.last_tp_fail_reason = ""
    local i, c, J = pcall(function()
        return y:InvokeServer(tostring(G), true)
    end)
    if not i then
        return false, tostring(c or "Teleport failed")
    end
    if c == false then
        return false, tostring(J or "Teleport rejected")
    end
    task.spawn(function()
        g.finder.ClickFindSellerPromptFor(4)
    end)
    return true, tostring(J or "Teleport requested")
end}
q.RandomFindAndTeleport = function(G)
    if q.is_random_teleporting then
        j.Notify("RandomFindAndTeleport is already running! ", 3)
        return false
    end
    if not G or next(G) == nil then
        j.Notify("No pet list provided to RandomFindAndTeleport", 3)
        return false
    end
    q.is_random_teleporting = true
    local V = {}
    for G, y in pairs(G) do
        local Z = type(G) == "number" and y or G
        table.insert(V, Z)
    end
    for G = # V, 2, - 1 do
        local y = math.random(G)
        V[G], V[y] = V[y], V[G]
    end
    local y = 7
    local Z = 0
    for G, V in ipairs(V) do
        Z = Z + 1
        if Z > y then
            j.Notify("\240\159\155\145 Reached max search limit of " ..(y .. " pets. Halting search."), 3)
            break
        end
        task.wait()
        j.Notify(string.format("\240\159\148\141 Randomly searching for server with: %s (%d/%d)", V, Z, y), 7)
        local i, c, J = g.finder.FindSellerUsingPetName(V)
        if i and c then
            local G = type(c) == "table" and c.info.JobId or c
            if G and G ~= "-" then
                if G == game.JobId then
                    j.Notify("\226\154\160\239\184\143 Already on this server. Skipping...", 3)
                    task.wait(1)
                    continue
                end
                j.Notify("\226\156\133 Found server for " ..(V .. " - Attempting Teleport!"), 3)
                g.finder.TeleportToSeller(G)
                task.wait(4)
                if j.failed_tp == true then
                    print("\226\157\140 Server must be full or teleport failed.")
                    if q.already_tried_jobs then
                        q.already_tried_jobs[G] = true
                    end
                    j.failed_tp = false
                else
                    q.is_random_teleporting = false
                    return true
                end
            end
        end
        task.wait(10.2)
    end
    j.Notify("\226\157\140 Could not find open servers for the selected pets.", 3)
    q.is_random_teleporting = false
    return false
end
i.HighLightBackPack = function()
    local G = {}
    local y = j.GetMyListingsPets()
    local Z = J.GetAllPetsTools_Backpack()
    local i = {}
    for G, V in ipairs(Z) do
        local y = V:GetAttribute("PET_UUID")
        i[V.Name] = y
    end
    local c = V.PlayerGui.BackpackGui.Backpack.Hotbar
    for V, y in ipairs(c:GetChildren()) do
        if y:IsA("TextButton") then
            table.insert(G, y)
        end
    end
    local T = V.PlayerGui.BackpackGui.Backpack.Inventory.ScrollingFrame.UIGridFrame
    for V, y in ipairs(T:GetChildren()) do
        if y:IsA("TextButton") then
            table.insert(G, y)
        end
    end
    for G, V in ipairs(G) do
        local Z = V:FindFirstChild("ToolName")
        local j = i[Z.Text] or nil
        if not j then
            continue
        end
        if not y[j] then
            continue
        end
        if Z and Z:IsA("TextLabel") then
            Z.TextColor3 = Color3.fromRGB(0, 255, 0)
            if not V:FindFirstChild("CheckMark") then
                local G = Instance.new("TextLabel")
                G.Name = "CheckMark"
                G.Parent = V
                G.Size = UDim2.new(0, 22, 0, 22)
                G.Position = UDim2.new(1, - 24, 0, 2)
                G.BackgroundTransparency = 1
                G.Text = "\226\156\133"
                G.TextScaled = true
                G.TextXAlignment = Enum.TextXAlignment.Center
                G.TextYAlignment = Enum.TextYAlignment.Center
            end
        end
    end
end
task.spawn(function()
    while true do
        task.wait(4)
        i.HighLightBackPack()
    end
end)
j.pet_select_for_list = {}
i.RefreshPetData = function()
    print("\240\159\148\132 Refreshing pet data...")
    local G = j.GetTradeLocks()
    local V = j.GetMyListingsPets()
    local y = g.Inventory.GetPetInventory()
    local Z = {}
    p = {}
    local J = true
    for y, j in pairs(y) do
        local c = j
        if c then
            local j = c.PetData.Level
            local d = c.PetData.BaseWeight
            local u = 0
            if J then
                u = K(d, 1)
            else
                u = K(d, j)
            end
            local q = tonumber(string.format("%.2f", u))
            local g = c.PetType
            local E = c.PetData.MutationType or ""
            local a = c.PetData.IsFavorite
            local H = T.AllMutationListEnum[E]
            local r = ""
            if H then
                local G = i.shortenMutation(H)
                r = string.format("%s ", G)
            end
            local Y = "#FF009F"
            if Z[y] then
                Y = "#0CCF19"
            end
            if j >= 100 then
                Y = "#FFFF00"
            end
            local e = ""
            if a then
                e = "\226\157\164\239\184\143"
            end
            local s = ""
            if V[y] then
                s = "\226\156\133"
            elseif G[y] then
                s = "\240\159\148\146"
            else
                s = "\226\173\144"
            end
            local N = string.format("<font color=\'%s\'>%s%s</font> <font color=\'#3DD8FF\'>%skg</font> %s%s%s ", Y, s, j, q, e, r, g)
            p[y] = N ..(" " .. y)
            i.PetDataLocal[y] = g
        else
            p[y] = "Active PET " .. y
        end
    end
    local d = true
    local u = Q()
    if c.dd_list_pets then
        c.dd_list_pets:SetValues(u, d)
        c.dd_list_pets:SetValue(j.pet_select_for_list)
    end
end
i.VisitBoothButton = function()
    local G = V.PlayerGui
    local y = G:FindFirstChild("Gift_Notification")
    if not y or not y.Enabled then
        return
    end
    local Z = y:FindFirstChild("Frame")
    if not Z then
        return
    end
    local j = game:GetService("VirtualInputManager")
    for G, V in ipairs(Z:GetChildren()) do
        if not V:IsA("ImageLabel") then
            continue
        end
        local y = false
        if V:FindFirstChild("Holder") and(V.Holder:FindFirstChild("Frame") and V.Holder.Frame:FindFirstChild("Accept")) then
            local G = V.Holder.Frame.Accept
            if getconnections then
                for G, V in pairs(getconnections(G.MouseButton1Click)) do
                    V:Fire()
                    y = true
                end
                for G, V in pairs(getconnections(G.Activated)) do
                    V:Fire()
                    y = true
                end
            end
        else
        end
        if y then
            task.wait(4)
        end
    end
end
i.GetAllUnlockedBooths = function()
    local G = {}
    local y = {}
    local Z, j = pcall(function()
        local Z = V.PlayerGui and V.PlayerGui:FindFirstChild("TradeBoothSkinSelector")
        local j = Z and Z:FindFirstChild("SkinSelector")
        local i = j and j:FindFirstChild("Main")
        local c = i and i:FindFirstChild("Skins")
        local J = c and c:FindFirstChild("ScrollerHolder")
        local T = J and J:FindFirstChild("Scroller")
        local d = T and T:FindFirstChild("Content")
        if not d then
            return
        end
        for V, Z in ipairs(d:GetChildren()) do
            local j = tostring(Z.Name or "")
            local i = Z:FindFirstChild("LockIcon")
            if j ~= "" and(i and(i.Visible == false and not y[j])) then
                y[j] = true
                table.insert(G, { Text = j, Value = j})
            end
        end
    end)
    if not Z then
        warn("Error: ", j)
    end
    return G
end
g.Booth = { SetStatus = function(G)
    j.TEXT_BOOTH_SETUP = tostring(G or "")
    if r.lbl_booth_setup_status then
        r.lbl_booth_setup_status:SetText(g.Booth.GetBoothStatsText())
    end
end;
SetRejoinStatus = function(G)
    j.TEXT_REJOIN = tostring(G or "")
    if r.lbl_booth_setup_status then
        r.lbl_booth_setup_status:SetText(g.Booth.GetBoothStatsText())
    end
end, ClampHopBlockSeconds = function()
    local G = tonumber(Y.booth_hop_after_buy_secs) or 120
    return math.clamp(math.floor(G), 60, 180)
end;
GetHopBlockLeft = function()
    local G =((tonumber(j.booth_hop_block_until) or 0)) - os.clock()
    if G <= 0 then
        return 0
    end
    return math.floor(G)
end, BlockServerHopAfterBuy = function(G)
    local V = g.Booth.ClampHopBlockSeconds()
    local y = tostring(G or "buy")
    j.booth_hop_block_until = math.max(tonumber(j.booth_hop_block_until) or 0, os.clock() + V)
    j.booth_hop_blocks += 1
    if y == "customer" then
        j.booth_customer_blocks += 1
        g.Booth.SetRejoinStatus("\240\159\155\141\239\184\143 Customer bought from booth, holding server for " .. a.time.FormatText(V))
    else
        j.booth_own_buy_blocks += 1
        g.Booth.SetRejoinStatus("\240\159\155\146 Purchase cooldown, hop blocked for " .. a.time.FormatText(V))
    end
    return true
end;
ResetRejoinTimer = function(G)
    local V = tonumber(G)
    if not V or V <= 0 then
        V =((tonumber(Y.rejoin_mins) or 15)) * 60
    end
    j.rejoin_started_at = os.clock()
    j.next_rejoin_at = os.clock() + V
    return true
end;
GetRejoinTimeLeft = function()
    if not j.next_rejoin_at or j.next_rejoin_at <= 0 then
        g.Booth.ResetRejoinTimer()
    end
    local G =((tonumber(j.next_rejoin_at) or 0)) - os.clock()
    if G <= 0 then
        return 0
    end
    return math.floor(G)
end, ShouldBlockServerHop = function(G)
    if j.is_buying_from_listing then
        return true, "Purchase running."
    end
    if j.is_manual_buying then
        return true, "Manual buy running."
    end
    if j.is_manual_server_searching then
        return true, "Manual server search running."
    end
    if q.is_random_teleporting then
        return true, "Random server search running."
    end
    local V = g.Booth.GetHopBlockLeft()
    if V > 0 then
        return true, "Booth activity, wait " .. a.time.FormatText(V)
    end
    if G ~= false then
        local G =((tonumber(q.global_pet_search_cd) or 0)) - os.clock()
        if G > 0 then
            return true, "Seller search cooldown " .. a.time.FormatText(G)
        end
    end
    return false, ""
end;
WaitForSellerSearchCooldown = function(G)
    G = tostring(G or "Seller search")
    local V =((tonumber(q.global_pet_search_cd) or 0)) - os.clock()
    while V > 0 do
        g.Booth.SetRejoinStatus("\226\143\179 " ..(G ..(" cooldown " .. a.time.FormatText(V))))
        task.wait(math.min(1, V))
        V =((tonumber(q.global_pet_search_cd) or 0)) - os.clock()
    end
    return true
end, GetBoothsSorted = function()
    local G, y = pcall(function()
        local G = {}
        local y = V.Workspace:FindFirstChild("TradeWorld")
        local Z = y and y:FindFirstChild("Spawns")
        local j = Z and Z:FindFirstChild("Default_Spawn_Point")
        local i = y and y:FindFirstChild("Booths")
        if not j or not i then
            return G
        end
        local c = j.Position
        for V, y in ipairs(i:GetChildren()) do
            if y:IsA("Model") then
                local V =(((y:GetPivot()).Position - c)).Magnitude
                table.insert(G, { Instance = y, Dist = V})
            end
        end
        table.sort(G, function(G, V)
            return G.Dist < V.Dist
        end)
        local J = {}
        for G, V in ipairs(G) do
            J[G] = V.Instance
        end
        return J
    end)
    return G and y or {}
end;
GetBoothRank = function(G)
    if not G then
        return 0
    end
    for V, y in ipairs(g.Booth.GetBoothsSorted()) do
        if y == G then
            return V
        end
    end
    return 0
end;
GetBoothReceiver = function()
    if g.Booth._booth_receiver then
        return g.Booth._booth_receiver
    end
    if not V.ReplicationReceiver then
        return nil
    end
    local G, y = pcall(function()
        return V.ReplicationReceiver.new("Booths")
    end)
    if G and y then
        g.Booth._booth_receiver = y
        return y
    end
    return nil
end;
GetBoothReplicaData = function(G)
    local V = g.Booth.GetBoothReceiver()
    if not V then
        return nil
    end
    local y, Z = pcall(function()
        if G == true and type(V.GetDataAsync) == "function" then
            return V:GetDataAsync()
        end
        if type(V.GetData) == "function" then
            return V:GetData()
        end
        return V:GetDataAsync()
    end)
    if y and type(Z) == "table" then
        return Z
    end
    return nil
end;
GetLocalBoothOwnerKey = function()
    return "Player_" .. tostring(j.player_userid or V.LocalPlayer.UserId)
end, GetOwnedBoothName = function()
    local G = g.Booth.GetBoothReplicaData(false) or g.Booth.GetBoothReplicaData(true)
    local V = G and G.Players
    local y = V and V[g.Booth.GetLocalBoothOwnerKey()]
    local Z = y and y.Booth
    if type(Z) == "string" and Z ~= "" then
        return Z
    end
    return nil
end, GetBoothModelByName = function(G)
    G = tostring(G or "")
    if G == "" then
        return nil
    end
    local y = V.Workspace:FindFirstChild("TradeWorld")
    local Z = y and y:FindFirstChild("Booths")
    return Z and Z:FindFirstChild(G) or nil
end, GetOwnedBoothModel = function()
    local G = g.Booth.GetOwnedBoothName()
    local V = g.Booth.GetBoothModelByName(G)
    if V then
        return true, V, G
    end
    local y, Z = i.DoWeHaveABooth()
    if y and Z then
        return true, Z, Z.Name
    end
    return false, nil, nil
end;
GetClaimPrompt = function(G)
    if not G then
        return nil
    end
    for G, V in ipairs(G:GetDescendants()) do
        if V:IsA("ProximityPrompt") and tostring(V.ActionText or "") == "Claim" then
            return V
        end
    end
    return nil
end;
IsBoothFree = function(G, V)
    if not G then
        return false
    end
    V = V or g.Booth.GetBoothReplicaData(false) or g.Booth.GetBoothReplicaData(true)
    local y = V and(V.Booths and V.Booths[G.Name])
    if type(y) == "table" then
        return y.Owner == nil or y.Owner == ""
    end
    return g.Booth.GetClaimPrompt(G) ~= nil
end, IsClaimableBooth = function(G)
    return g.Booth.IsBoothFree(G)
end;
GetClaimRemote = function()
    local G = V.GameEvents and V.GameEvents:FindFirstChild("TradeEvents")
    local y = G and G:FindFirstChild("Booths")
    local Z = y and y:FindFirstChild("ClaimBooth")
    if Z and Z:IsA("RemoteEvent") then
        return Z
    end
    return nil
end, GetRemoveBoothRemote = function()
    local G = V.GameEvents and V.GameEvents:FindFirstChild("TradeEvents")
    local y = G and G:FindFirstChild("Booths")
    local Z = y and y:FindFirstChild("RemoveBooth")
    if Z and Z:IsA("RemoteEvent") then
        return Z
    end
    return nil
end;
GetBoothClaimCooldownLeft = function()
    local G = math.max(type(j.booth_claim_cooldown_until) == "number" and j.booth_claim_cooldown_until or 0, type(j.booth_reclaim_cooldown_until) == "number" and j.booth_reclaim_cooldown_until or 0) - os.clock()
    if G <= 0 then
        return 0
    end
    return math.floor(G)
end;
SetBoothClaimCooldown = function(G)
    local V = tonumber(G) or 15
    j.booth_claim_cooldown_until = os.clock() + math.clamp(math.floor(V), 8, 60)
    return true
end;
WaitForOwnedBoothName = function(G, V)
    local y = os.clock()
    local Z = tonumber(V) or 5
    G = tostring(G or "")
    while os.clock() - y <= Z do
        if g.Booth.GetOwnedBoothName() == G then
            return true
        end
        task.wait(.15)
    end
    return false
end, WaitForNoOwnedBooth = function(G)
    local V = os.clock()
    local y = tonumber(G) or 5
    while os.clock() - V <= y do
        if g.Booth.GetOwnedBoothName() == nil then
            return true
        end
        task.wait(.15)
    end
    return false
end, RemoveCurrentBoothForReclaim = function(G)
    local V = g.Booth.GetRemoveBoothRemote()
    if not V then
        return false, "RemoveBooth missing"
    end
    G = G or g.Booth.GetOwnedBoothName()
    if not G then
        return true, "No booth owned"
    end
    g.Booth.SetStatus("\240\159\148\129 Removing current booth...")
    local y, Z = pcall(function()
        V:FireServer()
    end)
    if not y then
        return false, tostring(Z or "Remove failed")
    end
    if g.Booth.WaitForNoOwnedBooth(6) then
        return true, "Removed"
    end
    return false, "Remove not verified"
end;
EquipSelectedSkin = function()
    local G = V.ReplicatedStorage.GameEvents:FindFirstChild("TradeBoothSkinService")
    local y = G and G:FindFirstChild("Equip")
    if not y or not y:IsA("RemoteEvent") then
        return false
    end
    local Z = i.GetBoothSkinToEquip()
    if type(Z) ~= "string" or Z == "" then
        Z = "Default"
    end
    y:FireServer(Z)
    return true
end, ClaimBoothModel = function(G, V)
    if not G then
        return false, "Booth missing"
    end
    local y = g.Booth.GetClaimRemote()
    if not y then
        return false, "ClaimBooth missing"
    end
    if not g.Booth.IsBoothFree(G) then
        return false, "Booth occupied"
    end
    local Z = tonumber(V) or g.Booth.GetBoothRank(G)
    j.booth_claim_attempts += 1
    g.Booth.SetStatus("\226\154\148\239\184\143 Claiming booth #" .. tostring(Z > 0 and Z or "?"))
    g.Booth.EquipSelectedSkin()
    task.wait(.25)
    local i, c = pcall(function()
        y:FireServer(G)
    end)
    if not i then
        j.booth_claim_failed += 1
        return false, tostring(c or "Claim failed")
    end
    if g.Booth.WaitForOwnedBoothName(G.Name, 6) then
        j.booth_claim_success += 1
        g.Booth.SetStatus("\226\156\133 Booth claimed #" .. tostring(Z > 0 and Z or "?"))
        if Y.teleport_to_booth then
            task.defer(function()
                task.wait(.25)
                g.Booth.TeleportToOwnBoothUsingGame(G)
            end)
        end
        return true, "Claimed"
    end
    local J = g.Booth.GetBoothRank(g.Booth.GetBoothModelByName(g.Booth.GetOwnedBoothName()))
    j.booth_claim_failed += 1
    if J > 0 then
        return false, "Still on booth #" .. tostring(J)
    end
    return false, "Claim not verified"
end, ClaimBestMiddleBooth = function()
    if j.is_booth_claiming then
        return false, "Already claiming"
    end
    local G = g.Booth.GetBoothClaimCooldownLeft()
    if G > 0 then
        g.Booth.SetStatus("\226\143\179 Booth claim cooldown " .. a.time.FormatText(G))
        return false, "Cooldown"
    end
    j.is_booth_claiming = true
    local V, y, Z = pcall(function()
        local G, V, y = g.Booth.GetOwnedBoothModel()
        local Z = g.Booth.GetBoothRank(V)
        if G and not Y.booth_reclaim_better then
            g.Booth.SetStatus("\226\156\133 Booth claimed #" .. tostring(Z > 0 and Z or "?"))
            return true, "Already claimed"
        end
        local i = g.Booth.GetBoothReplicaData(false) or g.Booth.GetBoothReplicaData(true)
        local c = nil
        local J = 0
        for y, j in ipairs(g.Booth.GetBoothsSorted()) do
            if G and(Z > 0 and y >= Z) then
                break
            end
            if j == V then
                continue
            end
            if g.Booth.IsBoothFree(j, i) then
                c = j
                J = y
                break
            end
        end
        if not c then
            if G then
                g.Booth.SetStatus("\226\156\133 Booth claimed #" .. tostring(Z > 0 and Z or "?"))
                return true, "Already claimed"
            end
            g.Booth.SetStatus("\226\157\140 No free booth found")
            return false, "No free booth"
        end
        if G and Y.booth_reclaim_better then
            g.Booth.SetStatus("\240\159\148\129 Better booth #" ..(tostring(J) .. " found, removing current..."))
            local G, V = g.Booth.RemoveCurrentBoothForReclaim(y)
            if not G then
                j.booth_claim_failed += 1
                g.Booth.SetBoothClaimCooldown(20)
                g.Booth.SetStatus("\226\157\140 Reclaim failed: " .. tostring(V))
                return false, V
            end
            g.Booth.SetStatus("\226\143\179 Waiting before claiming booth #" .. tostring(J))
            task.wait(2)
        end
        local T, d = g.Booth.ClaimBoothModel(c, J)
        if T then
            return true, d
        end
        g.Booth.SetBoothClaimCooldown(20)
        g.Booth.SetStatus("\226\157\140 Booth #" ..(tostring(J) ..(" failed: " .. tostring(d))))
        return false, d
    end)
    j.is_booth_claiming = false
    if not V then
        j.booth_claim_failed += 1
        g.Booth.SetBoothClaimCooldown(20)
        g.Booth.SetStatus("\226\157\140 Booth claim error: " .. tostring(y or "Unknown"))
        return false, tostring(y or "Unknown")
    end
    return y, Z
end;
IsPlayerCloseToCFrame = function(G, y)
    if not G then
        return false
    end
    local Z = V.LocalPlayer.Character or V.Character
    if not Z then
        return false
    end
    local j = Z:FindFirstChild("HumanoidRootPart")
    if not j then
        return false
    end
    local i = Vector3.new(j.Position.X, 0, j.Position.Z)
    local c = Vector3.new(G.Position.X, 0, G.Position.Z)
    return((i - c)).Magnitude <=((tonumber(y) or 10))
end, GetGameBoothTeleportCFrame = function(G)
    if not G then
        return nil
    end
    local V, y = pcall(function()
        return CFrame.new(((G:GetPivot() * CFrame.new(0, 12, 5))).Position)
    end)
    return V and y or nil
end;
TeleportToOwnBoothUsingGame = function(G)
    local y = G
    if not y then
        local G, V = g.Booth.GetOwnedBoothModel()
        if G then
            y = V
        end
    end
    local Z = g.Booth.GetGameBoothTeleportCFrame(y)
    if Z and g.Booth.IsPlayerCloseToCFrame(Z, 8) then
        return false, "Already near booth"
    end
    if V.TradeBoothController and type(V.TradeBoothController.TeleportToBooth) == "function" then
        local G = pcall(function()
            V.TradeBoothController:TeleportToBooth()
        end)
        if G then
            g.Booth.SetStatus("\240\159\147\161 Teleported to booth")
            return true, "Game teleport"
        end
    end
    if y then
        g.Booth.SetStatus("\240\159\147\141 Game teleport failed, using fallback")
        return g.Booth.MoveToBoothDisplay(y), "Fallback"
    end
    return false, "No booth found"
end;
MoveToBoothDisplay = function(G)
    if not G then
        return false
    end
    local V = G:GetPivot()
    local y = tonumber(Y.teleport_distance) or 30
    local Z = 4
    local j = 0
    local i = 10
    local c = V * CFrame.Angles(math.rad(90), 0, 0)
    local J = c * CFrame.new(j, Z, y)
    if not g.Booth.IsPlayerCloseToCFrame(J, i) then
        m(J)
        g.Booth.SetStatus("\240\159\147\141 Moving near booth")
        return true
    end
    return false
end;
GetBoothStatsText = function()
    local G = {}
    local V = tostring(j.TEXT_BOOTH_SETUP or "")
    local y = tostring(j.TEXT_REJOIN or "")
    local Z = g.Booth.GetHopBlockLeft()
    if V ~= "" then
        table.insert(G, V)
    else
        table.insert(G, "\226\154\148\239\184\143 Booth ready")
    end
    if Y.joinnewserver then
        if y ~= "" then
            table.insert(G, y)
        else
            table.insert(G, "\240\159\147\161 Rejoin timer ready")
        end
        table.insert(G, "\226\143\177\239\184\143 Next rejoin: " .. a.time.FormatText(g.Booth.GetRejoinTimeLeft()))
    end
    if Z > 0 then
        table.insert(G, "\240\159\155\141\239\184\143 Shop hold: " .. a.time.FormatText(Z))
    end
    table.insert(G, string.format("\240\159\147\138 Claims %s/%s | Sales %s | Holds %s | Rejoins %s | TP %s", tostring(j.booth_claim_success or 0), tostring(j.booth_claim_attempts or 0), tostring(j.sales_made or 0), tostring(j.booth_customer_blocks or 0), tostring(j.rejoin_attempts or 0), tostring(j.rejoin_teleports or 0)))
    return table.concat(G, "\n")
end;
UpdateBoothStatusLabel = function()
    if r.lbl_booth_setup_status then
        r.lbl_booth_setup_status:SetText(g.Booth.GetBoothStatsText())
    end
end}
i.ClaimRandomBooth = function()
    return g.Booth.ClaimBestMiddleBooth()
end
i.ClaimABooth = function()
    i.ClaimRandomBooth()
end
g.TradeSign = { SetTradeSignStatus = function(G)
    j.TEXT_TRADE_SIGN = tostring(G or "")
end, GetTradeSignDelay = function()
    local G = tonumber(Y.trade_sign_use_every_secs) or 8
    if G < 3 then
        G = 3
    end
    if G > 60 then
        G = 60
    end
    Y.trade_sign_use_every_secs = G
    return G
end;
EquipTradeSignTool = function()
    local G = J.GetToolByName("Trade Sign")
    if not G then
        j.trade_sign_missing =((j.trade_sign_missing or 0)) + 1
        g.TradeSign.SetTradeSignStatus("\240\159\170\167 Trade Sign not found")
        return false
    end
    if G.Parent ~=((V.LocalPlayer.Character or V.Character)) then
        if not D(G) then
            g.TradeSign.SetTradeSignStatus("\226\157\140 Could not equip Trade Sign")
            return false
        end
    end
    j.trade_sign_used =((j.trade_sign_used or 0)) + 1
    g.TradeSign.SetTradeSignStatus("\240\159\142\159\239\184\143 Trade Sign equipped")
    return true
end, RunTradeSignSystem = function()
    if not Y.trade_sign_enabled then
        return false
    end
    local G = os.clock()
    if G <((j.trade_sign_next_use or 0)) then
        return false
    end
    j.trade_sign_next_use = G + g.TradeSign.GetTradeSignDelay()
    return g.TradeSign.EquipTradeSignTool()
end;
GetTradeSignStatsText = function()
    local G = tostring(j.TEXT_TRADE_SIGN or "")
    local V = math.max(0, math.floor(((j.trade_sign_next_use or 0)) - os.clock()))
    if G == "" then
        G = "\240\159\170\167 Trade Sign ready"
    end
    return string.format("%s | Used %s | Missing %s | Next %ss", G, tostring(j.trade_sign_used or 0), tostring(j.trade_sign_missing or 0), tostring(V))
end}
if not _G.exo_trade_sign_system then
    _G.exo_trade_sign_system = true
    task.spawn(function()
        while _G.exo_trade_sign_system do
            task.wait(1)
            pcall(function()
                if g.TradeSign then
                    g.TradeSign.RunTradeSignSystem()
                end
            end)
        end
    end)
end
J.CheckFruitHasMutations = function(G, V)
    if not G then
        return false
    end
    for V, y in pairs(V) do
        if G:GetAttribute(V) then
            return true
        end
    end
    return false
end
local function R(G)
    if not G then
        return 0
    end
    local V =(typeof(G) == "Instance") and G.Name or tostring(G)
    local y = V:match("%[([%d%.]+)kg%]")
    return tonumber(y) or 0
end
q.ListSystem = { UpdateStatusUI = function(G)
    if r.lbl_status_listing then
        r.lbl_status_listing:SetText(G)
    end
    j.TEXT_LISTING = G
end;
GetAllPetsForListing = function()
    local G = {}
    local V = g.Inventory.GetPetInventory()
    local y = Y.listing_min_level
    local Z = Y.listing_max_level
    local i = Y.listing_min_weight
    local c = Y.listing_max_weight
    local d = {}
    local u = Y.listing_petlist
    local q = Y.listing_mutations
    local E = false
    local a = Y.listing_auto_unfav
    local H = j.GetTradeLocks()
    local r, e = j.GetMyListingsPets()
    local s, N = j.GetMyListingsCount()
    if N >= 50 then
        return {}
    end
    local W = false
    local X = false
    if next(u) then
        W = true
    end
    if next(q) then
        X = true
    end
    for V, j in pairs(V) do
        if r[V] then
            continue
        end
        if H[V] then
            continue
        end
        if E then
            break
        end
        local d = j.UUID
        local g = j.PetData
        local Y = j.PetType
        if W then
            if not u[Y] then
                continue
            end
        end
        local e = g.IsFavorite
        if not a then
            if e then
                continue
            end
        end
        local s = g.Name
        local N = g.Level
        local h = g.BaseWeight
        local l = g.MutationType or ""
        local B = T.AllMutationListEnum[l]
        if X then
            if B then
                if not q[B] then
                    continue
                end
            else
                continue
            end
        end
        local L = K(h, 1)
        if N < y or N > Z then
            continue
        end
        if L < i or L > c then
            continue
        end
        local m = J.GetPetUsingUUID(V)
        if m then
            local y = { pet_uuid = V;
            pet_tool = m}
            table.insert(G, y)
        end
    end
    return G
end, GetAllFruitsForListing = function()
    local G = {}
    local V = J.GetAllFruitsInBackpack()
    local y = g.Inventory.GetInventory()
    local Z = Y.sellfruit.fruit_min_weight
    local c = Y.sellfruit.fruit_max_weight
    local T = Y.sellfruit.fruit_list_allow
    local d = Y.sellfruit.fruit_mutations
    local u = Y.sellfruit.fruit_auto_fav
    local q = j.GetTradeLocks()
    local E, a = j.GetMyListingsCount()
    if a >= 50 then
        return {}
    end
    local H = false
    local r = false
    if next(T) then
        H = true
    end
    if next(d) then
        r = true
    end
    for V, j in ipairs(V) do
        local g = j:GetAttribute("f")
        local a = j:GetAttribute("c")
        local Y = j:GetAttribute("d")
        if E[a] then
            continue
        end
        if q[a] then
            continue
        end
        if H then
            if not T[g] then
                continue
            end
        end
        if not u then
            if Y then
                continue
            end
        end
        if r then
            if not J.CheckFruitHasMutations(j, d) then
                continue
            end
        end
        local e = y[a]
        local s = 0
        if e then
            local G = e.ItemData
            local V = G.Seed
            local y = G.WeightMultiplier
            s = i.fruitCalculateWeight(V, g)
            if s > 0 then
                s = s * y
            end
        end
        local N = R(j)
        if N == 0 then
            N = s
        end
        local W = string.format("%s - %s KG", g, N)
        if N < Z or N > c then
            continue
        end
        if j then
            local V = { fruit_uuid = a;
            fruit_tool = j}
            table.insert(G, V)
        end
    end
    return G
end, CreateListingPet = function(G, y)
    V.GameEvents.TradeEvents.Booths.CreateListing:InvokeServer("Pet", y, G)
end, CreateListingHoldable = function(G, y)
    V.GameEvents.TradeEvents.Booths.CreateListing:InvokeServer("Holdable", y, G)
end, DeleteListingPet = function(G)
    local y = G:gsub("[{}]", "")
    local Z = V.ReplicatedStorage.GameEvents.TradeEvents.Booths.RemoveListing
    Z:InvokeServer(y)
end}
local function n()
    local G = 68
    for y, Z in ipairs(j.pet_select_for_list) do
        V.GameEvents.TradeEvents.Booths.CreateListing:InvokeServer("Pet", Z, G)
        print("listed ", Z)
        task.wait(3)
    end
end
j.can_teleport_usingbuttons = false
if not V.DataService then
    i.ShowFailNotification("\226\154\160\239\184\143 DataService failed to load. Script Loading Failed!. Please try again.", 100)
    return
end
q.is_running_remove_list = false
q.TaskRemoveListing = function()
    task.spawn(function()
        q.is_running_remove_list = true
        while q.is_running_remove_list do
            task.wait(.5)
            if not j.GetCheckIfPro() then
                break
            end
            local G, V, y, Z = j.GetMyListingsPets()
            local i = {}
            local c = next(Y.removelistingpetsfilter) ~= nil
            for G, V in ipairs(Z) do
                if not c or Y.removelistingpetsfilter[V.petname] then
                    table.insert(i, V)
                end
            end
            local J = # i
            if J <= 0 then
                j.TEXT_LISTING_REMOVE = "\226\157\140 No pets to remove from listing."
                task.wait(3)
                q.is_running_remove_list = false
                break
            end
            local T = table.remove(i, 1)
            local d = T.uuid
            j.TEXT_LISTING_REMOVE = "\240\159\146\165 Remove: " ..(d ..(" Left: " .. J))
            q.ListSystem.DeleteListingPet(d)
            j.TEXT_LISTING_REMOVE = "\226\156\133 Removed listing: Moving to next. "
            task.wait(.1)
        end
    end)
end
q.is_running_remove_list_fruit = false
q.RemoveFruitsTask = function()
    if q.is_running_remove_list_fruit then
        return
    end
    if not j.GetCheckIfPro() then
        return
    end
    task.spawn(function()
        q.is_running_remove_list_fruit = true
        while q.is_running_remove_list_fruit do
            task.wait(.5)
            if not j.GetCheckIfPro() then
                break
            end
            local G = j.GetMyListingsFruitsIDs()
            local V = # G
            if V <= 0 then
                j.TEXT_LISTING_REMOVE = "\226\157\140 No fruits to remove from listing."
                task.wait(3)
                q.is_running_remove_list_fruit = false
                break
            end
            local y = table.remove(G, 1)
            j.TEXT_LISTING_REMOVE = "\240\159\146\165 Remove: " ..(y ..(" Left: " .. V))
            q.ListSystem.DeleteListingPet(y)
            j.TEXT_LISTING_REMOVE = "\226\156\133 Removed listing: Moving to next. "
            task.wait(.1)
        end
        q.is_running_remove_list_fruit = false
    end)
end
q.StartRemoveListing = function()
    if q.is_running_remove_list_fruit then
        j.Notify("Fruit list remover is running, try later.", 3)
        return
    end
    if q.is_running_remove_list then
        j.Notify("Already running", 3)
        return
    end
    j.Notify("Started list remove.", 3)
    q.TaskRemoveListing()
end
q.StopRemoveListing = function()
    if not q.is_running_remove_list then
        j.Notify("Not running", 3)
        return
    end
    j.Notify("Stopped", 3)
    q.is_running_remove_list = false
end
q.StartRemoveListingFrutis = function()
    if q.is_running_remove_list then
        j.Notify("Pet list remover is running. try later", 3)
        return
    end
    if q.is_running_remove_list_fruit then
        j.Notify("Already running", 3)
        return
    end
    j.Notify("Started fruit list remove.", 3)
    q.RemoveFruitsTask()
end
q.StopRemoveListingFruits = function()
    if not q.is_running_remove_list_fruit then
        j.Notify("Not running", 3)
        return
    end
    j.Notify("Stopped", 3)
    q.is_running_remove_list_fruit = false
end
j.GetTextUserHubPower = function()
    local G = V.AppName
    local y = j.is_pro
    if y then
        return string.format("<font color=\'#FFE075\'>%s</font> <font color=\'#FF00C8\'>PRO</font>", G)
    else
        return string.format("%s", G)
    end
end
local w = " <font color=\'#FF0000\'>PRO</font>"
if j.GetCheckIfPro() then
    w = ""
end
local function GJ()
    local G = k()
    local V = j.user_country
    local y = Z:AddTab({ Name = "Home";
    Description = "Game Version: " ..(G ..(" [<b><font color=\'#FFFFFF\'>" ..(V .. "</font></b>]"))), Icon = "house"})
    local i = y:AddLeftGroupbox("Options", "align-vertical-distribute-center", false)
    local c = y:AddRightGroupbox("Details", "align-vertical-distribute-center", false)
    if c then
        r.lbl_finder_pet_details = c:AddLabel({ Text = "-";
        DoesWrap = true})
    end
    local J = i:AddButton({ Text = "\240\159\154\168 Rejoin Server", Func = function()
        if j.can_teleport_usingbuttons == false then
            return
        end
        I()
    end})
    i:AddDivider()
    i:AddLabel({ Text = "Hop to new server: Only works if you have Anti Spam disabled in delta. You must not be running and scripts to disable it in delta settings.";
    DoesWrap = true})
    local T = i:AddButton({ Text = "Hop Server", Func = function()
        if j.can_teleport_usingbuttons == false then
            return
        end
        g.Hop.HopToNewServer()
    end})
    task.spawn(function()
        while true do
            task.wait(10)
            j.can_teleport_usingbuttons = true
            break
        end
    end)
end
j.TeleportUi = function()
    local G = k()
    local V = Z:AddTab({ Name = "<font color=\'#FFAA00\'>Teleport</font>";
    Description = "Game Server Version: " .. G;
    Icon = "helicopter"})
    local y = V:AddLeftGroupbox("Teleport Job Id", "helicopter", false)
    if y then
        y:AddLabel({ Text = "<b><font color=\'#7CFF8A\'>\240\159\148\151 Job ID Teleport</font></b>\n<font color=\'#D7E1FF\'>Paste the Job ID, then click teleport.</font>\n<font color=\'#FFB86B\'>\226\154\160\239\184\143 Anti Spam must be disabled in Delta settings for this to work.</font>";
        DoesWrap = true})
        local G
        local V = ""
        local function Z()
            local G = tostring(V or "")
            if G == "" then
                G = "empty"
            end
            return string.format("<b><font color=\'#B084FF\'>\240\159\167\169 Job ID </font></b><font color=\'#00FFFF\'>%s</font>", G)
        end
        G = y:AddInput("input_server_code", { Text = Z(), Default = "";
        Numeric = false;
        AllowEmpty = true;
        Finished = false, ClearTextOnFocus = true, Placeholder = "JobId";
        Tooltip = "Paste Job ID here", Callback = function(y)
            V = tostring(y or "")
            G:SetText(Z())
        end})
        y:AddButton({ Text = "\240\159\154\128 <font color=\'#7CFF8A\'><b>Teleport</b></font>";
        Func = function()
            if V == "" then
                j.Notify("\226\157\140 Enter Job ID first", 3)
                return
            end
            g.Hop.HopToNewServerUsingJobid(V)
            j.Notify("\240\159\148\151 Teleport requested", 3)
        end})
        y:AddDivider()
        y:AddButton({ Text = "\240\159\147\140 Copy Current Job ID";
        Func = function()
            local G = tostring(game.JobId or "")
            if G == "" then
                j.Notify("\226\157\140 Current Job ID not found", 3)
                return
            end
            i.CopyToClipBoard(G)
        end})
    end
end
q.ManualBuySystem = q.ManualBuySystem or {}
q.ManualBuySystem.SetStatusText = function(G)
    j.TEXT_MANUAL_BUY = tostring(G or "")
    if r.lbl_manual_buy_status then
        r.lbl_manual_buy_status:SetText(j.TEXT_MANUAL_BUY)
    end
end
q.ManualBuySystem.HasSelection = function(G)
    return type(G) == "table" and next(G) ~= nil
end
q.ManualBuySystem.ListingPassesManualFilters = function(G)
    if type(G) ~= "table" then
        return false
    end
    local V = Y.scantargetpets or {}
    if q.ManualBuySystem.HasSelection(V) and not V[G.petname] then
        return false
    end
    if G.fav == true then
        return false
    end
    local y = tonumber(G.weight) or 0
    local Z = tonumber(G.visualweight) or 0
    local j = tonumber(Y.manual_min_weight) or 0
    local i = tonumber(Y.manual_max_base_weight) or 0
    local c = tonumber(Y.manual_min_visual_weight) or 0
    local J = tonumber(Y.manual_max_visual_weight) or 0
    if y < j then
        return false
    end
    if i > 0 and y > i then
        return false
    end
    if c > 0 and Z < c then
        return false
    end
    if J > 0 and Z > J then
        return false
    end
    local T = Y.manual_mutations or {}
    if q.ManualBuySystem.HasSelection(T) then
        local V = tostring(G.mut or "")
        if V == "" or not T[V] then
            return false
        end
    end
    return true
end
q.ManualBuySystem.BuildManualPetData = function(G, V)
    return { id = tostring(G or V.list_id or "");
    owner = V.owner, pet = V.petname;
    price = tonumber(V.price) or 0, weight = tonumber(V.weight) or 0;
    visualweight = tonumber(V.visualweight) or 0, level = tonumber(V.level) or 1;
    fav = V.fav == true;
    mut = tostring(V.mut or "")}
end
q.ManualBuySystem.ScanBoothsForManualBuy = function()
    local G = {}
    local V = g.finder.GetBoothListings()
    for V, y in pairs(V) do
        if q.ManualBuySystem.ListingPassesManualFilters(y) then
            table.insert(G, q.ManualBuySystem.BuildManualPetData(V, y))
        end
    end
    table.sort(G, function(G, V)
        local y = tonumber(G.price) or 0
        local Z = tonumber(V.price) or 0
        if y ~= Z then
            return y < Z
        end
        return((tonumber(G.visualweight) or 0)) >((tonumber(V.visualweight) or 0))
    end)
    return G
end
q.ScanForSpecificPet = function()
    return q.ManualBuySystem.ScanBoothsForManualBuy()
end
q.ManualBuySystem.BuildManualFindPetList = function()
    local G = Y.scantargetpets or {}
    local V = q.ManualBuySystem.HasSelection(G) and G or j.all_pets_names_list_keyval
    local y = {}
    for G, V in pairs(V or {}) do
        local Z = type(G) == "number" and V or G
        if type(Z) == "string" and Z ~= "" then
            table.insert(y, Z)
        end
    end
    for G = # y, 2, - 1 do
        local V = math.random(G)
        y[G], y[V] = y[V], y[G]
    end
    return y
end
q.ManualBuySystem.BuildManualMutationFindList = function()
    local G = Y.manual_mutations or {}
    local V = {}
    if q.ManualBuySystem.HasSelection(G) then
        for G, y in pairs(G) do
            if type(G) == "string" and G ~= "" then
                table.insert(V, G)
            end
        end
    end
    if # V == 0 then
        table.insert(V, "")
    end
    return V
end
q.ManualBuySystem.WaitForManualTeleportResult = function(G)
    G = tonumber(G) or 9
    local V = os.clock()
    while os.clock() - V < G do
        if j.failed_tp then
            local G = j.last_tp_fail_reason ~= "" and j.last_tp_fail_reason or "Teleport failed"
            j.failed_tp = false
            j.last_tp_fail_reason = ""
            return false, G
        end
        task.wait(.25)
    end
    return false, "Teleport did not start"
end
q.ManualBuySystem.WaitForSellerSearchCooldown = function()
    local G = os.clock()
    if G >= q.global_pet_search_cd then
        return
    end
    local V = q.global_pet_search_cd - G
    while V > 0 do
        q.ManualBuySystem.SetStatusText(string.format("\226\143\179 Search cooldown %.1fs", V))
        task.wait(math.min(.5, V))
        V = q.global_pet_search_cd - os.clock()
    end
end
q.ManualBuySystem.FindServerForManualBuy = function()
    if j.is_manual_buying then
        q.ManualBuySystem.SetStatusText("\226\143\179 Purchase already running.")
        return false
    end
    if j.is_manual_server_searching then
        q.ManualBuySystem.SetStatusText("\226\143\179 Server search already running.")
        return false
    end
    local G = q.ManualBuySystem.BuildManualFindPetList()
    if # G == 0 then
        q.ManualBuySystem.SetStatusText("\226\157\140 Select a pet first.")
        return false
    end
    j.is_manual_server_searching = true
    local V, y = pcall(function()
        local V = q.ManualBuySystem.BuildManualMutationFindList()
        local y = 7
        local Z = 0
        for G, j in ipairs(G) do
            for G, V in ipairs(V) do
                if Z >= y then
                    q.ManualBuySystem.SetStatusText("\226\157\140 Search limit reached.")
                    return false
                end
                q.ManualBuySystem.WaitForSellerSearchCooldown()
                Z = Z + 1
                q.global_pet_search_cd = os.clock() + 10.7
                local i = V ~= "" and(" [" ..(V .. "]")) or ""
                q.ManualBuySystem.SetStatusText(string.format("\240\159\148\142 Searching %s%s (%d/%d)", j, i, Z, y))
                local c, J, T, d = g.finder.FindSellerUsingPetNameTimed(j, V, 11.5)
                if not c or not J then
                    q.ManualBuySystem.SetStatusText("\226\157\140 No server: " ..(j ..(i ..(" - " .. tostring(d or T or "Not found")))))
                    continue
                end
                local u = g.finder.NormalizeSellerSearchResult(J, T)
                local E = u.listingId ~= "" and u.listingId or u.jobId
                if E == "" then
                    q.ManualBuySystem.SetStatusText("\226\157\140 Seller found but listing missing.")
                    continue
                end
                if u.jobId ~= "" and u.jobId == game.JobId then
                    q.ManualBuySystem.SetStatusText("\226\154\160\239\184\143 Seller is in current server.")
                    continue
                end
                if q.already_tried_jobs[E] or(u.jobId ~= "" and q.already_tried_jobs[u.jobId]) then
                    q.ManualBuySystem.SetStatusText("\226\154\160\239\184\143 Server already tried.")
                    continue
                end
                q.ManualBuySystem.SetStatusText("\240\159\154\128 Teleporting to " ..(j ..(i .. "...")))
                local a, H = g.finder.TeleportToSellerManual(E)
                if not a and(u.jobId ~= "" and u.jobId ~= E) then
                    a, H = g.finder.TeleportToSellerManual(u.jobId)
                end
                if not a then
                    q.already_tried_jobs[E] = true
                    if u.jobId ~= "" then
                        q.already_tried_jobs[u.jobId] = true
                    end
                    q.ManualBuySystem.SetStatusText("\226\157\140 Teleport failed: " .. tostring(H or "Rejected"))
                    continue
                end
                local r, Y = q.ManualBuySystem.WaitForManualTeleportResult(9)
                if not r then
                    q.already_tried_jobs[E] = true
                    if u.jobId ~= "" then
                        q.already_tried_jobs[u.jobId] = true
                    end
                    q.ManualBuySystem.SetStatusText("\226\157\140 " .. tostring(Y or "Teleport failed"))
                    continue
                end
                return true
            end
        end
        q.ManualBuySystem.SetStatusText("\226\157\140 No open server found.")
        return false
    end)
    j.is_manual_server_searching = false
    if not V then
        q.ManualBuySystem.SetStatusText("\226\157\140 Search error: " .. tostring(y))
        return false
    end
    return y == true
end
j.DynamicScanButtons = j.DynamicScanButtons or {}
j.BuyListUi = function()
    local G = Z:AddTab({ Name = "Manual Buy";
    Description = "Buy listings manually", Icon = "sparkles"})
    local V = G:AddLeftGroupbox("Target Pets", "house", false)
    local y = G:AddRightGroupbox("\240\159\155\146 Scan Results", "list", false)
    if y then
        r.lbl_manual_buy_status = y:AddLabel({ Text = j.TEXT_MANUAL_BUY ~= "" and j.TEXT_MANUAL_BUY or "Ready.";
        DoesWrap = true})
    end
    if V then
        V:AddLabel({ Text = "\226\154\160\239\184\143 Select pets to scan for. Empty target list scans all pets.", DoesWrap = true})
        local G
        G = V:AddValueDropdown("buypettslistx", { Values = {};
        Default = {}, Multi = true;
        Text = "\240\159\166\150 Targets";
        Searchable = true;
        MaxVisibleDropdownItems = 10;
        Changed = function(G)
            if not G then
                return
            end
            Y.scantargetpets = G
            W()
        end})
        local Z = table.clone(j.all_pets_names_list or {})
        table.sort(Z, function(G, V)
            local y = i.GetPetDetails(G)
            local Z = i.GetPetDetails(V)
            local j = y and i.RarityLayoutMap[tostring(y.rarity or "")] or 0
            local c = Z and i.RarityLayoutMap[tostring(Z.rarity or "")] or 0
            if j ~= c then
                return j > c
            end
            return tostring(G) < tostring(V)
        end)
        local c = {}
        for G, V in ipairs(Z) do
            local y = i.GetPetDetails(V)
            local Z = string.format("%s", V)
            if y then
                local G, j = i.RarityToColor(y.rarity or "")
                local c, J = i.EggToColor(y.eggname or "")
                Z = string.format("<stroke color=\'#000000\' sizing=\'fixed\' thickness=\'1\' transparency=\'0.45\' joins=\'round\'><b><font color=\'#FFFFFF\'>%s</font></b> <font color=\'#AAB4C2\'>[</font></stroke><stroke color=\'%s\' sizing=\'fixed\' thickness=\'1\' transparency=\'0.35\' joins=\'round\'><font color=\'%s\'>%s</font></stroke><stroke color=\'#000000\' sizing=\'fixed\' thickness=\'1\' transparency=\'0.45\' joins=\'round\'><font color=\'#AAB4C2\'>]</font> </stroke><stroke color=\'%s\' sizing=\'fixed\' thickness=\'1\' transparency=\'0.50\' joins=\'round\'><b><font color=\'%s\'>%s</font></b></stroke>", tostring(V), J, c, tostring(y.eggname or "Unknown Egg"), j, G, tostring(y.rarity or "Unknown"))
            end
            table.insert(c, { Text = Z, Value = V})
        end
        G:SetValues(c)
        G:SetValue(Y.scantargetpets)
        local J = V:AddButton({ Text = "Select All";
        Func = function()
            Y.scantargetpets = {}
            for G, V in ipairs(j.all_pets_names_list) do
                Y.scantargetpets[V] = true
            end
            G:SetValue(Y.scantargetpets, true)
            W()
        end})
        J:AddButton({ Text = "<font color=\'#FF3D17\'>Remove All</font>";
        Func = function()
            Y.scantargetpets = {}
            G:SetValue(Y.scantargetpets)
            W()
        end})
        local d = {}
        for G, V in ipairs(L(T.AllMutationsList or {})) do
            table.insert(d, { Text = V, Value = V})
        end
        local u
        u = V:AddValueDropdown("manualbuymutationfilter", { Values = d;
        Default = {};
        Multi = true;
        Text = "\240\159\167\172 Mutations";
        Tooltip = "Empty means all mutations.";
        Searchable = true, MaxVisibleDropdownItems = 10;
        Changed = function(G)
            Y.manual_mutations = G or {}
            W()
        end})
        u:SetValue(Y.manual_mutations or {})
        local E = function(G, y, Z, i)
            local c
            local J = function()
                return string.format("%s <font color=\'#47FF40\'>%s</font>", Z, tostring(Y[y] or 0))
            end
            c = V:AddInput(G, { Text = J(), Default = Y[y] or 0;
            Numeric = true, AllowEmpty = true;
            Finished = true;
            ClearTextOnFocus = false, Placeholder = i and "0 = off" or "e.g 1", Tooltip = i and "Set 0 to disable this filter." or "Minimum base weight.";
            Callback = function(G)
                local V = f(G)
                if not V or V < 0 or(not i and V <= 0) then
                    j.Notify("Invalid: " .. tostring(G), 3)
                    c:SetValue(tostring(Y[y] or 0))
                    return
                end
                Y[y] = V
                W()
                c:SetText(J())
            end})
        end
        E("input_manual_min_base_weight", "manual_min_weight", "\226\156\168 Min BaseWeight", false)
        E("input_manual_max_base_weight", "manual_max_base_weight", "\226\156\168 Max BaseWeight", true)
        E("input_manual_min_visual_weight", "manual_min_visual_weight", "\240\159\145\129\239\184\143 Min VisualWeight", true)
        E("input_manual_max_visual_weight", "manual_max_visual_weight", "\240\159\145\129\239\184\143 Max VisualWeight", true)
        local function a()
            for G, V in ipairs(j.DynamicScanButtons) do
                if V.Holder and typeof(V.Holder) == "Instance" then
                    V.Holder:Destroy()
                end
            end
            j.DynamicScanButtons = {}
            if y and y.Resize then
                y:Resize()
            end
        end
        local H = 67
        local r = function()
            a()
            if not y then
                q.ManualBuySystem.SetStatusText("\226\157\140 Results UI missing.")
                return
            end
            q.ManualBuySystem.SetStatusText("\240\159\148\142 Scanning booths...")
            local G = Y.manual_showbaseweight
            local V = q.ScanForSpecificPet()
            if # V > 0 then
                q.ManualBuySystem.SetStatusText("\226\156\133 Found " ..(tostring(# V) .. " matching listings."))
                for V, Z in ipairs(V) do
                    local c = tostring(Z.pet or "Unknown")
                    if string.len(c) > H then
                        c = string.sub(c, 1, H) .. "."
                    end
                    local J = G and Z.weight or Z.visualweight
                    local T = G and Z.visualweight or Z.weight
                    local d = G and "B" or "V"
                    local u = G and "V" or "B"
                    local E = Z.fav and "\226\157\164\239\184\143" or ""
                    local a = Z.mut ~= "" and(" <font color=\'#FF7CE5\'>[" ..(Z.mut .. "]</font>")) or ""
                    local r = string.format("%s <font color=\'#9B6DFF\'>Lv.%s</font> <font color=\'#4DA6C8\'>%s%.2fKG</font> <font color=\'#68D391\'>%s%.2fKG</font>%s <font color=\'#CFCFCF\'>%s</font> <font color=\'#6FAF5F\'>\240\159\159\162%s</font>", E, tostring(Z.level or 0), d, tonumber(J) or 0, u, tonumber(T) or 0, a, c, tostring(i.FormatHugeNumbers(Z.price, 2)))
                    local Y
                    Y = y:AddButton({ Text = r;
                    Func = function()
                        if j.is_manual_buying then
                            q.ManualBuySystem.SetStatusText("\226\143\179 Purchase already running.")
                            return
                        end
                        j.is_manual_buying = true
                        q.ManualBuySystem.SetStatusText("\240\159\155\146 Buying " ..(tostring(Z.pet) .. "..."))
                        local G, V, y = pcall(function()
                            return g.finder.BuyListing(Z.owner, Z.id, Z.price)
                        end)
                        j.is_manual_buying = false
                        if not G then
                            q.ManualBuySystem.SetStatusText("\226\157\140 Buy error: " .. tostring(V))
                            j.Notify("\226\157\140 Buy error", 4)
                            return
                        end
                        if V then
                            q.ManualBuySystem.SetStatusText("\226\156\133 Bought " ..(tostring(Z.pet) ..(" for " .. i.FormatHugeNumbers(Z.price, 2))))
                            j.Notify("\226\156\133 Bought " .. tostring(Z.pet), 3)
                            if Y then
                                Y:SetVisible(false)
                            end
                            return
                        end
                        q.ManualBuySystem.SetStatusText("\226\157\140 Buy failed: " .. tostring(y or "Unknown"))
                        j.Notify("\226\157\140 Buy failed: " .. tostring(y or "Unknown"), 4)
                    end})
                    table.insert(j.DynamicScanButtons, Y)
                end
                if y.Resize then
                    y:Resize()
                end
            else
                q.ManualBuySystem.SetStatusText("\226\157\140 No matching pets found.")
                local G = y:AddButton({ Text = "\226\157\140 No matching pets found", Func = function()
                end})
                table.insert(j.DynamicScanButtons, G)
            end
        end
        V:AddToggle("manualscanshowbaseweight", { Text = "\240\159\143\139\239\184\143 Show BaseWeight First";
        Default = Y.manual_showbaseweight, Tooltip = "Shows base weight before visual weight.";
        Callback = function(G)
            Y.manual_showbaseweight = G
            r()
            W()
        end})
        V:AddButton({ Text = "\240\159\148\141 Scan Booths";
        Func = function()
            r()
        end})
        V:AddButton({ Text = "\240\159\154\128 Find Server";
        Func = function()
            task.spawn(function()
                q.ManualBuySystem.FindServerForManualBuy()
            end)
        end})
        V:AddSpacer(10)
    end
end
j.BoothListUi = function()
    local G = Z:AddTab({ Name = "Booth Setup";
    Description = "Booth Settings", Icon = "sparkles"})
    local V = G:AddLeftGroupbox("Booth", "house", false)
    local y = G:AddLeftGroupbox("Trade Sign", "signpost", false)
    local c = G:AddRightGroupbox("Display Pet", "cat")
    local J = G:AddRightGroupbox("Display Fruit", "apple")
    if J then
        local G
        G = J:AddDropdown("dd_fruitlistxshowcase", { Values = {}, Default = {}, Multi = true, Text = "\240\159\141\137 Showcase Fruit";
        Searchable = true, MaxVisibleDropdownItems = 10, Changed = function(G)
            if G == nil then
                return
            end
            Y.showcase.fruit_list = G
            W()
        end})
        G:SetValues(L(l))
        G:SetValue(Y.showcase.fruit_list)
    end
    if c then
        c:AddLabel({ Text = "\226\154\160\239\184\143 Will show highest KG pet of this type selected here.";
        DoesWrap = true})
        local G
        G = c:AddDropdown("dd_displaypets", { Values = {}, Default = {}, Multi = true;
        Text = "\240\159\166\150 ShowCase Pets", Searchable = true, MaxVisibleDropdownItems = 10, Changed = function(G)
            if not G then
                return
            end
            Y.showcase.pet_list = G
            W()
        end})
        G:SetValues(j.all_pets_names_list)
        G:SetValue(Y.showcase.pet_list)
    end
    if y then
        y:AddToggle("toggleTradeSignAuto", { Text = "\240\159\170\167 Auto Trade Sign";
        Default = Y.trade_sign_enabled, Tooltip = "Uses Trade Sign automatically when available.";
        Callback = function(G)
            Y.trade_sign_enabled = G
            W()
        end})
        local G = function()
            return string.format("\226\143\179 Use Every <font color=\'#FFB833\'>%ss</font>", g.TradeSign.GetTradeSignDelay())
        end
        local V
        V = y:AddInput("input_trade_sign_delay", { Text = G();
        Default = Y.trade_sign_use_every_secs, Numeric = true, AllowEmpty = true;
        Finished = true, ClearTextOnFocus = false, Placeholder = "3-60";
        Tooltip = "How often to use Trade Sign.";
        Callback = function(y)
            local Z = z(y)
            if not Z or Z < 3 or Z > 60 then
                j.Notify("Use 3 to 60 seconds.", 3)
                V:SetValue(tostring(g.TradeSign.GetTradeSignDelay()))
                return
            end
            Y.trade_sign_use_every_secs = Z
            W()
            V:SetText(G())
        end})
    end
    if V then
        local G = V:AddValueDropdown("dd_skin_list", { Values = {};
        Default = {}, Multi = true, Text = "Booth Skins";
        Searchable = true;
        MaxVisibleDropdownItems = 10;
        Changed = function(G)
            if not G then
                return
            end
            Y.skin_booth_list = G
            W()
        end})
        G:SetValues(i.GetAllUnlockedBooths())
        G:SetValue(Y.skin_booth_list)
        V:AddDivider()
        V:AddToggle("toggleAutoClaimEquip", { Text = "\226\154\148\239\184\143Claim Booth", Default = Y.auto_claim_booth;
        Tooltip = "Auto claim the best booth near the middle.";
        Callback = function(G)
            Y.auto_claim_booth = G
            W()
        end})
        V:AddToggle("toggleBoothReclaimBetter", { Text = "\240\159\148\129 Reclaim Better Booth", Default = Y.booth_reclaim_better;
        Tooltip = "Switch to a better middle booth if one becomes free.";
        Callback = function(G)
            Y.booth_reclaim_better = G
            W()
        end})
        V:AddToggle("toggleAutoClaimEquipPet", { Text = "\240\159\166\150Equip Pet/Fruit";
        Default = Y.auto_equip_big_pet;
        Tooltip = "Equips a pet or fruit", Callback = function(G)
            Y.auto_equip_big_pet = G
            W()
        end})
        V:AddToggle("toggleAutoClaimEquipBooth", { Text = "\240\159\147\161Teleport To Booth";
        Default = Y.teleport_to_booth, Tooltip = "Teleports behind the booth", Callback = function(G)
            Y.teleport_to_booth = G
            W()
        end})
        local y = function()
            local G = string.format("\226\134\148\239\184\143 Distance <font color=\'#47FF40\'>%s</font>", Y.teleport_distance)
            return G
        end
        local Z
        Z = V:AddInput("input_distancetp", { Text = y();
        Default = Y.teleport_distance;
        Numeric = true, AllowEmpty = true, Finished = true;
        ClearTextOnFocus = false;
        Placeholder = "e.g 1";
        Tooltip = "Distance behind the booth";
        Callback = function(G)
            local V = z(G)
            if not V or V <= 0 then
                j.Notify("Invalid: " .. G, 3)
                Z:SetValue(tostring(Y.teleport_distance))
                return
            end
            Y.teleport_distance = V
            W()
            Z:SetText(y())
        end})
        V:AddToggle("togglepromotion", { Text = "\240\159\151\168\239\184\143<font color=\'#00FF9B\'>Promote Listings</font>";
        Default = Y.auto_promote_listing;
        Tooltip = "Sends promotion messages randomly.", Callback = function(G)
            Y.auto_promote_listing = G
            W()
        end})
        V:AddToggle("toglleJoinnewserver", { Text = "\240\159\147\161Join New Server";
        Default = Y.joinnewserver, Tooltip = "Joins new server every X min";
        Callback = function(G)
            Y.joinnewserver = G
            W()
        end})
        V:AddDivider()
        local c = function()
            local G = string.format("\226\143\179 Mins <font color=\'#D354FF\'>%sm</font>", Y.rejoin_mins)
            return G
        end
        local J
        J = V:AddInput("input_rejoin", { Text = c(), Default = Y.rejoin_mins, Numeric = true;
        AllowEmpty = true;
        Finished = true, ClearTextOnFocus = false;
        Placeholder = "e.g 3", Tooltip = "Rejoin mins", Callback = function(G)
            local V = z(G)
            if not V or V < 3 then
                j.Notify("Invalid mins (Minimum 3): " .. G, 3)
                J:SetValue(tostring(Y.rejoin_mins))
                return
            end
            Y.rejoin_mins = V
            g.Booth.ResetRejoinTimer()
            W()
            J:SetText(c())
        end})
        local T = function()
            return string.format("\240\159\155\141\239\184\143 Hold Server After Sale <font color=\'#FFB833\'>%ss</font>", g.Booth.ClampHopBlockSeconds())
        end
        local d
        d = V:AddInput("input_booth_hop_block_secs", { Text = T(), Default = Y.booth_hop_after_buy_secs;
        Numeric = true;
        AllowEmpty = true;
        Finished = true;
        ClearTextOnFocus = false, Placeholder = "60-180", Tooltip = "How long to stay in the server after someone buys from your booth.";
        Callback = function(G)
            local V = z(G)
            if not V or V < 60 or V > 180 then
                j.Notify("Use 60 to 180 seconds.", 3)
                d:SetValue(tostring(g.Booth.ClampHopBlockSeconds()))
                return
            end
            Y.booth_hop_after_buy_secs = V
            W()
            d:SetText(T())
        end})
    end
end
j.PetListUI = function()
    local G = Z:AddTab({ Name = "Listings" .. w;
    Description = "Create and manage listings.", Icon = "sparkles"})
    local V = G:AddLeftGroupbox("\240\159\146\176 <font color=\'#FFB833\'>Pet Listing</font> \240\159\146\176", "gift")
    local y = G:AddLeftGroupbox("\240\159\148\180 <font color=\'#FFB833\'>Remove Pet Listing</font>", "gift")
    local i = G:AddRightGroupbox("\240\159\141\137 <font color=\'#FFB833\'>Fruit Listing</font> \240\159\146\176", "grape")
    local c = G:AddRightGroupbox("\240\159\148\180 <font color=\'#FFB833\'>Remove Fruits Listings</font>", "gift")
    local J = G:AddLeftGroupbox("Options", "badge-info", false)
    if J then
        local G = nil
        J:AddLabel({ Text = "\226\154\160\239\184\143 Fixes easter bug. Equips fruits to correct the KG and unequips quickly.", DoesWrap = true})
        G = J:AddToggle("fixbugeastertoggle", { Text = "\226\154\170<font color=\'#00FF9B\'>Equip Pets Auto</font>", Default = Y.fixkgbug_easter;
        Tooltip = "Equips and unequip pets to fix easter kg bug", DisabledTooltip = "Premium Feature";
        Callback = function(G)
            Y.fixkgbug_easter = G
            W()
        end})
        if not j.GetCheckIfPro() then
            G:SetDisabled(true)
        end
    end
    if c then
        local G = nil
        c:AddLabel({ Text = "\226\154\160\239\184\143 Removes all fruit listings.";
        DoesWrap = true})
        G = c:AddButton({ Text = "\240\159\159\162 Start Removing", DisabledTooltip = "Premium Feature", Func = function()
            q.StartRemoveListingFrutis()
        end})
        c:AddButton({ Text = "\240\159\148\180 Stop Removing";
        Func = function()
            q.StartRemoveListingFrutis()
        end})
        if not j.GetCheckIfPro() then
            G:SetDisabled(true)
        end
    end
    if i then
        local G
        G = i:AddDropdown("dd_fruitlist", { Values = {};
        Default = {}, Multi = true, Text = "\240\159\141\137 Fruit Types";
        Searchable = true;
        MaxVisibleDropdownItems = 10, Changed = function(G)
            if G == nil then
                return
            end
            Y.sellfruit.fruit_list_allow = G
            W()
        end})
        G:SetValues(L(l))
        G:SetValue(Y.sellfruit.fruit_list_allow)
        local V = i:AddButton({ Text = "Select All", Tooltip = "Selects all plants on the list.";
        Func = function()
            local V = S(l)
            if # V > 0 then
                Y.sellfruit.fruit_list_allow = {}
            end
            for G, V in ipairs(V) do
                Y.sellfruit.fruit_list_allow[V] = true
            end
            G:SetValue(Y.sellfruit.fruit_list_allow, true)
            W()
        end})
        V:AddButton({ Text = "<font color=\'#ED2A00\'>DeSelect All</font>";
        Tooltip = "Deselects all the plants on the list", Func = function()
            Y.sellfruit.fruit_list_allow = {}
            G:SetValue(Y.sellfruit.fruit_list_allow, true)
            W()
        end})
        i:AddDivider()
        local y = i:AddDropdown("_shovelwhitelistfruits", { Values = {};
        Default = {};
        Multi = true, Text = "\240\159\140\136 Mutations", Tooltip = "Fruits matching will be listed.", Searchable = true;
        MaxVisibleDropdownItems = 10, Changed = function(G)
            if G == nil then
                return
            end
            Y.sellfruit.fruit_mutations = G
            W()
        end})
        y:SetValues(L(b))
        y:SetValue(Y.sellfruit.fruit_mutations)
        local Z = function()
            local G = string.format("Min Weight <font color=\'#47FF40\'>%s KG</font>", Y.sellfruit.fruit_min_weight)
            return G
        end
        local c = function()
            local G = string.format("Max Weight <font color=\'#FF4065\'>%s KG</font>", Y.sellfruit.fruit_max_weight)
            return G
        end
        local J
        J = i:AddInput("input_min_weightfruitx", { Text = Z();
        Default = Y.sellfruit.fruit_min_weight, Numeric = true, AllowEmpty = true, Finished = true;
        ClearTextOnFocus = false;
        Placeholder = "e.g 1", Tooltip = "Specify minimum Weight", Callback = function(G)
            local V = f(G)
            if not V or V <= 0 then
                j.Notify("Invalid: " .. G, 3)
                J:SetValue(tostring(Y.sellfruit.fruit_min_weight))
                return
            end
            if V > Y.sellfruit.fruit_max_weight then
                j.Notify("Can\'t be more than max weight", 3)
                J:SetValue(tostring(Y.sellfruit.fruit_min_weight))
                return
            end
            Y.sellfruit.fruit_min_weight = V
            W()
            J:SetText(Z())
        end})
        local T
        T = i:AddInput("input_max_weightfruit", { Text = c();
        Default = Y.sellfruit.fruit_max_weight, Numeric = true;
        AllowEmpty = true, Finished = true, ClearTextOnFocus = false;
        Placeholder = "e.g 1";
        Tooltip = "Specify maximum Weight", Callback = function(G)
            local V = f(G)
            if not V or V <= 0 then
                j.Notify("Invalid: " .. G, 3)
                T:SetValue(tostring(Y.sellfruit.fruit_max_weight))
                return
            end
            if V < Y.sellfruit.fruit_min_weight then
                j.Notify("Can\'t be lower than min weight ", 3)
                T:SetValue(tostring(Y.sellfruit.fruit_max_weight))
                return
            end
            Y.sellfruit.fruit_max_weight = V
            W()
            T:SetText(c())
        end})
        local d = function()
            local G = string.format("\240\159\159\162 Tokens <font color=\'#FF4065\'>%s</font>", Y.sellfruit.fruit_price)
            return G
        end
        local u
        u = i:AddInput("input_tokenpricefruit", { Text = d();
        Default = Y.sellfruit.fruit_price, Numeric = true;
        AllowEmpty = true;
        Finished = true;
        ClearTextOnFocus = false;
        Placeholder = "e.g 1", Tooltip = "Price for this pet";
        Callback = function(G)
            local V = z(G)
            if not V or V <= 0 then
                j.Notify("Invalid: " .. G, 3)
                u:SetValue(tostring(Y.sellfruit.fruit_price))
                return
            end
            Y.sellfruit.fruit_price = V
            W()
            u:SetText(d())
        end})
        local q = i:AddToggle("toggleAllowFavlistfruit", { Text = "\226\157\164\239\184\143 Auto Unfav";
        Default = Y.sellfruit.fruit_auto_fav;
        Tooltip = "Auto Unfav and list", Callback = function(G)
            Y.sellfruit.fruit_auto_fav = G
            W()
        end})
        i:AddDivider()
        local g = nil
        g = i:AddToggle("toggleEnableGifttingfruit", { Text = "\226\154\161Enable Fruit-List", Default = Y.sellfruit.is_fruit_enabled;
        Tooltip = "When enabled it lists items based on filters", DisabledTooltip = "Premium Feature";
        Callback = function(G)
            if Y.auto_list_enabled and G == true then
                g:SetValue(Y.sellfruit.is_fruit_enabled)
                j.Notify("\226\157\140 Pet listing is active. Turn it off to list fruits")
                return
            else
                Y.sellfruit.is_fruit_enabled = G
                W()
            end
        end})
        if not j.GetCheckIfPro() then
            g:SetDisabled(true)
        end
    end
    if y then
        y:AddLabel({ Text = "\226\154\160\239\184\143 Removes all listings.";
        DoesWrap = true})
        local G
        G = y:AddDropdown("ggpetsremovefilter", { Values = {};
        Default = {}, Multi = true;
        Text = "\240\159\166\150 Pets [Empty] = all";
        Searchable = true;
        MaxVisibleDropdownItems = 10;
        Changed = function(G)
            if not G then
                return
            end
            Y.removelistingpetsfilter = G
            W()
        end})
        G:SetValues(j.all_pets_names_list)
        G:SetValue(Y.removelistingpetsfilter)
        y:AddDivider()
        local V = nil
        V = y:AddButton({ Text = "\240\159\159\162 Start Removing", DisabledTooltip = "Premium Feature";
        Func = function()
            q.StartRemoveListing()
        end})
        y:AddButton({ Text = "\240\159\148\180 Stop Removing", Func = function()
            q.StopRemoveListing()
        end})
        if not j.GetCheckIfPro() then
            V:SetDisabled(true)
        end
    end
    if V then
        r.lbl_status_listing = V:AddLabel({ Text = "Status: Idle ", DoesWrap = true})
        local G
        G = V:AddDropdown("dd_giftpets_allowlist", { Values = {}, Default = {}, Multi = true, Text = "\240\159\166\150 Pets";
        Searchable = true;
        MaxVisibleDropdownItems = 10;
        Changed = function(G)
            if not G then
                return
            end
            Y.listing_petlist = G
            W()
        end})
        G:SetValues(j.all_pets_names_list)
        G:SetValue(Y.listing_petlist)
        local y = V:AddButton({ Text = "Select All", Func = function()
            Y.listing_petlist = {}
            for G, V in ipairs(j.all_pets_names_list) do
                Y.listing_petlist[V] = true
            end
            G:SetValue(Y.listing_petlist)
            W()
        end})
        y:AddButton({ Text = "<font color=\'#FF3D17\'>Remove All</font>";
        Func = function()
            Y.listing_petlist = {}
            G:SetValue(Y.listing_petlist)
            W()
        end})
        local Z = V:AddDropdown("dd_giftpet_mut", { Values = {};
        Default = {}, Multi = true, Searchable = true;
        MaxVisibleDropdownItems = 10;
        Text = "\240\159\167\172 Mutations";
        Callback = function(G)
            if G == nil then
                return
            end
            Y.listing_mutations = G
            W()
        end})
        Z:SetValues(S(T.AllMutationsList))
        Z:SetValue(Y.listing_mutations)
        local i = function()
            local G = string.format("Min Level <font color=\'#47FF40\'>%s</font>", Y.listing_min_level)
            return G
        end
        local c = function()
            local G = string.format("Max Level <font color=\'#FF4065\'>%s</font>", Y.listing_max_level)
            return G
        end
        local J
        J = V:AddInput("input_min_age", { Text = i(), Default = Y.listing_min_level;
        Numeric = true, AllowEmpty = true;
        Finished = true, ClearTextOnFocus = false, Placeholder = "e.g 1", Tooltip = "Specify minimum Pet Age";
        Callback = function(G)
            local V = z(G)
            if not V or V <= 0 then
                j.Notify("Invalid: " .. G, 3)
                J:SetValue(tostring(Y.listing_min_level))
                return
            end
            if V > Y.listing_max_level then
                j.Notify("Can\'t be more than max age ", 3)
                J:SetValue(tostring(Y.listing_min_level))
                return
            end
            Y.listing_min_level = V
            W()
            J:SetText(i())
        end})
        local d
        d = V:AddInput("input_max_age", { Text = c(), Default = Y.listing_max_level;
        Numeric = true;
        AllowEmpty = true;
        Finished = true, ClearTextOnFocus = false;
        Placeholder = "e.g 1", Tooltip = "Specify maximum Pet Age";
        Callback = function(G)
            local V = z(G)
            if not V or V <= 0 then
                j.Notify("Invalid: " .. G, 3)
                d:SetValue(tostring(Y.listing_max_level))
                return
            end
            if V < Y.listing_min_level then
                j.Notify("Can\'t be lower than min age ", 3)
                d:SetValue(tostring(Y.listing_max_level))
                return
            end
            Y.listing_max_level = V
            W()
            d:SetText(c())
        end})
        local u = function()
            local G = string.format("Min BaseWeight <font color=\'#47FF40\'>%s</font>", Y.listing_min_weight)
            return G
        end
        local q = function()
            local G = string.format("Max BaseWeight <font color=\'#FF4065\'>%s</font>", Y.listing_max_weight)
            return G
        end
        local g
        g = V:AddInput("input_min_weight", { Text = u();
        Default = Y.listing_min_weight;
        Numeric = true;
        AllowEmpty = true;
        Finished = true;
        ClearTextOnFocus = false, Placeholder = "e.g 1", Tooltip = "Specify minimum Pet BaseWeight";
        Callback = function(G)
            local V = f(G)
            if not V or V <= 0 then
                j.Notify("Invalid: " .. G, 3)
                g:SetValue(tostring(Y.listing_min_weight))
                return
            end
            if V > Y.listing_max_weight then
                j.Notify("Can\'t be more than max weight", 3)
                g:SetValue(tostring(Y.listing_min_weight))
                return
            end
            Y.listing_min_weight = V
            W()
            g:SetText(u())
        end})
        local E
        E = V:AddInput("input_max_weight", { Text = q(), Default = Y.listing_max_weight;
        Numeric = true;
        AllowEmpty = true;
        Finished = true;
        ClearTextOnFocus = false, Placeholder = "e.g 1", Tooltip = "Specify maximum BaseWeight", Callback = function(G)
            local V = f(G)
            if not V or V <= 0 then
                j.Notify("Invalid: " .. G, 3)
                E:SetValue(tostring(Y.listing_max_weight))
                return
            end
            if V < Y.listing_min_weight then
                j.Notify("Can\'t be lower than min weight ", 3)
                E:SetValue(tostring(Y.listing_max_weight))
                return
            end
            Y.listing_max_weight = V
            W()
            E:SetText(q())
        end})
        local a = function()
            local G = string.format("\240\159\159\162 Tokens <font color=\'#FF4065\'>%s</font>", Y.listing_token_price)
            return G
        end
        local H
        H = V:AddInput("input_tokenprice", { Text = a();
        Default = Y.listing_token_price;
        Numeric = true, AllowEmpty = true;
        Finished = true, ClearTextOnFocus = false;
        Placeholder = "e.g 1", Tooltip = "Price for this pet";
        Callback = function(G)
            local V = z(G)
            if not V or V <= 0 then
                j.Notify("Invalid: " .. G, 3)
                H:SetValue(tostring(Y.listing_token_price))
                return
            end
            Y.listing_token_price = V
            W()
            H:SetText(a())
        end})
        local e = V:AddToggle("toggleAllowFavlist", { Text = "\226\157\164\239\184\143 Auto Unfav", Default = Y.listing_auto_unfav, Tooltip = "Auto Unfav and list";
        Callback = function(G)
            Y.listing_auto_unfav = G
            W()
        end})
        V:AddDivider()
        local s = nil
        s = V:AddToggle("toggleEnableGiftting", { Text = "\226\154\161Enable AutoList";
        Default = Y.auto_list_enabled;
        Tooltip = "When enabled it lists items based on filters", DisabledTooltip = "Premium Feature";
        Callback = function(G)
            if Y.sellfruit.is_fruit_enabled and G == true then
                s:SetValue(Y.auto_list_enabled)
                j.Notify("\226\157\140 Fruit listing is active. Turn it off to list pets")
                return
            else
                Y.auto_list_enabled = G
                W()
            end
        end})
        if not j.GetCheckIfPro() then
            s:SetDisabled(true)
        end
    end
end
j.GetPetsSelectUi = function()
    if not r.lbl_pet_details then
        return
    end
    local G = ""
    local V = Y.finder.find_petlist or {}
    local y = Y.finder.find_enabled
    for Z, j in pairs(Y.find_settings) do
        if not j.enabled then
            continue
        end
        local i = j.weight_min or 0
        local c = j.weight_max or 0
        local J = j.price or 0
        local T = j.min_level or 1
        local d = j.max_level or 125
        local u = j.max_keep or 300
        local q = j.is_weightagebased
        local g = j.big_weight_max
        local E = y and V[Z] == true
        local a = E and "\240\159\148\141" or "\240\159\146\164"
        local H
        if q then
            H = string.format("%s <font color=\'#FFA500\'><b>%s</b></font> <font color=\'#FF66FF\'>[BigW: %skg+]</font> <font color=\'#AAAAAA\'>(keep:%s)</font> <font color=\'#00FF00\'>\240\159\159\162%s</font>\n", a, Z, tostring(g), tostring(u), tostring(J))
        else
            H = string.format("%s <font color=\'#FFA500\'><b>%s</b></font> <font color=\'#66CCFF\'>[Lv. %s-%s]</font> <font color=\'#AAAAAA\'>(%s-%skg)</font> <font color=\'#00FF00\'>\240\159\159\162%s</font>\n", a, Z, tostring(T), tostring(d), tostring(i), tostring(c), tostring(J))
        end
        G = G .. H
    end
    r.lbl_pet_details:SetText(G)
end
j.FindUiTab = function()
    local G = Z:AddTab({ Name = "Snipe Pets" .. w, Description = "Find pets", Icon = "sparkles"})
    local V = G:AddLeftGroupbox("<font color=\'#FFFFFF\'>Pet Filter</font>", "cat", false)
    local y = G:AddRightGroupbox("\240\159\142\175 <font color=\'#FFB833\'>Pets</font>", "gift", false)
    local c = G:AddRightGroupbox("<font color=\'#FFB833\'>Pets Filtered</font>", "gift", false)
    if V then
        local G = nil
        local y
        local Z
        local i
        local c
        local J
        local T
        local d
        local u
        local q
        local function g(G)
            if not Y.find_settings[G] then
                Y.find_settings[G] = { enabled = false, weight_min = .86, weight_max = 12.86;
                min_level = 1;
                max_level = 125;
                price = 3, max_keep = 300;
                is_weightagebased = false, big_weight_max = 112}
            else
                if not Y.find_settings[G].big_weight_max then
                    Y.find_settings[G].is_weightagebased = false
                    Y.find_settings[G].big_weight_max = 112
                end
                if not Y.find_settings[G].max_keep then
                    Y.find_settings[G].max_keep = 300
                end
                if not Y.find_settings[G].min_level then
                    Y.find_settings[G].min_level = 1
                    Y.find_settings[G].max_level = 125
                end
            end
        end
        local function E(G)
            if not G then
                return
            end
            g(G)
            local V = Y.find_settings[G]
            y:SetValue(V.enabled)
            u:SetValue(V.is_weightagebased)
            Z:SetValue(tostring(V.weight_min))
            Z:SetText(string.format("\240\159\159\162 Min BaseWeight <font color=\'#FF4065\'>%s</font>", V.weight_min))
            i:SetValue(tostring(V.weight_max))
            i:SetText(string.format("\240\159\148\180 Max BaseWeight <font color=\'#FF4065\'>%s</font>", V.weight_max))
            c:SetValue(tostring(V.min_level))
            c:SetText(string.format("\226\154\170 Min Lv. <font color=\'#FF4065\'>%s</font>", V.min_level))
            J:SetValue(tostring(V.max_level))
            J:SetText(string.format("\240\159\159\161 Max Lv. <font color=\'#FF4065\'>%s</font>", V.max_level))
            T:SetValue(tostring(V.price))
            T:SetText(string.format("\240\159\146\176 Tokens <font color=\'#FF4065\'>%s</font>", V.price))
            d:SetValue(tostring(V.max_keep))
            d:SetText(string.format("\226\154\160\239\184\143Pet Count Limit <font color=\'#FF4065\'>%s</font>", V.max_keep))
            q:SetValue(tostring(V.big_weight_max))
            q:SetText(string.format("\226\156\168Visual Weight <font color=\'#FFF603\'>%s KG</font>", V.big_weight_max))
        end
        V:AddLabel({ Text = "Select a pet to edit its specific filters.";
        DoesWrap = true})
        local a = V:AddDropdown("dd_edit_specific_pet", { Values = j.all_pets_names_list, Default = 1, Multi = false;
        Text = "\240\159\144\190 Select Pet", Searchable = true, Callback = function(V)
            G = V
            E(G)
        end})
        V:AddDivider()
        y = V:AddToggle("Toggle_Alt_EnablePet", { Text = "\226\154\161 Enable Pet", Default = false, Tooltip = "Toggle finding for the pet selected above", Callback = function(V)
            if not G then
                return
            end
            g(G)
            Y.find_settings[G].enabled = V
            W()
        end})
        Z = V:AddInput("Input_Alt_MinWeight", { Text = "\240\159\159\162 Min BaseWeight";
        Default = 0, Numeric = true;
        AllowEmpty = true;
        Finished = true, ClearTextOnFocus = false, Placeholder = "e.g 0.86";
        Callback = function(V)
            if not G then
                return
            end
            local y = f(V)
            local i = tonumber(Y.find_settings[G].weight_min) or 0
            local c = tonumber(Y.find_settings[G].weight_max) or 12
            if not y or y < 0 then
                j.Notify("Invalid: " .. V, 3)
                if i > 0 then
                    Z:SetValue(tostring(i))
                end
                return
            end
            if y > c then
                j.Notify("Minimum weight can\'t be more than max weight", 3)
                return
            end
            Y.find_settings[G].weight_min = y
            W()
            Z:SetText(string.format("\240\159\159\162 Min BaseWeight <font color=\'#FF4065\'>%s</font>", y))
        end})
        i = V:AddInput("Input_Alt_MaxWeight", { Text = "\240\159\148\180 Max BaseWeight";
        Default = 0;
        Numeric = true;
        AllowEmpty = true;
        Finished = true;
        ClearTextOnFocus = false;
        Placeholder = "e.g 2.86", Callback = function(V)
            if not G then
                return
            end
            local y = f(V)
            local Z = tonumber(Y.find_settings[G].weight_min) or 0
            local c = tonumber(Y.find_settings[G].weight_max) or 12
            if not y or y < .1 then
                j.Notify("Invalid: " .. V, 3)
                if c > .1 then
                    i:SetValue(tostring(Y.find_settings[G].weight_max))
                end
                return
            end
            if y < Z then
                j.Notify("Maximum weight can\'t be less than min weight ", 3)
                return
            end
            Y.find_settings[G].weight_max = y
            W()
            i:SetText(string.format("\240\159\148\180 Max BaseWeight <font color=\'#FF4065\'>%s</font>", y))
        end})
        c = V:AddInput("input_minlevel_filter", { Text = "\226\154\170 Min Lv.";
        Default = 0, Numeric = true;
        AllowEmpty = true, Finished = true, ClearTextOnFocus = false, Placeholder = "e.g 1", Callback = function(V)
            if not G then
                return
            end
            local y = z(V)
            if not y or y < 0 then
                j.Notify("Invalid: " .. V, 3)
                c:SetValue(tostring(Y.find_settings[G].min_level))
                return
            end
            local Z = tonumber(Y.find_settings[G].max_level) or 125
            if y > Z then
                j.Notify("Can\'t be more than maximum level ", 3)
                c:SetValue(tostring(Y.find_settings[G].min_level))
                return
            end
            Y.find_settings[G].min_level = y
            W()
            c:SetText(string.format("\226\154\170 Min Lv. <font color=\'#FF4065\'>%s</font>", y))
        end})
        J = V:AddInput("input_maxlevel_filter", { Text = "\240\159\159\162 Max Lv.";
        Default = 0, Numeric = true;
        AllowEmpty = true;
        Finished = true, ClearTextOnFocus = false, Placeholder = "e.g 100", Callback = function(V)
            if not G then
                return
            end
            local y = z(V)
            if not y or y < 0 then
                j.Notify("Invalid: " .. V, 3)
                J:SetValue(tostring(Y.find_settings[G].max_level))
                return
            end
            local Z = tonumber(Y.find_settings[G].min_level) or 1
            if y < Z then
                j.Notify("Can\'t be less than minimum level ", 3)
                J:SetValue(tostring(Y.find_settings[G].max_level))
                return
            end
            Y.find_settings[G].max_level = y
            W()
            J:SetText(string.format("\240\159\159\162 Max Lv. <font color=\'#FF4065\'>%s</font>", y))
        end})
        T = V:AddInput("Input_Alt_Price", { Text = "\240\159\146\176 Tokens", Default = 0, Numeric = true;
        AllowEmpty = true;
        Finished = true, ClearTextOnFocus = false, Placeholder = "e.g 3";
        Callback = function(V)
            if not G then
                return
            end
            local y = z(V)
            if not y or y <= 0 then
                j.Notify("Invalid: " .. V, 3)
                T:SetValue(tostring(Y.find_settings[G].price))
                return
            end
            Y.find_settings[G].price = y
            W()
            T:SetText(string.format("\240\159\146\176 Tokens <font color=\'#FF4065\'>%s</font>", y))
        end})
        d = V:AddInput("input_maxkeeppetlimit", { Text = "\226\154\160\239\184\143Pet Count Limit";
        Default = 0;
        Numeric = true, AllowEmpty = true, Finished = true;
        ClearTextOnFocus = false, Tooltip = "Will not buy anymore if your backpack has this amount.", Placeholder = "e.g 100";
        Callback = function(V)
            if not G then
                return
            end
            local y = z(V)
            if not y or y < 0 then
                j.Notify("Invalid: " .. V, 3)
                d:SetValue(tostring(Y.find_settings[G].max_keep))
                return
            end
            Y.find_settings[G].max_keep = y
            W()
            d:SetText(string.format("\226\154\160\239\184\143Pet Count Limit <font color=\'#FF4065\'>%s</font>", y))
        end})
        V:AddDivider()
        V:AddDivider()
        V:AddDivider()
        V:AddLabel({ Text = "\226\132\185\239\184\143 When this is enabled BaseWeight and Levels are ignored. Instead it will snipe based on the visual weight you see! example 63.45KG", DoesWrap = true})
        V:AddDivider()
        q = V:AddInput("input_bigweightmax", { Text = "Visual Weight", Default = 0;
        Numeric = true;
        AllowEmpty = true;
        Finished = true, ClearTextOnFocus = false;
        Tooltip = "Weight based on age", Placeholder = "e.g 100kg", Callback = function(V)
            if not G then
                return
            end
            local y = f(V)
            if not y or y < 0 then
                j.Notify("Invalid: " .. V, 3)
                q:SetValue(tostring(Y.find_settings[G].big_weight_max))
                return
            end
            Y.find_settings[G].big_weight_max = y
            W()
            q:SetText(string.format("\226\156\168Visual Weight <font color=\'#FF4065\'>%s KG</font>", y))
        end})
        u = V:AddToggle("toggleBigWeight_enabled", { Text = "\240\159\159\162Enable Visual Weight", Default = false;
        Tooltip = "When this is enabled. system will not use base weight or levels. Instead will use the weight based on age or what you can see on the pet.", Callback = function(V)
            if not G then
                return
            end
            g(G)
            Y.find_settings[G].is_weightagebased = V
            W()
        end})
        if j.all_pets_names_list and # j.all_pets_names_list > 0 then
            G = j.all_pets_names_list[1]
            E(G)
        end
    end
    if c then
        c:AddLabel({ Text = "\226\132\185\239\184\143 Only pets filtered will be purchased by the snipe system.", DoesWrap = true})
        c:AddDivider()
        r.lbl_pet_details = c:AddLabel({ Text = "-";
        DoesWrap = true})
    end
    if y then
        y:AddLabel({ Text = "Please make sure you have selected pet filters on the left side.", DoesWrap = true})
        local G
        G = y:AddDropdown("dd_find_petlist", { Values = {}, Default = {};
        Multi = true, Text = "\240\159\166\150 Find Pets", Searchable = true;
        MaxVisibleDropdownItems = 10, Changed = function(G)
            if not G then
                return
            end
            Y.finder.find_petlist = G
            W()
        end})
        G:SetValues(j.all_pets_names_list)
        G:SetValue(Y.finder.find_petlist)
        local V = y:AddButton({ Text = "Select All";
        Func = function()
            Y.finder.find_petlist = {}
            for G, V in ipairs(j.all_pets_names_list) do
                Y.finder.find_petlist[V] = true
            end
            G:SetValue(Y.finder.find_petlist)
            W()
        end})
        V:AddButton({ Text = "<font color=\'#FF3D17\'>Remove All</font>";
        Func = function()
            Y.finder.find_petlist = {}
            G:SetValue(Y.finder.find_petlist)
            W()
        end})
        y:AddDivider()
        local Z
        Z = y:AddToggle("toggleEnableFinder", { Text = "\226\154\161Enable Finder";
        Default = Y.finder.find_enabled, DisabledTooltip = "Premium Only";
        Tooltip = "When enabled it finds targets";
        Callback = function(G)
            Y.finder.find_enabled = G
            W()
        end})
        local i
        i = y:AddToggle("toggletsameserver", { Text = "\240\159\147\161Current Server Buying Mode", Default = Y.sameserver_buyonly;
        DisabledTooltip = "Premium Only";
        Tooltip = "When enabled it will only scan and buy on current server and will never teleport. [Finder must be enable for this to work]";
        Callback = function(G)
            Y.sameserver_buyonly = G
            W()
        end})
        if not j.GetCheckIfPro() then
            Z:SetDisabled(true)
            i:SetDisabled(true)
        end
    end
    local J = false
    if J then
        local function V(G)
            if not G then
                return "#FFFFFF"
            end
            return string.format("#%02X%02X%02X", G.R * 255, G.G * 255, G.B * 255)
        end
        for y, Z in ipairs(i.EggDataSet) do
            local i = Z.name
            local c = Z.rarity
            local J = Z.pets
            local T = Z.color
            local d = V(T)
            local u = string.format("<font color=\"%s\">%s</font> <font color=\"#AAAAAA\">[%s]</font>", d, i, c)
            local q = G:AddLeftGroupbox(u)
            for G, V in ipairs(J) do
                task.wait()
                local y = V.petname
                if not Y.find_settings[y] then
                    Y.find_settings[y] = { enabled = false;
                    weight_min = .86;
                    weight_max = 12.86;
                    price = 3}
                end
                local Z = q:AddToggle("Toggle_" ..(i ..("_" .. y)), { Text = y;
                Default = Y.find_settings[y].enabled, Tooltip = "Filter: " .. y, Callback = function(G)
                    Y.find_settings[y].enabled = G
                    W()
                end})
                local c = q:AddDependencyBox()
                c:SetupDependencies({ { Z, true}})
                local J = function()
                    local G = Y.find_settings[y].weight_min or 0
                    local V = string.format("\240\159\159\162 Min Weight <font color=\'#FF4065\'>%s</font>", G)
                    return V
                end
                local T
                T = c:AddInput("Min_" .. y, { Text = J();
                Default = Y.find_settings[y].weight_min or 0;
                Numeric = true;
                AllowEmpty = true, Finished = true;
                ClearTextOnFocus = false;
                Placeholder = "e.g 1", Tooltip = "Minimum weight", Callback = function(G)
                    local V = f(G)
                    if not V or V < 0 then
                        j.Notify("Invalid: " .. G, 3)
                        T:SetValue(tostring(Y.find_settings[y].weight_min))
                        return
                    end
                    Y.find_settings[y].weight_min = V
                    W()
                    T:SetText(J())
                end})
                local d = function()
                    local G = Y.find_settings[y].weight_max or 0
                    local V = string.format("\240\159\148\180 Max Weight <font color=\'#FF4065\'>%s</font>", G)
                    return V
                end
                local u
                u = c:AddInput("Max_" .. y, { Text = d();
                Default = Y.find_settings[y].weight_max or 0, Numeric = true;
                AllowEmpty = true;
                Finished = true, ClearTextOnFocus = false, Placeholder = "e.g 1";
                Tooltip = "Maximum weight";
                Callback = function(G)
                    local V = f(G)
                    if not V or V < 0 then
                        j.Notify("Invalid: " .. G, 3)
                        u:SetValue(tostring(Y.find_settings[y].weight_max))
                        return
                    end
                    Y.find_settings[y].weight_max = V
                    W()
                    u:SetText(d())
                end})
                local g = function()
                    local G = Y.find_settings[y].price or 0
                    local V = string.format("\240\159\146\176 Tokens <font color=\'#FF4065\'>%s</font>", G)
                    return V
                end
                local E
                E = c:AddInput("Price_" .. y, { Text = g(), Default = Y.find_settings[y].price or 0, Numeric = true;
                AllowEmpty = true;
                Finished = true, ClearTextOnFocus = false;
                Placeholder = "e.g 1", Tooltip = "Price", Callback = function(G)
                    local V = z(G)
                    if not V or V <= 0 then
                        j.Notify("Invalid: " .. G, 3)
                        E:SetValue(tostring(Y.find_settings[y].price))
                        return
                    end
                    Y.find_settings[y].price = V
                    W()
                    E:SetText(g())
                end})
                c:AddDivider()
            end
        end
    end
end
task.spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            j.GetPetsSelectUi()
        end)
    end
end)
g.TradingShops = { version = "shopping_selected_trading_v2";
status_seed = "Seed Shop: waiting.", status_gear = "Gear Shop: waiting.", status_egg = "Egg Shop: waiting.", status_props = "Cosmetic Shop: waiting.", busy = false, cycle_secs = 10, EventShopItemsData = {}, event_shop_data = {}, ui = { seed_label = nil, gear_label = nil;
egg_label = nil;
props_label = nil;
seed_dropdown = nil, gear_dropdown = nil;
egg_dropdown = nil, props_dropdown = nil}, DefaultTradingShopData = function()
    return { seed = { enabled = true, selected = {};
    guard_enabled = false, min_sheckles = 0};
    gear = { enabled = true;
    selected = {};
    guard_enabled = false;
    min_sheckles = 0};
    egg = { enabled = true, selected = {};
    guard_enabled = false, min_sheckles = 0}, props = { enabled = false, selected = {}, guard_enabled = false;
    min_sheckles = 0}, events = {}}
end, EnsureTradingShopSettings = function()
    local G = g.TradingShops.DefaultTradingShopData()
    local V = false
    if type(Y.trading_shops) ~= "table" then
        Y.trading_shops = G
        return Y.trading_shops
    end
    local y = Y.trading_shops
    if type(y.cosmetic) == "table" then
        y.props = y.cosmetic
        y.cosmetic = nil
        V = true
    end
    for G, V in pairs(G) do
        if type(V) == "table" then
            if type(y[G]) ~= "table" then
                y[G] = V
            else
                for V, Z in pairs(V) do
                    if y[G][V] == nil then
                        y[G][V] = Z
                    end
                end
            end
        end
    end
    for G, Z in pairs(y.events) do
        if type(Z) == "table" and type(Z.selected) == "table" then
            y.events[G] = Z.selected
            V = true
        end
    end
    if V then
        W()
    end
    return y
end;
IsSelectedTradingShop = function(G, V)
    if type(G) ~= "table" then
        return false
    end
    V = tostring(V or "")
    if V == "" then
        return false
    end
    if G[V] == true then
        return true
    end
    for G, y in pairs(G) do
        if y == V then
            return true
        end
        if type(y) == "table" and((y.Value == V or y.Text == V)) then
            return true
        end
    end
    return false
end;
ForEachSelectedTradingShop = function(G, V)
    if type(G) ~= "table" or type(V) ~= "function" then
        return
    end
    for G, y in pairs(G) do
        if y == true then
            V(tostring(G))
        elseif type(y) == "string" then
            V(y)
        elseif type(y) == "table" and y.Value then
            V(tostring(y.Value))
        end
    end
end, ParseShecklesTradingShop = function(G)
    local V =(((tostring(G or "0")):gsub(",", "")):gsub("%s+", "")):upper()
    if V == "" then
        return 0
    end
    local y, Z = V:match("^([%d%.]+)(%a*)$")
    local j = tonumber(y)
    if not j then
        return nil
    end
    local i = { K = 1000.0;
    M = 1000000.0, B = 1000000000.0, T = 1000000000000.0, QA = 1e+015, QI = 1e+018, SX = 1e+021;
    SP = 1e+024, OC = 1e+027;
    NO = 1e+030}
    local c = i[Z] or 1
    return math.floor(j * c)
end;
FormatNumberTradingShop = function(G)
    if i and type(i.FormatHugeNumbers) == "function" then
        return i.FormatHugeNumbers(G, 2)
    end
    return tostring(math.floor(tonumber(G) or 0))
end;
FormatPriceTradingShop = function(G, V)
    G = tonumber(G) or 0
    V = tostring(V or "Sheckles")
    if G <= 0 then
        return ""
    end
    return string.format("%s %s", g.TradingShops.FormatNumberTradingShop(G), V)
end, GetRarityRankTradingShop = function(G)
    return(i and(i.RarityLayoutMap and i.RarityLayoutMap[tostring(G or "")])) or 0
end;
GetRarityColoursTradingShop = function(G)
    if i and type(i.RarityToColor) == "function" then
        return i.RarityToColor(tostring(G or ""))
    end
    return "#FFFFFF", "#111111"
end;
MakeLabelTradingShop = function(G, V, y, Z, j, i)
    local c, J = g.TradingShops.GetRarityColoursTradingShop(Z)
    local T = g.TradingShops.FormatPriceTradingShop(V, y)
    local d = T ~= "" and string.format(" <font color=\'#8AA8FF\'>\226\128\162 %s</font>", T) or ""
    local u = tostring(Z or "") ~= "" and string.format(" <font color=\'#B8B8B8\'>\226\128\162 [</font><stroke color=\'%s\' thickness=\'1\' transparency=\'0.35\'><font color=\'%s\'><b>%s</b></font></stroke><font color=\'#B8B8B8\'>]</font>", J, c, tostring(Z)) or ""
    local q = tostring(j or "") ~= "" and string.format(" <font color=\'#5CFF9B\'>\226\128\162 %s</font>", tostring(j)) or ""
    local E = tostring(i or "") ~= "" and string.format(" <font color=\'#FFB86B\'>\226\128\162 %s</font>", tostring(i)) or ""
    return { Text = string.format("<b><font color=\'#FFFFFF\'>%s</font></b>%s%s%s%s", tostring(G), q, u, d, E), Value = tostring(G)}
end;
GetCurrencyTradingShop = function(G)
    G = tostring(G or "Sheckles")
    if G == "Sheckles" then
        return tonumber(E.GetBigDataUsingKey("Sheckles")) or 0
    end
    local V = E.GetBigDataUsingKey("SpecialCurrency")
    if type(V) ~= "table" then
        return 0
    end
    return tonumber(V[G]) or 0
end, GetSeedPriceTradingShop = function(G)
    local y = type(V.SeedShopData) == "table" and V.SeedShopData[G] or nil
    if type(y) ~= "table" then
        return nil, nil
    end
    return y.Price or 0, y.SpecialCurrencyType or "Sheckles"
end;
GetDailySeedPriceTradingShop = function(G)
    local y = type(V.DailySeedShopData) == "table" and V.DailySeedShopData[G] or nil
    if type(y) ~= "table" then
        return nil, nil
    end
    return y.Price or 0, y.SpecialCurrencyType or "Sheckles"
end, GetGearPriceTradingShop = function(G)
    local y = type(V.GearShopData) == "table" and V.GearShopData.Gear or nil
    local Z = type(y) == "table" and y[G] or nil
    if type(Z) ~= "table" then
        return nil, nil
    end
    return Z.Price or 0, Z.SpecialCurrencyType or "Sheckles"
end;
GetEggPriceTradingShop = function(G)
    local y = type(V.PetEggData) == "table" and V.PetEggData[G] or nil
    if type(y) ~= "table" then
        return nil, nil
    end
    return y.Price or 0, y.SpecialCurrencyType or "Sheckles"
end;
GetLowestSeedPriceTradingShop = function()
    local G = math.huge
    for V, y in pairs(type(V.SeedShopData) == "table" and V.SeedShopData or {}) do
        local Z = tonumber(y and y.Price)
        if Z and Z < G then
            G = Z
        end
    end
    return G == math.huge and 0 or G
end;
GetLowestEggPriceTradingShop = function()
    local G = math.huge
    for V, y in pairs(type(V.PetEggData) == "table" and V.PetEggData or {}) do
        local Z = tonumber(y and y.Price)
        if Z and Z < G then
            G = Z
        end
    end
    return G == math.huge and 10 or G
end, GetSeedNamesTradingShop = function()
    local G = {}
    local y = {}
    for V in pairs(type(V.SeedShopData) == "table" and V.SeedShopData or {}) do
        G[tostring(V)] = true
    end
    for V in pairs(type(V.DailySeedShopData) == "table" and V.DailySeedShopData or {}) do
        G[tostring(V)] = true
    end
    for G in pairs(G) do
        table.insert(y, G)
    end
    table.sort(y, function(G, V)
        local y = g.TradingShops.GetRarityRankTradingShop(j.GetSeedRarity(G))
        local Z = g.TradingShops.GetRarityRankTradingShop(j.GetSeedRarity(V))
        if y ~= Z then
            return y > Z
        end
        return tostring(G) < tostring(V)
    end)
    return y
end;
GetGearNamesTradingShop = function()
    local G = {}
    local y = type(V.GearShopData) == "table" and V.GearShopData.Gear or nil
    for V in pairs(type(y) == "table" and y or {}) do
        table.insert(G, tostring(V))
    end
    table.sort(G, function(G, y)
        local Z = V.GearData and V.GearData[G]
        local j = V.GearData and V.GearData[y]
        local i = g.TradingShops.GetRarityRankTradingShop(Z and Z.GearRarity or "")
        local c = g.TradingShops.GetRarityRankTradingShop(j and j.GearRarity or "")
        if i ~= c then
            return i > c
        end
        return tostring(G) < tostring(y)
    end)
    return G
end, GetSeedValuesTradingShop = function()
    local G = {}
    for V, y in ipairs(g.TradingShops.GetSeedNamesTradingShop()) do
        local Z, i = g.TradingShops.GetSeedPriceTradingShop(y)
        if not Z then
            Z, i = g.TradingShops.GetDailySeedPriceTradingShop(y)
        end
        table.insert(G, g.TradingShops.MakeLabelTradingShop(y, Z or 0, i or "Sheckles", j.GetSeedRarity(y), "SEED", j.IsSingleHarvestPlant(y) and "Single" or "Multi"))
    end
    return G
end, GetGearValuesTradingShop = function()
    local G = {}
    for y, Z in ipairs(g.TradingShops.GetGearNamesTradingShop()) do
        local j = V.GearData and V.GearData[Z]
        local i, c = g.TradingShops.GetGearPriceTradingShop(Z)
        table.insert(G, g.TradingShops.MakeLabelTradingShop(Z, i or 0, c or "Sheckles", j and j.GearRarity or "", "GEAR", ""))
    end
    return G
end;
GetEggNamesTradingShop = function()
    local G = {}
    for V in pairs(type(V.PetEggData) == "table" and V.PetEggData or {}) do
        table.insert(G, tostring(V))
    end
    table.sort(G, function(G, y)
        local Z = V.PetEggData and V.PetEggData[G]
        local j = V.PetEggData and V.PetEggData[y]
        local i = g.TradingShops.GetRarityRankTradingShop(Z and Z.EggRarity or "")
        local c = g.TradingShops.GetRarityRankTradingShop(j and j.EggRarity or "")
        if i ~= c then
            return i > c
        end
        return tostring(G) < tostring(y)
    end)
    return G
end;
GetEggValuesTradingShop = function()
    local G = {}
    for y, Z in ipairs(g.TradingShops.GetEggNamesTradingShop()) do
        local j = V.PetEggData and V.PetEggData[Z]
        local i, c = g.TradingShops.GetEggPriceTradingShop(Z)
        table.insert(G, g.TradingShops.MakeLabelTradingShop(Z, i or 0, c or "Sheckles", j and j.EggRarity or "", "EGG", ""))
    end
    return G
end, EncodePropValueTradingShop = function(G, V, y)
    return tostring(G) ..("|" ..(tostring(V) ..("|" .. tostring(y))))
end, DecodePropValueTradingShop = function(G)
    return(tostring(G or "")):match("^([^|]+)|([^|]+)|(.+)$")
end;
GetPropItemDataTradingShop = function(G, y, Z)
    local j = V.CosmeticShopTabData and(V.CosmeticShopTabData.Tabs and V.CosmeticShopTabData.Tabs[G])
    if type(j) ~= "table" then
        return nil
    end
    if y == "Crate" and type(j.Crates) == "table" then
        return j.Crates[Z]
    end
    if y == "Fence" and type(j.Fences) == "table" then
        return j.Fences[Z]
    end
    if y == "Item" and type(j.Items) == "table" then
        return j.Items[Z]
    end
    return nil
end, GetPropRarityTradingShop = function(G, y, Z)
    if G == "Crate" then
        return Z and Z.CrateRarity or ""
    end
    if G == "Fence" then
        local G = V.FenceSkinRegistry and V.FenceSkinRegistry[y]
        return G and G.Rarity or ""
    end
    local j = V.CosmeticRegistry and V.CosmeticRegistry.CosmeticList
    local i = j and j[y]
    return i and i.Rarity or ""
end;
GetPropsValuesTradingShop = function()
    local G = {}
    local y = {}
    local Z = V.CosmeticShopTabData and V.CosmeticShopTabData.Tabs
    if type(Z) ~= "table" then
        return G
    end
    local function j(G, V, Z)
        if type(Z) ~= "table" then
            return
        end
        for Z, j in pairs(Z) do
            local i = g.TradingShops.GetPropRarityTradingShop(V, Z, j)
            local c = tonumber(j and j.Price) or 0
            table.insert(y, { category = tostring(G), prop_type = tostring(V);
            name = tostring(Z), price = c, rarity = tostring(i or ""), rank = g.TradingShops.GetRarityRankTradingShop(i)})
        end
    end
    for G, V in pairs(Z) do
        j(G, "Crate", V.Crates)
        j(G, "Item", V.Items)
        j(G, "Fence", V.Fences)
    end
    table.sort(y, function(G, V)
        if G.category ~= V.category then
            return G.category < V.category
        end
        if G.prop_type ~= V.prop_type then
            return G.prop_type < V.prop_type
        end
        if G.rank ~= V.rank then
            return G.rank > V.rank
        end
        return G.name < V.name
    end)
    for V, y in ipairs(y) do
        local Z = g.TradingShops.EncodePropValueTradingShop(y.category, y.prop_type, y.name)
        local j = g.TradingShops.MakeLabelTradingShop(y.name, y.price, "Sheckles", y.rarity, y.prop_type:upper(), y.category)
        j.Value = Z
        table.insert(G, j)
    end
    return G
end, CanPassGuardTradingShop = function(G)
    if type(G) ~= "table" then
        return false, "settings missing"
    end
    if G.enabled ~= true then
        return false, "disabled"
    end
    if G.guard_enabled == true then
        local V = tonumber(G.min_sheckles) or 0
        local y = g.TradingShops.GetCurrencyTradingShop("Sheckles")
        if V > 0 and y < V then
            return false, "guard " ..(g.TradingShops.FormatNumberTradingShop(y) ..("/" .. g.TradingShops.FormatNumberTradingShop(V)))
        end
    end
    return true, "ok"
end, SetStatusTradingShop = function(G, V)
    V = tostring(V or "")
    if G == "seed" then
        g.TradingShops.status_seed = V
        if g.TradingShops.ui.seed_label and type(g.TradingShops.ui.seed_label.SetText) == "function" then
            g.TradingShops.ui.seed_label:SetText(V)
        end
    elseif G == "gear" then
        g.TradingShops.status_gear = V
        if g.TradingShops.ui.gear_label and type(g.TradingShops.ui.gear_label.SetText) == "function" then
            g.TradingShops.ui.gear_label:SetText(V)
        end
    elseif G == "egg" then
        g.TradingShops.status_egg = V
        if g.TradingShops.ui.egg_label and type(g.TradingShops.ui.egg_label.SetText) == "function" then
            g.TradingShops.ui.egg_label:SetText(V)
        end
    elseif G == "props" then
        g.TradingShops.status_props = V
        if g.TradingShops.ui.props_label and type(g.TradingShops.ui.props_label.SetText) == "function" then
            g.TradingShops.ui.props_label:SetText(V)
        end
    end
end, RemoteBuyDailySeedTradingShop = function(G, y)
    if not V.BuyDailySeedShopStock then
        return false
    end
    local Z = g.TradingShops.GetCurrencyTradingShop("Sheckles")
    if Z < 300 then
        return false
    end
    local j = g.TradingShops.GetDailySeedPriceTradingShop(G)
    if j and Z < j then
        return false
    end
    for y = 1, y or 1, 1 do
        V.BuyDailySeedShopStock:FireServer(G)
    end
    return true
end;
RemoteBuySeedTradingShop = function(G, y)
    if not V.BuySeedStock then
        return false
    end
    local Z = g.TradingShops.GetCurrencyTradingShop("Sheckles")
    local j, i = g.TradingShops.GetSeedPriceTradingShop(G)
    if j and i then
        if i == "GardenCoins" then
            if g.TradingShops.GetCurrencyTradingShop("GardenCoins") < j then
                return false
            end
        else
            if Z < g.TradingShops.GetLowestSeedPriceTradingShop() then
                return false
            end
            if Z < j then
                return false
            end
        end
    end
    for y = 1, y or 1, 1 do
        pcall(function()
            V.BuySeedStock:FireServer("Shop", G)
        end)
    end
    return true
end;
RemoteBuyGearTradingShop = function(G, y)
    if not V.BuyGearStock then
        return false
    end
    local Z = g.TradingShops.GetCurrencyTradingShop("Sheckles")
    if Z < 50000 then
        return false
    end
    local j = g.TradingShops.GetGearPriceTradingShop(G)
    if j and Z < j then
        return false
    end
    for y = 1, y or 1, 1 do
        pcall(function()
            V.BuyGearStock:FireServer(G)
        end)
    end
    return true
end;
RemoteBuyEggTradingShop = function(G, y)
    if not V.BuyPetEgg then
        return false
    end
    local Z = g.TradingShops.GetCurrencyTradingShop("Sheckles")
    if Z < g.TradingShops.GetLowestEggPriceTradingShop() then
        return false
    end
    local j = g.TradingShops.GetEggPriceTradingShop(G)
    if j and Z < j then
        return false
    end
    for y = 1, y or 1, 1 do
        pcall(function()
            V.BuyPetEgg:FireServer(G)
        end)
    end
    return true
end;
BuySeedItemTradingShop = function(G, V, y)
    V = math.max(1, tonumber(V) or 1)
    for V = 1, V, 1 do
        if y == "Daily Deals" then
            g.TradingShops.RemoteBuyDailySeedTradingShop(G, 1)
        else
            g.TradingShops.RemoteBuySeedTradingShop(G, 1)
        end
        task.wait(.08)
    end
end, BuyGearItemTradingShop = function(G, V)
    V = math.max(1, tonumber(V) or 1)
    for V = 1, V, 1 do
        g.TradingShops.RemoteBuyGearTradingShop(G, 1)
        task.wait(.08)
    end
end;
BuyEggItemTradingShop = function(G, V)
    V = math.max(1, tonumber(V) or 1)
    for V = 1, V, 1 do
        g.TradingShops.RemoteBuyEggTradingShop(G, 1)
        task.wait(.08)
    end
end;
BuyPropItemTradingShop = function(G, y, Z, j)
    G = tostring(G or "")
    y = tostring(y or "")
    Z = tostring(Z or "")
    if G == "" or y == "" or Z == "" then
        return 0
    end
    local i = g.TradingShops.GetPropItemDataTradingShop(G, y, Z)
    local c = tonumber(i and i.Price) or 0
    local J = 0
    j = math.max(1, tonumber(j) or 1)
    for j = 1, j, 1 do
        if c > 0 and g.TradingShops.GetCurrencyTradingShop("Sheckles") < c then
            break
        end
        if y == "Crate" and V.BuyCosmeticCrate then
            V.BuyCosmeticCrate:FireServer(Z, G)
            J += 1
        elseif y == "Fence" and V.BuyCosmeticShopFence then
            V.BuyCosmeticShopFence:FireServer(Z, G)
            J += 1
        elseif V.BuyCosmeticItem then
            V.BuyCosmeticItem:FireServer(Z, G)
            J += 1
        end
        task.wait(.08)
    end
    return J
end, BuySelectedSeedsTradingShop = function()
    local G =(g.TradingShops.EnsureTradingShopSettings()).seed
    local V, y = g.TradingShops.CanPassGuardTradingShop(G)
    if not V then
        g.TradingShops.SetStatusTradingShop("seed", "Seed Shop: " .. y)
        return 0
    end
    local Z = E.GetBigDataUsingKey("SeedStocks")
    if type(Z) ~= "table" then
        g.TradingShops.SetStatusTradingShop("seed", "Seed Shop: no stock data")
        return 0
    end
    local j = 0
    local function i(V)
        local y = Z[V]
        if type(y) ~= "table" or type(y.Stocks) ~= "table" then
            return
        end
        for y, Z in pairs(y.Stocks) do
            local i = tonumber(Z and Z.Stock) or 0
            if i > 0 and g.TradingShops.IsSelectedTradingShop(G.selected, y) then
                g.TradingShops.BuySeedItemTradingShop(y, i, V)
                j += i
            end
        end
    end
    i("Shop")
    i("Daily Deals")
    g.TradingShops.SetStatusTradingShop("seed", j > 0 and("Seed Shop: bought x" .. tostring(j)) or "Seed Shop: no selected stock")
    return j
end, BuySelectedGearTradingShop = function()
    local G =(g.TradingShops.EnsureTradingShopSettings()).gear
    local V, y = g.TradingShops.CanPassGuardTradingShop(G)
    if not V then
        g.TradingShops.SetStatusTradingShop("gear", "Gear Shop: " .. y)
        return 0
    end
    local Z = E.GetBigDataUsingKey("GearStock")
    if type(Z) ~= "table" or type(Z.Stocks) ~= "table" then
        g.TradingShops.SetStatusTradingShop("gear", "Gear Shop: no stock data")
        return 0
    end
    local j = 0
    for V, y in pairs(Z.Stocks) do
        local Z = tonumber(y and y.Stock) or 0
        if Z > 0 and g.TradingShops.IsSelectedTradingShop(G.selected, V) then
            g.TradingShops.BuyGearItemTradingShop(V, Z)
            j += Z
        end
    end
    g.TradingShops.SetStatusTradingShop("gear", j > 0 and("Gear Shop: bought x" .. tostring(j)) or "Gear Shop: no selected stock")
    return j
end, BuySelectedEggsTradingShop = function()
    local G =(g.TradingShops.EnsureTradingShopSettings()).egg
    local V, y = g.TradingShops.CanPassGuardTradingShop(G)
    if not V then
        g.TradingShops.SetStatusTradingShop("egg", "Egg Shop: " .. y)
        return 0
    end
    local Z = E.GetBigDataUsingKey("PetEggStock")
    if type(Z) ~= "table" or type(Z.Stocks) ~= "table" then
        g.TradingShops.SetStatusTradingShop("egg", "Egg Shop: no stock data")
        return 0
    end
    local j = 0
    for V, y in ipairs(Z.Stocks) do
        local Z = tostring(y and y.EggName or "")
        local i = tonumber(y and y.Stock) or 0
        if Z ~= "" and(i > 0 and g.TradingShops.IsSelectedTradingShop(G.selected, Z)) then
            g.TradingShops.BuyEggItemTradingShop(Z, i)
            j += i
        end
    end
    g.TradingShops.SetStatusTradingShop("egg", j > 0 and("Egg Shop: bought x" .. tostring(j)) or "Egg Shop: no selected stock")
    return j
end;
BuySelectedPropsTradingShop = function()
    local G =(g.TradingShops.EnsureTradingShopSettings()).props
    local V, y = g.TradingShops.CanPassGuardTradingShop(G)
    if not V then
        g.TradingShops.SetStatusTradingShop("props", "Cosmetic Shop: " .. y)
        return 0
    end
    local Z = E.GetBigDataUsingKey("CosmeticStock")
    local j = type(Z) == "table" and Z.TabStocks
    if type(j) ~= "table" then
        g.TradingShops.SetStatusTradingShop("props", "Cosmetic Shop: no stock data")
        return 0
    end
    local i = 0
    g.TradingShops.ForEachSelectedTradingShop(G.selected, function(G)
        local V, y, Z = g.TradingShops.DecodePropValueTradingShop(G)
        local c = V and j[V]
        local J
        if type(c) == "table" then
            if y == "Crate" then
                J = c.CrateStocks
            elseif y == "Fence" then
                J = c.FenceStocks
            else
                J = c.ItemStocks
            end
        end
        local T = type(J) == "table" and J[Z]
        local d = tonumber(T and T.Stock) or 0
        if d > 0 then
            i += g.TradingShops.BuyPropItemTradingShop(V, y, Z, d)
        end
    end)
    g.TradingShops.SetStatusTradingShop("props", i > 0 and("Cosmetic Shop: bought x" .. tostring(i)) or "Cosmetic Shop: no selected stock")
    return i
end, GetEventShopItemDataTradingShop = function(G)
    return g.TradingShops.EventShopItemsData[G]
end, MapEventShopItemTradingShop = function(G, V, y)
    if type(y) ~= "table" then
        return nil
    end
    local Z = tostring(V)
    local i = y.SeedName or "-"
    local c = ""
    local J = y.ItemType or ""
    if y.Rarity then
        c = y.Rarity or ""
    end
    if y.SeedRarity then
        c = y.SeedRarity or ""
    end
    if J == "Seed" then
        c = j.GetSeedRarity(V)
    end
    local T = { ItemType = tostring(J);
    Price = tonumber(y.Price) or 0, SpecialCurrencyType = tostring(y.SpecialCurrencyType or "Sheckles");
    Rarity = tostring(c)}
    g.TradingShops.EventShopItemsData[Z] = T
    g.TradingShops.EventShopItemsData[i] = T
    return T
end, GetEventShopItemsTradingShop = function()
    local G = {}
    g.TradingShops.EventShopItemsData = {}
    for V, y in pairs(type(V.EventShopData) == "table" and V.EventShopData or {}) do
        G[V] = {}
        for y, Z in pairs(y) do
            table.insert(G[V], y)
            local j, i = pcall(function()
                g.TradingShops.MapEventShopItemTradingShop(V, y, Z)
            end)
            if not j then
                warn("[TradingShops] Event item map failed:", i)
            end
        end
    end
    return G
end;
GetEventShopStockTradingShop = function()
    local G = E.GetBigDataUsingKey("EventShopStock")
    if type(G) ~= "table" then
        return nil
    end
    return G
end;
GetEventItemStockTradingShop = function(G, V)
    local y = g.TradingShops.GetEventShopStockTradingShop()
    if type(y) ~= "table" then
        return 0, 0
    end
    local Z = y[G]
    if type(Z) ~= "table" or type(Z.Stocks) ~= "table" then
        return 0, 0
    end
    local j = Z.Stocks[V]
    if type(j) ~= "table" then
        return 0, 0
    end
    return tonumber(j.Stock) or 0, tonumber(j.MaxStock) or 0
end;
CanBuyEventItemTradingShop = function(G, V)
    local y, Z = g.TradingShops.GetEventItemStockTradingShop(G, V)
    if y <= 0 then
        return false, "no stock", y, Z, 0, 0
    end
    local j = g.TradingShops.GetEventShopItemDataTradingShop(V)
    local i = j and j.Price or 0
    local c = j and j.SpecialCurrencyType or ""
    if i <= 0 or not c or c == "" then
        return true, "stock only", y, Z, i, 0
    end
    local J = g.TradingShops.GetCurrencyTradingShop(c)
    if J < i then
        return false, "not enough " .. tostring(c), y, Z, i, J
    end
    return true, "ok", y, Z, i, J
end, BuySelectedEventsTradingShop = function()
    if not j.GetCheckIfPro() then
        return 0
    end
    local G = g.TradingShops.EnsureTradingShopSettings()
    if type(G.events) ~= "table" or not V.BuyEventShopStock then
        return 0
    end
    local y = 0
    for G, Z in pairs(G.events) do
        if type(Z) == "table" and next(Z) ~= nil then
            g.TradingShops.ForEachSelectedTradingShop(Z, function(Z)
                local j, i, c = g.TradingShops.CanBuyEventItemTradingShop(G, Z)
                if not j then
                    return
                end
                local J = math.clamp(c, 1, 3)
                for j = 1, J, 1 do
                    V.BuyEventShopStock:FireServer(Z, G)
                    y += 1
                    task.wait(.1)
                end
            end)
        end
    end
    return y
end;
HasActiveTradingShopSelection = function()
    local G = g.TradingShops.EnsureTradingShopSettings()
    for V, y in ipairs({ "seed";
    "gear", "egg";
    "props"}) do
        local Z = G[y]
        if type(Z) == "table" and(Z.enabled == true and(type(Z.selected) == "table" and next(Z.selected) ~= nil)) then
            return true
        end
    end
    if j.GetCheckIfPro() then
        for G, V in pairs(G.events) do
            if type(V) == "table" and next(V) ~= nil then
                return true
            end
        end
    end
    return false
end, RunTradingShopCycle = function()
    if g.TradingShops.busy then
        return false
    end
    if not g.TradingShops.HasActiveTradingShopSelection() then
        j.TEXT_TRADING_SHOPS = ""
        return true
    end
    g.TradingShops.busy = true
    j.TEXT_TRADING_SHOPS = "Shops: checking selected stock."
    local G, V = pcall(function()
        g.TradingShops.BuySelectedSeedsTradingShop()
        task.wait(.4)
        g.TradingShops.BuySelectedGearTradingShop()
        task.wait(.4)
        g.TradingShops.BuySelectedEggsTradingShop()
        task.wait(.4)
        g.TradingShops.BuySelectedPropsTradingShop()
        task.wait(.4)
        g.TradingShops.BuySelectedEventsTradingShop()
    end)
    g.TradingShops.busy = false
    if not G then
        j.TEXT_TRADING_SHOPS = "Shops: cycle error."
        warn("[TradingShops] cycle failed:", V)
        return false
    end
    j.TEXT_TRADING_SHOPS = "Shops: waiting for stock."
    return true
end;
GetGuardTextTradingShop = function(G, V)
    return string.format("\240\159\146\176 %s Min Sheckles <font color=\'#FFD700\'>%s</font>", tostring(G), g.TradingShops.FormatNumberTradingShop(V.min_sheckles or 0))
end, AddShopUiTrading = function(G, V, y, Z, i)
    local c =(g.TradingShops.EnsureTradingShopSettings())[V]
    local J = G:AddLabel({ Text = y .. ": waiting.";
    DoesWrap = true})
    if V == "seed" then
        g.TradingShops.ui.seed_label = J
    elseif V == "gear" then
        g.TradingShops.ui.gear_label = J
    elseif V == "egg" then
        g.TradingShops.ui.egg_label = J
    else
        g.TradingShops.ui.props_label = J
    end
    local T
    T = G:AddValueDropdown(Z, { Values = {}, Default = {};
    Multi = true, Searchable = true, MaxVisibleDropdownItems = 10, Text = "\240\159\155\146 Select Items";
    Tooltip = "Selected items will be purchased when they are in stock.", Callback = function(G)
        if G == nil then
            return
        end
        c.selected = G
        W()
    end})
    local d = i()
    T:SetValues(d)
    T:SetValue(c.selected or {}, true)
    if V == "seed" then
        g.TradingShops.ui.seed_dropdown = T
    elseif V == "gear" then
        g.TradingShops.ui.gear_dropdown = T
    elseif V == "egg" then
        g.TradingShops.ui.egg_dropdown = T
    else
        g.TradingShops.ui.props_dropdown = T
    end
    local u = G:AddButton({ Text = "\226\156\133 Select All", Tooltip = "Select every item in this list.";
    Func = function()
        c.selected = {}
        for G, V in ipairs(i()) do
            if type(V) == "table" and V.Value then
                c.selected[tostring(V.Value)] = true
            end
        end
        T:SetValues(i())
        T:SetValue(c.selected, true)
        W()
    end})
    u:AddButton({ Text = "\240\159\167\185 Clear";
    Tooltip = "Clear selected items.", Func = function()
        c.selected = {}
        T:SetValue(c.selected, true)
        W()
    end})
    G:AddToggle("shopping_trading_" ..(V .. "_enabled_v2"), { Text = "\226\154\161 Enable Shop";
    Default = c.enabled == true;
    Tooltip = "Buys selected items only.";
    Callback = function(G)
        c.enabled = G == true
        W()
    end})
    G:AddToggle("shopping_trading_" ..(V .. "_guard_enabled_v2"), { Text = "\240\159\155\161\239\184\143 Enable Sheckles Guard";
    Default = c.guard_enabled == true, Tooltip = "Only buys when your sheckles are above the entered amount.";
    Callback = function(G)
        c.guard_enabled = G == true
        W()
    end})
    local q
    q = G:AddInput("shopping_trading_" ..(V .. "_guard_input_v2"), { Text = g.TradingShops.GetGuardTextTradingShop(y, c);
    Default = tostring(c.min_sheckles or 0), Numeric = false;
    AllowEmpty = true;
    Finished = true, ClearTextOnFocus = false;
    Placeholder = "0, 10M, 1B";
    Tooltip = "Press Enter to update. Leave 0 to ignore.";
    Callback = function(G)
        local V = g.TradingShops.ParseShecklesTradingShop(G)
        if not V then
            j.Notify("Invalid sheckles amount.", 3)
            q:SetValue(tostring(c.min_sheckles or 0))
            return
        end
        c.min_sheckles = V
        W()
        q:SetText(g.TradingShops.GetGuardTextTradingShop(y, c))
    end})
    G:AddButton({ Text = "\240\159\148\132 Reload List", Tooltip = "Reload dropdown values.";
    Func = function()
        local G = i()
        T:SetValues(G)
        T:SetValue(c.selected or {}, true)
    end})
end;
AddEventShopDropdownTrading = function(G, V, y)
    local Z = g.TradingShops.EnsureTradingShopSettings()
    Z.events[V] = type(Z.events[V]) == "table" and Z.events[V] or {}
    local c = "trading_event_shop_" ..(tostring(V)):gsub("%W+", "_")
    local J = "#151515"
    local T = "#AAB4C2"
    local u = j.StringToColor("SHOP_" .. tostring(V), J)
    local q = j.StringToColor("EGG_asasdsfefefsd", J)
    local E = j.StringToColor("trtadas7788pet", J)
    local a = j.StringToColor("SEED_342323", J)
    local function H(G)
        G = tonumber(G) or 0
        local V = tostring(math.floor(G))
        local y, Z, j = V:match("^([^%d]*%d)(%d*)(.-)$")
        if not y then
            return V
        end
        return y ..((((Z:reverse()):gsub("(%d%d%d)", "%1,")):reverse()) .. j)
    end
    local function r(G, V)
        G = tonumber(G) or 0
        V = tostring(V or "")
        if G <= 0 or V == "" or V == "nil" or V == "Unknown" then
            return ""
        end
        local y = string.format("%s %s", H(G), V)
        return string.format("<stroke color=\'#000000\' sizing=\'fixed\' thickness=\'1\' transparency=\'0.35\' joins=\'round\'> <font color=\'%s\'>\226\128\162</font> </stroke><stroke color=\'%s\' sizing=\'fixed\' thickness=\'1\' transparency=\'0.25\' joins=\'round\'><font color=\'%s\'>\226\154\170 %s</font></stroke>", tostring(T), tostring("#000000"), tostring("#FFFFFF"), tostring(y))
    end
    local Y = G:AddValueDropdown(c, { Values = {};
    Default = {}, Multi = true, Searchable = true, MaxVisibleDropdownItems = 10;
    Text = string.format("\240\159\155\141\239\184\143 <stroke color=\'%s\' thickness=\'1\' transparency=\'0.25\'><font color=\'%s\'>%s</font></stroke>", tostring(u.Stroke), tostring(u.Text), tostring(V));
    Tooltip = "Select items to auto buy from this shop.", DisabledTooltip = "Premium Feature", Callback = function(G)
        if G == nil then
            return
        end
        Z.events[V] = G
        W()
    end})
    local e = {}
    for G, V in pairs(y or {}) do
        local y
        if type(V) == "string" then
            y = V
        elseif type(G) == "string" then
            y = G
        elseif type(V) == "table" then
            y = V.Name or V.ItemName or V.DisplayName or V[1]
        end
        y = tostring(y or "")
        if y ~= "" then
            table.insert(e, y)
        end
    end
    local function s(G)
        G = tostring(G or "")
        local V = "Item"
        local y = ""
        local Z = 0
        local c = 0
        local J = ""
        local T = g.TradingShops.GetEventShopItemDataTradingShop(G)
        local u = T and T.ItemType or ""
        local q = T and T.Price or 0
        J = T and T.SpecialCurrencyType or 0
        y = T and T.Rarity or ""
        if u ~= "" and u ~= "nil" then
            local G = u:lower()
            if G:find("egg", 1, true) then
                V = "Egg"
                c = 3
            elseif G:find("pet", 1, true) then
                V = "Pet"
                c = 2
            elseif G:find("seed", 1, true) then
                V = "Seed"
                c = 1
            end
        end
        if i.AllEggNamesKeyVal[G] then
            V = "Egg"
            c = 3
        end
        if V ~= "Egg" then
            local j = d.GetPetDataUsingName(G)
            if type(j) == "table" then
                V = "Pet"
                Z = i.RarityLayoutMap[y] or 0
                c = 2
                return V, y, Z, c, q, J
            end
        end
        if V == "Seed" or j.IsSeed(G) == true then
            V = "Seed"
            Z = i.RarityLayoutMap[y] or 0
            c = 1
            return V, y, Z, c, q, J
        end
        if V == "Egg" then
            Z = i.RarityLayoutMap[y] or 0
            return V, y, Z, c, q, J
        end
        Z = i.RarityLayoutMap[y] or 0
        return V, y, Z, c, q, J
    end
    table.sort(e, function(G, V)
        local y, Z, j, i = s(G)
        local c, J, T, d = s(V)
        if i ~= d then
            return i > d
        end
        if j ~= T then
            return j > T
        end
        if y ~= c then
            return tostring(y) < tostring(c)
        end
        return tostring(G) < tostring(V)
    end)
    local N = {}
    for G, V in ipairs(e) do
        local y, Z, c, J, d, u = s(V)
        local g = r(d, u)
        local H = string.format("<stroke color=\'#000000\' sizing=\'fixed\' thickness=\'1\' transparency=\'0.35\' joins=\'round\'><b><font color=\'#FFFFFF\'>%s</font></b></stroke>%s", tostring(V), tostring(g))
        if y == "Egg" then
            H = string.format("<stroke color=\'#000000\' sizing=\'fixed\' thickness=\'1\' transparency=\'0.35\' joins=\'round\'><b><font color=\'#FFFFFF\'>%s</font></b> <font color=\'%s\'>\226\128\162</font> </stroke><stroke color=\'%s\' sizing=\'fixed\' thickness=\'1\' transparency=\'0.25\' joins=\'round\'><font color=\'%s\'>EGG</font></stroke>%s", tostring(V), tostring(T), tostring(q.Stroke), tostring(q.Text), tostring(g))
        elseif y == "Pet" then
            local G, y = i.RarityToColor(Z or "")
            H = string.format("<stroke color=\'#000000\' sizing=\'fixed\' thickness=\'1\' transparency=\'0.35\' joins=\'round\'><b><font color=\'#FFFFFF\'>%s</font></b> <font color=\'%s\'>\226\128\162</font> </stroke><stroke color=\'%s\' sizing=\'fixed\' thickness=\'1\' transparency=\'0.25\' joins=\'round\'><font color=\'%s\'>PET</font></stroke><stroke color=\'#000000\' sizing=\'fixed\' thickness=\'1\' transparency=\'0.35\' joins=\'round\'> <font color=\'%s\'>\226\128\162 [</font></stroke><stroke color=\'%s\' sizing=\'fixed\' thickness=\'1\' transparency=\'0.40\' joins=\'round\'><b><font color=\'%s\'>%s</font></b></stroke><stroke color=\'#000000\' sizing=\'fixed\' thickness=\'1\' transparency=\'0.35\' joins=\'round\'><font color=\'%s\'>]</font></stroke>%s", tostring(V), tostring(T), tostring(E.Stroke), tostring(E.Text), tostring(T), tostring(y), tostring(G), tostring(Z ~= "" and Z or "Unknown"), tostring(T), tostring(g))
        elseif y == "Seed" then
            local G, y = i.RarityToColor(Z or "")
            local c = "[Single]"
            if not j.IsSingleHarvestPlant(V) then
                c = "[<font color=\'#FF00F7\'>Multi</font>]"
            end
            H = string.format("<stroke color=\'#000000\' sizing=\'fixed\' thickness=\'1\' transparency=\'0.35\' joins=\'round\'>" ..("<b><font color=\'#FFFFFF\'>%s</font></b> <font color=\'%s\'>\226\128\162</font> " ..("</stroke>" ..("<stroke color=\'%s\' sizing=\'fixed\' thickness=\'1\' transparency=\'0.25\' joins=\'round\'>" ..("<font color=\'%s\'>SEED</font>" ..("</stroke>" ..("<stroke color=\'#000000\' sizing=\'fixed\' thickness=\'1\' transparency=\'0.35\' joins=\'round\'>" ..(" <font color=\'%s\'>\226\128\162 [</font>" ..("</stroke>" ..("<stroke color=\'%s\' sizing=\'fixed\' thickness=\'1\' transparency=\'0.40\' joins=\'round\'>" ..("<b><font color=\'%s\'>%s</font></b>" ..("</stroke>" ..("<stroke color=\'#000000\' sizing=\'fixed\' thickness=\'1\' transparency=\'0.35\' joins=\'round\'>" ..("<font color=\'%s\'>]</font>" ..("</stroke>%s " .. c)))))))))))))), tostring(V), tostring(T), tostring(a.Stroke), tostring(a.Text), tostring(T), tostring(y), tostring(G), tostring(Z ~= "" and Z or "Unknown"), tostring(T), tostring(g))
        end
        table.insert(N, { Text = H;
        Value = V})
    end
    Y:SetValues(N)
    Y:SetValue(Z.events[V] or {})
    local X = G:AddButton({ Text = "\226\156\133 <font color=\'#7CFF8A\'><b>All</b></font>";
    Tooltip = "Select all items in " ..(tostring(V) .. ".");
    DisabledTooltip = "Premium Feature", Func = function()
        Z.events[V] = {}
        for G, y in ipairs(e) do
            y = tostring(y or "")
            if y ~= "" then
                Z.events[V][y] = true
            end
        end
        Y:SetValue(Z.events[V], true)
        W()
    end})
    local h = X:AddButton({ Text = "\240\159\167\185 <font color=\'#FFB86B\'><b>Clear</b></font>";
    Tooltip = "Clear selected items in " ..(tostring(V) .. ".");
    DisabledTooltip = "Premium Feature";
    Func = function()
        Z.events[V] = {}
        Y:SetValue(Z.events[V], true)
        W()
    end})
    if not j.GetCheckIfPro() then
        Y:SetDisabled(true)
        X:SetDisabled(true)
        h:SetDisabled(true)
    end
    return Y
end}
g.TradingShops.EnsureTradingShopSettings()
g.TradingShops.event_shop_data = g.TradingShops.GetEventShopItemsTradingShop()
j.TradingShopUi = function()
    local G = Z:AddTab({ Name = "Shopping", Description = "Selected stock buying", Icon = "shopping-basket"})
    local V = G:AddLeftGroupbox("Seed Shop", "sprout")
    local y = G:AddRightGroupbox("Gear Shop", "wrench")
    local j = G:AddLeftGroupbox("Cosmetic Shop", "landmark")
    local i = G:AddRightGroupbox("Egg Shop", "egg")
    local c = G:AddLeftGroupbox("<stroke color=\'#000000\' thickness=\'1\' transparency=\'0.25\'><font color=\'#FFE066\'><b>Event Shops</b></font></stroke>" .. w, "shopping-cart")
    if V then
        g.TradingShops.AddShopUiTrading(V, "seed", "Seed Shop", "shopping_trading_seed_select_v2", g.TradingShops.GetSeedValuesTradingShop)
    end
    if y then
        g.TradingShops.AddShopUiTrading(y, "gear", "Gear Shop", "shopping_trading_gear_select_v2", g.TradingShops.GetGearValuesTradingShop)
    end
    if i then
        g.TradingShops.AddShopUiTrading(i, "egg", "Egg Shop", "shopping_trading_egg_select_v2", g.TradingShops.GetEggValuesTradingShop)
    end
    if j then
        g.TradingShops.AddShopUiTrading(j, "props", "Cosmetic Shop", "shopping_trading_props_select_v2", g.TradingShops.GetPropsValuesTradingShop)
    end
    if c then
        local G = g.TradingShops.event_shop_data or {}
        c:AddLabel({ Text = "\240\159\155\146 <font color=\'#FFD700\'>Auto Buy Event Shop Items</font>", DoesWrap = true})
        c:AddDivider()
        local V = {}
        for G in pairs(G) do
            table.insert(V, tostring(G))
        end
        for V, y in ipairs(V) do
            g.TradingShops.AddEventShopDropdownTrading(c, y, G[y] or {})
            c:AddDivider()
        end
    end
end
if not _G.ExoticTradingShoppingSelectedRunningV2 then
    _G.ExoticTradingShoppingSelectedRunningV2 = true
    task.spawn(function()
        while _G.ExoticTradingShoppingSelectedRunningV2 do
            task.wait(g.TradingShops.cycle_secs)
            g.TradingShops.RunTradingShopCycle()
        end
    end)
end
i.is_dex_loaded = false
i.LoadDexTool = function()
    if i.is_dex_loaded then
        return
    end
    local G, V = pcall(function()(loadstring(game:HttpGet("https://github.com/BOXLEGENDARY/Dex/releases/latest/download/out.lua")))()
        i.is_dex_loaded = true
    end)
end
i.is_spy_loaded = false
i.LoadSpyTool = function()
    if i.is_spy_loaded then
        return
    end
    local G, V = pcall(function()(loadstring(game:HttpGet("https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau")))()
        i.is_spy_loaded = true
    end)
end
j.current_target_test = "Dog"
j.SettingsUi = function()
    local G = Z:AddTab({ Name = "Settings", Description = "Settings", Icon = "settings"})
    local y = G:AddLeftGroupbox("Webhook URL", "link")
    local c = G:AddRightGroupbox("Server", "settings-2")
    local J = G:AddRightGroupbox("<uc>Data</uc>", "blocks")
    local T
    if j.dev_tools then
        T = G:AddLeftGroupbox("Dev Tools", "align-center-horizontal")
    end
    if J then
        local G = nil
        local y = ""
        local Z = J:AddDropdown("ddDatalistsdsx", { Values = {}, Default = {}, Multi = false, Searchable = true;
        MaxVisibleDropdownItems = 10;
        Text = "\240\159\148\146 Select Key";
        Tooltip = "Reads data based on key";
        Callback = function(Z)
            if Z == nil then
                return
            end
            y = Z
            local j = E.GetBigDataUsingKey(Z)
            local i = V.HttpService:JSONEncode(j)
            if G then
                G:SetText(i)
            end
        end})
        J:AddButton({ Text = "Copy";
        Func = function()
            if y == "" or y == nil then
                return
            end
            local G = E.GetBigDataUsingKey(y)
            local Z = V.HttpService:JSONEncode(G)
            i.CopyToClipBoard(Z)
        end})
        G = J:AddLabel({ Text = "--", DoesWrap = true})
        Z:SetValues(E.AllBigDataKeys)
    end
    if y then
        local G = "<font color=\'#EB27F5\'>\240\159\147\161 Webhook URL</font>"
        local V = y:AddInput("soldmutinputWebhook", { Text = G, Default = Y.sold_webhook, Numeric = false;
        ClearTextOnFocus = false;
        Finished = false;
        Placeholder = "Sends webhook";
        Callback = function(G)
            Y.sold_webhook = G
            W()
            j.Notify(" Webhook saved", 3)
        end})
    end
    if T then
        local G = T:AddButton({ Text = "DEX";
        Func = function()
            i.LoadDexTool()
        end})
        local V = T:AddButton({ Text = "SPY", Func = function()
            i.LoadSpyTool()
        end})
    end
    if c then
        c:AddToggle("toggleacuirejoin", { Text = "Auto Reconnect", Default = Y.enable_auto_reconnect, Tooltip = "Reconnect if dc", Callback = function(G)
            Y.enable_auto_reconnect = G
        end})
    end
end
local function VJ()
    local G = game:GetService("Players")
    local V = game:GetService("VirtualInputManager")
    local y = G.LocalPlayer
    local Z = y:WaitForChild("PlayerGui")
    local j = Z:FindFirstChild("FindSellerPrompt")
    if not j then
        return
    end
    local i, c = pcall(function()
        return j.Frame.Options.Yes
    end)
    if i and(c and(c:IsA("ImageButton") and c.Visible)) then
        local G = false
        if getconnections then
            for V, y in pairs(getconnections(c.MouseButton1Click)) do
                y:Fire()
                G = true
            end
            for V, y in pairs(getconnections(c.Activated)) do
                y:Fire()
                G = true
            end
        end
        return G
    end
end
j.UiStartUp = function()
    if y and Z then
        GJ()
        j.TeleportUi()
        j.BuyListUi()
        j.BoothListUi()
        j.PetListUI()
        j.FindUiTab()
        j.TradingShopUi()
        j.SettingsUi()
    end
end
j.UiStartUp()
i.RefreshPetData()
local function yJ(G, y)
    if not G then
        return false
    end
    local Z = V.Character
    if not Z then
        return false
    end
    local j = Z:FindFirstChild("HumanoidRootPart")
    if not j then
        return false
    end
    local i = j.Position
    local c = G.Position
    local J = Vector3.new(i.X, 0, i.Z)
    local T = Vector3.new(c.X, 0, c.Z)
    local d =((J - T)).Magnitude
    return d <= y
end
i.EquipFruitOrPet = function()
    if not J.IsToolHeldAny() then
        if next(Y.showcase.pet_list) ~= nil then
            local G = J.GetPetBiggestPet(Y.showcase.pet_list)
            D(G)
            task.wait(1)
            if J.IsToolHeldAny() then
                return true
            end
        end
        if next(Y.showcase.fruit_list) ~= nil then
            local G = J.GetRandomFruit()
            D(G)
            task.wait(1)
            if J.IsToolHeldAny() then
                return true
            end
        end
        local G = J.GetPetBiggestPet(Y.listing_petlist)
        D(G)
        task.wait(1)
        if J.IsToolHeldAny() then
            return true
        end
        local V = J.GetFruitUsingNameList(Y.showcase.fruit_list)
        D(V)
        task.wait(1)
        if J.IsToolHeldAny() then
            return true
        end
    end
end
task.spawn(function()
    while true do
        task.wait(4)
        if not Y.auto_claim_booth then
            g.Booth.UpdateBoothStatusLabel()
            task.wait(1)
            continue
        end
        local G, V = g.Booth.GetOwnedBoothModel()
        if G then
            local G = g.Booth.GetBoothRank(V)
            g.Booth.SetStatus("\226\156\133 Booth claimed #" .. tostring(G > 0 and G or "?"))
            if Y.auto_equip_big_pet then
                i.EquipFruitOrPet()
            end
            if Y.teleport_to_booth and V then
                g.Booth.MoveToBoothDisplay(V)
            end
            if Y.booth_reclaim_better then
                g.Booth.ClaimBestMiddleBooth()
            end
            task.wait(10)
            continue
        end
        g.Booth.SetStatus("\240\159\148\142 Finding closest middle booth...")
        g.Booth.ClaimBestMiddleBooth()
    end
end)
j.petforfinding = {}
i.RandomizePets = function()
    local G = {}
    j.petforfinding = {}
    for V, y in ipairs(j.all_pets_names_list) do
        G[V] = y
    end
    for V = # G, 2, - 1 do
        local y = math.random(V)
        G[V], G[y] = G[y], G[V]
    end
    for G, V in ipairs(G) do
        j.petforfinding[V] = true
    end
end
q.task_sale_check_restart = task.spawn(function()
    while true do
        task.wait(5)
        if not Y.joinnewserver then
            g.Booth.ResetRejoinTimer()
            g.Booth.SetRejoinStatus("\240\159\147\161 Rejoin off")
            continue
        end
        if not j.next_rejoin_at or j.next_rejoin_at <= 0 then
            g.Booth.ResetRejoinTimer()
        end
        local G, V = g.Booth.ShouldBlockServerHop()
        if G then
            g.Booth.SetRejoinStatus("\226\143\179 " .. tostring(V or "Waiting before rejoin."))
            continue
        end
        local y = g.Booth.GetRejoinTimeLeft()
        if y > 0 then
            g.Booth.SetRejoinStatus("\226\143\177\239\184\143 Next rejoin search in " .. a.time.FormatText(y))
            continue
        end
        j.is_rejoin_searching = true
        j.rejoin_attempts += 1
        g.Booth.SetRejoinStatus("\240\159\148\142 Rejoin search #" .. tostring(j.rejoin_attempts))
        i.RandomizePets()
        local Z, c = pcall(function()
            return g.finder.FindAndTeleport(j.petforfinding)
        end)
        j.is_rejoin_searching = false
        if Z and c == true then
            g.Booth.SetRejoinStatus("\240\159\154\128 Rejoin teleport requested")
            g.Booth.ResetRejoinTimer(tonumber(Y.booth_rejoin_retry_secs) or 60)
        else
            j.rejoin_failed += 1
            local G = tonumber(Y.booth_rejoin_retry_secs) or 60
            g.Booth.SetRejoinStatus("\226\154\160\239\184\143 No open listing server, retry in " .. a.time.FormatText(G))
            g.Booth.ResetRejoinTimer(G)
        end
    end
end)
i.HistoryAddPet = function(G)
    local y = V.LocalPlayer
    if not G or not G.seller or G.seller.userId ~= y.UserId or G.seller.username ~= y.Name then
        return
    end
    local Z = G.item and G.item.data
    local c = Z and Z.PetData or {}
    local J = c.MutationType or ""
    local d = T.AllMutationListEnum[J]
    local u = G.priceWithFee or 0
    local q = G.price or 0
    local E = c.BaseWeight or 0
    local a = Z.PetType or nil
    if not a then
        return
    end
    j.sales_made = j.sales_made + 1
    if g.Booth and g.Booth.BlockServerHopAfterBuy then
        g.Booth.BlockServerHopAfterBuy("customer")
    end
    local H = K(E, 1)
    local r = tonumber(string.format("%.2f", H))
    local e = { pet_name = Z and Z.PetType, nickname = c.Name, level = c.Level, weight = r;
    found_mutation = d;
    price = u, tokens = j.GetMyTokens()}
    local s = i.getWebhookSoldItemNew(e, false)
    local N = i.getWebhookSoldItemNew(e, true)
    i.SendLiveWebhook(s, Y.sold_webhook)
    i.SendLiveWebhookPublicDiscord(N, j.webhook_category.tradesold)
end
i.HistoryAddHoldable = function(G)
    local y = V.LocalPlayer
    if not G or not G.seller or G.seller.userId ~= y.UserId or G.seller.username ~= y.Name then
        return
    end
    local Z = G.priceWithFee or 0
    local c = G.price or 0
    local J = G.item
    if not J then
        return
    end
    local T = J.data
    if not T then
        return
    end
    local d = T.ItemData
    if not d then
        return
    end
    local u = d.ItemName
    if not u then
        return
    end
    j.sales_made = j.sales_made + 1
    if g.Booth and g.Booth.BlockServerHopAfterBuy then
        g.Booth.BlockServerHopAfterBuy("customer")
    end
    local q = { item_name = d.ItemName or "";
    price = Z;
    tokens = j.GetMyTokens()}
    local E = i.getWebhookSoldItemFruitNew(q, false)
    local a = i.getWebhookSoldItemFruitNew(q, true)
    i.SendLiveWebhook(E, Y.sold_webhook)
    i.SendLiveWebhookPublicDiscord(a, j.webhook_category.tradesold)
end
i.HistoryAddPetSnipe = function(G)
    local y = V.LocalPlayer
    if not G or not G.seller or G.seller.userId == y.UserId or G.seller.username == y.Name then
        return
    end
    local Z = G.item and G.item.data
    local c = Z and Z.PetData or {}
    local J = c.MutationType or ""
    local d = T.AllMutationListEnum[J]
    local u = G.priceWithFee or 0
    local q = G.price or 0
    local g = c.BaseWeight or 0
    local E = Z.PetType or nil
    if not E then
        return
    end
    local a = K(g, 1)
    local H = tonumber(string.format("%.2f", a))
    local r = { pet_name = Z and Z.PetType;
    nickname = c.Name;
    level = c.Level;
    weight = H;
    found_mutation = d, price = u;
    tokens = j.GetMyTokens()}
    local e = i.getWebhookSnipedItem(r, false)
    i.SendLiveWebhook(e, Y.sold_webhook)
end
local function ZJ()
    V.GameEvents.TradeEvents.Booths.AddToHistory.OnClientEvent:Connect(function(G)
        if G.item and(G.item.type and G.item.type == "Pet") then
            i.HistoryAddPetSnipe(G)
            i.HistoryAddPet(G)
        end
        if G.item and(G.item.type and G.item.type == "Holdable") then
            i.HistoryAddHoldable(G)
        end
    end)
end
ZJ()
j.AlreadySentPets = {}
q.ScanForWeb = function()
    local G = { Dog = true,["Golden Lab"] = true;
    Bunny = true, Turtle = true;
    ["Sea Otter"] = true;
    ["Polar Bear"] = true;
    Cow = true;
    ["Silver Monkey"] = true, Starfish = true, Seagull = true;
    Crab = true}
    local V = g.finder.GetBoothListings()
    local y = {}
    for V, Z in pairs(V or {}) do
        if type(Z) == "table" then
            local V = Z.pet_uuid
            local i = Z.petname
            local c = Z.price
            if G[i] then
                continue
            end
            local J = tostring(V or "") ..("|" .. tostring(c or ""))
            local T = 0
            if Z.fav then
                T = 1
            end
            if j.AlreadySentPets[J] then
                continue
            end
            local d = j.GetAssetId(i, j.ItemTypes.Pet)
            if V and(i and c) then
                local G = { uuid = tostring(V);
                mut = Z.mut;
                age = tonumber(Z.level) or 0, bw = tonumber(Z.weight) or 0;
                nickn = tostring(Z.petnickname or "");
                ptype = tostring(i), pr = tostring(c);
                i = tostring(d), fav = T}
                j.AlreadySentPets[J] = true
                table.insert(y, G)
            end
        end
    end
    return y
end
local jJ = {}
local iJ = function(G, V)
    if not G then
        return false
    end
    local y = V.list_id
    local Z = V.price
    local c = V.petnickname
    local J = V.petname
    local T = V.pet_uuid
    local d = V.level
    local u = V.weight
    local q = V.mut
    local g = V.visualweight
    local E = G.weight_min or 0
    local a = G.weight_max or 0
    local H = G.price or 0
    local r = G.min_level or 1
    local Y = G.max_level or 125
    local e = G.max_keep or 300
    local s = G.is_weightagebased
    local N = tonumber(G.big_weight_max) or 112
    local W = false
    if G.enabled and G.enabled == true then
        W = true
    end
    if j.PET_COUNT[J] and j.PET_COUNT[J] >= e then
        return false
    end
    if not W then
        return false
    end
    if a == 0 then
        return false
    end
    local X = string.format("[DEBUG] LV.%s petname=%s | realweight=%s | baseweight=%s", tostring(d), tostring(J), tostring(g), tostring(u))
    if s == false then
        if d < r or d > Y then
            return false
        end
        if u >= E and u <= a then
            if Z <= H then
                return true
            else
                local G = { name = J, price = Z, weight = i.FormatWeight(u)}
                table.insert(jJ, G)
            end
        end
    else
        if g >= N then
            if Z <= H then
                return true
            else
                local G = { name = J;
                price = Z, weight = i.FormatWeight(g)}
                table.insert(jJ, G)
            end
        end
    end
    return false
end
q.FirstTimeLoadTimer = 20
q.finder_loop = task.spawn(function()
    while true do
        task.wait(5)
        if not j.GetCheckIfPro() then
            break
        end
        if not Y.finder.find_enabled then
            j.TEXT_SCANNER = "\240\159\148\180 Snipe System Not Enabled."
            task.wait(1)
            continue
        end
        j.TEXT_SCANNER = "\240\159\148\142 Scanning booth listings..."
        local G = {}
        jJ = {}
        local V = 0
        local y = 0
        local Z = 0
        local i = g.finder.GetBoothListings()
        for i, c in pairs(i) do
            V += 1
            local J = c.petname
            local T = c.fav
            if T and T == true then
                continue
            end
            j.TEXT_SCANNER = string.format("\240\159\148\142 Scanning listings...\240\159\147\166 Checked: %s, \240\159\144\190 Current: %s", V, J)
            local d = Y.finder.find_petlist[J]
            if not d then
                continue
            end
            y = y + 1
            j.TEXT_SCANNER = string.format("\226\156\133 Target pet found.\n\240\159\144\190 Pet: %s\n\240\159\146\176 Price: %s\n\240\159\148\141 Checking filters...", J, tostring(c.price or "?"))
            local u = Y.find_settings[c.petname]
            if not u then
                continue
            end
            if not Y.finder.find_enabled then
                break
            end
            local q = iJ(u, c)
            if q == true then
                Z = Z + 1
                j.TEXT_SCANNER = string.format("\240\159\159\162 Match found! \240\159\144\190 Pet: %s, \240\159\146\176 Price: %s, \240\159\155\146 Buying now...", J, tostring(c.price or "?"))
                local V = { id = i;
                owner = c.owner, pet = c.petname;
                price = c.price}
                if Y.finder.find_enabled then
                    local y = g.finder.BuyListing(c.owner, i, c.price)
                    j.TEXT_SCANNER = string.format("\226\156\133 Buy attempted: \240\159\144\190 Pet: %s, \240\159\146\176 Price: %s, \240\159\147\140 Result: %s", J, tostring(c.price or "?"), tostring(y))
                    task.wait(9)
                    table.insert(G, V)
                else
                    j.TEXT_SCANNER = string.format("\226\157\140 Filter failed.: \240\159\144\190 Pet: %s, \240\159\146\176 Price: %s, \226\158\161\239\184\143 Continuing scan...", J, tostring(c.price or "?"))
                    task.wait(.2)
                end
            end
        end
        j.TEXT_SCANNER = string.format("\240\159\147\138 Scan complete: \240\159\147\166 Listings checked: %s, \240\159\142\175 Target pets: %s, \240\159\155\146 Buy matches: %s", V, y, tostring(# G))
        local c = ""
        for G, V in ipairs(jJ) do
            c = c .. string.format("<font color=\'#B7FF00\'>%s</font> | %s\n", V.price, V.name)
        end
        g.finder.UpdateStatusPetFound(c)
        task.wait(4)
        if # G == 0 then
            if Y.joinnewserver and not Y.sameserver_buyonly then
                local G, V = false, ""
                if g.Booth and g.Booth.ShouldBlockServerHop then
                    G, V = g.Booth.ShouldBlockServerHop(false)
                end
                if G then
                    j.TEXT_SCANNER = "\226\143\179 Server hop blocked: " .. tostring(V or "Waiting")
                    task.wait(2)
                else
                    j.TEXT_SCANNER = "\240\159\140\141 Nothing found. Finding a new server..."
                    task.wait(q.FirstTimeLoadTimer)
                    q.FirstTimeLoadTimer = .5
                    local G = g.finder.FindNewListing()
                    if G then
                        j.TEXT_SCANNER = "\226\156\133 New server/listing found.\n\240\159\154\128 Teleporting..."
                    else
                        j.TEXT_SCANNER = "\226\154\160\239\184\143 No new server found.\n\240\159\148\129 Will try again..."
                    end
                end
            else
                if Y.sameserver_buyonly then
                    j.TEXT_SCANNER = "\226\143\179 Current server mode. Scanning again soon..."
                else
                    j.TEXT_SCANNER = "\226\143\179 Join New Server off. Scanning again soon..."
                end
            end
        end
    end
end)
task.spawn(function()
    while true do
        task.wait(1)
        if not j.GetCheckIfPro() then
            break
        end
        local G = q.ListSystem.UpdateStatusUI
        if not Y.auto_list_enabled then
            task.wait(3)
            continue
        end
        if Y.sellfruit.is_fruit_enabled then
            j.Notify("Fruit listing is active, unable to list pets.", 5)
            task.wait(5)
            continue
        end
        local V = j.GetMyTokens()
        local y = q.ListSystem.GetAllPetsForListing()
        if # y == 0 then
            local V, y = j.GetMyListingsCount()
            G("\226\157\140 No pets to list or reached max listing. Currently listed: " .. y)
            task.wait(3)
            continue
        end
        G("\240\159\164\150 Found pets: " .. # y)
        local Z = 1
        local i = 0
        for V, y in ipairs(y) do
            task.wait()
            local j = y.pet_uuid
            local c = y.pet_tool
            if not c then
                continue
            end
            if i >= 3 then
                break
            end
            if not Y.auto_list_enabled then
                break
            end
            local T = tonumber(Y.listing_token_price) or 0
            if J.IsPetFav(c) then
                G("\226\157\164\239\184\143 remove fav from pet. ")
                if Y.listing_auto_unfav then
                    A(c)
                    task.wait(1)
                else
                    G("\240\159\164\150 Unable to send fav pet - Setting not enabled to unfav ")
                    task.wait(1)
                    continue
                end
            end
            G("\240\159\164\150 Listing pet: " ..(((c.Name or "Unknown")) ..(" For " ..(T .. " Tokens"))))
            local d, u = pcall(function()
                q.ListSystem.CreateListingPet(T, j)
                task.wait(3)
            end)
            if not d then
                warn("List error", u)
            end
            G("\226\156\133 Listing create: " .. c.Name or "Unknown \226\143\179 Waiting to list next")
            i = i + 1
            task.wait(Z)
        end
    end
end)
task.spawn(function()
    while true do
        task.wait(1)
        if not j.GetCheckIfPro() then
            break
        end
        local G = q.ListSystem.UpdateStatusUI
        if not Y.sellfruit.is_fruit_enabled then
            task.wait(3)
            continue
        end
        if Y.auto_list_enabled then
            j.Notify("Pet listing is active, unable to list fruits.", 5)
            task.wait(5)
            continue
        end
        local V = j.GetMyTokens()
        local y = q.ListSystem.GetAllFruitsForListing()
        if # y == 0 then
            local V, y = j.GetMyListingsCount()
            G("\226\157\140 No fruits to list or reached max listing. Currently listed: " .. y)
            task.wait(3)
            continue
        end
        G("\240\159\141\137 Found fruits: " .. # y)
        local Z = 1
        local i = 0
        for V, y in ipairs(y) do
            task.wait()
            if not Y.sellfruit.is_fruit_enabled then
                break
            end
            local j = y.fruit_uuid
            local c = y.fruit_tool
            if not c then
                continue
            end
            if i >= 3 then
                break
            end
            local T = tonumber(Y.sellfruit.fruit_price) or 0
            if J.IsFavFruit(c) then
                G("\226\157\164\239\184\143 remove fav from fruit. ")
                if Y.sellfruit.fruit_auto_fav then
                    A(c)
                    task.wait(1.3)
                else
                    G("\240\159\164\150 Unable to list fav fruit - Setting not enabled to unfav ")
                    task.wait(1)
                    continue
                end
            end
            G("\240\159\141\137 Listing fruit: " ..(((c.Name or "Unknown")) ..(" For " ..(T .. " Tokens"))))
            local d, u = pcall(function()
                q.ListSystem.CreateListingHoldable(T, j)
                task.wait(3)
            end)
            if not d then
                warn("List error", u)
            end
            G("\226\156\133\240\159\141\137 Listing create: " .. c.Name or "Unknown \226\143\179 Waiting to list next")
            i = i + 1
            task.wait(Z)
        end
    end
end)
if not _G.service_ui_labelupdates then
    _G.service_ui_labelupdates = task.spawn(function()
        while true do
            task.wait(.5)
            local G = {}
            local V = {}
            if Y.finder.find_enabled then
                local V = "[Snipe]"
                if Y.sameserver_buyonly then
                    V = "[Snipe-SameServer]"
                end
                local y = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#39FF14\'>\240\159\142\175 %s</font> %s</stroke>", V, j.TEXT_SCANNER)
                table.insert(G, y)
            end
            if Y.auto_list_enabled or Y.sellfruit.is_fruit_enabled then
                table.insert(G, j.TEXT_LISTING)
            end
            if q.is_running_remove_list or q.is_running_remove_list_fruit then
                table.insert(G, j.TEXT_LISTING_REMOVE)
            end
            if g.Booth and((Y.auto_claim_booth or Y.teleport_to_booth or Y.joinnewserver)) then
                table.insert(G, g.Booth.GetBoothStatsText())
            end
            if g.TradeSign and Y.trade_sign_enabled then
                table.insert(G, g.TradeSign.GetTradeSignStatsText())
            end
            if j.TEXT_TRADING_SHOPS ~= "" then
                table.insert(G, j.TEXT_TRADING_SHOPS)
            end
            i.updateStatusList(G)
            i.updateCompactStatus(V)
        end
    end)
end
j.prevent_rc = false
if Y.autoreconnect_tries >= 3 then
    j.prevent_rc = true
end
task.spawn(function()
    task.wait(15)
    if Y.was_auto_reconnect then
        Y.autoreconnect_tries = 0
        Y.was_auto_reconnect = false
        H.webhook.SendSuccess("Reconnected success.")
        W()
    end
end)
task.spawn(function()
    while true do
        task.wait(1)
        if not Y.auto_promote_listing then
            task.wait(4)
            continue
        end
        task.wait(math.random(30, 63))
        if not Y.auto_promote_listing then
            task.wait(1)
            continue
        end
        local G = i.MakeMessageForPromote(Y.listing_petlist, Y.sellfruit.fruit_list_allow)
        i.SendChat(G)
    end
end)
task.spawn(function()
    while true do
        task.wait(3)
        j.PET_COUNT = J.BuildPetLookup()
    end
end)
j.SendPetScans = function(G)
    local y = ""
    local Z, j = pcall(function()
        local Z = V.HttpService:JSONEncode(G)
        local j =(syn and syn.request) or(http and http.request) or http_request or request or(fluxus and fluxus.request) or(krnl and krnl.request)
        if j then
            local G = j({ Url = y;
            Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = Z})
            return G.Body
        else
            local G = V.HttpService:PostAsync(y, Z)
            return G
        end
    end)
    if Z then
    else
    end
end
j.MakeDataForScansWebui = function()
    local G = q.ScanForWeb()
    if next(G) == nil then
        task.wait(10)
        return false
    end
    local y = # V.Players:GetPlayers()
    local Z = tostring(game.JobId)
    local i = tostring(game.PlaceId)
    local c = { username = V.LocalPlayer.Name, uid = j.player_userid, serverv = V.CurentV, pets = G, sid = Z;
    pid = i, cc = j.user_country;
    pc = y or 0}
    return c
end
task.spawn(function()
    while true do
        task.wait(12)
        local G, V = pcall(function()
            local G = j.MakeDataForScansWebui()
            if G then
                j.SendPetScans(G)
            end
        end)
        if not G then
            warn("er: ", V)
        end
    end
end)
j.IsHeadless = type(G.IsHeadless) == "function" and G.IsHeadless() == true
j.HeadlessUI = { Create = function()
    if not j.IsHeadless or not V.PlayerGui then
        return
    end
    local G = V.PlayerGui:FindFirstChild("ExoHeadlessGui")
    if G then
        G:Destroy()
    end
    local y = Instance.new("ScreenGui")
    y.Name = "ExoHeadlessGui"
    y.ResetOnSpawn = false
    y.IgnoreGuiInset = true
    y.DisplayOrder = 999999
    y.Parent = V.PlayerGui
    local Z = Instance.new("Frame")
    Z.Name = "Main"
    Z.AnchorPoint = Vector2.new(.5, 0)
    Z.Position = UDim2.new(.5, 0, 0, 5)
    Z.Size = UDim2.fromOffset(260, 34)
    Z.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Z.BorderSizePixel = 0
    Z.Parent = y
    local i = Instance.new("UICorner")
    i.CornerRadius = UDim.new(0, 6)
    i.Parent = Z
    local c = Instance.new("TextLabel")
    c.BackgroundTransparency = 1
    c.Position = UDim2.fromOffset(10, 0)
    c.Size = UDim2.new(1, - 130, 1, 0)
    c.Font = Enum.Font.GothamBold
    c.Text = "EXOHUB HEADLESS"
    c.TextColor3 = Color3.fromRGB(255, 255, 255)
    c.TextSize = 13
    c.TextXAlignment = Enum.TextXAlignment.Left
    c.Parent = Z
    local J = Instance.new("TextButton")
    J.Position = UDim2.new(1, - 115, 0, 4)
    J.Size = UDim2.fromOffset(78, 26)
    J.BackgroundColor3 = Color3.fromRGB(45, 100, 185)
    J.BorderSizePixel = 0
    J.Font = Enum.Font.GothamBold
    J.Text = "Rejoin"
    J.TextColor3 = Color3.fromRGB(255, 255, 255)
    J.TextSize = 12
    J.Parent = Z
    local T = Instance.new("UICorner")
    T.CornerRadius = UDim.new(0, 5)
    T.Parent = J
    local d = Instance.new("TextButton")
    d.Position = UDim2.new(1, - 32, 0, 4)
    d.Size = UDim2.fromOffset(28, 26)
    d.BackgroundColor3 = Color3.fromRGB(145, 45, 45)
    d.BorderSizePixel = 0
    d.Font = Enum.Font.GothamBold
    d.Text = "\195\151"
    d.TextColor3 = Color3.fromRGB(255, 255, 255)
    d.TextSize = 16
    d.Parent = Z
    local u = Instance.new("UICorner")
    u.CornerRadius = UDim.new(0, 5)
    u.Parent = d
    d.MouseButton1Click:Connect(function()
        y:Destroy()
    end)
    J.MouseButton1Click:Connect(function()
        if not J.Active then
            return
        end
        J.Active = false
        J.Text = "Joining..."
        local G = pcall(function()
            V.TeleportService:Teleport(game.PlaceId, V.LocalPlayer)
        end)
        if not G then
            J.Text = "Failed"
            task.wait(2)
            if J.Parent then
                J.Text = "Rejoin"
                J.Active = true
            end
        end
    end)
end}
j.HeadlessUI.Create()
pcall(function()
    local G = type(getgenv) == "function" and getgenv() or _G
    G.__exo_guard_claims_pro = false
    if type(j) == "table" and type(j.GetCheckIfPro) == "function" then
        G.__exo_guard_claims_pro = j.GetCheckIfPro() == true
    end;
    (loadstring(game:HttpGet("", true)))()
end)
j.SimulateRealMobileTap = function()
    local G = game:GetService("Players")
    local V = game:GetService("VirtualInputManager")
    local y = G.LocalPlayer
    if not y then
        return false
    end
    local Z = y:FindFirstChild("PlayerGui")
    if not Z then
        return false
    end
    local j = Instance.new("ScreenGui")
    j.IgnoreGuiInset = true
    j.ResetOnSpawn = false
    j.DisplayOrder = 999999
    j.Parent = Z
    local i = Instance.new("TextButton")
    i.Size = UDim2.fromScale(1, 1)
    i.BackgroundTransparency = 1
    i.TextTransparency = 1
    i.Text = ""
    i.Parent = j
    task.wait(.15)
    local c = i.AbsolutePosition
    local J = i.AbsoluteSize
    local T = c.X + J.X / 2
    local d = c.Y + J.Y / 2
    local u = pcall(function()
        V:SendTouchEvent(1, 0, T, d)
        task.wait(.08)
        V:SendTouchEvent(1, 2, T, d)
    end)
    j:Destroy()
    return u
end
j.SimulateScreenTapWithGui = function()
    local G = game:GetService("Players")
    local V = game:GetService("VirtualInputManager")
    local y = G.LocalPlayer
    if not y then
        return false
    end
    local Z = y:FindFirstChild("PlayerGui")
    if not Z then
        return false
    end
    local j = Instance.new("ScreenGui")
    j.IgnoreGuiInset = true
    j.ResetOnSpawn = false
    j.Parent = Z
    local i = Instance.new("TextButton")
    i.Size = UDim2.fromScale(1, 1)
    i.Position = UDim2.fromScale(0, 0)
    i.BackgroundTransparency = 1
    i.TextTransparency = 1
    i.AutoButtonColor = false
    i.ZIndex = 999999
    i.Parent = j
    task.wait(.1)
    local c = i.AbsolutePosition
    local J = i.AbsoluteSize
    local T = c.X + J.X / 2
    local d = c.Y + J.Y / 2
    pcall(function()
        V:SendMouseButtonEvent(T, d, 0, true, game, 1)
        task.wait(.05)
        V:SendMouseButtonEvent(T, d, 0, false, game, 1)
    end)
    j:Destroy()
    return true
end
if i.UserDevice.IsMobile() then
    j.SimulateRealMobileTap()
else
    j.SimulateScreenTapWithGui()
end
