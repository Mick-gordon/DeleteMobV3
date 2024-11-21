-- DeleteMob V3 Drawing Lib Made By @m1ckgordon
-- Variables 
local CoreGui = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer.PlayerGui;
local DrawingHolder = Instance.new("ScreenGui", CoreGui);
local CurrentCamera = game:GetService("Workspace").CurrentCamera;

-- Drawing
local DMDrawing = {}
do

	local function DrawLine(Properties)
		local LineProperties = {
			Visible = true,
			ZIndex = 0,
			Transparency = 0,
			Color = Color3.fromRGB(255, 255, 255),
			Thickness = 1,
			From = Vector2.new(0, 0),
			To = Vector2.new(0, 0)
		};

		for i,v in next, Properties do
			LineProperties[i] = v
		end;

		local Line = Instance.new("Frame", DrawingHolder);
		Line.Name = #DrawingHolder:GetChildren() + 1;
		Line.BorderSizePixel = 0;
		Line.BackgroundColor3 = LineProperties.Color;
		Line.BackgroundTransparency = LineProperties.Transparency;
		Line.Visible = LineProperties.Visible;
		Line.ZIndex = LineProperties.ZIndex;
		Line.AnchorPoint = Vector2.new(.5, .5);

		local Position = (LineProperties.From + LineProperties.To) / 2;
		Line.Position = UDim2.fromOffset(Position.X, Position.Y);
		Line.Size = UDim2.fromOffset(LineProperties.Thickness, (LineProperties.From - LineProperties.To).Magnitude);
		Line.Rotation = math.deg(math.atan2(LineProperties.From.Y - LineProperties.To.Y, LineProperties.From.X - LineProperties.To.X));

		local MT = setmetatable({}, {
			__newindex = (function(self, Property, Value)
				if Property == "To" then

					LineProperties.To = Value;
					local Position = (LineProperties.To + LineProperties.From) / 2;
					local Position = (LineProperties.To + LineProperties.From) / 2;
					Line.Rotation = math.deg(math.atan2(LineProperties.From.Y - LineProperties.To.Y, LineProperties.From.X - LineProperties.To.X));
					Line.Position = UDim2.fromOffset(Position.X, Position.Y);
					Line.Size = UDim2.fromOffset((LineProperties.To - LineProperties.From).Magnitude, LineProperties.Thickness);

				elseif Property == "From" then

					LineProperties.From = Value;
					local Position = (LineProperties.To + LineProperties.From) / 2;
					Line.Rotation = math.deg(math.atan2(LineProperties.From.Y - LineProperties.To.Y, LineProperties.From.X - LineProperties.To.X));
					Line.Position = UDim2.fromOffset(Position.X, Position.Y);
					Line.Size = UDim2.fromOffset((LineProperties.To - LineProperties.From).Magnitude, LineProperties.Thickness);

				elseif Property == "Visible" then

					LineProperties.Visible = Value;
					Line.Visible = Value;

				elseif Property == "ZIndex" then

					LineProperties.ZIndex = Value;
					Line.ZIndex = Value;

				elseif Property == "Transparency" then

					LineProperties.Transparency = Value;
					Line.BackgroundTransparency = Value;

				elseif Property == "Thickness" then

					LineProperties.Thickness = Value;
					local Position = (LineProperties.To + LineProperties.From) / 2;
					Line.Rotation = math.deg(math.atan2(LineProperties.From.Y - LineProperties.To.Y, LineProperties.From.X - LineProperties.To.X));
					Line.Position = UDim2.fromOffset(Position.X, Position.Y);
					Line.Size = UDim2.fromOffset((LineProperties.To - LineProperties.From).Magnitude, LineProperties.Thickness);

				elseif Property == "Color" then

					LineProperties.Color = Value;
					Line.BackgroundColor3 = LineProperties.Color;

				end;

			end),
			__index = (function(self, Property)
				if Property == "Remove" then
					return (function()
						Line:Destroy();
					end);
				end;

				return LineProperties[Property];
			end);
		});
		return MT
	end;
	
	local function DrawBox(Properties)
		local BoxProperties = {
			Visible = true,
			ZIndex = 0,
			Transparency = 0,
			Color = Color3.fromRGB(255, 255, 255),
			Thickness = 1,
			Filled = false,
			Position = Vector2.new(0, 0),
			Size = Vector2.new(10, 10),
		};

		for i,v in next, Properties do
			BoxProperties[i] = v
		end;

		local Upper = Instance.new("Frame", DrawingHolder);
		Upper.Name = #DrawingHolder:GetChildren() + 1;
		Upper.BorderSizePixel = 0;
		Upper.BackgroundColor3 = BoxProperties.Color;
		Upper.BackgroundTransparency = BoxProperties.Transparency;
		Upper.Visible = BoxProperties.Visible;
		Upper.ZIndex = BoxProperties.ZIndex;
		
		local Lower = Instance.new("Frame", DrawingHolder);
		Lower.Name = #DrawingHolder:GetChildren() + 1;
		Lower.BorderSizePixel = 0;
		Lower.BackgroundColor3 = BoxProperties.Color;
		Lower.BackgroundTransparency = BoxProperties.Transparency;
		Lower.Visible = BoxProperties.Visible;
		Lower.ZIndex = BoxProperties.ZIndex;
		
		local Right = Instance.new("Frame", DrawingHolder);
		Right.Name = #DrawingHolder:GetChildren() + 1;
		Right.BorderSizePixel = 0;
		Right.BackgroundColor3 = BoxProperties.Color;
		Right.BackgroundTransparency = BoxProperties.Transparency;
		Right.Visible = BoxProperties.Visible;
		Right.ZIndex = BoxProperties.ZIndex;
		
		local Left = Instance.new("Frame", DrawingHolder);
		Left.Name = #DrawingHolder:GetChildren() + 1;
		Left.BorderSizePixel = 0;
		Left.BackgroundColor3 = BoxProperties.Color;
		Left.BackgroundTransparency = BoxProperties.Transparency;
		Left.Visible = BoxProperties.Visible;
		Left.ZIndex = BoxProperties.ZIndex;
		
		local function PositionNSize()
			
			Left.Position = UDim2.fromOffset(BoxProperties.Position.X, BoxProperties.Position.Y);
			Left.Size = UDim2.fromOffset(BoxProperties.Thickness, BoxProperties.Size.Y);
			Upper.Position = UDim2.fromOffset(BoxProperties.Position.X, BoxProperties.Position.Y - BoxProperties.Thickness);
			Upper.Size = UDim2.fromOffset(BoxProperties.Size.X, BoxProperties.Thickness);
			Right.Position = UDim2.fromOffset(BoxProperties.Position.X + BoxProperties.Size.X  - BoxProperties.Thickness, BoxProperties.Position.Y);
			Right.Size = UDim2.fromOffset(BoxProperties.Thickness, BoxProperties.Size.Y);
			Lower.Position = UDim2.fromOffset(BoxProperties.Position.X, BoxProperties.Position.Y + BoxProperties.Size.Y - BoxProperties.Thickness);
			Lower.Size = UDim2.fromOffset(BoxProperties.Size.X, BoxProperties.Thickness);
			
		end;
		
		local function PositionNSizeFilled()
			
			Left.Position = UDim2.fromOffset(BoxProperties.Position.X, BoxProperties.Position.Y);
			Left.Size = UDim2.fromOffset(BoxProperties.Size.X, BoxProperties.Size.Y);
			
		end;
		

		local MT = setmetatable({}, {
			__newindex = (function(self, Property, Value)
				if Property == "Size" and BoxProperties.Filled ~= true then
					
					BoxProperties.Size = Value;
					PositionNSize();
					
				elseif Property == "Size" and BoxProperties.Filled then
					
				BoxProperties.Size = Value;
				PositionNSizeFilled();
				
				elseif Property == "Color" then
					
					BoxProperties.Color = Value;
					Lower.BackgroundColor3 = BoxProperties.Color;
					Upper.BackgroundColor3 = BoxProperties.Color;
					Right.BackgroundColor3 = BoxProperties.Color;
					Left.BackgroundColor3 = BoxProperties.Color;
				
				elseif Property == "Position" and BoxProperties.Filled ~= true then
				
					BoxProperties.Position = Value;
					PositionNSize();
				
				elseif Property == "Position" and BoxProperties.Filled then
					
					BoxProperties.Position = Value;
					PositionNSizeFilled();
				
				elseif Property == "Filled" and Value then
				
					BoxProperties.Filled = Value;
					Upper.Visible = false;
					Lower.Visible = false;
					Right.Visible = false;
					PositionNSizeFilled();
				
				elseif Property == "Filled" and Value ~= true then
					
					BoxProperties.Filled = Value;
					Upper.Visible = true;
					Lower.Visible = true;
					Right.Visible = true;
					
				elseif Property == "Visible" and BoxProperties.Filled ~= true then

					BoxProperties.Visible = Value;
					Upper.Visible = BoxProperties.Visible;
					Lower.Visible = BoxProperties.Visible;
					Right.Visible = BoxProperties.Visible;
					Left.Visible = BoxProperties.Visible;
					
				elseif Property == "Visible" and BoxProperties.Filled then

					BoxProperties.Visible = Value;
					Upper.Visible = false;
					Lower.Visible = false;
					Right.Visible = false;
					Left.Visible = BoxProperties.Visible;
					
				elseif Property == "Thickness" and BoxProperties.Filled ~= true then
					
					BoxProperties.Thickness = Value;
					PositionNSize();
				
				elseif Property == "ZIndex" then
					
					BoxProperties.ZIndex = Value;
					Upper.ZIndex = BoxProperties.ZIndex;
					Lower.ZIndex = BoxProperties.ZIndex;
					Right.ZIndex = BoxProperties.ZIndex;
					Left.ZIndex = BoxProperties.ZIndex;
				
				elseif Property == "Transparency"  then
					
					BoxProperties.Transparency = Value;
					Upper.Transparency = BoxProperties.Transparency;
					Lower.Transparency = BoxProperties.Transparency;
					Right.Transparency = BoxProperties.Transparency;
					Left.Transparency = BoxProperties.Transparency;
				
				end

			end),
			__index = (function(self, Property)
				if Property == "Remove" then
					return (function()
						Upper:Destroy();
						Lower:Destroy();
						Left:Destroy();
						Right:Destroy();
					end);
				end;

				return BoxProperties[Property];
			end);
		});
		return MT
	end;
	
	local function DrawCircle(Properties)
		local CircleProperties = {
			Visible = true,
			ZIndex = 0,
			Transparency = 0,
			Color = Color3.fromRGB(255, 255, 255),
			Thickness = 1,
			Filled = false,
			Position = Vector2.new(0, 0),
			Radius = 10,
		};

		for i,v in next, Properties do
			CircleProperties[i] = v
		end;
		
		local Fill = Instance.new("Frame", DrawingHolder);
		Fill.Size = UDim2.fromOffset(CircleProperties.Radius + CircleProperties.Radius/2 - CircleProperties.Thickness, CircleProperties.Radius + CircleProperties.Radius/2 - CircleProperties.Thickness);
		Fill.Transparency = (CircleProperties.Filled and CircleProperties.Transparency or CircleProperties.Filled ~= true and 1);
		Fill.Visible = CircleProperties.Visible;
		Fill.BackgroundColor3 = CircleProperties.Color;
		Fill.AnchorPoint = Vector2.new(.5, .5);
		Fill.Position = UDim2.fromOffset(CircleProperties.Position.X, CircleProperties.Position.Y);
		
		local UICorner = Instance.new("UICorner", Fill);
		UICorner.CornerRadius = UDim.new(1, 0);
		
		local Circumference = Instance.new("UIStroke", Fill);
		Circumference.Color = CircleProperties.Color;
		Circumference.Thickness = CircleProperties.Thickness;

		local MT = setmetatable({}, {
			__newindex = (function(self, Property, Value)
				
				if Property == "Visible" then
					
					CircleProperties.Visible = Value;
					Fill.Visible = CircleProperties.Visible;
					
				elseif Property == "Color" then
					
					CircleProperties.Color = Value;
					Fill.BackgroundColor3 = CircleProperties.Color;
					Circumference.Color = CircleProperties.Color;
					
				elseif Property == "Thickness" and CircleProperties.Filled ~= true then
					
					CircleProperties.Thickness = Value;
					Circumference.Thickness = CircleProperties.Thickness;
					
				elseif Property == "Position" then
					
					CircleProperties.Position = Value;
					Fill.Position = UDim2.fromOffset(CircleProperties.Position.X, CircleProperties.Position.Y);
					
				elseif Property == "Radius" then
					
					CircleProperties.Radius = Value;
					Fill.Size = UDim2.fromOffset(CircleProperties.Radius + CircleProperties.Radius/2 - CircleProperties.Thickness, CircleProperties.Radius + CircleProperties.Radius/2 - CircleProperties.Thickness);
					
				elseif Property == "Transparency" then
					
					CircleProperties.Transparency = Value;
					Fill.Transparency = (CircleProperties.Filled and CircleProperties.Transparency or CircleProperties.Filled ~= true and 1);
					Circumference.Transparency = CircleProperties.Transparency;
				
				elseif Property == "ZIndex" then
					
					CircleProperties.ZIndex = Value;
					Fill.ZIndex = CircleProperties.ZIndex;
				
				elseif Property == "Filled" then
					
					CircleProperties.Filled = Value;
					Fill.Transparency = (CircleProperties.Filled and CircleProperties.Transparency or CircleProperties.Filled ~= true and 1);
				
				end;

			end),
			__index = (function(self, Property)
				if Property == "Remove" then
					return (function()
						Fill:Destroy();
						UICorner:Destroy();
						Circumference:Destroy();
					end);
				end;

				return CircleProperties[Property];
			end);
		});
		return MT
	end;


	function DMDrawing.new(Type, Properties)

		if Type == "Line" then
			return DrawLine(Properties);
		elseif Type == "Box" then
			return DrawBox(Properties);
		elseif Type == "Circle" then
			return DrawCircle(Properties)
		end;

	end;


end;
