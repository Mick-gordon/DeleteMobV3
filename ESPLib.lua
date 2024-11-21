local DMDrawing = {
		Font = "Code",
	}
	local function DrawLine(Properties)
		local LineProperties = {
			Visible = false,
			Enabled = false,
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
		Line.Visible = LineProperties.Visible or LineProperties.Enabled;
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

				elseif Property == "Visible" or Property == "Enabled" then

					LineProperties.Visible = Value;
					LineProperties.Enabled = Value;
					Line.Visible = LineProperties.Visible or LineProperties.Enabled;

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
			Visible = false,
			Enabled = false,
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
		Upper.Visible = BoxProperties.Visible or BoxProperties.Enabled;
		Upper.ZIndex = BoxProperties.ZIndex;

		local Lower = Instance.new("Frame", DrawingHolder);
		Lower.Name = #DrawingHolder:GetChildren() + 1;
		Lower.BorderSizePixel = 0;
		Lower.BackgroundColor3 = BoxProperties.Color;
		Lower.BackgroundTransparency = BoxProperties.Transparency;
		Lower.Visible = BoxProperties.Visible or BoxProperties.Enabled;
		Lower.ZIndex = BoxProperties.ZIndex;

		local Right = Instance.new("Frame", DrawingHolder);
		Right.Name = #DrawingHolder:GetChildren() + 1;
		Right.BorderSizePixel = 0;
		Right.BackgroundColor3 = BoxProperties.Color;
		Right.BackgroundTransparency = BoxProperties.Transparency;
		Right.Visible = BoxProperties.Visible or BoxProperties.Enabled;
		Right.ZIndex = BoxProperties.ZIndex;

		local Left = Instance.new("Frame", DrawingHolder);
		Left.Name = #DrawingHolder:GetChildren() + 1;
		Left.BorderSizePixel = 0;
		Left.BackgroundColor3 = BoxProperties.Color;
		Left.BackgroundTransparency = BoxProperties.Transparency;
		Left.Visible = BoxProperties.Visible or BoxProperties.Enabled;
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
					PositionNSize();

				elseif Property == "Visible" and BoxProperties.Filled ~= true or Property == "Enabled" and BoxProperties.Filled ~= true then

					BoxProperties.Visible = Value;
					BoxProperties.Enabled = Value;
					Upper.Visible = BoxProperties.Visible or BoxProperties.Enabled;
					Lower.Visible = BoxProperties.Visible or BoxProperties.Enabled; 
					Right.Visible = BoxProperties.Visible or BoxProperties.Enabled;
					Left.Visible = BoxProperties.Visible or BoxProperties.Enabled;

				elseif Property == "Visible" and BoxProperties.Filled or Property == "Enabled" and BoxProperties.Filled then

					BoxProperties.Visible = Value;
					BoxProperties.Enabled = Value;
					Upper.Visible = false;
					Lower.Visible = false;
					Right.Visible = false;
					Left.Visible = BoxProperties.Visible or BoxProperties.Enabled;

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
			Visible = false,
			Enabled = false,
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
		Fill.Visible = CircleProperties.Visible or CircleProperties.Enabled;
		Fill.BackgroundColor3 = CircleProperties.Color;
		Fill.AnchorPoint = Vector2.new(.5, .5);
		Fill.Position = UDim2.fromOffset(CircleProperties.Position.X, CircleProperties.Position.Y);
		Fill.ZIndex = CircleProperties.ZIndex;

		local UICorner = Instance.new("UICorner", Fill);
		UICorner.CornerRadius = UDim.new(1, 0);

		local Circumference = Instance.new("UIStroke", Fill);
		Circumference.Color = CircleProperties.Color;
		Circumference.Thickness = CircleProperties.Thickness;
		Circumference.Transparency = CircleProperties.Transparency;

		local MT = setmetatable({}, {
			__newindex = (function(self, Property, Value)

				if Property == "Visible" or Property == "Enabled" then

					CircleProperties.Visible = Value;
					CircleProperties.Enabled = Value;
					Fill.Visible = CircleProperties.Visible or CircleProperties.Enabled;

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
		return MT;
	end;

	local function DrawText(Properties)
		local TextProperties = {
			Visible = false,
			Enabled = false,
			ZIndex = 0,
			Transparency = 0,
			Color = Color3.fromRGB(255, 255, 255),
			TextBounds = Vector2.zero,
			Position = Vector2.new(0, 0),
			Text = "",
			Size = 12,
			Center = true,
			Outline = true,
			OutlineColor = Color3.fromRGB(0, 0, 0),
			Font = DMDrawing.Font;
		};

		for i,v in next, Properties do
			TextProperties[i] = v
		end;

		local Text = Instance.new("TextLabel", DrawingHolder);
		Text.Visible = TextProperties.Visible or TextProperties.Enabled;
		Text.BackgroundTransparency = 1;
		Text.TextColor3 = TextProperties.Color;
		Text.Text = TextProperties.Text;
		Text.TextXAlignment = (TextProperties.Center and Enum.TextXAlignment.Center or TextProperties.Center ~= true and Enum.TextXAlignment.Left);
		Text.Position = UDim2.fromOffset(TextProperties.Position.X, TextProperties.Position.Y);
		Text.ZIndex = TextProperties.ZIndex;
		xpcall(function()
			Text.Font = TextProperties.Font;
		end,function()
			warn("DeleteMob: Font Was Not Found!");
			print("DMDrawing function DrawText");
		end);

		local UIStroke = Instance.new("UIStroke", Text); -- Looks Better Than The One Already Used In Text.TextStroke.
		UIStroke.Enabled = TextProperties.Outline;
		UIStroke.Color = TextProperties.OutlineColor;

		TextProperties.TextBounds = Text.TextBounds;


		local MT = setmetatable({}, {
			__newindex = (function(self, Property, Value)

				if Property == "Visible" or Property == "Enabled" then

					TextProperties.Visible = Value;
					TextProperties.Enabled = Value;
					Text.Visible = TextProperties.Visible or TextProperties.Enabled;

				elseif Property == "ZIndex" then

					TextProperties.ZIndex = Value;
					Text.ZIndex = TextProperties.ZIndex;

				elseif Property == "Transparency" then

					TextProperties.Transparency = Value;
					Text.TextTransparency = TextProperties.Transparency;
					UIStroke.Transparency = TextProperties.Transparency;

				elseif Property == "Color" then

					TextProperties.Color = Value;
					Text.TextColor3 = TextProperties.Color;

				elseif Property == "Position" then

					TextProperties.Position = Value;
					TextProperties.TextBounds = Text.TextBounds;
					Text.Position = UDim2.fromOffset(TextProperties.Position.X, TextProperties.Position.Y);

				elseif Property == "Text" then

					TextProperties.Text = Value;
					TextProperties.TextBounds = Text.TextBounds;
					Text.Text = TextProperties.Text;

				elseif Property == "Size" then

					TextProperties.Size = Value;
					Text.TextSize = Value;

				elseif Property == "Center" then

					TextProperties.Center = Value;
					Text.TextXAlignment = (TextProperties.Center and Enum.TextXAlignment.Center or TextProperties.Center ~= true and Enum.TextXAlignment.Left);

				elseif Property == "Outline" then

					TextProperties.Outline = Value;
					UIStroke.Enabled = TextProperties.Outline;

				elseif Property == "OutlineColor" then

					TextProperties.OutlineColor = Value;
					UIStroke.Color = TextProperties.OutlineColor;

				elseif Property == "Font" then

					TextProperties.Font = Value;
					xpcall(function()
						Text.Font = TextProperties.Font;
					end,function()
						warn("DeleteMob: Font Was Not Found!");
						print("DMDrawing function DrawText");
					end);

				end

			end),
			__index = (function(self, Property)
				if Property == "Remove" then
					return (function()
						Text:Destroy();
						UIStroke:Destroy();
					end);
				end;

				return TextProperties[Property];
			end);
		});
		return MT;
	end;


	function DMDrawing.new(Type, Properties)

		if Type == "Line" then
			return DrawLine(Properties);
		elseif Type == "Box" then
			return DrawBox(Properties);
		elseif Type == "Circle" then
			return DrawCircle(Properties)
		elseif Type == "Text" then
			return DrawText(Properties);
		end;

	end;

	function DMDrawing.Fonts(Type) -- I Am To Lazy To Add Anything Else
		if typeof(Type) == "string" then
			DMDrawing.Font = Type;
		else
			warn("DMDrawing.Fonts Must Be A String!");
		end;
	end;


	return DMDrawing;
