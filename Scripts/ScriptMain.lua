local MineString = userMods.ToWString 'Мина Молоха'
local wtChat
local valuedText = common.CreateValuedText()
local addonName = common.GetAddonName()
local MineArrowTexture
local MainPanel
--local function isEnemyPlayer(unitId)
--  return object.IsEnemy(unitId) -- and  object.IsUnit(unitId) and unit.IsPlayer(unitId)
--end


local function LogToChat(text)
  if not wtChat then
      wtChat = stateMainForm:GetChildUnchecked("ChatLog", false)
      wtChat = wtChat:GetChildUnchecked("Container", true)
      local formatVT = "<html fontname='AllodsFantasy' fontsize='14' shadow='1'><rs class='color'><r name='addonName'/><r name='text'/></rs></html>"
      valuedText:SetFormat(userMods.ToWString(formatVT))
  end

  if wtChat and wtChat.PushFrontValuedText then
      if not common.IsWString(text) then
          text = userMods.ToWString(text)
      end

      valuedText:ClearValues()
      valuedText:SetClassVal("color", "LogColorRed")
      valuedText:SetVal("text", text)
      valuedText:SetVal("addonName", userMods.ToWString("123: "))
      wtChat:PushFrontValuedText(valuedText)
  end
end
MainPanel = mainForm:GetChildUnchecked("TargetPanel", false)
local function onEnemyPlayerSpawned(unitId)
  LogToChat('найден персонаж')
  local objectId = unitId
  local ObjectName = object.GetName(objectId)
  local wtControl3D 
  local size = { 
      sizeX = 160,
      sizeY = 260 
  }
  if ObjectName == MineString then
    --local pos = {}
    local pos = avatar.GetPos()
    LogToChat('точка один')
    if not MainPanel or not MainPanel:IsValid() then
      LogToChat('шит хеппендс')
      return
     end
    local MainPanell = mainForm:GetChildUnchecked("test", false)
    LogToChat('точка два')
    local wtMainAddonMainForm = common.GetAddonMainForm( "Main" )
    local wtControl3D = wtMainAddonMainForm:GetChildChecked( "MainScreenControl3D", false )
    --object.SetControl3DForProjected( wtControl3D )
    --wtControl3D = stateMainForm:GetChildChecked'MainAddonMainForm':GetChildChecked 'MainScreenControl3D'

    LogToChat('точка три')
    local contol = wtControl3D:AddWidget3D( MainPanel, size, pos, true, false, 100.0, WIDGET_3D_BIND_POINT_HIGH, 0.5, 1.5 )
    if not contol or not contol:IsValid() then
      LogToChat('шит хеппендс рил')
      return
     end
    LogToChat('точка четыре')
    --wtControl3Dd:Show(true)
    object.AttachWidget3D( objectId, wtControl3D, MainPanel, 1 )
    LogToChat('точка пять')
  end
end

local trackedUnits = {}
local function onUnitsChanged(p)
  for _, unitId in pairs(p.despawned) do
    if trackedUnits[unitId] then
      trackedUnits[unitId] = nil
    end
  end
  for _, unitId in pairs(p.spawned) do
    if not trackedUnits[unitId] then --and  isEnemyPlayer(unitId) then
      trackedUnits[unitId] = true
      onEnemyPlayerSpawned(unitId)
    end
  end
end

local function Init()
  local units = avatar.IsExist() and avatar.GetUnitList()
  if units then
    for _, unitId in pairs(units) do
--      if isEnemy(unitId) then
        trackedUnits[unitId] = true
--        onEnemySpawned(unitId)
--      end
    end
  end
  common.RegisterEventHandler(onUnitsChanged, 'EVENT_UNITS_CHANGED')
end

local function onEnemySpawned(unitId)
  local objectId = unitId
  local ObjectName = object.GetName(objectId)
  if ObjectName then
    ObjectName = MineString
    LogToChat(1)
  end
end

Init()




--local wtMainScreenControl3D = stateMainForm:GetChildChecked'MainAddonMainForm':GetChildChecked 'MainScreenControl3D'
