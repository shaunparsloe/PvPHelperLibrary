-- ****************************************************
-- CCTypeList
-- ****************************************************
CCTypeList={};
CCTypeList.__index = CCTypeList -- failed table lookups on the instances should fallback to the class table, to get methods

local L = PVPHelperLib_LocalizationTable;

-- Intialise the List
function CCTypeList.new()
  -- the new instance
  local self = setmetatable({}, CCTypeList)
  self.SpellIDLookup = {}
  return self;
end

function CCTypeList:Add(objCCType)
  table.insert(self, objCCType);
  self.SpellIDLookup[tostring(objCCType.SpellId)] = table.getn(self); 	-- Add to lookup table.
end

function CCTypeList:Delete(objCCType)
--	print("DELETING "..objCCType.SpellId)
--		for i,cctype in ipairs(self) do
--			print("Self SpellID Lookup " ..i.. " - " .. cctype.SpellId .. " " .. cctype.CCName);
--		end  
--	print("Lookup ID "..objCCType.SpellId)
	
	local foundId = self.SpellIDLookup[tostring(objCCType.SpellId)];
	--print("FoundID="..tostring(foundId));
	
  	if foundId then
  		
		for i,cctype in ipairs(self) do
			--print("BeltAndBraces-SELF-Lookup " ..i.." - " .. cctype.SpellId .. " " .. cctype.CCName);
			if cctype.SpellId == objCCType.SpellId then
				--print("Found and removed self at " .. i);
				table.remove(self, i);
			end
		end  
		for i,cctype in ipairs(self.SpellIDLookup) do
			---print("BeltAndBracesSpellIDLookup " ..i.." - " .. cctype.SpellId .. " " .. cctype.CCName);
			if cctype.SpellId == objCCType.SpellId then
				--print("Found and removed Lookup" .. i);
				table.remove(self.SpellIDLookup, i);
			end
		end  
	end
end

-- NOT USED (Left this in in case we need to ever do a rebuild)
--function CCTypeList.ReBuildSpellIdLookup()
--  self.SpellIDLookup = nil;
--  self.SpellIDLookup = {}
--  for i,v in ipairs(self) do
--    self.SpellIDLookup[tostring(v.SpellId)] = i
--  end
--end

-- Reverse lookup the SpellId.  Return found spell.
function CCTypeList:LookupSpellId(spellId)
  local foundId = self.SpellIDLookup[tostring(spellId)];
  if foundId then
    return self[foundId];
  else
    return nil;
  end
end

-- List out all spellIDs
function CCTypeList:ListSpellIds()
  local strJoin = "";
  local strResult = "";
  local i,cctype
  for i,cctype in ipairs(self) do
    strResult = strResult..strJoin..tostring(cctype.SpellId)
    strJoin = ",";
  end  
  return strResult;
end

function CCTypeList:MaxActiveCCExpires()
	local maxExpiry = 0;
  local i,cctype
	for i,cctype in ipairs(self) do
		maxExpiry = math.max(maxExpiry, cctype:ActiveCCExpires());
	end  
	return maxExpiry;
end



function CCTypeList:LoadAllCCTypes()

local objClass = CCTypeList.new();
  
  objClass:Add(CCType.new({SpellId=118, Class=L["MAGE"], CCType="CC", CCName=L["Polymorph (Sheep)"], DRType="DO", Duration=8, IsCore=true, CastTime=1.7, Cooldown=0, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=23160}))
--  objClass:Add(CCType.new({SpellId=28271, Class=L["MAGE"], CCType="CC", CCName=L["Polymorph (Turtle)"], DRType="DO", Duration=8, IsCore=true, CastTime=1.7, Cooldown=0, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=23160}))
--  objClass:Add(CCType.new({SpellId=28272, Class=L["MAGE"], CCType="CC", CCName=L["Polymorph (Pig)"], DRType="DO", Duration=8, IsCore=true, CastTime=1.7, Cooldown=0, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=23160}))
  objClass:Add(CCType.new({SpellId=10326, Class=L["PALADIN"], CCType="CC", CCName=L["Turn Evil"], DRType="F", Duration=8, IsCore=true, CastTime=1.5, Cooldown=15, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=23160}))
  objClass:Add(CCType.new({SpellId=113506, Class=L["ANY"], CCType="CC", CCName=L["Cyclone (Symbiosis)"], DRType="cyclone", Duration=6, IsCore=true, CastTime=1.7, Cooldown=0, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=23120}))
  objClass:Add(CCType.new({SpellId=33786, Class=L["DRUID"], CCType="CC", CCName=L["Cyclone"], DRType="cyclone", Duration=6, IsCore=true, CastTime=1.7, Cooldown=0, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=23120}))
  objClass:Add(CCType.new({SpellId=5872, Class=L["WARLOCK"], CCType="CC", CCName=L["Fear"], DRType="F", Duration=6, IsCore=true, CastTime=1.7, Cooldown=0, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=23120}))
  objClass:Add(CCType.new({SpellId=9005, Class=L["DRUID"], CCType="CC", CCName=L["Pounce"], DRType="CS", Duration=4, IsCore=true, CastTime=0, Cooldown=0, Targeted=true, Ranged=true, RequiresStealth=true, IsChannelled=false, Weighting=23105}))
--  objClass:Add(CCType.new({SpellId=102546, Class=L["DRUID"], CCType="CC", CCName=L["Pounce"], DRType="CS", Duration=4, IsCore=true, CastTime=0, Cooldown=0, Targeted=true, Ranged=true, RequiresStealth=true, IsChannelled=false, Weighting=23105}))
  objClass:Add(CCType.new({SpellId=115078, Class=L["Monk"], CCType="CC", CCName=L["Paralysis"], DRType="DO", Duration=4, IsCore=true, CastTime=0, Cooldown=15, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=23105}))
  
  objClass:Add(CCType.new({SpellId=605, Class=L["PRIEST"], CCType="CC", CCName=L["Dominate Mind"], DRType="dommind", Duration=6, IsCore=true, CastTime=1.8, Cooldown=0, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=true, Weighting=22120}))
  
  objClass:Add(CCType.new({SpellId=71289, Class=L["PRIEST"], CCType="CC", CCName=L["Dominate Mind"], DRType="dommind", Duration=6, IsCore=true, CastTime=1.8, Cooldown=0, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=true, Weighting=2120}))
--  objClass:Add(CCType.new({SpellId=14515, Class=L["PRIEST"], CCType="CC", CCName=L["Dominate Mind"], DRType="dommind", Duration=6, IsCore=true, CastTime=1.8, Cooldown=0, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=true, Weighting=22120}))
  objClass:Add(CCType.new({SpellId=12589, Class=L["MAGE"], CCType="CC", CCName=L["Improved Counterspell, Frostjaw (talent)"], DRType="S", Duration=6, IsCore=false, CastTime=0, Cooldown=24, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=11145}))
  objClass:Add(CCType.new({SpellId=102051, Class=L["MAGE"], CCType="CC", CCName=L["Frostjaw (talent)"], DRType="S", Duration=6, IsCore=false, CastTime=0, Cooldown=24, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=11145}))
  objClass:Add(CCType.new({SpellId=34490, Class=L["HUNTER"], CCType="CC", CCName=L["Silencing Shot (talent)"], DRType="S", Duration=3, IsCore=false, CastTime=0, Cooldown=24, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=11085}))
  objClass:Add(CCType.new({SpellId=108194, Class=L["DEATHKNIGHT"], CCType="CC", CCName=L["Knight Asphyxiate (talent), Gnaw (Unholy Ghoul), Monstrous Blow (Dark Transformation Unholy Ghoul ab"], DRType="CS", Duration=5, IsCore=false, CastTime=0, Cooldown=30, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=9125}))
  objClass:Add(CCType.new({SpellId=44572, Class=L["MAGE"], CCType="CC", CCName=L["Deep Freeze"], DRType="CS", Duration=5, IsCore=false, CastTime=0, Cooldown=30, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=9125}))
  objClass:Add(CCType.new({SpellId=107570, Class=L["WARRIOR"], CCType="CC", CCName=L["Storm Bolt (talent)"], DRType="CS", Duration=4, IsCore=false, CastTime=0, Cooldown=30, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=9105}))
  objClass:Add(CCType.new({SpellId=19503, Class=L["HUNTER"], CCType="CC", CCName=L["Scatter Shot"], DRType="scatter", Duration=4, IsCore=false, CastTime=0, Cooldown=30, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=9105}))
  objClass:Add(CCType.new({SpellId=60192, Class=L["HUNTER"], CCType="CC", CCName=L["Freezing Trap"], DRType="scatter", Duration=4, IsCore=false, CastTime=0, Cooldown=30, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=9105}))
  objClass:Add(CCType.new({SpellId=8122, Class=L["PRIEST"], CCType="CC", CCName=L["Psychic Scream"], DRType="F", Duration=8, IsCore=false, CastTime=0, Cooldown=30, Targeted=false, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=8185}))
--  objClass:Add(CCType.new({SpellId=30283, Class=L["WARLOCK"], CCType="CC", CCName=L["Shadowfury"], DRType="CS", Duration=3, IsCore=false, CastTime=0, Cooldown=30, Targeted=false, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=8085}))
  objClass:Add(CCType.new({SpellId=81441, Class=L["WARLOCK"], CCType="CC", CCName=L["Shadowfury"], DRType="CS", Duration=3, IsCore=false, CastTime=0, Cooldown=30, Targeted=false, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=8085}))
  objClass:Add(CCType.new({SpellId=100, Class=L["WARRIOR"], CCType="CC", CCName=L["Charge"], DRType="CS", Duration=4, IsCore=false, CastTime=0, Cooldown=40, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=7105}))
  objClass:Add(CCType.new({SpellId=46968, Class=L["WARRIOR"], CCType="CC", CCName=L["Shockwave"], DRType="CS", Duration=4, IsCore=false, CastTime=0, Cooldown=40, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=7105}))
  objClass:Add(CCType.new({SpellId=51514, Class=L["SHAMAN"], CCType="CC", CCName=L["Hex"], DRType="DO", Duration=8, IsCore=false, CastTime=1.5, Cooldown=45, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=6493}))
  objClass:Add(CCType.new({SpellId=19386, Class=L["HUNTER"], CCType="CC", CCName=L["Wyvern Sting (Survival)"], DRType="DO", Duration=6, IsCore=false, CastTime=0, Cooldown=45, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=6478}))
  objClass:Add(CCType.new({SpellId=15487, Class=L["PRIEST"], CCType="CC", CCName=L["Silence"], DRType="S", Duration=5, IsCore=false, CastTime=0, Cooldown=45, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=6458}))
  objClass:Add(CCType.new({SpellId=11129, Class=L["MAGE"], CCType="CC", CCName=L["Combustion"], DRType="CS", Duration=3, IsCore=false, CastTime=0, Cooldown=45, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=6418}))
  objClass:Add(CCType.new({SpellId=6789, Class=L["WARLOCK"], CCType="CC", CCName=L["Mortal Coil (talent)"], DRType="H", Duration=3, IsCore=false, CastTime=0, Cooldown=45, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=6418}))
  objClass:Add(CCType.new({SpellId=64044, Class=L["PRIEST"], CCType="CC", CCName=L["Psychic Horror"], DRType="H", Duration=5, IsCore=false, CastTime=0, Cooldown=45, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=6378}))
--  objClass:Add(CCType.new({SpellId=64058, Class=L["PRIEST"], CCType="CC", CCName=L["Psychic Horror"], DRType="H", Duration=1, IsCore=false, CastTime=0, Cooldown=45, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=6378}))
--  objClass:Add(CCType.new({SpellId=65545, Class=L["PRIEST"], CCType="CC", CCName=L["Psychic Horror"], DRType="H", Duration=1, IsCore=false, CastTime=0, Cooldown=45, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=6378}))
  objClass:Add(CCType.new({SpellId=1776, Class=L["ROGUE"], CCType="CC", CCName=L["Gouge"], DRType="DO", Duration=4, IsCore=false, CastTime=0, Cooldown=10, Targeted=true, Ranged=false, RequiresStealth=false, IsChannelled=false, Weighting=6105}))
--  objClass:Add(CCType.new({SpellId=143939, Class=L["ROGUE"], CCType="CC", CCName=L["Gouge, Sap"], DRType="DO", Duration=4, IsCore=false, CastTime=0, Cooldown=10, Targeted=true, Ranged=false, RequiresStealth=false, IsChannelled=false, Weighting=6105}))
--  objClass:Add(CCType.new({SpellId=34940, Class=L["ROGUE"], CCType="CC", CCName=L["Gouge, Sap"], DRType="DO", Duration=4, IsCore=false, CastTime=0, Cooldown=10, Targeted=true, Ranged=false, RequiresStealth=false, IsChannelled=false, Weighting=6105}))
  objClass:Add(CCType.new({SpellId=22570, Class=L["DRUID"], CCType="CC", CCName=L["Maim"], DRType="CS", Duration=1, IsCore=false, CastTime=0, Cooldown=10, Targeted=true, Ranged=false, RequiresStealth=false, IsChannelled=false, Weighting=6045}))
  objClass:Add(CCType.new({SpellId=853, Class=L["PALADIN"], CCType="CC", CCName=L["Hammer of Justice"], DRType="CS", Duration=6, IsCore=false, CastTime=0, Cooldown=60, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=5145}))
--  objClass:Add(CCType.new({SpellId=110698, Class=L["PALADIN"], CCType="CC", CCName=L["Hammer of Justice"], DRType="CS", Duration=6, IsCore=false, CastTime=0, Cooldown=60, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=5145}))
--  objClass:Add(CCType.new({SpellId=77787, Class=L["PALADIN"], CCType="CC", CCName=L["Hammer of Justice"], DRType="CS", Duration=6, IsCore=false, CastTime=0, Cooldown=60, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=5145}))
  objClass:Add(CCType.new({SpellId=47476, Class=L["DEATHKNIGHT"], CCType="CC", CCName=L["Strangulate"], DRType="S", Duration=5, IsCore=false, CastTime=0, Cooldown=60, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=5125}))
--  objClass:Add(CCType.new({SpellId=55314, Class=L["DEATHKNIGHT"], CCType="CC", CCName=L["Strangulate"], DRType="S", Duration=5, IsCore=false, CastTime=0, Cooldown=60, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=5125}))
  objClass:Add(CCType.new({SpellId=20066, Class=L["PALADIN"], CCType="CC", CCName=L["Repentance (talent)"], DRType="DO", Duration=6, IsCore=false, CastTime=1.7, Cooldown=60, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=5120}))
--  objClass:Add(CCType.new({SpellId=29511, Class=L["PALADIN"], CCType="CC", CCName=L["Repentance (talent)"], DRType="DO", Duration=6, IsCore=false, CastTime=1.7, Cooldown=60, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=5120}))
--  objClass:Add(CCType.new({SpellId=81947, Class=L["PALADIN"], CCType="CC", CCName=L["Repentance (talent)"], DRType="DO", Duration=6, IsCore=false, CastTime=1.7, Cooldown=60, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=5120}))
  objClass:Add(CCType.new({SpellId=19577, Class=L["HUNTER"], CCType="CC", CCName=L["Intimidation"], DRType="CS", Duration=3, IsCore=false, CastTime=0, Cooldown=60, Targeted=true, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=5085}))
  objClass:Add(CCType.new({SpellId=78675, Class=L["DRUID"], CCType="CC", CCName=L["Solar Beam (Balance)"], DRType="S", Duration=8, IsCore=false, CastTime=0, Cooldown=60, Targeted=false, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=4185}))
  objClass:Add(CCType.new({SpellId=115750, Class=L["PALADIN"], CCType="CC", CCName=L["Blinding Light"], DRType="F", Duration=6, IsCore=false, CastTime=1.8, Cooldown=120, Targeted=false, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=2120}))
--  objClass:Add(CCType.new({SpellId=23773, Class=L["PALADIN"], CCType="CC", CCName=L["Blinding Light"], DRType="F", Duration=6, IsCore=false, CastTime=1.8, Cooldown=120, Targeted=false, Ranged=true, RequiresStealth=false, IsChannelled=false, Weighting=2120}))
  objClass:Add(CCType.new({SpellId=2094, Class=L["ROGUE"], CCType="CC", CCName=L["Blind"], DRType="F", Duration=8, IsCore=false, CastTime=0, Cooldown=60, Targeted=true, Ranged=false, RequiresStealth=false, IsChannelled=false, Weighting=-1815}))
--  objClass:Add(CCType.new({SpellId=24469, Class=L["ROGUE"], CCType="CC", CCName=L["Blind"], DRType="F", Duration=8, IsCore=false, CastTime=0, Cooldown=60, Targeted=true, Ranged=false, RequiresStealth=false, IsChannelled=false, Weighting=-1815}))
--  objClass:Add(CCType.new({SpellId=43433, Class=L["ROGUE"], CCType="CC", CCName=L["Blind"], DRType="F", Duration=8, IsCore=false, CastTime=0, Cooldown=60, Targeted=true, Ranged=false, RequiresStealth=false, IsChannelled=false, Weighting=-1815}))
  objClass:Add(CCType.new({SpellId=5246, Class=L["WARRIOR"], CCType="CC", CCName=L["Intimidating Shout"], DRType="F", Duration=8, IsCore=false, CastTime=0, Cooldown=90, Targeted=true, Ranged=false, RequiresStealth=false, IsChannelled=false, Weighting=-3149}))
--  objClass:Add(CCType.new({SpellId=20511, Class=L["WARRIOR"], CCType="CC", CCName=L["Intimidating Shout"], DRType="F", Duration=8, IsCore=false, CastTime=0, Cooldown=90, Targeted=true, Ranged=false, RequiresStealth=false, IsChannelled=false, Weighting=-3149}))
--  objClass:Add(CCType.new({SpellId=65930, Class=L["WARRIOR"], CCType="CC", CCName=L["Intimidating Shout"], DRType="F", Duration=8, IsCore=false, CastTime=0, Cooldown=90, Targeted=true, Ranged=false, RequiresStealth=false, IsChannelled=false, Weighting=-3149}))


  self = objClass;
  -- return the initialised list
  return self;
end







