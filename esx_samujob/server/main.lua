ESX = nil

local playersHealing = {}



TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('esx_samujob:revive')

AddEventHandler('esx_samujob:revive', function(target)

	local xPlayer = ESX.GetPlayerFromId(source)

	local xPlayers = ESX.GetPlayers()



	if xPlayer.job.name == 'samu' then

		local societyAccount = nil

		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_samu', function(account)

			societyAccount = account

		end)

		if societyAccount ~= nil then

			xPlayer.addMoney(Config.ReviveReward)

			TriggerClientEvent('esx_samujob:revive', target)

			societyAccount.addMoney(150)

			print('150$ ajouté')

		end

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name == 'samu' then

				TriggerClientEvent('esx_samujob:notif', xPlayers[i])

			end

		end

	else

		print(('esx_samujob: %s attempted to revive!'):format(xPlayer.identifier))

	end

end)



RegisterServerEvent('esx_samujob:revive2')

AddEventHandler('esx_samujob:revive2', function(target)

	local xPlayer = ESX.GetPlayerFromId(source)

	local xPlayers = ESX.GetPlayers()

	TriggerClientEvent('esx_samujob:revive2', target)

end)





RegisterServerEvent('esx_samu:Notification')

AddEventHandler('esx_samu:Notification', function(x, y, z, name, coords)

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(_source)

	local xPlayers = ESX.GetPlayers()



	for i = 1, #xPlayers, 1 do

		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])

		if thePlayer.job.name == 'samu' then

			TriggerClientEvent('esx_samujob:Notif2', xPlayers[i], _source, x, y, z, coords)

		end

	end

end)



-- Blips de l'unité X



RegisterServerEvent('esx_samu:NotificationBlipsX')

AddEventHandler('esx_samu:NotificationBlipsX', function(x, y, z, name)

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(_source)

	local xPlayers = ESX.GetPlayers()



	for i = 1, #xPlayers, 1 do

		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])

		if thePlayer.job.name == 'samu' then

			TriggerClientEvent('esx_samujob:NotificationBlipsX2', xPlayers[i], _source, x, y, z)

		end

	end

end)



RegisterServerEvent('esx_samujob:heal')

AddEventHandler('esx_samujob:heal', function(target, type)

	local xPlayer = ESX.GetPlayerFromId(source)



	if xPlayer.job.name == 'samu' then

		TriggerClientEvent('esx_samujob:heal', target, type)

	else

		print(('esx_samujob: %s attempted to heal!'):format(xPlayer.identifier))

	end

end)



RegisterServerEvent('esx_samujob:putInVehicle')

AddEventHandler('esx_samujob:putInVehicle', function(target)

	local xPlayer = ESX.GetPlayerFromId(source)



	if xPlayer.job.name == 'samu' then

		TriggerClientEvent('esx_samujob:putInVehicle', target)

	else

		print(('esx_samujob: %s attempted to put in vehicle!'):format(xPlayer.identifier))

	end

end)



TriggerEvent('esx_phone:registerNumber', 'samu', _U('alert_samu'), true, true)



TriggerEvent('esx_society:registerSociety', 'samu', 'samu', 'society_samu', 'society_samu', 'society_samu', {type = 'public'})



ESX.RegisterServerCallback('esx_samujob:removeItemsAfterRPDeath', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)



	if Config.RemoveCashAfterRPDeath then

		if xPlayer.getMoney() > 0 then

			xPlayer.removeMoney(xPlayer.getMoney())

		end



		if xPlayer.getAccount('black_money').money > 0 then

			xPlayer.setAccountMoney('black_money', 0)

		end

	end



	if Config.RemoveItemsAfterRPDeath then

		for i=1, #xPlayer.inventory, 1 do

			if xPlayer.inventory[i].count > 0 then

				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)

			end

		end

	end



	local playerLoadout = {}

	if Config.RemoveWeaponsAfterRPDeath then

		for i=1, #xPlayer.loadout, 1 do

			xPlayer.removeWeapon(xPlayer.loadout[i].name)

		end

	else -- save weapons & restore em' since spawnmanager removes them

		for i=1, #xPlayer.loadout, 1 do

			table.insert(playerLoadout, xPlayer.loadout[i])

		end



		-- give back wepaons after a couple of seconds

		Citizen.CreateThread(function()

			Citizen.Wait(5000)

			for i=1, #playerLoadout, 1 do

				if playerLoadout[i].label ~= nil then

					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)

				end

			end

		end)

	end



	cb()

end)



if Config.EarlyRespawnFine then

	ESX.RegisterServerCallback('esx_samujob:checkBalance', function(source, cb)

		local xPlayer = ESX.GetPlayerFromId(source)

		local bankBalance = xPlayer.getAccount('bank').money



		cb(bankBalance >= Config.EarlyRespawnFineAmount)

	end)



	RegisterServerEvent('esx_samujob:payFine')

	AddEventHandler('esx_samujob:payFine', function()

		local xPlayer = ESX.GetPlayerFromId(source)

		local fineAmount = Config.EarlyRespawnFineAmount



		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))

		xPlayer.removeAccountMoney('bank', fineAmount)

	end)

end



ESX.RegisterServerCallback('esx_samujob:getItemAmount', function(source, cb, item)

	local xPlayer = ESX.GetPlayerFromId(source)

	local quantity = xPlayer.getInventoryItem(item).count



	cb(quantity)

end)



ESX.RegisterServerCallback('esx_samujob:buyJobVehicle', function(source, cb, vehicleProps, type)

	local xPlayer = ESX.GetPlayerFromId(source)

	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)



	-- vehicle model not found

	if price == 0 then

		print(('esx_samujob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))

		cb(false)

	else

		if xPlayer.getMoney() >= price then

			xPlayer.removeMoney(price)

	

			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {

				['@owner'] = xPlayer.identifier,

				['@vehicle'] = json.encode(vehicleProps),

				['@plate'] = vehicleProps.plate,

				['@type'] = type,

				['@job'] = xPlayer.job.name,

				['@stored'] = true

			}, function (rowsChanged)

				cb(true)

			end)

		else

			cb(false)

		end

	end

end)



ESX.RegisterServerCallback('esx_samujob:storeNearbyVehicle', function(source, cb, nearbyVehicles)

	local xPlayer = ESX.GetPlayerFromId(source)

	local foundPlate, foundNum



	for k,v in ipairs(nearbyVehicles) do

		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {

			['@owner'] = xPlayer.identifier,

			['@plate'] = v.plate,

			['@job'] = xPlayer.job.name

		})



		if result[1] then

			foundPlate, foundNum = result[1].plate, k

			break

		end

	end



	if not foundPlate then

		cb(false)

	else

		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {

			['@owner'] = xPlayer.identifier,

			['@plate'] = foundPlate,

			['@job'] = xPlayer.job.name

		}, function (rowsChanged)

			if rowsChanged == 0 then

				print(('esx_samujob: %s has exploited the garage!'):format(xPlayer.identifier))

				cb(false)

			else

				cb(true, foundNum)

			end

		end)

	end



end)



function getPriceFromHash(hashKey, jobGrade, type)

	if type == 'helicopter' then

		local vehicles = Config.AuthorizedHelicopters[jobGrade]



		for k,v in ipairs(vehicles) do

			if GetHashKey(v.model) == hashKey then

				return v.price

			end

		end

	elseif type == 'car' then

		local vehicles = Config.AuthorizedVehicles[jobGrade]



		for k,v in ipairs(vehicles) do

			if GetHashKey(v.model) == hashKey then

				return v.price

			end

		end

	end



	return 0

end



RegisterServerEvent('esx_samujob:removeItem')

AddEventHandler('esx_samujob:removeItem', function(item)

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(_source)



	xPlayer.removeInventoryItem(item, 1)



	if item == 'bandage' then

		TriggerClientEvent('esx:showNotification', _source, _U('used_bandage'))

	elseif item == 'medikit' then

		TriggerClientEvent('esx:showNotification', _source, _U('used_medikit'))

	end

end)



RegisterServerEvent('esx_samujob:giveItem')

AddEventHandler('esx_samujob:giveItem', function(itemName)

	local xPlayer = ESX.GetPlayerFromId(source)



	if xPlayer.job.name ~= 'samu' then

		print(('esx_samujob: %s attempted to spawn in an item!'):format(xPlayer.identifier))

		return

	elseif (itemName ~= 'medikit' and itemName ~= 'bandage' and itemName ~= 'stretcher') then

		print(('esx_samujob: %s attempted to spawn in an item!'):format(xPlayer.identifier))

		return

	end



	local xItem = xPlayer.getInventoryItem(itemName)

	local count = 1



	if xItem.limit ~= -1 then

		count = xItem.limit - xItem.count

	end



	if xItem.count < xItem.limit then

		xPlayer.addInventoryItem(itemName, count)

	else

		TriggerClientEvent('esx:showNotification', source, _U('max_item'))

	end

end)



TriggerEvent('es:addGroupCommand', 'revive', 'admin', function(source, args, user)

	if args[1] ~= nil then

		if GetPlayerName(tonumber(args[1])) ~= nil then

			print(('esx_samujob: %s used admin revive'):format(GetPlayerIdentifiers(source)[1]))

			TriggerClientEvent('esx_samujob:revive', tonumber(args[1]))

		end

	else

		TriggerClientEvent('esx_samujob:revive', source)

	end

end, function(source, args, user)

	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })

end, { help = _U('revive_help'), params = {{ name = 'id' }} })



ESX.RegisterUsableItem('medikit', function(source)

	if not playersHealing[source] then

		local xPlayer = ESX.GetPlayerFromId(source)

		xPlayer.removeInventoryItem('medikit', 1)

	

		playersHealing[source] = true

		TriggerClientEvent('esx_samujob:useItem', source, 'medikit')



		Citizen.Wait(10000)

		playersHealing[source] = nil

	end

end)



ESX.RegisterUsableItem('bandage', function(source)

	if not playersHealing[source] then

		local xPlayer = ESX.GetPlayerFromId(source)

		xPlayer.removeInventoryItem('bandage', 1)

	

		playersHealing[source] = true

		TriggerClientEvent('esx_samujob:useItem', source, 'bandage')



		Citizen.Wait(10000)

		playersHealing[source] = nil

	end

end)



ESX.RegisterServerCallback('esx_samujob:getDeathStatus', function(source, cb)

	local identifier = GetPlayerIdentifiers(source)[1]



	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {

		['@identifier'] = identifier

	}, function(isDead)

		if isDead then

			print(('esx_samujob: %s attempted combat logging!'):format(identifier))

		end



		cb(isDead)

	end)

end)



RegisterServerEvent('esx_samujob:setDeathStatus')

AddEventHandler('esx_samujob:setDeathStatus', function(isDead)

	local identifier = GetPlayerIdentifiers(source)[1]



	if type(isDead) ~= 'boolean' then

		print(('esx_samujob: %s attempted to parse something else than a boolean to setDeathStatus!'):format(identifier))

		return

	end



	MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {

		['@identifier'] = identifier,

		['@isDead'] = isDead

	})

end)





RegisterServerEvent('esx_samujob:RetirerBlipServer')

AddEventHandler('esx_samujob:RetirerBlipServer', function(blipsRenfort)

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(_source)

	local xPlayers = ESX.GetPlayers()



	for i = 1, #xPlayers, 1 do

		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])

		if thePlayer.job.name == 'samu' then

			TriggerClientEvent('esx_samujob:BlipRetirer', xPlayers[i], blipsRenfort)

		end

	end

end)





RegisterServerEvent('AnnounceSAMUOuvert')

AddEventHandler('AnnounceSAMUOuvert', function()

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(_source)

	local xPlayers	= ESX.GetPlayers()

	for i=1, #xPlayers, 1 do

		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'SMUR', '~b~Annonce Samu', 'Un Samu est en service ! Votre santé avant tout !', 'CHAR_PEGASUS_DELIVERY', 8)

	end

end)



RegisterServerEvent('AnnounceSAMUFerme')

AddEventHandler('AnnounceSAMUFerme', function()

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(_source)

	local xPlayers	= ESX.GetPlayers()

	for i=1, #xPlayers, 1 do

		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'SMUR', '~b~Annonce Samu', 'Il n\'y a plus de Samu en service !', 'CHAR_PEGASUS_DELIVERY', 8)

	end

end)



-- Prise Appel EMS 





-- Notification appel ems pour tout les ems

RegisterServerEvent("Server:emsAppel")

AddEventHandler("Server:emsAppel", function(coords, id)

	--local xPlayer = ESX.GetPlayerFromId(source)

	local _coords = coords

	local xPlayers	= ESX.GetPlayers()



	for i=1, #xPlayers, 1 do

		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

          if xPlayer.job.name == 'samu' then

               TriggerClientEvent("AppelemsTropBien", xPlayers[i], _coords, id)

		end

	end

end)



-- Prise d'appel ems

RegisterServerEvent('EMS:PriseAppelServeur')

AddEventHandler('EMS:PriseAppelServeur', function()

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(_source)

	local name = xPlayer.getName(source)

	local xPlayers = ESX.GetPlayers()



	for i = 1, #xPlayers, 1 do

		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])

		if thePlayer.job.name == 'samu' then

			TriggerClientEvent('EMS:AppelDejaPris', xPlayers[i], name)

		end

	end

end)



ESX.RegisterServerCallback('EMS:GetID', function(source, cb)

	local idJoueur = source

	cb(idJoueur)

end)



local AppelTotal = 0

RegisterServerEvent('EMS:AjoutAppelTotalServeur')

AddEventHandler('EMS:AjoutAppelTotalServeur', function()

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(_source)

	local name = xPlayer.getName(source)

	local xPlayers = ESX.GetPlayers()

	AppelTotal = AppelTotal + 1



	for i = 1, #xPlayers, 1 do

		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])

		if thePlayer.job.name == 'samu' then

			TriggerClientEvent('EMS:AjoutUnAppel', xPlayers[i], AppelTotal)

		end

	end



end)

