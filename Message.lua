Message = {}
Message.__index = Message; -- failed table lookups on the instances should fallback to the class table, to get methods

GVAR = {}
UIWidgets = {}


function Message.new (options)
  local self = setmetatable({}, Message)
  self.Text = "";
  self.From = "";
  self.To = "";
  self.ReceivePrefix = "blankprefix";
  self.Header = "";
  self.Payload = ""
  self.Time = ""
  return self;
end
--
--function Message:Clone(message)
--  local objMsg = Message.new();
--  if (message) then
--    objMsg.Text = message.Text
--    objMsg.From = message.From
--    objMsg.To = message.To
--    objMsg.Prefix = message.Prefix
--    objMsg.Payload = message.Payload
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
  self.Payload = tostring(self.Header).."."..tostring(strMessage)
  self.Payload2 = tostring(strMessage)
  self.To = tostring(strTarget);
  if (strTarget) then
      --print("DEBUG: Message.SendMessagePrefixed:"..strPrefix ..", "..self.Payload.." : "..self.To)
    SendAddonMessage(strPrefix, self.Payload, "WHISPER", self.To)
  else
    --If we are in a party or a raid
      --print("DEBUG: Message.SendMessagePrefixed:"..strPrefix .." : "..strType.." : "..strMessage.." : TO PARTY")
	SendAddonMessage(strPrefix, self.Payload, "PARTY")
  end
  self.Time = time()

  return self
end



function Message:Format(strPrefix, strMessage, strType, strSender)
  if strPrefix == self.ReceivePrefix then
	local messageSplit = string_split(strMessage, ".");

    self.Text = strMessage;
    self.Header = messageSplit[1];
    self.Body = messageSplit[2];
    
--    local iHeaderLen = 4;
--    self.Header = string.sub(strMessage, 1, iHeaderLen)
--    self.Body = string.sub(strMessage, 1+iHeaderLen+1)
--    
    self.Type = strType
    self.From = strSender
    self.Time = time()
    
--    print("Format Message: strMessage ".. tostring(strMessage));
--    print("Format Message: self.Text ".. tostring(self.Text));
--    print("Format Message: self.Header ".. tostring(self.Header));
--    print("Format Message: self.Body ".. tostring(self.Body));
--    print("Format Message: self.Type ".. tostring(self.Type));
--    print("Format Message: self.From ".. tostring(self.From));
--    print("Format Message: self.strSender ".. tostring(self.strSender));
--    print("Format Message: self.Time ".. tostring(self.Type));
--    print("Format Message: self.Type ".. tostring(self.Type));
--    print("Format Message: self.Type ".. tostring(self.Type));
--    print("Format Message: self.Type ".. tostring(self.Type));
--    print("Format Message: self.Type ".. tostring(self.Type));
  else
		print("Message prefix is "..strPrefix.." expecting to receive ".. self.ReceivePrefix)
  end
end
