-- ****************************************************
-- Class CCType
-- ****************************************************
CCType={};
CCType.__index = CCType -- failed table lookups on the instances should fallback to the class table, to get methods

-- Create this cover function to check mandatory and optional parameters for CCTYPES
function CCType.new (options)
  -- the new instance
  local self = setmetatable(
  {  
    CCType = options.CCType,
    SpellId = options.SpellId, 
    Class = options.Class,
    CCName = options.CCName, 
    DRType = options.DRType, 
    Duration = options.Duration, 
    IsCore = options.IsCore, 
    CastTime = options.CastTime, 
    Cooldown = options.Cooldown, 
    Targeted = options.Targeted, 
    Ranged = options.Ranged, 
    RequiresStealth = options.RequiresStealth, 
    IsChannelled = options.IsChannelled,
    Weighting = options.Weighting,
    _IsCooldown = false,
    _IsActiveCC = false,
    _CooldownExpires = 0,
    _ActiveCCExpires = 0}
  , CCType)
  -- return the instance
  return self;
end

function CCType:CastSpell()
  --print ("self._IsCooldown = true;");
  --print ("self._CooldownExpires = "..tostring(GetPvPClockTime() + self.Cooldown));
  self._CooldownExpires = GetPvPClockTime() + self.Cooldown;
  self._ActiveCCExpires = GetPvPClockTime() + self.Duration;
  self._IsCooldown = true;
  self._IsActiveCC = true;
  return self
end


function CCType:Reset()
  self._IsCooldown = false;
  self._IsActiveCC = false;
  self._CooldownExpires = 0;
  self._ActiveCCExpires = 0;
  return self
end

function CCType:RemoveActiveCC()
  self._IsActiveCC = false;
  self._ActiveCCExpires = 0;
  return self
end


function CCType:IsAvailable()
  local retval = false;
  if (self._IsCooldown) then
    if (GetPvPClockTime() > self._CooldownExpires) then
      self._IsCooldown = false
      retval = true;
    end
  else
    retval = true;
  end

  return retval;
end

function CCType:CooldownExpires()
  local seconds = 0;
  if self._IsCooldown then
    seconds = math.round(self._CooldownExpires - GetPvPClockTime(),1);
    if (seconds <= 0) then
      self._IsCooldown = false
      seconds = 0;
    end
  end

  return seconds;
end


function CCType:IsActive()
  if (self._IsActiveCC) then
    if (GetPvPClockTime() > self._ActiveCCExpires) then
      self._IsActiveCC = false
    end
  end

  return self._IsActiveCC;
end

function CCType:ActiveCCExpires()
  local seconds = 0;
  if self:IsActive() then
    seconds = self._ActiveCCExpires - GetPvPClockTime();
    if (seconds < 0) then
      self._IsActiveCC = false
      seconds = 0;
    end
  end

  return seconds;
end


-- ****************************************************
-- Class CCType
-- ****************************************************

