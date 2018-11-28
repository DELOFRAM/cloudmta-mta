----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function isVehicleEmpty( vehicle )
    if not isElement( vehicle ) or getElementType( vehicle ) ~= "vehicle" then
        return true
    end
 
    local passengers = getVehicleMaxPassengers( vehicle )
    if type( passengers ) == 'number' then
        for seat = 0, passengers do
            if getVehicleOccupant( vehicle, seat ) then
                return false
            end
        end
    end
    return true
end