getgenv().raw = loadstring(game:HttpGet("https://raw.githubusercontent.com/lolz1de/r0t4/main/raw.lua"))() -- raw library

local function GetParents(Inst)
	local Parent, Parents = Inst, {}
    repeat
		Parent = raw.get(Parent, "Parent")
		Parents[#Parents+1] = Parent
    until not Parent

    return Parents
end

local function setparent(Inst, Destination)
    local Parents = {
        [Destination] = true
    }

    for _, Parent in pairs(GetParents(Destination)) do
        Parents[Parent] = true
    end

    for _, Parent in pairs(GetParents(Inst)) do
        Parents[Parent] = true
    end

    local Connections = {}

    for Parent, _ in pairs(Parents) do
        Connections[#Connections+1] = getconnections(raw.get(Parent, "DescendantAdded"))
        Connections[#Connections+1] = getconnections(raw.get(Parent, "ChildAdded"))
        Connections[#Connections+1] = getconnections(raw.get(Parent, "DescendantRemoving"))
        Connections[#Connections+1] = getconnections(raw.get(Parent, "ChildRemoved"))
    end

    local DisabledSignals = {}

    for _, Signals in pairs(Connections) do
        for _, Signal in pairs(Signals) do
            if Signal.Enabled == true and Signal.Function ~= nil and isexecutorclosure(Signal.Function) == false then
                DisabledSignals[#DisabledSignals+1] = Signal
                Signal:Disable()
            end
        end
    end

    raw.set(Inst, "Parent", Destination)

    for _, Signal in pairs(DisabledSignals) do
        Signal:Enable()
    end
end

return setparent
