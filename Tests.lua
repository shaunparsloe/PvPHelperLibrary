

--local filepath = "\\Users\\sparsloe\\Downloads\\ZeroBane\\myprograms\\PVPHelper\\"
--local filepath = "\\Games\\World of Warcraft\\Interface\\AddOns\\PVPHelperClient\\"
--local libfilepath = "\\Users\\sparsloe\\Downloads\\ZeroBane\\myprograms\\PVPHelperLibrary\\"
local libfilepath = "\\Games\\World of Warcraft\\Interface\\AddOns\\PVPHelperLibrary\\"
dofile(libfilepath.."Utils.lua")
dofile(libfilepath.."Localization.lua")
dofile(libfilepath.."CCType.lua")
dofile(libfilepath.."CCTypeList.lua")
dofile(libfilepath.."Message.lua")
dofile(libfilepath.."Test_MockWoWFunctions.lua")


function TEST_MESSAGE_FORMAT_SHORT()
  -- Arrange
  objMessage = Message.new();
  objMessage.ReceivePrefix = "TestPrefix";	
  
  DEBUG.SetClockSeconds = 1000;
  
  -- Use these flags to log messages for debugging
  DEBUG.LogMessages = true;
  GVAR.MessageLog = {};

  -- Act
  objMessage:Format("TestPrefix", "WhatSpellsDoYouHave", "WHISPER", "FromSender") 
  
  TESTAssert("WhatSpellsDoYouHave", objMessage.CompleteText);
  TESTAssert("WhatSpellsDoYouHave", objMessage.Header);
  TESTAssert(nil, objMessage.Body);
  TESTAssert("WHISPER", objMessage.Type);
  TESTAssert("FromSender", objMessage.From);
  TESTAssert(1000, objMessage.Time);
  
  
 end

function TEST_MESSAGE_FORMAT()
  -- Arrange
  objMessage = Message.new();
  objMessage.ReceivePrefix = "TestPrefix";	
  
  DEBUG.SetClockSeconds = 1000;
  
  -- Use these flags to log messages for debugging
  DEBUG.LogMessages = true;
  GVAR.MessageLog = {};

  -- Act
  objMessage:Format("TestPrefix", "WhatSpellsDoYouHave.1234", "WHISPER", "FromSender") 
  
  TESTAssert("WhatSpellsDoYouHave.1234", objMessage.CompleteText);
  TESTAssert("WhatSpellsDoYouHave", objMessage.Header);
  TESTAssert("1234", objMessage.Body);
  TESTAssert("WHISPER", objMessage.Type);
  TESTAssert("FromSender", objMessage.From);
  TESTAssert(1000, objMessage.Time);
  
  
 end


-- TESTS TO PERFORM
print("--START TESTS--\n")
TEST_MESSAGE_FORMAT()
TEST_MESSAGE_FORMAT_SHORT()
print("\n--END TESTS--")



