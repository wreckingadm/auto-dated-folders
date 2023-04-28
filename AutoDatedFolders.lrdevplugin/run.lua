-- local LrDialogs = import 'LrDialogs'
-- LrDialogs.message("Hello World")

local LrApplication = import 'LrApplication'
local LrDialogs = import 'LrDialogs'
local LrTasks = import 'LrTasks'

LrTasks.startAsyncTask(function ()
  local catalog = LrApplication.activeCatalog()

  local photo = catalog:getTargetPhoto()
  if photo == nil then
    LrDialogs.message("Hello World", "Please select a photo")
    return
  end

  local filename = photo:getFormattedMetadata("fileName")
  local msg = string.format("The selected photo's filename is %q", filename)
  LrDialogs.message("Hello World", msg)
end)