local chatInputActive = false
local chatInputActivating = false
local chatHidden = true
local chatLoaded = false

RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:addSuggestions')
RegisterNetEvent('chat:removeSuggestion')
RegisterNetEvent('chat:clear')

-- internal events
RegisterNetEvent('__cfx_internal:serverPrint')

RegisterNetEvent('_chat:messageEntered')

local fijos = {
  ["news"] = true,
  ["prv"] = true,
  ["warning"] = true,
  ["error"] = true,
  ["report"] = true,
  ["ayuda"] = true,
  ["normal"] = true,
}

local IsEnabled = true

RegisterNetEvent("chat:client:toggleHud", function(st)
  if st ~= nil then
    IsEnabled = st
  else
    IsEnabled = not IsEnabled
  end
end)

RegisterNetEvent('Betra:Client:OnPlayerLoaded')
AddEventHandler('Betra:Client:OnPlayerLoaded', function()
    while true do
      Citizen.Wait((60 * 1000) * 25)  
      TriggerEvent("chatMessage", "RECUERDA", "normal", 'Si necesitás ayuda puedes usar el comando /ayuda, mientras que con el comando /report se atenderán SOLO casos de moderación.')         
    end
end)

--deprecated, use chat:addMessage
AddEventHandler('chatMessage', function(author, ctype, text)
  if not IsEnabled then
    return
  end

  local args = { text }
  if author ~= "" then
    table.insert(args, 1, author)
  end
  local ctype = ctype ~= false and ctype or "normal"
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      template = '<div class="msg-wrap"><div class="prefix ' ..ctype.. '"><p>' ..(fijos[ctype] and author or ctype).. '</p></div><div class="chat-message normal"><div class="chat-message-body"><strong>' ..(fijos[ctype] and "" or (author.." ◉")).. ' </strong>{1}</div></div></div>',
      args = {author, text}
    }
  })
end)

AddEventHandler('__cfx_internal:serverPrint', function(msg)
  -- SendNUIMessage({
  --   type = 'ON_MESSAGE',
  --   message = {
  --     templateId = 'print',
  --     multiline = true,
  --     args = { msg }
  --   }
  -- })
end)

AddEventHandler('chat:addMessage', function(message)
  if message.template ~= "id_card" then
    SendNUIMessage({
      type = 'ON_MESSAGE',
      message = message
    })
  else
    SendNUIMessage({
      type = 'ON_MESSAGE',
      message = message
    })
  end
end)

RegisterNetEvent('chat:showFBI')
AddEventHandler('chat:showFBI', function(placa)
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      color = 1,
      multiline = false,
      args = {placa}
    }
  })
end)

AddEventHandler('chat:addSuggestion', function(name, help, params)
  SendNUIMessage({
    type = 'ON_SUGGESTION_ADD',
    suggestion = {
      name = name,
      help = help,
      params = params or nil
    }
  })
end)

AddEventHandler('chat:addSuggestions', function(suggestions)
  for _, suggestion in ipairs(suggestions) do
    SendNUIMessage({
      type = 'ON_SUGGESTION_ADD',
      suggestion = suggestion
    })
  end
end)

AddEventHandler('chat:removeSuggestion', function(name)
  SendNUIMessage({
    type = 'ON_SUGGESTION_REMOVE',
    name = name
  })
end)

AddEventHandler('chat:addTemplate', function(id, html)
  SendNUIMessage({
    type = 'ON_TEMPLATE_ADD',
    template = {
      id = id,
      html = html
    }
  })
end)

AddEventHandler('chat:clear', function(name)
  SendNUIMessage({
    type = 'ON_CLEAR'
  })
end)

RegisterCommand("clear", function(source, args, rawCommand)
  SendNUIMessage({
    type = 'ON_CLEAR'
  })
end, false)

RegisterNUICallback('chatResult', function(data, cb)
  chatInputActive = false
  SetNuiFocus(false, false)

  if not data.canceled then
    local id = PlayerId()

    --deprecated
    local r, g, b = 0, 0x99, 255

    if data.message:sub(1, 1) == '/' then
      ExecuteCommand(data.message:sub(2))
    else
      TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.message)
    end
  end

  cb('ok')
end)

local function refreshCommands()
  if GetRegisteredCommands then
    local registeredCommands = GetRegisteredCommands()

    local suggestions = {}

    for _, command in ipairs(registeredCommands) do
       Wait(5)
        if IsAceAllowed(('command.%s'):format(command.name)) then
            table.insert(suggestions, {
                name = '/' .. command.name,
                help = ''
            })
        end
    end

    TriggerEvent('chat:addSuggestions', suggestions)
  end
end

local function refreshThemes()
  local themes = {}

  for resIdx = 0, GetNumResources() - 1 do
    Wait(5)
    local resource = GetResourceByFindIndex(resIdx)

    if GetResourceState(resource) == 'started' then
      local numThemes = GetNumResourceMetadata(resource, 'chat_theme')

      if numThemes > 0 then
        local themeName = GetResourceMetadata(resource, 'chat_theme')
        local themeData = json.decode(GetResourceMetadata(resource, 'chat_theme_extra') or 'null')

        if themeName and themeData then
          themeData.baseUrl = 'nui://' .. resource .. '/'
          themes[themeName] = themeData
        end
      end
    end
  end

  SendNUIMessage({
    type = 'ON_UPDATE_THEMES',
    themes = themes
  })
end

AddEventHandler('onClientResourceStart', function(resName)
  Wait(500)

  refreshCommands()
  refreshThemes()
end)

AddEventHandler('onClientResourceStop', function(resName)
  Wait(500)

  refreshCommands()
  refreshThemes()
end)

RegisterNUICallback('loaded', function(data, cb)
  TriggerServerEvent('chat:init');

  refreshCommands()
  refreshThemes()

  chatLoaded = true

  cb('ok')
end)

Citizen.CreateThread(function()
  SetTextChatEnabled(false)
  SetNuiFocus(false, false)

  while true do
    Wait(3)

    if not chatInputActive then
      if IsControlPressed(0, 245) --[[ INPUT_MP_TEXT_CHAT_ALL ]] then
        chatInputActive = true
        chatInputActivating = true

        SendNUIMessage({
          type = 'ON_OPEN'
        })
      end
    end

    if chatInputActivating then
      if not IsControlPressed(0, 245) then
        SetNuiFocus(true)

        chatInputActivating = false
      end
    end

    if chatLoaded then
      local shouldBeHidden = false

      if IsScreenFadedOut() or IsPauseMenuActive() then
        shouldBeHidden = true
      end

      if (shouldBeHidden and not chatHidden) or (not shouldBeHidden and chatHidden) then
        chatHidden = shouldBeHidden
        SendNUIMessage({
          type = 'ON_SCREEN_STATE_CHANGE',
          shouldHide = shouldBeHidden
        })
      end
    end
  end
end)