
	local Libary = { 
		Flags = { };
		Items = { };
	};

	local UserInputService = game:GetService("UserInputService");
	local RunService = game:GetService("RunService");
	local TweenService = game:GetService("TweenService");

	local CoreGui = game:FindFirstChild("CoreGui");
	local PlayerGui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui");

	local LocalPlayer = game:GetService("Players").LocalPlayer;
	local Mouse = LocalPlayer:GetMouse();
	local CurrentCamera = game.Workspace.CurrentCamera;

	Libary.Theme = {
		BackGround1 = Color3.fromRGB(47, 47, 47);
		BackGround2 = Color3.fromRGB(38, 38, 38);

		Outline = Color3.fromRGB(30, 87, 75);

		Selected = Color3.fromRGB(18, 161, 130);

		TextColor = Color3.fromRGB(255, 255, 255);
		Font = "Montserrat";
		TextSize = 14;

		TabOptionsHoverTween = 0.3;
		TabOptionsSelectTween = 0.3;
		TabOptionsUnSelectTween = 0.2;

		TabTween = 0.5;

		SubtabTween = 0.35;
		SubtabbarTween = 0.4;

		CloseOpenTween = 0.8;

		ToggleTween = 0.2;
		SliderTween = 0.07;
	}; 

	function Libary:CreateWindow(Name, Toggle, keybind)
		local Window = { };
		Window.Name = Name or "DeleteMob";
		Window.Toggle = Toggle or false;
		Window.Keybind = keybind or Enum.KeyCode.RightShift;
		Window.ColorPickerSelected = nil;

		local dragging, dragInput, dragStart, startPos
		UserInputService.InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				local delta = input.Position - dragStart
				Window.Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end
		end)

		local dragstart = function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = Window.Main.Position

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end

		local dragend = function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end

		local function CloseFrame(Frame)
			if Frame  and Frame.Name ~= "c" then
				local CloseTween = TweenService:Create(Frame, TweenInfo.new(Libary.Theme.CloseOpenTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(921, 0)})
				CloseTween:Play()
				CloseTween.Completed:Connect(function()
					Frame.Visible = false;
				end)
			else
				local CloseTween = TweenService:Create(Frame, TweenInfo.new(Libary.Theme.CloseOpenTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(266, 0)})
				CloseTween:Play()
				CloseTween.Completed:Connect(function()
					Frame.Visible = false;
				end)
			end
		end

		local function OpenFrame(Frame)
			if Frame and Frame.Name ~= "c" then
				Frame.Size = UDim2.fromOffset(921, 0)
				Frame.Visible = true;

				local OpenTween = TweenService:Create(Frame, TweenInfo.new(Libary.Theme.CloseOpenTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(921, 428)})
				OpenTween:Play()
			else
				Frame.Size = UDim2.fromOffset(266, 0)
				Frame.Visible = true;

				local OpenTween = TweenService:Create(Frame, TweenInfo.new(Libary.Theme.CloseOpenTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(266, 277)})
				OpenTween:Play()
			end
		end

		Window.ScreenGui = Instance.new("ScreenGui", CoreGui or PlayerGui);
		Window.ScreenGui.ResetOnSpawn = false;
		Window.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global;

		function Window:CreateColorPicker()
			local ColorPicker = { };
			ColorPicker.Flag = nil;
			ColorPicker.Color = nil;
			ColorPicker.HuePosition = 0;

			ColorPicker.Main = Instance.new("Frame", Window.ScreenGui);
			ColorPicker.Main.Size = UDim2.fromOffset(266, 277);
			ColorPicker.Main.BackgroundColor3 = Libary.Theme.BackGround2
			ColorPicker.Main.ClipsDescendants = true;
			ColorPicker.Main.Name = "c"

			ColorPicker.UICorner = Instance.new("UICorner", ColorPicker.Main);
			ColorPicker.UICorner.CornerRadius = UDim.new(0, 4);

			ColorPicker.UIStroke = Instance.new("UIStroke", ColorPicker.Main);
			ColorPicker.UIStroke.Color = Libary.Theme.Outline;
			ColorPicker.UIStroke.Thickness = 1;
			ColorPicker.UIStroke.ApplyStrokeMode = "Border";

			local dragging2, dragInput2, dragStart2, startPos2
			UserInputService.InputChanged:Connect(function(input)
				if input == dragInput2 and dragging2 then
					local delta = input.Position - dragStart2
					ColorPicker.Main.Position = UDim2.new(startPos2.X.Scale, startPos2.X.Offset + delta.X, startPos2.Y.Scale, startPos2.Y.Offset + delta.Y)
				end
			end)

			local dragStart2 = function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging2 = true
					dragStart2 = input.Position
					startPos2 = ColorPicker.Main.Position

					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging2 = false
						end
					end)
				end
			end

			local dragend2 = function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					dragInput2 = input
				end
			end

			UserInputService.InputBegan:Connect(function(Key)
				if Key.KeyCode == Window.Keybind then
					if ColorPicker.Main.Visible then
						CloseFrame(ColorPicker.Main);
					else
						OpenFrame(ColorPicker.Main);
					end
				end
			end)

			ColorPicker.Main.InputBegan:Connect(dragStart2);
			ColorPicker.Main.InputChanged:Connect(dragend2);

			ColorPicker.Frame = Instance.new("Frame", ColorPicker.Main);
			ColorPicker.Frame.Size = UDim2.fromScale(1, 1);
			ColorPicker.Frame.BackgroundTransparency = 1;

			ColorPicker.Line = Instance.new("Frame", ColorPicker.Frame);
			ColorPicker.Line.Position = UDim2.fromOffset(0, 34);
			ColorPicker.Line.Size = UDim2.new(1, 0, 0, 1);
			ColorPicker.Line.BorderSizePixel = 0;
			ColorPicker.Line.BackgroundColor3 = Libary.Theme.Outline;

			ColorPicker.Lable = Instance.new("TextLabel", ColorPicker.Frame);
			ColorPicker.Lable.Size = UDim2.fromOffset(116, 34);
			ColorPicker.Lable.BackgroundTransparency = 1;
			ColorPicker.Lable.RichText = true;
			ColorPicker.Lable.Text = "<b>" .. "Colorpicker" .."</b>";
			ColorPicker.Lable.Font = Enum.Font.Ubuntu;
			ColorPicker.Lable.TextSize = 18;
			ColorPicker.Lable.TextColor3 = Color3.fromRGB(255, 255, 255);

			ColorPicker.Saturation = Instance.new("ImageButton", ColorPicker.Frame);
			ColorPicker.Saturation.BackgroundTransparency = 0;
			ColorPicker.Saturation.Position = UDim2.fromOffset(11, 45);
			ColorPicker.Saturation.Size = UDim2.fromOffset(220, 220);
			ColorPicker.Saturation.Image = "rbxassetid://13901004307";
			ColorPicker.Saturation.AutoButtonColor = false;

			ColorPicker.SaturationSelect = Instance.new("Frame", ColorPicker.Saturation);
			ColorPicker.SaturationSelect.Size = UDim2.fromOffset(1, 1);
			ColorPicker.SaturationSelect.BackgroundColor3 = Color3.fromRGB(255 ,255 ,255);
			ColorPicker.SaturationSelect.BorderColor3 = Color3.fromRGB(0, 0, 0);

			ColorPicker.Hue = Instance.new("TextButton", ColorPicker.Frame);
			ColorPicker.Hue.Position = UDim2.fromOffset(237, 45);
			ColorPicker.Hue.Size = UDim2.fromOffset(22, 193);
			ColorPicker.Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
			ColorPicker.Hue.BorderSizePixel = 0;
			ColorPicker.Hue.AutoButtonColor = false;
			ColorPicker.Hue.Text = "";

			ColorPicker.UiGradient = Instance.new("UIGradient", ColorPicker.Hue);
			ColorPicker.UiGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))}
			ColorPicker.UiGradient.Rotation = 90;

			ColorPicker.HueSelect = Instance.new("Frame", ColorPicker.Hue);
			ColorPicker.HueSelect.Size = UDim2.fromOffset(22, 1);
			ColorPicker.HueSelect.BackgroundColor3 = Color3.fromRGB(255 ,255 ,255);
			ColorPicker.HueSelect.BorderColor3 = Color3.fromRGB(0, 0, 0);

			ColorPicker.View = Instance.new("Frame", ColorPicker.Frame);
			ColorPicker.View.Position = UDim2.fromOffset(237, 243);
			ColorPicker.View.Size = UDim2.fromOffset(22, 22);
			ColorPicker.View.BackgroundColor3 = Color3.fromRGB(255 ,255 ,255);
			ColorPicker.View.BorderSizePixel = 0;

			local Hue, Sat, Val;

			function ColorPicker:Set(color, transparency, ignore)
				transparency = 0;

				if type(color) == "table" then
					transparency = color.a;
					color = color.c;
				end;

				Hue, Sat, Val = color:ToHSV();

				ColorPicker.Color = color;
				ColorPicker.Transparency = transparency;

				if not ignore then
					ColorPicker.SaturationSelect.Position = UDim2.new(
						math.clamp(Sat, 0, 1),
						Sat < 1 and -1 or -3,
						math.clamp(1 - Val, 0, 1),
						1 - Val < 1 and -1 or -3
					);         

					ColorPicker.HuePosition = Hue;

					ColorPicker.HueSelect.Position = UDim2.new(
						0,
						0,
						math.clamp(1 - Hue, 0, 1),
						1 - Hue < 1 and -1 or -2
					);

					Libary.Flags[ColorPicker.Flag] = color;
				end;

				if ColorPicker.Flag then
					Libary.Flags[ColorPicker.Flag] = color;
				end;

				pcall(ColorPicker.CallBack, color);

				ColorPicker.Saturation.BackgroundColor3 = Color3.fromHSV(ColorPicker.HuePosition, 1, 1);
				ColorPicker.View.BackgroundColor3 = color;
			end;

			function ColorPicker:Add(Flag, CallBack)
				ColorPicker.Flag = Flag;
				ColorPicker.CallBack = CallBack;
				ColorPicker:Set(Libary.Flags[Flag], 0, false);
			end;

			function ColorPicker.SlideSaturation(input)
				local SizeX = math.clamp((input.Position.X - ColorPicker.Saturation.AbsolutePosition.X) / ColorPicker.Saturation.AbsoluteSize.X, 0, 1);
				local SizeY = 1 - math.clamp((input.Position.Y - ColorPicker.Saturation.AbsolutePosition.Y) / ColorPicker.Saturation.AbsoluteSize.Y, 0, 1);

				ColorPicker.SaturationSelect.Position = UDim2.new(SizeX, SizeX < 1 and -1 or -3, 1 - SizeY, 1 - SizeY < 1 and -1 or -3);
				ColorPicker:Set(Color3.fromHSV(ColorPicker.HuePosition, SizeX, SizeY), 0, true);
			end;

			ColorPicker.Saturation.MouseButton1Down:Connect(function()
				ColorPicker.SlidingSaturation = true;
				ColorPicker.SlideSaturation({ Position = UserInputService:GetMouseLocation() - Vector2.new(0, 38) });
			end);

			ColorPicker.Saturation.InputChanged:Connect(function()
				if ColorPicker.SlidingSaturation then
					ColorPicker.SlideSaturation({ Position = UserInputService:GetMouseLocation() - Vector2.new(0, 38) });
				end;
			end);

			ColorPicker.Saturation.MouseButton1Up:Connect(function()
				ColorPicker.SlidingSaturation = false;
			end);

			ColorPicker.Saturation.MouseLeave:Connect(function()
				ColorPicker.SlidingSaturation = false;
			end);

			function ColorPicker.SlideHue(input)
				local SizeY = 1 - math.clamp((input.Position.Y - ColorPicker.Hue.AbsolutePosition.Y) / ColorPicker.Hue.AbsoluteSize.Y, 0, 1);

				ColorPicker.HueSelect.Position = UDim2.new(0, 0, 1 - SizeY, 1 - SizeY < 1 and -1 or -2);
				ColorPicker.HuePosition = SizeY;

				ColorPicker:Set(Color3.fromHSV(SizeY, Sat, Val), 0, true);
			end;

			ColorPicker.Hue.MouseButton1Down:Connect(function()
				ColorPicker.SlidingHue = true
				ColorPicker.SlideHue({ Position = UserInputService:GetMouseLocation() - Vector2.new(0, 38) });
			end);

			ColorPicker.Hue.InputChanged:Connect(function()
				if ColorPicker.SlidingHue then
					ColorPicker.SlideHue({ Position = UserInputService:GetMouseLocation() - Vector2.new(0, 38) });
				end;
			end);

			ColorPicker.Hue.MouseButton1Up:Connect(function()
				ColorPicker.SlidingHue = false;
			end);

			ColorPicker.Hue.MouseLeave:Connect(function()
				ColorPicker.SlidingHue = false;
			end);

			return ColorPicker;
		end;

		local ColorPickerM = Window:CreateColorPicker();

		Window.Main = Instance.new("TextButton", Window.ScreenGui);
		Window.Main.Size = UDim2.fromOffset(921, 428);
		Window.Main.Position = UDim2.fromScale(0.3, 0.3);
		Window.Main.BackgroundColor3 = Libary.Theme.BackGround1;
		Window.Main.ClipsDescendants = true;
		Window.Main.Visible = true;
		Window.Main.AutoButtonColor = false;
		Window.Main.Text = "";
		Window.Main.InputBegan:Connect(dragstart);
		Window.Main.InputChanged:Connect(dragend);

		Window.UICorner = Instance.new("UICorner", Window.Main);
		Window.UICorner.CornerRadius = UDim.new(0, 4);

		Window.UIStroke = Instance.new("UIStroke", Window.Main);
		Window.UIStroke.Color = Libary.Theme.Outline;
		Window.UIStroke.Thickness = 1;
		Window.UIStroke.ApplyStrokeMode = "Border";

		UserInputService.InputBegan:Connect(function(Key)
			if Key.KeyCode == Window.Keybind then
				if Window.Main.Visible then
					CloseFrame(Window.Main);
				else
					OpenFrame(Window.Main);
				end
			end
		end)

		Window.Frame = Instance.new("Frame", Window.Main);
		Window.Frame.BackgroundColor3 = Libary.Theme.BackGround1;
		Window.Frame.Position = UDim2.fromOffset(1, 1);
		Window.Frame.Size = UDim2.fromOffset(919, 426);

		Window.UICorner2 = Instance.new("UICorner", Window.Frame);
		Window.UICorner2.CornerRadius = UDim.new(0, 4);

		Window.Misc1 = Instance.new("Frame", Window.Frame);
		Window.Misc1.Position = UDim2.fromScale(0.969, 0);
		Window.Misc1.Size = UDim2.fromScale(0.031, 0.063);
		Window.Misc1.BackgroundColor3 = Libary.Theme.BackGround2;
		Window.Misc1.BorderSizePixel = 0;

		Window.UICorner3 = Instance.new("UICorner", Window.Misc1);
		Window.UICorner3.CornerRadius = UDim.new(0, 4);

		Window.Misc2 = Instance.new("Frame", Window.Frame);
		Window.Misc2.Position = UDim2.fromScale(0, 0);
		Window.Misc2.Size = UDim2.fromScale(0.031, 0.063);
		Window.Misc2.BackgroundColor3 = Libary.Theme.BackGround2;
		Window.Misc2.BorderSizePixel = 0;

		Window.UICorner4 = Instance.new("UICorner", Window.Misc2);
		Window.UICorner4.CornerRadius = UDim.new(0, 4);

		Window.Misc3 = Instance.new("Frame", Window.Frame);
		Window.Misc3.Position = UDim2.fromScale(0, 0.935);
		Window.Misc3.Size = UDim2.fromScale(0.031, 0.063);
		Window.Misc3.BackgroundColor3 = Libary.Theme.BackGround2;
		Window.Misc3.BorderSizePixel = 0;

		Window.UICorner5 = Instance.new("UICorner", Window.Misc3);
		Window.UICorner5.CornerRadius = UDim.new(0, 4);

		Window.Misc4 = Instance.new("Frame", Window.Frame);
		Window.Misc4.Position = UDim2.fromScale(0, 0.032);
		Window.Misc4.Size = UDim2.fromScale(0.164, 0.939);
		Window.Misc4.BackgroundColor3 = Libary.Theme.BackGround2;
		Window.Misc4.BorderSizePixel = 0;

		Window.Misc5 = Instance.new("Frame", Window.Frame);
		Window.Misc5.Position = UDim2.fromScale(0.017, 0);
		Window.Misc5.Size = UDim2.fromScale(0.964, 0.126);
		Window.Misc5.BackgroundColor3 = Libary.Theme.BackGround2;
		Window.Misc5.BorderSizePixel = 0;
		Window.Misc5.ZIndex = 3;

		Window.Misc6 = Instance.new("Frame", Window.Frame);
		Window.Misc6.Position = UDim2.fromScale(0.969, 0.019);
		Window.Misc6.Size = UDim2.fromScale(0.031, 0.107);
		Window.Misc6.BackgroundColor3 = Libary.Theme.BackGround2;
		Window.Misc6.BorderSizePixel = 0;

		Window.Misc7 = Instance.new("Frame", Window.Frame);
		Window.Misc7.Position = UDim2.fromScale(0.017, 0.935);
		Window.Misc7.Size = UDim2.fromScale(0.147, 0.063);
		Window.Misc7.BackgroundColor3 = Libary.Theme.BackGround2;
		Window.Misc7.BorderSizePixel = 0;

		Window.Border = Instance.new("Frame", Window.Frame);
		Window.Border.Position = UDim2.fromScale(0.163, -0.001);
		Window.Border.Size = UDim2.fromOffset(1, 428);
		Window.Border.BackgroundColor3 = Libary.Theme.Outline;
		Window.Border.BorderSizePixel = 0;
		Window.Border.ZIndex = 4;

		Window.Border2 = Instance.new("Frame", Window.Frame);
		Window.Border2.Position = UDim2.fromScale(0.164, 0.124);
		Window.Border2.Size = UDim2.fromOffset(770, 1);
		Window.Border2.BackgroundColor3 = Libary.Theme.Outline;
		Window.Border2.BorderSizePixel = 0;
		Window.Border2.ZIndex = 3;

		Window.TextLable = Instance.new("TextLabel", Window.Frame);
		Window.TextLable.BackgroundTransparency = 1;
		Window.TextLable.RichText = true;
		Window.TextLable.Text = "<b>" .. Window.Name .."</b>";
		Window.TextLable.Font = Libary.Theme.Font;
		Window.TextLable.TextSize = 23;
		Window.TextLable.TextColor3 = Libary.Theme.TextColor;
		Window.TextLable.Position = UDim2.fromOffset(17, 10);
		Window.TextLable.Size = UDim2.fromScale(0.126, 0.078);
		Window.TextLable.ZIndex = 4;

		Window.SubOptionsHoler = Instance.new("Folder", Window.Frame);

		Window.TabHolder = Instance.new("Frame", Window.Frame);
		Window.TabHolder.BackgroundTransparency = 1;
		Window.TabHolder.Position = UDim2.fromScale(0.165, 0.121);
		Window.TabHolder.Size = UDim2.fromScale(0.836, 0.872);
		Window.TabHolder.ClipsDescendants = true;

		Window.Tablist = Instance.new("ScrollingFrame", Window.Frame);
		Window.Tablist.Position = UDim2.fromOffset(0, 54);
		Window.Tablist.Size = UDim2.fromOffset(150, 362);
		Window.Tablist.BackgroundColor3 = Libary.Theme.BackGround2;
		Window.Tablist.BorderSizePixel = 0;
		Window.Tablist.ScrollBarThickness = 0;

		Window.UiList = Instance.new("UIListLayout", Window.Tablist);
		Window.UiList.FillDirection = "Vertical";
		Window.UiList.HorizontalAlignment = "Left";
		Window.UiList.SortOrder = "LayoutOrder"
		Window.UiList.VerticalAlignment = "Top";

		Window.OpenedColorPickers = { };
		Window.Tabs = { };

		function Window:UpdateTabList()
			Window.Tablist.CanvasSize = UDim2.fromOffset(0, Window.UiList.AbsoluteContentSize.Y);
		end

		function Window:CreateTabSection(text)
			local SubTab = { };
			SubTab.Text = text or "";

			SubTab.TextLable = Instance.new("TextLabel", Window.Tablist);
			SubTab.TextLable.BackgroundTransparency = 1;
			SubTab.TextLable.Size = UDim2.fromScale(1, 0.05);
			SubTab.TextLable.Text = "      " .. SubTab.Text;
			SubTab.TextLable.TextColor3 = Libary.Theme.TextColor;
			SubTab.TextLable.TextSize = 13;
			SubTab.TextLable.Font = Libary.Theme.Font;
			SubTab.TextLable.TextXAlignment = "Left"

			Window:UpdateTabList();
			return SubTab;
		end

		function Window:CreateTab(Name)
			local Tab = { };
			Tab.Name = Name or "";

			function Tab:Select()
				for i,v in pairs(Window.Tablist:GetChildren()) do
					if v:IsA("TextButton") then
						TweenService:Create(v.SelectedAnimation, TweenInfo.new(Libary.Theme.TabOptionsSelectTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.fromScale(0, 1)}):Play();
					end;
				end;
				if Tab.MainTab.Visible ~= true then
					for i,v in pairs(Window.TabHolder:GetChildren()) do
						v.Visible = false;
					end;
					Tab.MainTab.Position = UDim2.new(0, Tab.MainTab.Position.X.Offset, 0.15, 0);
					Tab.MainTab.Visible = true;
					TweenService:Create(Tab.MainTab, TweenInfo.new(Libary.Theme.TabTween, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, Tab.MainTab.Position.X.Offset, 0, 0)}):Play();
				end;
				TweenService:Create(Tab.SelectedAnimation, TweenInfo.new(Libary.Theme.TabOptionsSelectTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.fromScale(1.1, 1)}):Play();
				for i,v in pairs(Window.SubOptionsHoler:GetChildren()) do
					v.Visible = false;
				end
				local SubTables = Tab.SubOptions:GetChildren();

				if #SubTables > 1 then
					Tab.SubOptions.Visible = true;
					Tab.SubSelector.Visible = true;
				end
			end;

			Tab.SubOptions = Instance.new("Frame", Window.SubOptionsHoler);
			Tab.SubOptions.Position = UDim2.fromScale(0.178, 0);
			Tab.SubOptions.Size = UDim2.fromOffset(755, 53);
			Tab.SubOptions.BackgroundTransparency = 1;
			Tab.SubOptions.Visible = false;
			Tab.SubOptions.Name = `{Tab.Name}SubTable`;

			Tab.UiList2 = Instance.new("UIListLayout", Tab.SubOptions);
			Tab.UiList2.Padding = UDim.new(0, 4);
			Tab.UiList2.FillDirection = "Horizontal";
			Tab.UiList2.HorizontalAlignment = "Left";
			Tab.UiList2.SortOrder = "LayoutOrder";
			Tab.UiList2.VerticalAlignment = "Top";

			Tab.SubSelector = Instance.new("Frame", Window.SubOptionsHoler);
			Tab.SubSelector.Size = UDim2.fromOffset(65, 1);
			Tab.SubSelector.Position = UDim2.fromScale(0.178, 0.124);
			Tab.SubSelector.BorderSizePixel = 0;
			Tab.SubSelector.BackgroundColor3 = Libary.Theme.Selected;
			Tab.SubSelector.Visible = false;
			Tab.SubSelector.Name = `{Tab.Name}SubSelector`;

			Tab.Button = Instance.new("TextButton", Window.Tablist);
			Tab.Button.Size = UDim2.new(1, 0, 0, 34);
			Tab.Button.BackgroundColor3 = Libary.Theme.BackGround2;
			Tab.Button.BorderSizePixel = 0;
			Tab.Button.AutoButtonColor = false;
			Tab.Button.Text = "";
			Tab.Button.MouseEnter:Connect(function()
				TweenService:Create(Tab.TextLable, TweenInfo.new(Libary.Theme.TabOptionsHoverTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0.06, 0,0.287, 0)}):Play();
			end)
			Tab.Button.MouseLeave:Connect(function()
				TweenService:Create(Tab.TextLable, TweenInfo.new(Libary.Theme.TabOptionsHoverTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0,0.287, 0)}):Play();
			end)
			Tab.Button.MouseButton1Click:Connect(function()Tab:Select();end);

			Tab.TextLable = Instance.new("TextLabel", Tab.Button);
			Tab.TextLable.BackgroundTransparency = 1;
			Tab.TextLable.Size = UDim2.fromScale(1, 0.458);
			Tab.TextLable.Position = UDim2.fromScale(0, 0.287);
			Tab.TextLable.Text = Tab.Name;
			Tab.TextLable.TextColor3 = Libary.Theme.TextColor;
			Tab.TextLable.TextSize = Libary.Theme.TextSize;
			Tab.TextLable.Font = Libary.Theme.Font;
			Tab.TextLable.TextXAlignment = "Center";
			Tab.TextLable.ZIndex = 2;
			Tab.TextLable.TextScaled = true;

			Tab.SelectedAnimation = Instance.new("Frame", Tab.Button);
			Tab.SelectedAnimation.AnchorPoint = Vector2.new(0.5, 0.5);
			Tab.SelectedAnimation.Position = UDim2.fromScale(0.5, 0.5);
			Tab.SelectedAnimation.Size = UDim2.fromScale(0, 1);
			Tab.SelectedAnimation.ZIndex = 1;
			Tab.SelectedAnimation.BackgroundColor3 = Color3.fromRGB(45, 45, 45);
			Tab.SelectedAnimation.BorderSizePixel = 0;
			Tab.SelectedAnimation.Name = "SelectedAnimation";

			Tab.UICorner = Instance.new("UICorner", Tab.SelectedAnimation); -- Makes It Look a Bit Better For The Few Miliseconds.
			Tab.UICorner.CornerRadius = UDim.new(0, 10);

			Tab.MainTab = Instance.new("Frame", Window.TabHolder); -- For Sub Tab
			Tab.MainTab.Size = UDim2.fromOffset(768, 371);
			Tab.MainTab.Position = UDim2.fromOffset(0, 0);
			Tab.MainTab.BackgroundTransparency = 1;
			Tab.MainTab.Visible = false;

			Tab.UIListLayout3 = Instance.new("UIListLayout", Tab.MainTab);
			Tab.UIListLayout3.Padding = UDim.new(0,0);
			Tab.UIListLayout3.HorizontalAlignment = "Left";
			Tab.UIListLayout3.SortOrder = "LayoutOrder";
			Tab.UIListLayout3.FillDirection = "Horizontal";

			Tab.TabScroll = Instance.new("ScrollingFrame", Tab.MainTab);
			Tab.TabScroll.Position = UDim2.fromOffset(0, 0);
			Tab.TabScroll.Size = UDim2.fromOffset(768, 371);
			Tab.TabScroll.BackgroundTransparency = 1;
			Tab.TabScroll.ScrollBarThickness = 0;

			Tab.Left = Instance.new("Frame", Tab.TabScroll);
			Tab.Left.Size = UDim2.fromScale(0.1, 1);
			Tab.Left.Position = UDim2.fromScale(0.206, 0);
			Tab.Left.BackgroundTransparency = 1;

			Tab.UIListLayout = Instance.new("UIListLayout", Tab.Left);
			Tab.UIListLayout.Padding = UDim.new(0, 10);
			Tab.UIListLayout.FillDirection = "Vertical";
			Tab.UIListLayout.HorizontalAlignment = "Center";
			Tab.UIListLayout.SortOrder = "LayoutOrder";
			Tab.UIListLayout.VerticalAlignment = "Top";

			Tab.EmptySpace = Instance.new("Frame", Tab.Left); -- I Am Lazy
			Tab.EmptySpace.BackgroundTransparency = 1;
			Tab.EmptySpace.Size = UDim2.fromOffset(38, 14);

			Tab.Right = Instance.new("Frame", Tab.TabScroll);
			Tab.Right.Size = UDim2.fromScale(0.1, 1);
			Tab.Right.Position = UDim2.fromScale(0.693, 0);
			Tab.Right.BackgroundTransparency = 1;

			Tab.UIListLayout2 = Instance.new("UIListLayout", Tab.Right);
			Tab.UIListLayout2.Padding = UDim.new(0, 10);
			Tab.UIListLayout2.FillDirection = "Vertical";
			Tab.UIListLayout2.HorizontalAlignment = "Center";
			Tab.UIListLayout2.SortOrder = "LayoutOrder";
			Tab.UIListLayout2.VerticalAlignment = "Top";

			Tab.EmptySpace = Instance.new("Frame", Tab.Right); -- I Am Lazy
			Tab.EmptySpace.BackgroundTransparency = 1;
			Tab.EmptySpace.Size = UDim2.fromOffset(38, 14);

			if #Window.Tabs == 0 then
				Tab:Select();
			end

			function Tab:CreateSector(Name, Side)
				local Sector = { };
				Sector.Name = Name or "";
				Sector.Side = Side:lower() or "left"

				Sector.Main = Instance.new("Frame", Sector.Side == "left" and Tab.Left or Tab.Right);
				Sector.Main.Size = UDim2.fromOffset(349, 300);
				Sector.Main.BackgroundColor3 = Libary.Theme.BackGround2;

				Sector.UiCorner = Instance.new("UICorner", Sector.Main);
				Sector.UiCorner.CornerRadius = UDim.new(0, 8);

				Sector.TextLable = Instance.new("TextLabel", Sector.Main);
				Sector.TextLable.Size = UDim2.new(1, 0, 0, 20);
				Sector.TextLable.Position = UDim2.fromOffset(0, 0);
				Sector.TextLable.BackgroundTransparency = 1;
				Sector.TextLable.Text = Sector.Name;
				Sector.TextLable.TextColor3 = Libary.Theme.TextColor;
				Sector.TextLable.TextSize = Libary.Theme.TextSize;
				Sector.TextLable.Font = Libary.Theme.Font;
				Sector.TextLable.TextXAlignment = "Center";
				Sector.TextLable.TextYAlignment = "Bottom";

				Sector.Sepirator = Instance.new("Frame", Sector.Main);
				Sector.Sepirator.Position = UDim2.fromOffset(25, 25);
				Sector.Sepirator.Size = UDim2.fromOffset(300, 1);
				Sector.Sepirator.BorderSizePixel = 0;
				Sector.Sepirator.BackgroundColor3 = Libary.Theme.Outline;

				Sector.Holder = Instance.new("Frame", Sector.Main);
				Sector.Holder.BackgroundTransparency = 1;
				Sector.Holder.Position = UDim2.fromOffset(0, 29);
				Sector.Holder.Size = UDim2.fromOffset(349, 56);

				Sector.UiListLayout = Instance.new("UIListLayout", Sector.Holder);
				Sector.UiListLayout.Padding = UDim.new(0, 0);
				Sector.UiListLayout.FillDirection = "Vertical";
				Sector.UiListLayout.HorizontalAlignment = "Center";
				Sector.UiListLayout.VerticalAlignment = "Top";

				function Sector:FixSize()
					Sector.Main.Size = UDim2.fromOffset(349, Sector.UiListLayout.AbsoluteContentSize.Y + 42);
					local Left = Tab.UIListLayout.AbsoluteContentSize.Y + 20;
					local Right = Tab.UIListLayout2.AbsoluteContentSize.Y + 20;
					Tab.TabScroll.CanvasSize = (Left>Right and UDim2.fromOffset(768, Left) or UDim2.fromOffset(768, Right));
				end

				function Sector:CreateToggle(Name, Defult, CallBack, Flag)
					local Toggle = { };
					Toggle.Name = Name or "";
					Toggle.Defult = Defult or false;
					Toggle.CallBack = CallBack or function() end;
					Toggle.Flag = Flag or Name;
					Toggle.Value = Toggle.Defult;

					function Toggle:Set(bool)
						Toggle.Value = bool;

						if Toggle.Flag and Toggle.Flag ~= "" then
							Libary.Flags[Toggle.Flag] = Toggle.Value;
						end
						if Toggle.Value then
							TweenService:Create(Toggle.ToggleBackColor, TweenInfo.new(Libary.Theme.ToggleTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.fromScale(1, 1)}):Play();
							TweenService:Create(Toggle.Ball, TweenInfo.new(Libary.Theme.ToggleTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.919, 0.2)}):Play();
						else
							TweenService:Create(Toggle.ToggleBackColor, TweenInfo.new(Libary.Theme.ToggleTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.fromScale(0.4, 1)}):Play();
							TweenService:Create(Toggle.Ball, TweenInfo.new(Libary.Theme.ToggleTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.833, 0.2)}):Play(); 
						end
						pcall(Toggle.CallBack, bool);
					end

					function Toggle:Get() 
						return Toggle.Value;
					end

					Toggle.Main = Instance.new("TextButton", Sector.Holder);
					Toggle.Main.Size = UDim2.fromOffset(300, 30);
					Toggle.Main.BackgroundTransparency = 1;
					Toggle.Main.AutoButtonColor = false;
					Toggle.Main.Text = "";
					Toggle.Main.MouseButton1Click:Connect(function()
						Toggle:Set(not Toggle.Value)
					end)

					Toggle.TextLable = Instance.new("TextLabel", Toggle.Main);
					Toggle.TextLable.Size = UDim2.fromOffset(164, 30);
					Toggle.TextLable.Position = UDim2.fromOffset(0,0)
					Toggle.TextLable.BackgroundTransparency = 1;
					Toggle.TextLable.Text = Toggle.Name;
					Toggle.TextLable.TextColor3 = Libary.Theme.TextColor;
					Toggle.TextLable.TextSize = Libary.Theme.TextSize;
					Toggle.TextLable.Font = Libary.Theme.Font;
					Toggle.TextLable.TextXAlignment = "Left";
					Toggle.TextLable.TextYAlignment = "Center";

					Toggle.ToggleBack = Instance.new("Frame", Toggle.Main);
					Toggle.ToggleBack.Position = UDim2.fromScale(0.833, 0.2);
					Toggle.ToggleBack.Size = UDim2.fromOffset(40, 17);
					Toggle.ToggleBack.BackgroundColor3 = Libary.Theme.BackGround1;
					Toggle.ToggleBack.ClipsDescendants = true;

					Toggle.UICorner = Instance.new("UICorner", Toggle.ToggleBack);
					Toggle.UICorner.CornerRadius = UDim.new(0, 5);

					Toggle.ToggleBackColor = Instance.new("Frame", Toggle.ToggleBack);
					Toggle.ToggleBackColor.Position = UDim2.fromScale(0, 0);
					Toggle.ToggleBackColor.Size = UDim2.fromScale(0, 1);
					Toggle.ToggleBackColor.BackgroundColor3 = Libary.Theme.Selected;

					Toggle.UICorner3 = Instance.new("UICorner", Toggle.ToggleBackColor);
					Toggle.UICorner3.CornerRadius = UDim.new(0, 5);

					Toggle.UIStroke = Instance.new("UIStroke", Toggle.ToggleBack);
					Toggle.UIStroke.Thickness = 1;
					Toggle.UIStroke.Color = Libary.Theme.Outline;
					Toggle.UIStroke.ApplyStrokeMode = "Border";

					Toggle.Ball = Instance.new("Frame", Toggle.Main);
					Toggle.Ball.AnchorPoint = Vector2.new(0, 0);
					Toggle.Ball.Size = UDim2.fromOffset(17, 17);
					Toggle.Ball.Position = UDim2.fromScale(0.833, 0.2);
					Toggle.Ball.BackgroundColor3 = Color3.fromRGB(255, 255, 255);

					Toggle.UICorner2 = Instance.new("UICorner", Toggle.Ball);
					Toggle.UICorner2.CornerRadius = UDim.new(0, 5);

					Toggle.UIStroke2 = Instance.new("UIStroke", Toggle.Ball);
					Toggle.UIStroke2.Thickness = 1;
					Toggle.UIStroke2.Color = Libary.Theme.Outline;

					Toggle.Holder = Instance.new("Frame", Toggle.Main);
					Toggle.Holder.Position = UDim2.fromScale(0.595, 0.167);
					Toggle.Holder.Size = UDim2.fromOffset(60, 17);
					Toggle.Holder.BackgroundTransparency = 1;

					Toggle.UIList = Instance.new("UIListLayout", Toggle.Holder);
					Toggle.UIList.FillDirection = "Horizontal";
					Toggle.UIList.HorizontalAlignment = "Right";
					Toggle.UIList.SortOrder = "LayoutOrder";
					Toggle.UIList.VerticalAlignment = "Center";

					Toggle:Set(Toggle.Defult);

					if Toggle.Flag and Toggle.Flag ~= "" then
						Libary.Flags[Toggle.Flag] = Toggle.Defult or false;
					end

					function Toggle:CreateColorPicker(Defult, CallBack, Flag)
						local ColorPicker = { };
						ColorPicker.CallBack = CallBack or function() end;
						ColorPicker.Defult = Defult or Color3.fromRGB(255, 255, 255);
						ColorPicker.Value = ColorPicker.Defult;
						ColorPicker.Flag = Flag or ((Toggle.Name or "") .. tostring(#Toggle.Holder:GetChildren()));

						if ColorPicker.Flag and ColorPicker.Flag ~= "" then
							Libary.Flags[ColorPicker.Flag] = ColorPicker.Defult or Color3.fromRGB(255, 255, 255);
						end

						ColorPicker.Main = Instance.new("ImageButton", Toggle.Holder);
						ColorPicker.Main.BackgroundTransparency = 1;
						ColorPicker.Main.Size = UDim2.fromOffset(17, 17);
						ColorPicker.Main.Image = "rbxassetid://11430234918";
						ColorPicker.Main.MouseButton1Click:Connect(function()
							ColorPickerM:Add(ColorPicker.Flag, ColorPicker.CallBack)
							Window.ColorPickerSelected = ColorPicker.Flag
						end);

						pcall(ColorPicker.CallBack, ColorPicker.Value);

						table.insert(Libary.Items, ColorPicker);
						return ColorPicker;
					end

					Sector:FixSize();
					table.insert(Libary.Items, Toggle);
					return Toggle;
				end;

				function Sector:CreateSlider(Text, Min, Default, Max, Decimals, Callback, Flag)
					local Slider = { };
					Slider.Text = Text or "";
					Slider.Callback = Callback or function(Value) end;
					Slider.Min = Min or 0;
					Slider.Max = Max or 100;
					Slider.Decimals = Decimals or 1;
					Slider.Default = Default or Slider.min;
					Slider.Flag = Flag or Text or "";

					Slider.Value = Slider.Default;
					local Dragging = false;

					Slider.MainBack = Instance.new("TextButton", Sector.Holder);
					Slider.MainBack.Size = UDim2.fromOffset(300, 50);
					Slider.MainBack.BackgroundTransparency = 1;
					Slider.MainBack.AutoButtonColor = false;
					Slider.MainBack.Text = "";

					Slider.TextLable = Instance.new("TextLabel", Slider.MainBack);
					Slider.TextLable.Size = UDim2.fromOffset(164, 22);
					Slider.TextLable.Position = UDim2.fromOffset(0,0)
					Slider.TextLable.BackgroundTransparency = 1;
					Slider.TextLable.Text = Slider.Text;
					Slider.TextLable.TextColor3 = Libary.Theme.TextColor;
					Slider.TextLable.TextSize = Libary.Theme.TextSize;
					Slider.TextLable.Font = Libary.Theme.Font;
					Slider.TextLable.TextXAlignment = "Left";
					Slider.TextLable.TextYAlignment = "Center";

					Slider.TextBox = Instance.new("TextBox", Slider.MainBack);
					Slider.TextBox.Position = UDim2.fromScale(0.87, 0);
					Slider.TextBox.Size = UDim2.fromOffset(30, 22);
					Slider.TextBox.BackgroundTransparency = 1;
					Slider.TextBox.TextColor3 = Libary.Theme.TextColor;
					Slider.TextBox.TextSize = Libary.Theme.TextSize;
					Slider.TextBox.Font = Libary.Theme.Font;
					Slider.TextBox.TextXAlignment = "Center";
					Slider.TextBox.TextYAlignment = "Center";
					Slider.TextBox.Text = "0";

					Slider.Main = Instance.new("TextButton", Slider.MainBack);
					Slider.Main.Position = UDim2.fromScale(-0.003, 0.533);
					Slider.Main.Size = UDim2.fromOffset(291, 17);
					Slider.Main.BackgroundColor3 = Libary.Theme.BackGround1;
					Slider.Main.Text = "";
					Slider.Main.AutoButtonColor = false;

					Slider.UiCorner = Instance.new("UICorner", Slider.Main);
					Slider.UiCorner.CornerRadius = UDim.new(0, 5);

					Slider.UiStroke = Instance.new("UIStroke", Slider.Main);
					Slider.UiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
					Slider.UiStroke.Color = Libary.Theme.Outline;

					Slider.SlideBar = Instance.new("Frame", Slider.Main);
					Slider.SlideBar.BackgroundColor3 = Libary.Theme.Selected;
					Slider.SlideBar.Size = UDim2.fromScale(0,0);
					Slider.SlideBar.Position = UDim2.new();

					Slider.UiCorner2 = Instance.new("UICorner", Slider.SlideBar);
					Slider.UiCorner2.CornerRadius = UDim.new(0, 5);

					if Slider.Flag and Slider.Flag ~= "" then
						Libary.Flags[Slider.Flag] = Slider.Default or Slider.Min or 0;
					end;

					function Slider:Get()
						return Slider.Value;
					end;

					function Slider:Set(value)
						Slider.Value = math.clamp(math.round(value * Slider.Decimals) / Slider.Decimals, Slider.Min, Slider.Max);
						local percent = 1 - ((Slider.Max - Slider.Value) / (Slider.Max - Slider.Min));
						if Slider.Flag and Slider.Flag ~= "" then
							Libary.Flags[Slider.Flag] = Slider.Value;
						end;
						Slider.SlideBar:TweenSize(UDim2.fromOffset(percent * Slider.Main.AbsoluteSize.X, Slider.Main.AbsoluteSize.Y), Enum.EasingDirection.In, Enum.EasingStyle.Sine, Libary.Theme.SliderTween);
						Slider.TextBox.Text = Slider.Value;
						if Slider.Value <= Slider.Min then
							Slider.SlideBar.BackgroundTransparency = 1;
						else
							Slider.SlideBar.BackgroundTransparency = 0;
						end;
						pcall(Slider.Callback, Slider.Value);
					end;
					Slider:Set(Slider.Default);

					Slider.TextBox.FocusLost:Connect(function(Return)
						if not Return then 
							return;
						end;
						if (Slider.TextBox.Text:match("^%d+$")) then
							Slider:Set(tonumber(Slider.TextBox.Text));
						else
							Slider.TextBox.Text = tostring(Slider.Value);
						end;
					end);

					function Slider:Refresh()
						local mousePos = CurrentCamera:WorldToViewportPoint(Mouse.Hit.p)
						local percent = math.clamp(mousePos.X - Slider.SlideBar.AbsolutePosition.X, 0, Slider.Main.AbsoluteSize.X) / Slider.Main.AbsoluteSize.X;
						local value = math.floor((Slider.Min + (Slider.Max - Slider.Min) * percent) * Slider.Decimals) / Slider.Decimals;
						value = math.clamp(value, Slider.Min, Slider.Max);
						Slider:Set(value);
					end;

					Slider.SlideBar.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							Dragging = true
							Slider:Refresh()
						end
					end)

					Slider.SlideBar.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							Dragging = false
						end
					end)

					Slider.Main.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							Dragging = true
							Slider:Refresh()
						end
					end)

					Slider.Main.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							Dragging = false
						end
					end)

					UserInputService.InputChanged:Connect(function(input)
						if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
							Slider:Refresh()
						end
					end)

					Sector:FixSize();
					table.insert(Libary.Items, Slider);
					return Slider;
				end;

				function Sector:CreateDropdown(Text, Items, Defult, Multichoice, Callback, Flag)
					local DropDown = { };
					DropDown.Text = Text or "";
					DropDown.Defaultitems = Items or { };
					DropDown.Default = Defult;
					DropDown.Callback = Callback or function() end;
					DropDown.Multichoice = Multichoice or false;
					DropDown.Values = { };
					DropDown.Flag = Flag or Text or "";

					DropDown.MainBack = Instance.new("TextButton", Sector.Holder);
					DropDown.MainBack.Size = UDim2.fromOffset(300, 50);
					DropDown.MainBack.BackgroundTransparency = 1;
					DropDown.MainBack.AutoButtonColor = false;
					DropDown.MainBack.Text = "";

					DropDown.TextLable = Instance.new("TextLabel", DropDown.MainBack);
					DropDown.TextLable.Size = UDim2.fromOffset(164, 22);
					DropDown.TextLable.Position = UDim2.fromOffset(0,0)
					DropDown.TextLable.BackgroundTransparency = 1;
					DropDown.TextLable.Text = DropDown.Text;
					DropDown.TextLable.TextColor3 = Libary.Theme.TextColor;
					DropDown.TextLable.TextSize = Libary.Theme.TextSize;
					DropDown.TextLable.Font = Libary.Theme.Font;
					DropDown.TextLable.TextXAlignment = "Left";
					DropDown.TextLable.TextYAlignment = "Center";

					DropDown.Drop = Instance.new("TextButton", DropDown.MainBack);
					DropDown.Drop.Size = UDim2.fromOffset(291, 21);
					DropDown.Drop.Position = UDim2.fromScale(-0.003, 0.433);
					DropDown.Drop.BackgroundColor3 = Libary.Theme.BackGround1;
					DropDown.Drop.AutoButtonColor = false;
					DropDown.Drop.Text = "";
					DropDown.Drop.MouseButton1Click:Connect(function()
						DropDown.MainDrop.Visible = not DropDown.MainDrop.Visible;
					end);

					DropDown.UiCorner = Instance.new("UICorner", DropDown.Drop);
					DropDown.UiCorner.CornerRadius = UDim.new(0, 5);

					DropDown.UiStroke = Instance.new("UIStroke", DropDown.Drop);
					DropDown.UiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
					DropDown.UiStroke.Color = Libary.Theme.Outline;

					DropDown.Selected = Instance.new("TextLabel", DropDown.Drop);
					DropDown.Selected.BackgroundTransparency = 1;
					DropDown.Selected.Position = UDim2.fromScale(0.02, 0);
					DropDown.Selected.Size = UDim2.fromScale(0.945, 1);
					DropDown.Selected.Font = Libary.Theme.Font;
					DropDown.Selected.TextColor3 = Libary.Theme.TextColor;
					DropDown.Selected.TextXAlignment = "Left";
					DropDown.Selected.TextSize = Libary.Theme.TextSize;
					DropDown.Selected.Text = DropDown.Text;

					DropDown.MainDrop = Instance.new("Frame", DropDown.MainBack);
					DropDown.MainDrop.Position = UDim2.fromScale(0, 0.967);
					DropDown.MainDrop.Size = UDim2.fromOffset(289, 100);
					DropDown.MainDrop.BackgroundColor3 = Libary.Theme.BackGround1;
					DropDown.MainDrop.ZIndex = 10;
					DropDown.MainDrop.Visible = false;

					DropDown.UiCorner2 = Instance.new("UICorner", DropDown.MainDrop);
					DropDown.UiCorner2.CornerRadius = UDim.new(0, 5);

					DropDown.UiStroke2 = Instance.new("UIStroke", DropDown.MainDrop);
					DropDown.UiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
					DropDown.UiStroke2.Color = Libary.Theme.Outline;

					DropDown.ScrollingFrame = Instance.new("ScrollingFrame", DropDown.MainDrop);
					DropDown.ScrollingFrame.BackgroundTransparency = 1;
					DropDown.ScrollingFrame.Position = UDim2.fromScale();
					DropDown.ScrollingFrame.Size = UDim2.fromScale(1, 1);
					DropDown.ScrollingFrame.ScrollBarThickness = 0;
					DropDown.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, 0);

					DropDown.UIListLayout = Instance.new("UIListLayout", DropDown.ScrollingFrame);
					DropDown.UIListLayout.SortOrder = "LayoutOrder";


					function DropDown:GetOptions()
						return DropDown.values;
					end;

					function DropDown:UpdateSize()
						DropDown.ScrollingFrame.CanvasSize = UDim2.fromOffset(0, DropDown.UIListLayout.AbsoluteContentSize.Y);
						if DropDown.UIListLayout.AbsoluteContentSize.Y < 100  then
							DropDown.MainDrop.Size = UDim2.fromOffset(289, DropDown.UIListLayout.AbsoluteContentSize.Y);
						else
							DropDown.MainDrop.Size = UDim2.fromOffset(289, 100);
						end;
					end;

					function DropDown:updateText(Text)
						if #Text >= 47 then
							Text = Text:sub(1, 45) .. "..";
						end;
						DropDown.Selected.Text = Text;
					end;

					DropDown.Changed = Instance.new("BindableEvent");
					function DropDown:Set(value)
						if type(value) == "table" then
							DropDown.Values = value;
							DropDown:updateText(table.concat(value, ", "));
							pcall(DropDown.Callback, value);
						else
							DropDown:updateText(value)
							DropDown.Values = { value };
							pcall(DropDown.Callback, value);
						end;

						DropDown.Changed:Fire(value);
						if DropDown.Flag and DropDown.Flag ~= "" then
							Libary.Flags[DropDown.Flag] = DropDown.Multichoice and DropDown.Values or DropDown.Values[1];
						end;
					end;

					function DropDown:Get()
						return DropDown.Multichoice and DropDown.Values or DropDown.Values[1];
					end;

					function DropDown:isSelected(item)
						for i, v in pairs(DropDown.Values) do
							if v == item then
								return true;
							end;
						end;
						return false;
					end;

					local function CreateOption(Name)
						DropDown.Option = Instance.new("TextButton", DropDown.ScrollingFrame);
						DropDown.Option.AutoButtonColor = false;
						DropDown.Option.BackgroundTransparency = 1;
						DropDown.Option.Size = UDim2.new(1, 0, 0, 20);
						DropDown.Option.Text = "  " .. Name;
						DropDown.Option.BorderSizePixel = 0;
						DropDown.Option.TextXAlignment = "Left"
						DropDown.Option.Name = Name;
						DropDown.Option.ZIndex = 10;
						DropDown.Option.TextColor3 = Libary.Theme.TextColor;
						DropDown.Option.Font = Libary.Theme.Font;
						DropDown.Option.TextSize = Libary.Theme.TextSize;
						DropDown.Option.MouseButton1Down:Connect(function()
							if DropDown.Multichoice then
								if DropDown:isSelected(Name) then
									for i2, v2 in pairs(DropDown.Values) do
										if v2 == Name then
											table.remove(DropDown.Values, i2);
										end;
									end;
									DropDown:Set(DropDown.Values);
								else
									table.insert(DropDown.Values, Name);
									DropDown:Set(DropDown.Values);
								end;

								return;
							else
								DropDown.MainDrop.Visible = false;
							end;

							DropDown:Set(Name);
							return;
						end)
						DropDown:UpdateSize()
					end;

					for _,v in pairs(DropDown.Defaultitems) do
						CreateOption(v)
					end;

					if DropDown.Default then
						DropDown:Set(DropDown.Default)
					end

					DropDown.Items = { };

					Sector:FixSize();
					DropDown:UpdateSize()
					table.insert(Libary.Items, DropDown);
					return DropDown;
				end;

				Sector:FixSize();
				return Sector;
			end;

			function Tab:CreateSub(Name) -- Fun
				local SubTab = { };
				SubTab.Name = Name or "";

				function SubTab:Select()
					if SubTab.TabScroll then
						local Ammount = SubTab.TabScroll.Name
						TweenService:Create(Tab.MainTab, TweenInfo.new(Libary.Theme.SubtabTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position =  -UDim2.fromOffset(768 * Ammount, 0)}):Play();
						TweenService:Create(Tab.SubSelector, TweenInfo.new(Libary.Theme.SubtabbarTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.178 + (0.075 * Ammount), 0.124)}):Play();
					else
						TweenService:Create(Tab.MainTab, TweenInfo.new(Libary.Theme.SubtabTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0,0, 0)}):Play();
						TweenService:Create(Tab.SubSelector, TweenInfo.new(Libary.Theme.SubtabbarTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.178, 0.124)}):Play();
					end
				end

				SubTab.Button = Instance.new("TextButton", Tab.SubOptions);
				SubTab.Button.Size = UDim2.new(0, 65, 1, 0);
				SubTab.Button.BackgroundTransparency = 1;
				SubTab.Button.Text = SubTab.Name;
				SubTab.Button.TextColor3 = Libary.Theme.TextColor;
				SubTab.Button.TextSize = Libary.Theme.TextSize;
				SubTab.Button.Font = Libary.Theme.Font;
				SubTab.Button.ZIndex = 3;
				SubTab.Button.MouseButton1Click:Connect(function()
					SubTab:Select();
				end);

				local AmountOfSubTabs = Tab.SubOptions:GetChildren();
				local AmountOfTabs = Tab.MainTab:GetChildren();
				if #AmountOfSubTabs > #AmountOfTabs then

					Tab.MainTab.Size = Tab.MainTab.Size + UDim2.fromOffset(Tab.UIListLayout3.AbsoluteContentSize.X, 0);

					SubTab.TabScroll = Instance.new("ScrollingFrame", Tab.MainTab);
					SubTab.TabScroll.Position = UDim2.fromOffset(Tab.MainTab.Size.X - UDim.new(0, 768), 0);
					SubTab.TabScroll.Size = UDim2.fromOffset(768, 371);
					SubTab.TabScroll.BackgroundTransparency = 1;
					SubTab.TabScroll.ScrollBarThickness = 0;
					SubTab.TabScroll.Name = #AmountOfTabs - 1;

					SubTab.Left = Instance.new("Frame", SubTab.TabScroll);
					SubTab.Left.Size = UDim2.fromScale(0.1, 1);
					SubTab.Left.Position = UDim2.fromScale(0.206, 0);
					SubTab.Left.BackgroundTransparency = 1;

					SubTab.UIListLayout = Instance.new("UIListLayout", SubTab.Left);
					SubTab.UIListLayout.Padding = UDim.new(0, 10);
					SubTab.UIListLayout.FillDirection = "Vertical";
					SubTab.UIListLayout.HorizontalAlignment = "Center";
					SubTab.UIListLayout.SortOrder = "LayoutOrder";
					SubTab.UIListLayout.VerticalAlignment = "Top";

					SubTab.EmptySpace = Instance.new("Frame", SubTab.Left); -- I Am Lazy
					SubTab.EmptySpace.BackgroundTransparency = 1;
					SubTab.EmptySpace.Size = UDim2.fromOffset(38, 14);

					SubTab.Right = Instance.new("Frame", SubTab.TabScroll);
					SubTab.Right.Size = UDim2.fromScale(0.1, 1);
					SubTab.Right.Position = UDim2.fromScale(0.693, 0);
					SubTab.Right.BackgroundTransparency = 1;

					SubTab.UIListLayout2 = Instance.new("UIListLayout", SubTab.Right);
					SubTab.UIListLayout2.Padding = UDim.new(0, 10);
					SubTab.UIListLayout2.FillDirection = "Vertical";
					SubTab.UIListLayout2.HorizontalAlignment = "Center";
					SubTab.UIListLayout2.SortOrder = "LayoutOrder";
					SubTab.UIListLayout2.VerticalAlignment = "Top";

					SubTab.EmptySpace = Instance.new("Frame", SubTab.Right); -- I Am Lazy
					SubTab.EmptySpace.BackgroundTransparency = 1;
					SubTab.EmptySpace.Size = UDim2.fromOffset(38, 14);
				end

				if SubTab.TabScroll then

					function SubTab:CreateSector(Name, Side)
						local Sector = { };
						Sector.Name = Name or "";
						Sector.Side = Side:lower() or "left"

						Sector.Main = Instance.new("Frame", Sector.Side == "left" and SubTab.Left or SubTab.Right);
						Sector.Main.Size = UDim2.fromOffset(349, 300);
						Sector.Main.BackgroundColor3 = Libary.Theme.BackGround2;

						Sector.UiCorner = Instance.new("UICorner", Sector.Main);
						Sector.UiCorner.CornerRadius = UDim.new(0, 8);

						Sector.TextLable = Instance.new("TextLabel", Sector.Main);
						Sector.TextLable.Size = UDim2.new(1, 0, 0, 20);
						Sector.TextLable.Position = UDim2.fromOffset(0, 0);
						Sector.TextLable.BackgroundTransparency = 1;
						Sector.TextLable.Text = Sector.Name;
						Sector.TextLable.TextColor3 = Libary.Theme.TextColor;
						Sector.TextLable.TextSize = Libary.Theme.TextSize;
						Sector.TextLable.Font = Libary.Theme.Font;
						Sector.TextLable.TextXAlignment = "Center";
						Sector.TextLable.TextYAlignment = "Bottom";

						Sector.Sepirator = Instance.new("Frame", Sector.Main);
						Sector.Sepirator.Position = UDim2.fromOffset(25, 25);
						Sector.Sepirator.Size = UDim2.fromOffset(300, 1);
						Sector.Sepirator.BorderSizePixel = 0;
						Sector.Sepirator.BackgroundColor3 = Libary.Theme.Outline;

						Sector.Holder = Instance.new("Frame", Sector.Main);
						Sector.Holder.BackgroundTransparency = 1;
						Sector.Holder.Position = UDim2.fromOffset(0, 29);
						Sector.Holder.Size = UDim2.fromOffset(349, 56);

						Sector.UiListLayout = Instance.new("UIListLayout", Sector.Holder);
						Sector.UiListLayout.Padding = UDim.new(0, 0);
						Sector.UiListLayout.FillDirection = "Vertical";
						Sector.UiListLayout.HorizontalAlignment = "Center";
						Sector.UiListLayout.VerticalAlignment = "Top";

						function Sector:FixSize()
							Sector.Main.Size = UDim2.fromOffset(349, Sector.UiListLayout.AbsoluteContentSize.Y + 42);
							local Left = SubTab.UIListLayout.AbsoluteContentSize.Y + 20;
							local Right = SubTab.UIListLayout2.AbsoluteContentSize.Y + 20;
							SubTab.TabScroll.CanvasSize = (Left>Right and UDim2.fromOffset(768, Left) or UDim2.fromOffset(768, Right));
						end

						function Sector:CreateToggle(Name, Defult, CallBack, Flag)
							local Toggle = { };
							Toggle.Name = Name or "";
							Toggle.Defult = Defult or false;
							Toggle.CallBack = CallBack or function() end;
							Toggle.Flag = Flag or Name;
							Toggle.Value = Toggle.Defult;

							function Toggle:Set(bool)
								Toggle.Value = bool;

								if Toggle.Flag and Toggle.Flag ~= "" then
									Libary.Flags[Toggle.Flag] = Toggle.Value;
								end
								if Toggle.Value then
									TweenService:Create(Toggle.ToggleBackColor, TweenInfo.new(Libary.Theme.ToggleTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.fromScale(1, 1)}):Play();
									TweenService:Create(Toggle.Ball, TweenInfo.new(Libary.Theme.ToggleTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.919, 0.2)}):Play();
								else
									TweenService:Create(Toggle.ToggleBackColor, TweenInfo.new(Libary.Theme.ToggleTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.fromScale(0.4, 1)}):Play();
									TweenService:Create(Toggle.Ball, TweenInfo.new(Libary.Theme.ToggleTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.833, 0.2)}):Play(); 
								end
								pcall(Toggle.CallBack, bool);
							end

							function Toggle:Get() 
								return Toggle.Value;
							end

							Toggle.Main = Instance.new("TextButton", Sector.Holder);
							Toggle.Main.Size = UDim2.fromOffset(300, 30);
							Toggle.Main.BackgroundTransparency = 1;
							Toggle.Main.AutoButtonColor = false;
							Toggle.Main.Text = "";
							Toggle.Main.MouseButton1Click:Connect(function()
								Toggle:Set(not Toggle.Value)
							end)

							Toggle.TextLable = Instance.new("TextLabel", Toggle.Main);
							Toggle.TextLable.Size = UDim2.fromOffset(164, 30);
							Toggle.TextLable.Position = UDim2.fromOffset(0,0)
							Toggle.TextLable.BackgroundTransparency = 1;
							Toggle.TextLable.Text = Toggle.Name;
							Toggle.TextLable.TextColor3 = Libary.Theme.TextColor;
							Toggle.TextLable.TextSize = Libary.Theme.TextSize;
							Toggle.TextLable.Font = Libary.Theme.Font;
							Toggle.TextLable.TextXAlignment = "Left";
							Toggle.TextLable.TextYAlignment = "Center";

							Toggle.ToggleBack = Instance.new("Frame", Toggle.Main);
							Toggle.ToggleBack.Position = UDim2.fromScale(0.833, 0.2);
							Toggle.ToggleBack.Size = UDim2.fromOffset(40, 17);
							Toggle.ToggleBack.BackgroundColor3 = Libary.Theme.BackGround1;
							Toggle.ToggleBack.ClipsDescendants = true;

							Toggle.UICorner = Instance.new("UICorner", Toggle.ToggleBack);
							Toggle.UICorner.CornerRadius = UDim.new(0, 5);

							Toggle.ToggleBackColor = Instance.new("Frame", Toggle.ToggleBack);
							Toggle.ToggleBackColor.Position = UDim2.fromScale(0, 0);
							Toggle.ToggleBackColor.Size = UDim2.fromScale(0, 1);
							Toggle.ToggleBackColor.BackgroundColor3 = Libary.Theme.Selected;

							Toggle.UICorner3 = Instance.new("UICorner", Toggle.ToggleBackColor);
							Toggle.UICorner3.CornerRadius = UDim.new(0, 5);

							Toggle.UIStroke = Instance.new("UIStroke", Toggle.ToggleBack);
							Toggle.UIStroke.Thickness = 1;
							Toggle.UIStroke.Color = Libary.Theme.Outline;
							Toggle.UIStroke.ApplyStrokeMode = "Border";

							Toggle.Ball = Instance.new("Frame", Toggle.Main);
							Toggle.Ball.AnchorPoint = Vector2.new(0, 0);
							Toggle.Ball.Size = UDim2.fromOffset(17, 17);
							Toggle.Ball.Position = UDim2.fromScale(0.833, 0.2);
							Toggle.Ball.BackgroundColor3 = Color3.fromRGB(255, 255, 255);

							Toggle.UICorner2 = Instance.new("UICorner", Toggle.Ball);
							Toggle.UICorner2.CornerRadius = UDim.new(0, 5);

							Toggle.UIStroke2 = Instance.new("UIStroke", Toggle.Ball);
							Toggle.UIStroke2.Thickness = 1;
							Toggle.UIStroke2.Color = Libary.Theme.Outline;

							Toggle.Holder = Instance.new("Frame", Toggle.Main);
							Toggle.Holder.Position = UDim2.fromScale(0.595, 0.167);
							Toggle.Holder.Size = UDim2.fromOffset(60, 17);
							Toggle.Holder.BackgroundTransparency = 1;

							Toggle.UIList = Instance.new("UIListLayout", Toggle.Holder);
							Toggle.UIList.FillDirection = "Horizontal";
							Toggle.UIList.HorizontalAlignment = "Right";
							Toggle.UIList.SortOrder = "LayoutOrder";
							Toggle.UIList.VerticalAlignment = "Center";

							Toggle:Set(Toggle.Defult);

							if Toggle.Flag and Toggle.Flag ~= "" then
								Libary.Flags[Toggle.Flag] = Toggle.Defult or false;
							end

							function Toggle:CreateColorPicker(Defult, CallBack, Flag)
								local ColorPicker = { };
								ColorPicker.CallBack = CallBack or function() end;
								ColorPicker.Defult = Defult or Color3.fromRGB(255, 255, 255);
								ColorPicker.Value = ColorPicker.Defult;
								ColorPicker.Flag = Flag or ((Toggle.Name or "") .. tostring(#Toggle.Holder:GetChildren()));

								if ColorPicker.Flag and ColorPicker.Flag ~= "" then
									Libary.Flags[ColorPicker.Flag] = ColorPicker.Defult or Color3.fromRGB(255, 255, 255);
								end

								ColorPicker.Main = Instance.new("ImageButton", Toggle.Holder);
								ColorPicker.Main.BackgroundTransparency = 1;
								ColorPicker.Main.Size = UDim2.fromOffset(17, 17);
								ColorPicker.Main.Image = "rbxassetid://11430234918";
								ColorPicker.Main.MouseButton1Click:Connect(function()
									ColorPickerM:Add(ColorPicker.Flag, ColorPicker.CallBack)
									Window.ColorPickerSelected = ColorPicker.Flag
								end);

								pcall(ColorPicker.Callback, ColorPicker.Value);

								table.insert(Libary.Items, ColorPicker);
								return ColorPicker;
							end

							Sector:FixSize();
							table.insert(Libary.Items, Toggle);
							return Toggle;
						end;

						function Sector:CreateSlider(Text, Min, Default, Max, Decimals, Callback, Flag)
							local Slider = { };
							Slider.Text = Text or "";
							Slider.Callback = Callback or function(Value) end;
							Slider.Min = Min or 0;
							Slider.Max = Max or 100;
							Slider.Decimals = Decimals or 1;
							Slider.Default = Default or Slider.min;
							Slider.Flag = Flag or Text or "";

							Slider.Value = Slider.Default;
							local Dragging = false;

							Slider.MainBack = Instance.new("TextButton", Sector.Holder);
							Slider.MainBack.Size = UDim2.fromOffset(300, 50);
							Slider.MainBack.BackgroundTransparency = 1;
							Slider.MainBack.AutoButtonColor = false;
							Slider.MainBack.Text = "";

							Slider.TextLable = Instance.new("TextLabel", Slider.MainBack);
							Slider.TextLable.Size = UDim2.fromOffset(164, 22);
							Slider.TextLable.Position = UDim2.fromOffset(0,0)
							Slider.TextLable.BackgroundTransparency = 1;
							Slider.TextLable.Text = Slider.Text;
							Slider.TextLable.TextColor3 = Libary.Theme.TextColor;
							Slider.TextLable.TextSize = Libary.Theme.TextSize;
							Slider.TextLable.Font = Libary.Theme.Font;
							Slider.TextLable.TextXAlignment = "Left";
							Slider.TextLable.TextYAlignment = "Center";

							Slider.TextBox = Instance.new("TextBox", Slider.MainBack);
							Slider.TextBox.Position = UDim2.fromScale(0.87, 0);
							Slider.TextBox.Size = UDim2.fromOffset(30, 22);
							Slider.TextBox.BackgroundTransparency = 1;
							Slider.TextBox.TextColor3 = Libary.Theme.TextColor;
							Slider.TextBox.TextSize = Libary.Theme.TextSize;
							Slider.TextBox.Font = Libary.Theme.Font;
							Slider.TextBox.TextXAlignment = "Center";
							Slider.TextBox.TextYAlignment = "Center";
							Slider.TextBox.Text = "0";

							Slider.Main = Instance.new("TextButton", Slider.MainBack);
							Slider.Main.Position = UDim2.fromScale(-0.003, 0.533);
							Slider.Main.Size = UDim2.fromOffset(291, 17);
							Slider.Main.BackgroundColor3 = Libary.Theme.BackGround1;
							Slider.Main.Text = "";
							Slider.Main.AutoButtonColor = false;

							Slider.UiCorner = Instance.new("UICorner", Slider.Main);
							Slider.UiCorner.CornerRadius = UDim.new(0, 5);

							Slider.UiStroke = Instance.new("UIStroke", Slider.Main);
							Slider.UiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
							Slider.UiStroke.Color = Libary.Theme.Outline;

							Slider.SlideBar = Instance.new("Frame", Slider.Main);
							Slider.SlideBar.BackgroundColor3 = Libary.Theme.Selected;
							Slider.SlideBar.Size = UDim2.fromScale(0,0);
							Slider.SlideBar.Position = UDim2.new();

							Slider.UiCorner2 = Instance.new("UICorner", Slider.SlideBar);
							Slider.UiCorner2.CornerRadius = UDim.new(0, 5);

							if Slider.Flag and Slider.Flag ~= "" then
								Libary.Flags[Slider.Flag] = Slider.Default or Slider.Min or 0;
							end;

							function Slider:Get()
								return Slider.Value;
							end;

							function Slider:Set(value)
								Slider.Value = math.clamp(math.round(value * Slider.Decimals) / Slider.Decimals, Slider.Min, Slider.Max);
								local percent = 1 - ((Slider.Max - Slider.Value) / (Slider.Max - Slider.Min));
								if Slider.Flag and Slider.Flag ~= "" then
									Libary.Flags[Slider.Flag] = Slider.Value;
								end;
								Slider.SlideBar:TweenSize(UDim2.fromOffset(percent * Slider.Main.AbsoluteSize.X, Slider.Main.AbsoluteSize.Y), Enum.EasingDirection.In, Enum.EasingStyle.Sine, Libary.Theme.SliderTween);
								Slider.TextBox.Text = Slider.Value;
								if Slider.Value <= Slider.Min then
									Slider.SlideBar.BackgroundTransparency = 1;
								else
									Slider.SlideBar.BackgroundTransparency = 0;
								end;
								pcall(Slider.Callback, Slider.Value);
							end;
							Slider:Set(Slider.Default);

							Slider.TextBox.FocusLost:Connect(function(Return)
								if not Return then 
									return;
								end;
								if (Slider.TextBox.Text:match("^%d+$")) then
									Slider:Set(tonumber(Slider.TextBox.Text));
								else
									Slider.TextBox.Text = tostring(Slider.Value);
								end;
							end);

							function Slider:Refresh()
								local mousePos = CurrentCamera:WorldToViewportPoint(Mouse.Hit.p)
								local percent = math.clamp(mousePos.X - Slider.SlideBar.AbsolutePosition.X, 0, Slider.Main.AbsoluteSize.X) / Slider.Main.AbsoluteSize.X;
								local value = math.floor((Slider.Min + (Slider.Max - Slider.Min) * percent) * Slider.Decimals) / Slider.Decimals;
								value = math.clamp(value, Slider.Min, Slider.Max);
								Slider:Set(value);
							end;

							Slider.SlideBar.InputBegan:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 then
									Dragging = true
									Slider:Refresh()
								end
							end)

							Slider.SlideBar.InputEnded:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 then
									Dragging = false
								end
							end)

							Slider.Main.InputBegan:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 then
									Dragging = true
									Slider:Refresh()
								end
							end)

							Slider.Main.InputEnded:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 then
									Dragging = false
								end
							end)

							UserInputService.InputChanged:Connect(function(input)
								if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
									Slider:Refresh()
								end
							end)

							Sector:FixSize();
							table.insert(Libary.Items, Slider);
							return Slider;
						end;

						function Sector:CreateDropdown(Text, Items, Defult, Multichoice, Callback, Flag)
							local DropDown = { };
							DropDown.Text = Text or "";
							DropDown.Defaultitems = Items or { };
							DropDown.Default = Defult;
							DropDown.Callback = Callback or function() end;
							DropDown.Multichoice = Multichoice or false;
							DropDown.Values = { };
							DropDown.Flag = Flag or Text or "";

							DropDown.MainBack = Instance.new("TextButton", Sector.Holder);
							DropDown.MainBack.Size = UDim2.fromOffset(300, 50);
							DropDown.MainBack.BackgroundTransparency = 1;
							DropDown.MainBack.AutoButtonColor = false;
							DropDown.MainBack.Text = "";

							DropDown.TextLable = Instance.new("TextLabel", DropDown.MainBack);
							DropDown.TextLable.Size = UDim2.fromOffset(164, 22);
							DropDown.TextLable.Position = UDim2.fromOffset(0,0)
							DropDown.TextLable.BackgroundTransparency = 1;
							DropDown.TextLable.Text = DropDown.Text;
							DropDown.TextLable.TextColor3 = Libary.Theme.TextColor;
							DropDown.TextLable.TextSize = Libary.Theme.TextSize;
							DropDown.TextLable.Font = Libary.Theme.Font;
							DropDown.TextLable.TextXAlignment = "Left";
							DropDown.TextLable.TextYAlignment = "Center";

							DropDown.Drop = Instance.new("TextButton", DropDown.MainBack);
							DropDown.Drop.Size = UDim2.fromOffset(291, 21);
							DropDown.Drop.Position = UDim2.fromScale(-0.003, 0.433);
							DropDown.Drop.BackgroundColor3 = Libary.Theme.BackGround1;
							DropDown.Drop.AutoButtonColor = false;
							DropDown.Drop.Text = "";
							DropDown.Drop.MouseButton1Click:Connect(function()
								DropDown.MainDrop.Visible = not DropDown.MainDrop.Visible;
							end);

							DropDown.UiCorner = Instance.new("UICorner", DropDown.Drop);
							DropDown.UiCorner.CornerRadius = UDim.new(0, 5);

							DropDown.UiStroke = Instance.new("UIStroke", DropDown.Drop);
							DropDown.UiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
							DropDown.UiStroke.Color = Libary.Theme.Outline;

							DropDown.Selected = Instance.new("TextLabel", DropDown.Drop);
							DropDown.Selected.BackgroundTransparency = 1;
							DropDown.Selected.Position = UDim2.fromScale(0.02, 0);
							DropDown.Selected.Size = UDim2.fromScale(0.945, 1);
							DropDown.Selected.Font = Libary.Theme.Font;
							DropDown.Selected.TextColor3 = Libary.Theme.TextColor;
							DropDown.Selected.TextXAlignment = "Left";
							DropDown.Selected.TextSize = Libary.Theme.TextSize;
							DropDown.Selected.Text = DropDown.Text;

							DropDown.MainDrop = Instance.new("Frame", DropDown.MainBack);
							DropDown.MainDrop.Position = UDim2.fromScale(0, 0.967);
							DropDown.MainDrop.Size = UDim2.fromOffset(289, 100);
							DropDown.MainDrop.BackgroundColor3 = Libary.Theme.BackGround1;
							DropDown.MainDrop.ZIndex = 10;
							DropDown.MainDrop.Visible = false;

							DropDown.UiCorner2 = Instance.new("UICorner", DropDown.MainDrop);
							DropDown.UiCorner2.CornerRadius = UDim.new(0, 5);

							DropDown.UiStroke2 = Instance.new("UIStroke", DropDown.MainDrop);
							DropDown.UiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
							DropDown.UiStroke2.Color = Libary.Theme.Outline;

							DropDown.ScrollingFrame = Instance.new("ScrollingFrame", DropDown.MainDrop);
							DropDown.ScrollingFrame.BackgroundTransparency = 1;
							DropDown.ScrollingFrame.Position = UDim2.fromScale();
							DropDown.ScrollingFrame.Size = UDim2.fromScale(1, 1);
							DropDown.ScrollingFrame.ScrollBarThickness = 0;
							DropDown.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, 0);

							DropDown.UIListLayout = Instance.new("UIListLayout", DropDown.ScrollingFrame);
							DropDown.UIListLayout.SortOrder = "LayoutOrder";


							function DropDown:GetOptions()
								return DropDown.values;
							end;

							function DropDown:UpdateSize()
								DropDown.ScrollingFrame.CanvasSize = UDim2.fromOffset(0, DropDown.UIListLayout.AbsoluteContentSize.Y);
								if DropDown.UIListLayout.AbsoluteContentSize.Y < 100  then
									DropDown.MainDrop.Size = UDim2.fromOffset(289, DropDown.UIListLayout.AbsoluteContentSize.Y);
								else
									DropDown.MainDrop.Size = UDim2.fromOffset(289, 100);
								end;
							end;

							function DropDown:updateText(Text)
								if #Text >= 47 then
									Text = Text:sub(1, 45) .. "..";
								end;
								DropDown.Selected.Text = Text;
							end;

							DropDown.Changed = Instance.new("BindableEvent");
							function DropDown:Set(value)
								if type(value) == "table" then
									DropDown.Values = value;
									DropDown:updateText(table.concat(value, ", "));
									pcall(DropDown.Callback, value);
								else
									DropDown:updateText(value)
									DropDown.Values = { value };
									pcall(DropDown.Callback, value);
								end;

								DropDown.Changed:Fire(value);
								if DropDown.Flag and DropDown.Flag ~= "" then
									Libary.Flags[DropDown.Flag] = DropDown.Multichoice and DropDown.Values or DropDown.Values[1];
								end;
							end;

							function DropDown:Get()
								return DropDown.Multichoice and DropDown.Values or DropDown.Values[1];
							end;

							function DropDown:isSelected(item)
								for i, v in pairs(DropDown.Values) do
									if v == item then
										return true;
									end;
								end;
								return false;
							end;

							local function CreateOption(Name)
								DropDown.Option = Instance.new("TextButton", DropDown.ScrollingFrame);
								DropDown.Option.AutoButtonColor = false;
								DropDown.Option.BackgroundTransparency = 1;
								DropDown.Option.Size = UDim2.new(1, 0, 0, 20);
								DropDown.Option.Text = "  " .. Name;
								DropDown.Option.BorderSizePixel = 0;
								DropDown.Option.TextXAlignment = "Left"
								DropDown.Option.Name = Name;
								DropDown.Option.ZIndex = 10;
								DropDown.Option.TextColor3 = Libary.Theme.TextColor;
								DropDown.Option.Font = Libary.Theme.Font;
								DropDown.Option.TextSize = Libary.Theme.TextSize;
								DropDown.Option.MouseButton1Down:Connect(function()
									if DropDown.Multichoice then
										if DropDown:isSelected(Name) then
											for i2, v2 in pairs(DropDown.Values) do
												if v2 == Name then
													table.remove(DropDown.Values, i2);
												end;
											end;
											DropDown:Set(DropDown.Values);
										else
											table.insert(DropDown.Values, Name);
											DropDown:Set(DropDown.Values);
										end;

										return;
									else
										DropDown.MainDrop.Visible = false;
									end;

									DropDown:Set(Name);
									return;
								end)
								DropDown:UpdateSize()
							end;

							for _,v in pairs(DropDown.Defaultitems) do
								CreateOption(v)
							end;

							if DropDown.Default then
								DropDown:Set(DropDown.Default)
							end

							DropDown.Items = { };

							Sector:FixSize();
							DropDown:UpdateSize()
							table.insert(Libary.Items, DropDown);
							return DropDown;
						end;

						Sector:FixSize();
						return Sector;
					end

				else

					function SubTab:CreateSector(Name, Side)
						local Sector = { };
						Sector.Name = Name or "";
						Sector.Side = Side:lower() or "left"

						Sector.Main = Instance.new("Frame", Sector.Side == "left" and Tab.Left or Tab.Right);
						Sector.Main.Size = UDim2.fromOffset(349, 300);
						Sector.Main.BackgroundColor3 = Libary.Theme.BackGround2;

						Sector.UiCorner = Instance.new("UICorner", Sector.Main);
						Sector.UiCorner.CornerRadius = UDim.new(0, 8);

						Sector.TextLable = Instance.new("TextLabel", Sector.Main);
						Sector.TextLable.Size = UDim2.new(1, 0, 0, 20);
						Sector.TextLable.Position = UDim2.fromOffset(0, 0);
						Sector.TextLable.BackgroundTransparency = 1;
						Sector.TextLable.Text = Sector.Name;
						Sector.TextLable.TextColor3 = Libary.Theme.TextColor;
						Sector.TextLable.TextSize = Libary.Theme.TextSize;
						Sector.TextLable.Font = Libary.Theme.Font;
						Sector.TextLable.TextXAlignment = "Center";
						Sector.TextLable.TextYAlignment = "Bottom";

						Sector.Sepirator = Instance.new("Frame", Sector.Main);
						Sector.Sepirator.Position = UDim2.fromOffset(25, 25);
						Sector.Sepirator.Size = UDim2.fromOffset(300, 1);
						Sector.Sepirator.BorderSizePixel = 0;
						Sector.Sepirator.BackgroundColor3 = Libary.Theme.Outline;

						Sector.Holder = Instance.new("Frame", Sector.Main);
						Sector.Holder.BackgroundTransparency = 1;
						Sector.Holder.Position = UDim2.fromOffset(0, 29);
						Sector.Holder.Size = UDim2.fromOffset(349, 56);

						Sector.UiListLayout = Instance.new("UIListLayout", Sector.Holder);
						Sector.UiListLayout.Padding = UDim.new(0, 0);
						Sector.UiListLayout.FillDirection = "Vertical";
						Sector.UiListLayout.HorizontalAlignment = "Center";
						Sector.UiListLayout.VerticalAlignment = "Top";

						function Sector:FixSize()
							Sector.Main.Size = UDim2.fromOffset(349, Sector.UiListLayout.AbsoluteContentSize.Y + 42);
							local Left = Tab.UIListLayout.AbsoluteContentSize.Y + 20;
							local Right = Tab.UIListLayout2.AbsoluteContentSize.Y + 20;
							Tab.TabScroll.CanvasSize = (Left>Right and UDim2.fromOffset(768, Left) or UDim2.fromOffset(768, Right));
						end

						function Sector:CreateToggle(Name, Defult, CallBack, Flag)
							local Toggle = { };
							Toggle.Name = Name or "";
							Toggle.Defult = Defult or false;
							Toggle.CallBack = CallBack or function() end;
							Toggle.Flag = Flag or Name;
							Toggle.Value = Toggle.Defult;

							function Toggle:Set(bool)
								Toggle.Value = bool;

								if Toggle.Flag and Toggle.Flag ~= "" then
									Libary.Flags[Toggle.Flag] = Toggle.Value;
								end
								if Toggle.Value then
									TweenService:Create(Toggle.ToggleBackColor, TweenInfo.new(Libary.Theme.ToggleTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.fromScale(1, 1)}):Play();
									TweenService:Create(Toggle.Ball, TweenInfo.new(Libary.Theme.ToggleTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.919, 0.2)}):Play();
								else
									TweenService:Create(Toggle.ToggleBackColor, TweenInfo.new(Libary.Theme.ToggleTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.fromScale(0.4, 1)}):Play();
									TweenService:Create(Toggle.Ball, TweenInfo.new(Libary.Theme.ToggleTween, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.833, 0.2)}):Play(); 
								end
								pcall(Toggle.CallBack, bool);
							end

							function Toggle:Get() 
								return Toggle.Value;
							end

							Toggle.Main = Instance.new("TextButton", Sector.Holder);
							Toggle.Main.Size = UDim2.fromOffset(300, 30);
							Toggle.Main.BackgroundTransparency = 1;
							Toggle.Main.AutoButtonColor = false;
							Toggle.Main.Text = "";
							Toggle.Main.MouseButton1Click:Connect(function()
								Toggle:Set(not Toggle.Value)
							end)

							Toggle.TextLable = Instance.new("TextLabel", Toggle.Main);
							Toggle.TextLable.Size = UDim2.fromOffset(164, 30);
							Toggle.TextLable.Position = UDim2.fromOffset(0,0)
							Toggle.TextLable.BackgroundTransparency = 1;
							Toggle.TextLable.Text = Toggle.Name;
							Toggle.TextLable.TextColor3 = Libary.Theme.TextColor;
							Toggle.TextLable.TextSize = Libary.Theme.TextSize;
							Toggle.TextLable.Font = Libary.Theme.Font;
							Toggle.TextLable.TextXAlignment = "Left";
							Toggle.TextLable.TextYAlignment = "Center";

							Toggle.ToggleBack = Instance.new("Frame", Toggle.Main);
							Toggle.ToggleBack.Position = UDim2.fromScale(0.833, 0.2);
							Toggle.ToggleBack.Size = UDim2.fromOffset(40, 17);
							Toggle.ToggleBack.BackgroundColor3 = Libary.Theme.BackGround1;
							Toggle.ToggleBack.ClipsDescendants = true;

							Toggle.UICorner = Instance.new("UICorner", Toggle.ToggleBack);
							Toggle.UICorner.CornerRadius = UDim.new(0, 5);

							Toggle.ToggleBackColor = Instance.new("Frame", Toggle.ToggleBack);
							Toggle.ToggleBackColor.Position = UDim2.fromScale(0, 0);
							Toggle.ToggleBackColor.Size = UDim2.fromScale(0, 1);
							Toggle.ToggleBackColor.BackgroundColor3 = Libary.Theme.Selected;

							Toggle.UICorner3 = Instance.new("UICorner", Toggle.ToggleBackColor);
							Toggle.UICorner3.CornerRadius = UDim.new(0, 5);

							Toggle.UIStroke = Instance.new("UIStroke", Toggle.ToggleBack);
							Toggle.UIStroke.Thickness = 1;
							Toggle.UIStroke.Color = Libary.Theme.Outline;
							Toggle.UIStroke.ApplyStrokeMode = "Border";

							Toggle.Ball = Instance.new("Frame", Toggle.Main);
							Toggle.Ball.AnchorPoint = Vector2.new(0, 0);
							Toggle.Ball.Size = UDim2.fromOffset(17, 17);
							Toggle.Ball.Position = UDim2.fromScale(0.833, 0.2);
							Toggle.Ball.BackgroundColor3 = Color3.fromRGB(255, 255, 255);

							Toggle.UICorner2 = Instance.new("UICorner", Toggle.Ball);
							Toggle.UICorner2.CornerRadius = UDim.new(0, 5);

							Toggle.UIStroke2 = Instance.new("UIStroke", Toggle.Ball);
							Toggle.UIStroke2.Thickness = 1;
							Toggle.UIStroke2.Color = Libary.Theme.Outline;

							Toggle.Holder = Instance.new("Frame", Toggle.Main);
							Toggle.Holder.Position = UDim2.fromScale(0.595, 0.167);
							Toggle.Holder.Size = UDim2.fromOffset(60, 17);
							Toggle.Holder.BackgroundTransparency = 1;

							Toggle.UIList = Instance.new("UIListLayout", Toggle.Holder);
							Toggle.UIList.FillDirection = "Horizontal";
							Toggle.UIList.HorizontalAlignment = "Right";
							Toggle.UIList.SortOrder = "LayoutOrder";
							Toggle.UIList.VerticalAlignment = "Center";

							Toggle:Set(Toggle.Defult);

							if Toggle.Flag and Toggle.Flag ~= "" then
								Libary.Flags[Toggle.Flag] = Toggle.Defult or false;
							end

							function Toggle:CreateColorPicker(Defult, CallBack, Flag)
								local ColorPicker = { };
								ColorPicker.CallBack = CallBack or function() end;
								ColorPicker.Defult = Defult or Color3.fromRGB(255, 255, 255);
								ColorPicker.Value = ColorPicker.Defult;
								ColorPicker.Flag = Flag or ((Toggle.Name or "") .. tostring(#Toggle.Holder:GetChildren()));

								if ColorPicker.Flag and ColorPicker.Flag ~= "" then
									Libary.Flags[ColorPicker.Flag] = ColorPicker.Defult or Color3.fromRGB(255, 255, 255);
								end

								ColorPicker.Main = Instance.new("ImageButton", Toggle.Holder);
								ColorPicker.Main.BackgroundTransparency = 1;
								ColorPicker.Main.Size = UDim2.fromOffset(17, 17);
								ColorPicker.Main.Image = "rbxassetid://11430234918";
								ColorPicker.Main.MouseButton1Click:Connect(function()
									ColorPickerM:Add(ColorPicker.Flag, ColorPicker.CallBack)
									Window.ColorPickerSelected = ColorPicker.Flag
								end);

								table.insert(Libary.Items, ColorPicker);
								return ColorPicker;
							end

							Sector:FixSize();
							table.insert(Libary.Items, Toggle);
							return Toggle;
						end;

						function Sector:CreateSlider(Text, Min, Default, Max, Decimals, Callback, Flag)
							local Slider = { };
							Slider.Text = Text or "";
							Slider.Callback = Callback or function(Value) end;
							Slider.Min = Min or 0;
							Slider.Max = Max or 100;
							Slider.Decimals = Decimals or 1;
							Slider.Default = Default or Slider.min;
							Slider.Flag = Flag or Text or "";

							Slider.Value = Slider.Default;
							local Dragging = false;

							Slider.MainBack = Instance.new("TextButton", Sector.Holder);
							Slider.MainBack.Size = UDim2.fromOffset(300, 50);
							Slider.MainBack.BackgroundTransparency = 1;
							Slider.MainBack.AutoButtonColor = false;
							Slider.MainBack.Text = "";

							Slider.TextLable = Instance.new("TextLabel", Slider.MainBack);
							Slider.TextLable.Size = UDim2.fromOffset(164, 22);
							Slider.TextLable.Position = UDim2.fromOffset(0,0)
							Slider.TextLable.BackgroundTransparency = 1;
							Slider.TextLable.Text = Slider.Text;
							Slider.TextLable.TextColor3 = Libary.Theme.TextColor;
							Slider.TextLable.TextSize = Libary.Theme.TextSize;
							Slider.TextLable.Font = Libary.Theme.Font;
							Slider.TextLable.TextXAlignment = "Left";
							Slider.TextLable.TextYAlignment = "Center";

							Slider.TextBox = Instance.new("TextBox", Slider.MainBack);
							Slider.TextBox.Position = UDim2.fromScale(0.87, 0);
							Slider.TextBox.Size = UDim2.fromOffset(30, 22);
							Slider.TextBox.BackgroundTransparency = 1;
							Slider.TextBox.TextColor3 = Libary.Theme.TextColor;
							Slider.TextBox.TextSize = Libary.Theme.TextSize;
							Slider.TextBox.Font = Libary.Theme.Font;
							Slider.TextBox.TextXAlignment = "Center";
							Slider.TextBox.TextYAlignment = "Center";
							Slider.TextBox.Text = "0";

							Slider.Main = Instance.new("TextButton", Slider.MainBack);
							Slider.Main.Position = UDim2.fromScale(-0.003, 0.533);
							Slider.Main.Size = UDim2.fromOffset(291, 17);
							Slider.Main.BackgroundColor3 = Libary.Theme.BackGround1;
							Slider.Main.Text = "";
							Slider.Main.AutoButtonColor = false;

							Slider.UiCorner = Instance.new("UICorner", Slider.Main);
							Slider.UiCorner.CornerRadius = UDim.new(0, 5);

							Slider.UiStroke = Instance.new("UIStroke", Slider.Main);
							Slider.UiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
							Slider.UiStroke.Color = Libary.Theme.Outline;

							Slider.SlideBar = Instance.new("Frame", Slider.Main);
							Slider.SlideBar.BackgroundColor3 = Libary.Theme.Selected;
							Slider.SlideBar.Size = UDim2.fromScale(0,0);
							Slider.SlideBar.Position = UDim2.new();

							Slider.UiCorner2 = Instance.new("UICorner", Slider.SlideBar);
							Slider.UiCorner2.CornerRadius = UDim.new(0, 5);

							if Slider.Flag and Slider.Flag ~= "" then
								Libary.Flags[Slider.Flag] = Slider.Default or Slider.Min or 0;
							end;

							function Slider:Get()
								return Slider.Value;
							end;

							function Slider:Set(value)
								Slider.Value = math.clamp(math.round(value * Slider.Decimals) / Slider.Decimals, Slider.Min, Slider.Max);
								local percent = 1 - ((Slider.Max - Slider.Value) / (Slider.Max - Slider.Min));
								if Slider.Flag and Slider.Flag ~= "" then
									Libary.Flags[Slider.Flag] = Slider.Value;
								end;
								Slider.SlideBar:TweenSize(UDim2.fromOffset(percent * Slider.Main.AbsoluteSize.X, Slider.Main.AbsoluteSize.Y), Enum.EasingDirection.In, Enum.EasingStyle.Sine, Libary.Theme.SliderTween);
								Slider.TextBox.Text = Slider.Value;
								if Slider.Value <= Slider.Min then
									Slider.SlideBar.BackgroundTransparency = 1;
								else
									Slider.SlideBar.BackgroundTransparency = 0;
								end;
								pcall(Slider.Callback, Slider.Value);
							end;
							Slider:Set(Slider.Default);

							Slider.TextBox.FocusLost:Connect(function(Return)
								if not Return then 
									return;
								end;
								if (Slider.TextBox.Text:match("^%d+$")) then
									Slider:Set(tonumber(Slider.TextBox.Text));
								else
									Slider.TextBox.Text = tostring(Slider.Value);
								end;
							end);

							function Slider:Refresh()
								local mousePos = CurrentCamera:WorldToViewportPoint(Mouse.Hit.p)
								local percent = math.clamp(mousePos.X - Slider.SlideBar.AbsolutePosition.X, 0, Slider.Main.AbsoluteSize.X) / Slider.Main.AbsoluteSize.X;
								local value = math.floor((Slider.Min + (Slider.Max - Slider.Min) * percent) * Slider.Decimals) / Slider.Decimals;
								value = math.clamp(value, Slider.Min, Slider.Max);
								Slider:Set(value);
							end;

							Slider.SlideBar.InputBegan:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 then
									Dragging = true
									Slider:Refresh()
								end
							end)

							Slider.SlideBar.InputEnded:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 then
									Dragging = false
								end
							end)

							Slider.Main.InputBegan:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 then
									Dragging = true
									Slider:Refresh()
								end
							end)

							Slider.Main.InputEnded:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 then
									Dragging = false
								end
							end)

							UserInputService.InputChanged:Connect(function(input)
								if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
									Slider:Refresh()
								end
							end)

							Sector:FixSize();
							table.insert(Libary.Items, Slider);
							return Slider;
						end;

						function Sector:CreateDropdown(Text, Items, Defult, Multichoice, Callback, Flag)
							local DropDown = { };
							DropDown.Text = Text or "";
							DropDown.Defaultitems = Items or { };
							DropDown.Default = Defult;
							DropDown.Callback = Callback or function() end;
							DropDown.Multichoice = Multichoice or false;
							DropDown.Values = { };
							DropDown.Flag = Flag or Text or "";

							DropDown.MainBack = Instance.new("TextButton", Sector.Holder);
							DropDown.MainBack.Size = UDim2.fromOffset(300, 50);
							DropDown.MainBack.BackgroundTransparency = 1;
							DropDown.MainBack.AutoButtonColor = false;
							DropDown.MainBack.Text = "";

							DropDown.TextLable = Instance.new("TextLabel", DropDown.MainBack);
							DropDown.TextLable.Size = UDim2.fromOffset(164, 22);
							DropDown.TextLable.Position = UDim2.fromOffset(0,0)
							DropDown.TextLable.BackgroundTransparency = 1;
							DropDown.TextLable.Text = DropDown.Text;
							DropDown.TextLable.TextColor3 = Libary.Theme.TextColor;
							DropDown.TextLable.TextSize = Libary.Theme.TextSize;
							DropDown.TextLable.Font = Libary.Theme.Font;
							DropDown.TextLable.TextXAlignment = "Left";
							DropDown.TextLable.TextYAlignment = "Center";

							DropDown.Drop = Instance.new("TextButton", DropDown.MainBack);
							DropDown.Drop.Size = UDim2.fromOffset(291, 21);
							DropDown.Drop.Position = UDim2.fromScale(-0.003, 0.433);
							DropDown.Drop.BackgroundColor3 = Libary.Theme.BackGround1;
							DropDown.Drop.AutoButtonColor = false;
							DropDown.Drop.Text = "";
							DropDown.Drop.MouseButton1Click:Connect(function()
								DropDown.MainDrop.Visible = not DropDown.MainDrop.Visible;
							end);

							DropDown.UiCorner = Instance.new("UICorner", DropDown.Drop);
							DropDown.UiCorner.CornerRadius = UDim.new(0, 5);

							DropDown.UiStroke = Instance.new("UIStroke", DropDown.Drop);
							DropDown.UiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
							DropDown.UiStroke.Color = Libary.Theme.Outline;

							DropDown.Selected = Instance.new("TextLabel", DropDown.Drop);
							DropDown.Selected.BackgroundTransparency = 1;
							DropDown.Selected.Position = UDim2.fromScale(0.02, 0);
							DropDown.Selected.Size = UDim2.fromScale(0.945, 1);
							DropDown.Selected.Font = Libary.Theme.Font;
							DropDown.Selected.TextColor3 = Libary.Theme.TextColor;
							DropDown.Selected.TextXAlignment = "Left";
							DropDown.Selected.TextSize = Libary.Theme.TextSize;
							DropDown.Selected.Text = DropDown.Text;

							DropDown.MainDrop = Instance.new("Frame", DropDown.MainBack);
							DropDown.MainDrop.Position = UDim2.fromScale(0, 0.967);
							DropDown.MainDrop.Size = UDim2.fromOffset(289, 100);
							DropDown.MainDrop.BackgroundColor3 = Libary.Theme.BackGround1;
							DropDown.MainDrop.ZIndex = 10;
							DropDown.MainDrop.Visible = false;

							DropDown.UiCorner2 = Instance.new("UICorner", DropDown.MainDrop);
							DropDown.UiCorner2.CornerRadius = UDim.new(0, 5);

							DropDown.UiStroke2 = Instance.new("UIStroke", DropDown.MainDrop);
							DropDown.UiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
							DropDown.UiStroke2.Color = Libary.Theme.Outline;

							DropDown.ScrollingFrame = Instance.new("ScrollingFrame", DropDown.MainDrop);
							DropDown.ScrollingFrame.BackgroundTransparency = 1;
							DropDown.ScrollingFrame.Position = UDim2.fromScale();
							DropDown.ScrollingFrame.Size = UDim2.fromScale(1, 1);
							DropDown.ScrollingFrame.ScrollBarThickness = 0;
							DropDown.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, 0);

							DropDown.UIListLayout = Instance.new("UIListLayout", DropDown.ScrollingFrame);
							DropDown.UIListLayout.SortOrder = "LayoutOrder";


							function DropDown:GetOptions()
								return DropDown.values;
							end;

							function DropDown:UpdateSize()
								DropDown.ScrollingFrame.CanvasSize = UDim2.fromOffset(0, DropDown.UIListLayout.AbsoluteContentSize.Y);
								if DropDown.UIListLayout.AbsoluteContentSize.Y < 100  then
									DropDown.MainDrop.Size = UDim2.fromOffset(289, DropDown.UIListLayout.AbsoluteContentSize.Y);
								else
									DropDown.MainDrop.Size = UDim2.fromOffset(289, 100);
								end;
							end;

							function DropDown:updateText(Text)
								if #Text >= 47 then
									Text = Text:sub(1, 45) .. "..";
								end;
								DropDown.Selected.Text = Text;
							end;

							DropDown.Changed = Instance.new("BindableEvent");
							function DropDown:Set(value)
								if type(value) == "table" then
									DropDown.Values = value;
									DropDown:updateText(table.concat(value, ", "));
									pcall(DropDown.Callback, value);
								else
									DropDown:updateText(value)
									DropDown.Values = { value };
									pcall(DropDown.Callback, value);
								end;

								DropDown.Changed:Fire(value);
								if DropDown.Flag and DropDown.Flag ~= "" then
									Libary.Flags[DropDown.Flag] = DropDown.Multichoice and DropDown.Values or DropDown.Values[1];
								end;
							end;

							function DropDown:Get()
								return DropDown.Multichoice and DropDown.Values or DropDown.Values[1];
							end;

							function DropDown:isSelected(item)
								for i, v in pairs(DropDown.Values) do
									if v == item then
										return true;
									end;
								end;
								return false;
							end;

							local function CreateOption(Name)
								DropDown.Option = Instance.new("TextButton", DropDown.ScrollingFrame);
								DropDown.Option.AutoButtonColor = false;
								DropDown.Option.BackgroundTransparency = 1;
								DropDown.Option.Size = UDim2.new(1, 0, 0, 20);
								DropDown.Option.Text = "  " .. Name;
								DropDown.Option.BorderSizePixel = 0;
								DropDown.Option.TextXAlignment = "Left"
								DropDown.Option.Name = Name;
								DropDown.Option.ZIndex = 10;
								DropDown.Option.TextColor3 = Libary.Theme.TextColor;
								DropDown.Option.Font = Libary.Theme.Font;
								DropDown.Option.TextSize = Libary.Theme.TextSize;
								DropDown.Option.MouseButton1Down:Connect(function()
									if DropDown.Multichoice then
										if DropDown:isSelected(Name) then
											for i2, v2 in pairs(DropDown.Values) do
												if v2 == Name then
													table.remove(DropDown.Values, i2);
												end;
											end;
											DropDown:Set(DropDown.Values);
										else
											table.insert(DropDown.Values, Name);
											DropDown:Set(DropDown.Values);
										end;

										return;
									else
										DropDown.MainDrop.Visible = false;
									end;

									DropDown:Set(Name);
									return;
								end)
								DropDown:UpdateSize()
							end;

							for _,v in pairs(DropDown.Defaultitems) do
								CreateOption(v)
							end;

							if DropDown.Default then
								DropDown:Set(DropDown.Default)
							end

							DropDown.Items = { };

							Sector:FixSize();
							DropDown:UpdateSize()
							table.insert(Libary.Items, DropDown);
							return DropDown;
						end;

						Sector:FixSize();
						return Sector;
					end

				end


				return SubTab;
			end

			Window:UpdateTabList();
			table.insert(Window.Tabs, Tab);
			return Tab;
		end

		return Window;
	end

	return Libary;
