--
-- (C) 2013-24 - ntop.org
--

if(ntop.limitResourcesUsage()) then return end

local prefs = ntop.getPrefs()

if(prefs.active_monitoring == true) then
   local dirs = ntop.getDirs()
   package.path = dirs.installdir .. "/scripts/lua/modules/?.lua;" .. package.path
   
   local discover_utils = require "discover_utils"
   local callback_utils = require "callback_utils"
   
   -- ########################################################
   
   local ifnames = interface.getIfNames()
   
   -- ########################################################
   
   local oneshot_discovery_condition = function(ifId)
      local check_requested = discover_utils.networkDiscoveryRequested(ifId)
      return check_requested
   end
   
   -- ########################################################
   
   -- discovery requests performed by the user from the GUI
   callback_utils.foreachInterface(ifnames, oneshot_discovery_condition, discover_utils.discovery_function)
end
