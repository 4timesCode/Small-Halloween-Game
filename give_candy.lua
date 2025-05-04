-- Get the parent of script
local Part = script.Parent

-- get the sounds to play later
local Sound = Part:WaitForChild("Dingaling")
local Candy = Part:WaitForChild("Candy")

-- get the proximity prompt to track its trigger
local ProximityPrompt = Part:WaitForChild("ProximityPrompt")

-- Get objects in replicated storage
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Neighbor = ReplicatedStorage:WaitForChild("Neighbor")
local Rare = ReplicatedStorage:WaitForChild("4times")
local CandyFolder = ReplicatedStorage:WaitForChild("CandyFolder")

-- debounce to stop spamming later
local debounce = false


-- Triggers when the player presses on the proximity prompt
ProximityPrompt.Triggered:Connect(function(player)
	
	-- check if debounce is false to prevent spamming
	if debounce == false then
		
		-- set a random number between 1 and 100
		local Rarity = math.random(1, 100)
		
		-- set debounce to true and disables 
		-- proximity prompt to prevent player spam
		debounce = true
		ProximityPrompt.Enabled = false
		
		Sound:Play()
		
		-- if the rarity is less than 100, then the player loads in 
		-- neighbor object and smaller range of candy 
		if Rarity < 100 then
			
			-- Clone the neighbor rig into the workspace
			-- and set its position to the part's position 
			-- but a little higher
			local Person = Neighbor:Clone()
			Person.Parent = workspace
			Person:MoveTo(Part.Position + Vector3.new(-3, -4, 0))
			
			-- randomized amount of candy given to players
			local CandyAmount = math.random(5, 20)

			-- wait for the neightbor to finish dialogue
			wait(5)
			Candy:Play()
			
			-- while loop to shower player in candy and 
			-- give candy to player score
			while CandyAmount ~= 0 do
				
				-- random variable to generate either one of two candy models
				-- and set the parent to the workspace to generate it.
				local RandomCandy = math.random(1, 2)
				local CandyClone = CandyFolder:WaitForChild(RandomCandy):Clone()
				CandyClone.Parent = workspace
				CandyClone.Position = Part.Position + Vector3.new(3, 5, 0)
				CandyAmount -= 1
				wait(.1)
				
				-- add candy to the player's score
				player.leaderstats.Candy.Value += 1
				player.leaderstats.TotalCandy.Value += 1
			end
			
			-- wait a little before destroying the neighbor rig
			wait(3)
			Person:Destroy()
			
		-- if the player rolls a 100, then the rare neighbor will spawn
		elseif Rarity == 100 then
			
			-- spawns the rare neighbor rig and puts it in the workspace
			-- for the player to see
			local Person = Rare:Clone()
			Person.Parent = workspace
			Person:MoveTo(Part.Position + Vector3.new(-3, -4, 0))
			
			-- randomize a number of candy than ususal
			local CandyAmount = math.random(50, 100)
			
			-- wait for neighbor dialogue to be done
			wait(5)
			
			-- play candy sound
			Candy:Play()
			
			-- while loop to give player candy and add it to their score
			-- and also showers the player in candy
			while CandyAmount ~= 0 do
				
				-- does the same thing as the other candy spawning
				local RandomCandy = math.random(1, 2)
				local CandyClone = CandyFolder:WaitForChild(RandomCandy):Clone()
				CandyClone.Parent = workspace
				CandyClone.Position = Part.Position + Vector3.new(3, 5, 0)
				CandyAmount -= 1
				wait(.01)
				player.leaderstats.Candy.Value += 1
				player.leaderstats.TotalCandy.Value += 1
			end
			wait(3)
			Person:Destroy()
		end
		
		-- turn debounce to false and enable proximity 
		-- prompt again to allow player to ring the doorbell again.
		debounce = false
		ProximityPrompt.Enabled = true
	elseif debounce == true then
		return
	end
end)
