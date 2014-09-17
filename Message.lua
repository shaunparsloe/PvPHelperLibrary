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
  self.Body = ""
  self.Time = ""
  return self;
end

function Message:Clone(message)
  local objMsg = Message.new();
  if (message) then
    objMsg.Text = message.Text
    objMsg.From = message.From
    objMsg.To = message.To
    objMsg.Prefix = message.Prefix
    objMsg.Payload = message.Payload
    objMsg.Header = message.Header
    objMsg.Body = message.Body
    objMsg.Time = message.Time
  end
  return objMsg;
end

function Message:SendMessagePrefixed(strPrefix, strType, strMessage, strTarget)
	if not strMessage then
		strMessage = "";
	end
--	print("Preparing message for sending ");
  self.Header = strType
  self.Body = self.Header.."|"..strMessage
  self.Payload = strMessage
  self.To = strTarget
  if (strTarget) then
      print("DEBUG: Message.SendMessagePrefixed:"..strPrefix .." : "..strType.." : "..strMessage.." : "..strTarget)
    SendAddonMessage(strPrefix, self.Body, "WHISPER", self.To)
  else
    --If we are in a party or a raid
      --print("DEBUG: Message.SendMessagePrefixed:"..strPrefix .." : "..strType.." : "..strMessage.." : TO PARTY")
	SendAddonMessage(strPrefix, self.Body, "PARTY")
  end
  self.Time = time()

  return self
end



function Message:Format(strPrefix, strMessage, strType, strSender)
  if strPrefix == self.ReceivePrefix then
	local messageSplit = string_split(strMessage, "|");

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
  else
		print("Message prefix is "..strPrefix.." expecting to receive ".. self.ReceivePrefix)
  end
end
