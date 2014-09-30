Message = {}
Message.__index = Message; -- failed table lookups on the instances should fallback to the class table, to get methods

--GVAR = {}
--UIWidgets = {}


function Message.new (options)
  local self = setmetatable({}, Message)
  self.CompleteText = "";
  self.From = "";
  self.To = "";
  self.ReceivePrefix = "blankprefix";
  self.Header = "";
  self.Body = ""
  self.Time = ""
  return self;
end
--
--function Message:Clone(message)
--  local objMsg = Message.new();
--  if (message) then
--    objMsg.CompleteText = message.CompleteText
--    objMsg.From = message.From
--    objMsg.To = message.To
--    objMsg.Prefix = message.Prefix
--    objMsg.Body = message.Body
--    objMsg.Header = message.Header
--    objMsg.Body = message.Body
--    objMsg.Time = message.Time
--  end
--  return objMsg;
--end

function Message:SendMessagePrefixed(strPrefix, strType, strMessage, strTarget)
	if not strMessage then
		strMessage = "";
	end
--	print("Preparing message for sending ");
  self.Header = tostring(strType)
  self.Body = tostring(strMessage)
  self.To = tostring(strTarget);
  if DEBUG and DEBUG.LogMessages then
    table.insert(GVAR.MessageLog, self);
  end

  if (strTarget) then
      print("DEBUG: Message.SendMessagePrefixed:"..strPrefix ..", ".. tostring(self.Header).."."..tostring(self.Body).." : "..self.To)
    SendAddonMessage(strPrefix, tostring(self.Header).."."..tostring(self.Body), "WHISPER", self.To)
  else
    --If we are in a party or a raid
      print("DEBUG: Message.SendMessagePrefixed:"..strPrefix .." : "..strType.." : "..strMessage.." : TO PARTY")
	SendAddonMessage(strPrefix, tostring(self.Header).."."..tostring(self.Body), "PARTY")
  end
  self.Time = GetTime()

  return self
end



function Message:Format(strPrefix, strMessage, strType, strSender)
  if strPrefix == self.ReceivePrefix then
	local messageSplit = string_split(strMessage, ".");



  --for i,v in ipairs(messageSplit) do
  --  print("Split["..i.."] "..messageSplit[i]);
  --end

    --print("Message is "..strMessage);
    self.CompleteText = strMessage;
    --print("Header=Split[1] "..messageSplit[1]);
    self.Header = messageSplit[1];
    --print("Body=Split[2] "..messageSplit[2]);
    self.Body = messageSplit[2];
  
    self.Type = strType
    self.From = strSender
    self.Time = GetTime()

  else
		print("Message prefix is "..strPrefix.." expecting to receive ".. self.ReceivePrefix)
  end
end
