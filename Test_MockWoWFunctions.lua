--TEST FUNCTIONS
if os then
    
  DEBUG = {}
  
  SlashCmdList = {}
  Frame = {}
  Frame.__index = Frame; -- failed table lookups on the instances should fallback to the class table, to get methods
  function Frame.new (options)
    local self = setmetatable({}, Frame)
    self.TimeSinceLastUpdate = 0;
    return self;
  end
  function Frame:SetAttribute(stratt, strset) end
  function Frame:RegisterEvent() end;
  function Frame:Enable() end
  function Frame:AddMessage() end
  function Frame:Clear() end
  function Frame:Disable() end
  function Frame:SetFrameStrata() end
  function Frame:SetShadowOffset() end
  function Frame:SetShadowColor() end
  function Frame:SetTextColor() end
  function Frame:SetAlpha(intAlpha) end
  function Frame:SetText(strText) self.Text = strText; end
  function Frame:SetMovable(bln) end
	function Frame:EnableMouse(bln) end
	function Frame:RegisterForDrag(strMouseButton) end
	function Frame:SetResizable(bln) end
	function Frame:SetToplevel(bln) end
	function Frame:SetClampedToScreen(bln) end

	function Frame:SetScript(strAction, func) end

	function Frame:SetBackdrop(options) end
  
  function Frame:SetPoint(relativePoint, ofsx, ofsy) end; 
	function Frame:SetSize(iWidth, iHeight) end; 
	function Frame:SetWidth(iWidth) end; 
	function Frame:SetHeight(iHeight) end;
  function Frame:CreateFontString(strName, strLayer, strInherits) return Frame.new(); end
  function Frame:SetUserPlaced(bln) end;

	function Frame:SetFontObject() return nil; end;
	function Frame:SetJustifyH() return nil; end;
	function Frame:SetFading() return nil; end;

  function Frame:SetNormalFontObject(strFontObject) end;
  function Frame:SetHighlightFontObject(strFontObject) end;
  function Frame:SetNormalFontObject(strFontObject) end;
  function Frame:CreateTexture() return Texture.new(); end;
  function Frame:SetNormalTexture(tex) end;
  function Frame:SetHighlightTexture(tex) end;
  function Frame:SetPushedTexture(tex) end;
  
  function Frame:SetName(name) self.Name = name; end;
  function Frame:GetName(name) return tostring(self.Name); end;
    
  function CreateFrame(frameType, frameName, parentFrame, inheritsFrame)
    local frame = Frame.new();
    frame.Name = frameName
    return frame;
  end

  Texture = {}
  Texture.__index = Texture; -- failed table lookups on the instances should fallback to the class table, to get methods
  function Texture.new (options)
    local self = setmetatable({}, Texture)
    return self;
  end
  function Texture:SetTexture(strTex) end;
	function Texture:SetTexCoord(p1, p2, p3, p4) end
	function Texture:SetAllPoints()	end
  function Texture:SetWidth(buttonWidth) self.Width = buttonWidth end
  function Texture:GetWidth() return self.Width; end
  function Texture:SetHeight(buttonHeight) end
  function Texture:SetPoint() end

  function UnitName(strName) 
    local retval = strName;
    if (DEBUG.UnitName and DEBUG.UnitName[strName]) then
      retval = DEBUG.UnitName[strName]
    end
    return retval; 
  end;
  
  function UnitGUID(strName)
    local retval = strName;
    if (DEBUG.UnitGUID and DEBUG.UnitGUID[strName]) then
      retval = DEBUG.UnitGUID[strName]
    end
    return retval; 
  end
 
	function GetRealmName() return "Hellfire" end
  
  function UnitClass(target) return nil, nil; end;
  function UnitHealth(unit) return 100; end
  function UnitHealthMax(unit) return 100; end
  function RegisterAddonMessagePrefix(string) end;
  function UI_SetMainAssist() end;
   
  function GetPlayerInfoByGUID(guid)
    return "Rogue", "ROGUE", "Human", "HUMAN", "Male", "Sahk", "Hellfire"
  end
    
    
  function IsPlayerSpell(spellId)
    local retval = false
    if spellId == 1776 or spellId == 2094 then
      retval = true
    end
    return retval
  end

  function IsUsableSpell(spellId)
    local retval, nomana
    if (DEBUG.spells[spellId]) then
      retval = DEBUG.spells[spellId].retval
      nomana = DEBUG.spells[spellId].nomana
    else
      print("Cant find DEBUG.spells["..tostring(spellId).."]")
    end
    return retval, nomana
  end

  function UnitInRaid(Unit)
    local retval, nomana
    if (DEBUG.UnitInRaid[Unit]) then
      retval = DEBUG.UnitInRaid[Unit].retval
    else
      print("Cant find DEBUG.UnitInRaid["..tostring(Unit).."]")
    end
    return retval
  end
  
  function UnitInParty(Unit)
    local retval, nomana
    if (DEBUG.UnitInParty[Unit]) then
      retval = DEBUG.UnitInParty[Unit].retval
    else
      print("Cant find DEBUG.UnitInParty["..tostring(Unit).."]")
    end
    return retval
  end
  
  function GetNumRaidMembers()
    local retval = 1
    if (DEBUG.GetNumRaidMembers) then
      retval = DEBUG.GetNumRaidMembers;
    else
      print("Cant find DEBUG.GetNumRaidMembers")
    end
    return retval
  end
  
  function GetNumPartyMembers()
    local retval = 1
    if (DEBUG.GetNumPartyMembers) then
      retval = DEBUG.GetNumPartyMembers;
    else
      print("Cant find DEBUG.GetNumPartyMembers")
    end
    return retval
  end
  
  function UnitIsDeadOrGhost()
    return DEBUG.UnitIsDeadOrGhost
  end
  
  function UnitIsConnected()
    if DEBUG.UnitIsDisconnected then
      print("Unit is not connected")
      return nil;
    else
      return 1;
    end
  end
  
  function GetRaidRosterInfo(raidIndex)
    if (DEBUG.GetRaidRosterInfo and DEBUG.GetRaidRosterInfo[raidIndex]) then
      local x = DEBUG.GetRaidRosterInfo[raidIndex]
      return x.name, x.rank, x.subgroup, x.level, x.class, x.fileName, x.zone, x.online, x.isDead, x.role, x.isML
    else
      print("Cant find DEBUG.GetRaidRosterInfo["..tostring(raidIndex).."]")
      return nil
    end
  end
  function strsplit(sep, inputstr)
    if sep == nil then
            sep = "%s"
    end
    t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            t[i] = str
            i = i + 1
    end
    return t
  end
   

  --TEST
  function SendAddonMessage(prefix, message, group, person)
    if person then
      --print("SENDADDONMESSAGE: "..group.." to "..person.." Prefix="..prefix.." Message="..message)
    else
      --print("SENDADDONMESSAGE: To "..group.." Prefix:"..prefix.." Message="..message)
    end
  end
  
  RAID_CLASS_COLORS = {} 
  local color = {}
  color.r = 196;
  color.g = 30;
  color.b = 59;
  RAID_CLASS_COLORS["DEATHKNIGHT"] = color --{[r] = 196, [g] = 30, [b] = 59};
--   "DRUID" = {r = 255, g = 125, b = 10},
--   "WARRIOR" = {r = 199, g = 156, b = 110}
  color = nil;
  color = {}
  color.r = 255;
  color.g = 245;
  color.b = 105;
  RAID_CLASS_COLORS["ROGUE"] = color
  
  color = nil;
  color = {}
  color.r = 199;
  color.g = 156;
  color.b = 110;
  RAID_CLASS_COLORS["WARRIOR"] = color --{[r] = 196, [g] = 30, [b] = 59};
  
 
end
