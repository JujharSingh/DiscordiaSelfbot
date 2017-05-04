Player=game:GetService("Players").LocalPlayer
Character=Player.Character 
PlayerGui=Player.PlayerGui
Backpack=Player.Backpack 
Torso=Character.Torso 
Head=Character.Head 
Humanoid=Character.Humanoid
m=Instance.new('Model',Character)
LeftArm=Character["Left Arm"] 
LeftLeg=Character["Left Leg"] 
RightArm=Character["Right Arm"] 
RightLeg=Character["Right Leg"] 
LS=Torso["Left Shoulder"] 
LH=Torso["Left Hip"] 
RS=Torso["Right Shoulder"] 
RH=Torso["Right Hip"] 
Face = Head.face
Neck=Torso.Neck
it=Instance.new
attacktype=1
vt=Vector3.new
cf=CFrame.new
euler=CFrame.fromEulerAnglesXYZ
angles=CFrame.Angles
cloaked=false
necko=cf(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
necko2=cf(0, -0.5, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
LHC0=cf(-1,-1,0,-0,-0,-1,0,1,0,1,0,0)
LHC1=cf(-0.5,1,0,-0,-0,-1,0,1,0,1,0,0)
RHC0=cf(1,-1,0,0,0,1,0,1,0,-1,-0,-0)
RHC1=cf(0.5,1,0,0,0,1,0,1,0,-1,-0,-0)
RootPart=Character.HumanoidRootPart
RootJoint=RootPart.RootJoint
RootCF=euler(-1.57,0,3.14)
attack = false 
attackdebounce = false 
deb=false
equipped=true
hand=false
MMouse=nil
combo=0
mana=0
trispeed=.2
attackmode='none'
local idle=0
local Anim="Idle"
local Effects={}
local gun=false
local shoot=false
player=nil 
mana=0
cam = workspace.CurrentCamera
ZTarget = nil
RocketTarget = nil

mouse=Player:GetMouse()
--save shoulders 
RSH, LSH=nil, nil 
--welds 
RW, LW=Instance.new("Weld"), Instance.new("Weld") 
RW.Name="Right Shoulder" LW.Name="Left Shoulder"
LH=Torso["Left Hip"]
RH=Torso["Right Hip"]
TorsoColor=Torso.BrickColor
function NoOutline(Part)
Part.TopSurface,Part.BottomSurface,Part.LeftSurface,Part.RightSurface,Part.FrontSurface,Part.BackSurface = 10,10,10,10,10,10
end
player=Player 
ch=Character
RSH=ch.Torso["Right Shoulder"] 
LSH=ch.Torso["Left Shoulder"] 
-- 
RSH.Parent=nil 
LSH.Parent=nil 
-- 
RW.Name="Right Shoulder"
RW.Part0=ch.Torso 
RW.C0=cf(1.5, 0.5, 0) --* CFrame.fromEulerAnglesXYZ(1.3, 0, -0.5) 
RW.C1=cf(0, 0.5, 0) 
RW.Part1=ch["Right Arm"] 
RW.Parent=ch.Torso 
-- 
LW.Name="Left Shoulder"
LW.Part0=ch.Torso 
LW.C0=cf(-1.5, 0.5, 0) --* CFrame.fromEulerAnglesXYZ(1.7, 0, 0.8) 
LW.C1=cf(0, 0.5, 0) 
LW.Part1=ch["Left Arm"] 
LW.Parent=ch.Torso 

	function swait(num)
    if num==0 or num==nil then
    game:service'RunService'.Heartbeat:wait(0)
    else
    for i=0,num do
    game:service'RunService'.Heartbeat:wait(0)
    end
    end
	    end
	
	function nooutline(part)
		part.TopSurface,part.BottomSurface,part.LeftSurface,part.RightSurface,part.FrontSurface,part.BackSurface = 10,10,10,10,10,10
	end
	
	function part(formfactor,parent,material,reflectance,transparency,brickcolor,name,size)
		local fp=it("Part")
		fp.formFactor=formfactor
		fp.Parent=parent
		fp.Reflectance=reflectance
		fp.Transparency=transparency
		fp.CanCollide=false
		fp.Locked=true
		fp.BrickColor=BrickColor.new(tostring(brickcolor))
		fp.Name=name
		fp.Size=size
		fp.Position=Character.Torso.Position
		nooutline(fp)
		fp.Material=material
		fp:BreakJoints()
		return fp
	end
	
	function mesh(Mesh,part,meshtype,meshid,offset,scale)
		local mesh=it(Mesh)
		mesh.Parent=part
		if Mesh=="SpecialMesh" then
			mesh.MeshType=meshtype
			mesh.MeshId=meshid
		end
		mesh.Offset=offset
		mesh.Scale=scale
		return mesh
	end
	
	function weld(parent,part0,part1,c0,c1)
		local weld=it("Weld")
		weld.Parent=parent
		weld.Part0=part0
		weld.Part1=part1
		weld.C0=c0
		weld.C1=c1
		return weld
	end
	
	
local function CFrameFromTopBack(at, top, back)
local right = top:Cross(back)
return CFrame.new(at.x, at.y, at.z,
right.x, top.x, back.x,
right.y, top.y, back.y,
right.z, top.z, back.z)
end

function Triangle(a, b, c)
local edg1 = (c-a):Dot((b-a).unit)
local edg2 = (a-b):Dot((c-b).unit)
local edg3 = (b-c):Dot((a-c).unit)
if edg1 <= (b-a).magnitude and edg1 >= 0 then
a, b, c = a, b, c
elseif edg2 <= (c-b).magnitude and edg2 >= 0 then
a, b, c = b, c, a
elseif edg3 <= (a-c).magnitude and edg3 >= 0 then
a, b, c = c, a, b
else
assert(false, "unreachable")
end
 
local len1 = (c-a):Dot((b-a).unit)
local len2 = (b-a).magnitude - len1
local width = (a + (b-a).unit*len1 - c).magnitude
 
local maincf = CFrameFromTopBack(a, (b-a):Cross(c-b).unit, -(b-a).unit)
 
local list = {}

local TrailColor = ("Bright violet")
 
if len1 > 0.01 then
local w1 = Instance.new('WedgePart', m)
game:GetService("Debris"):AddItem(w1,5)
w1.Material = "SmoothPlastic"
w1.FormFactor = 'Custom'
w1.BrickColor = BrickColor.new(TrailColor)
w1.Transparency = 0
w1.Reflectance = 0
w1.Material = "SmoothPlastic"
w1.CanCollide = false
NoOutline(w1)
local sz = Vector3.new(0.2, width, len1)
w1.Size = sz
local sp = Instance.new("SpecialMesh",w1)
sp.MeshType = "Wedge"
sp.Scale = Vector3.new(0,1,1) * sz/w1.Size
w1:BreakJoints()
w1.Anchored = true
w1.Parent = workspace
w1.Transparency = 0.7
table.insert(Effects,{w1,"Disappear",.01})
w1.CFrame = maincf*CFrame.Angles(math.pi,0,math.pi/2)*CFrame.new(0,width/2,len1/2)
table.insert(list,w1)
end
 
if len2 > 0.01 then
local w2 = Instance.new('WedgePart', m)
game:GetService("Debris"):AddItem(w2,5)
w2.Material = "SmoothPlastic"
w2.FormFactor = 'Custom'
w2.BrickColor = BrickColor.new(TrailColor)
w2.Transparency = 0
w2.Reflectance = 0
w2.Material = "SmoothPlastic"
w2.CanCollide = false
NoOutline(w2)
local sz = Vector3.new(0.2, width, len2)
w2.Size = sz
local sp = Instance.new("SpecialMesh",w2)
sp.MeshType = "Wedge"
sp.Scale = Vector3.new(0,1,1) * sz/w2.Size
w2:BreakJoints()
w2.Anchored = true
w2.Parent = workspace
w2.Transparency = 0.7
table.insert(Effects,{w2,"Disappear",.01})
w2.CFrame = maincf*CFrame.Angles(math.pi,math.pi,-math.pi/2)*CFrame.new(0,width/2,-len1 - len2/2)
table.insert(list,w2)
end
return unpack(list)
end
	
	
so = function(id,par,vol,pit) 
coroutine.resume(coroutine.create(function()
local sou = Instance.new("Sound",par or workspace)
sou.Volume=vol
sou.Pitch=pit or 1
sou.SoundId=id
swait() 
sou:play() 
game:GetService("Debris"):AddItem(sou,6)
end))
end
 
function clerp(a,b,t) 
local qa = {QuaternionFromCFrame(a)}
local qb = {QuaternionFromCFrame(b)} 
local ax, ay, az = a.x, a.y, a.z 
local bx, by, bz = b.x, b.y, b.z
local _t = 1-t
return QuaternionToCFrame(_t*ax + t*bx, _t*ay + t*by, _t*az + t*bz,QuaternionSlerp(qa, qb, t)) 
end 
 
function QuaternionFromCFrame(cf) 
local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components() 
local trace = m00 + m11 + m22 
if trace > 0 then 
local s = math.sqrt(1 + trace) 
local recip = 0.5/s 
return (m21-m12)*recip, (m02-m20)*recip, (m10-m01)*recip, s*0.5 
else 
local i = 0 
if m11 > m00 then
i = 1
end
if m22 > (i == 0 and m00 or m11) then 
i = 2 
end 
if i == 0 then 
local s = math.sqrt(m00-m11-m22+1) 
local recip = 0.5/s 
return 0.5*s, (m10+m01)*recip, (m20+m02)*recip, (m21-m12)*recip 
elseif i == 1 then 
local s = math.sqrt(m11-m22-m00+1) 
local recip = 0.5/s 
return (m01+m10)*recip, 0.5*s, (m21+m12)*recip, (m02-m20)*recip 
elseif i == 2 then 
local s = math.sqrt(m22-m00-m11+1) 
local recip = 0.5/s return (m02+m20)*recip, (m12+m21)*recip, 0.5*s, (m10-m01)*recip 
end 
end 
end
 
function QuaternionToCFrame(px, py, pz, x, y, z, w) 
local xs, ys, zs = x + x, y + y, z + z 
local wx, wy, wz = w*xs, w*ys, w*zs 
local xx = x*xs 
local xy = x*ys 
local xz = x*zs 
local yy = y*ys 
local yz = y*zs 
local zz = z*zs 
return CFrame.new(px, py, pz,1-(yy+zz), xy - wz, xz + wy,xy + wz, 1-(xx+zz), yz - wx, xz - wy, yz + wx, 1-(xx+yy)) 
end
 
function QuaternionSlerp(a, b, t) 
local cosTheta = a[1]*b[1] + a[2]*b[2] + a[3]*b[3] + a[4]*b[4] 
local startInterp, finishInterp; 
if cosTheta >= 0.0001 then 
if (1 - cosTheta) > 0.0001 then 
local theta = math.acos(cosTheta) 
local invSinTheta = 1/math.sin(theta) 
startInterp = math.sin((1-t)*theta)*invSinTheta 
finishInterp = math.sin(t*theta)*invSinTheta  
else 
startInterp = 1-t 
finishInterp = t 
end 
else 
if (1+cosTheta) > 0.0001 then 
local theta = math.acos(-cosTheta) 
local invSinTheta = 1/math.sin(theta) 
startInterp = math.sin((t-1)*theta)*invSinTheta 
finishInterp = math.sin(t*theta)*invSinTheta 
else 
startInterp = t-1 
finishInterp = t 
end 
end 
return a[1]*startInterp + b[1]*finishInterp, a[2]*startInterp + b[2]*finishInterp, a[3]*startInterp + b[3]*finishInterp, a[4]*startInterp + b[4]*finishInterp 
end

function rayCast(Pos, Dir, Max, Ignore)  -- Origin Position , Direction, MaxDistance , IgnoreDescendants
return game:service("Workspace"):FindPartOnRay(Ray.new(Pos, Dir.unit * (Max or 999.999)), Ignore) 
end 

Damagefunc=function(Part,hit,minim,maxim,knockback,Type,Property,Delay,KnockbackType,decreaseblock)
        if hit.Parent==nil then
                return
        end
        local h=hit.Parent:FindFirstChild("Humanoid")
        for _,v in pairs(hit.Parent:children()) do
        if v:IsA("Humanoid") then
        h=v
        end
        end
        if hit.Parent.Parent:FindFirstChild("Torso")~=nil then
        h=hit.Parent.Parent:FindFirstChild("Humanoid")
        end
        if hit.Parent.className=="Hat" then
        hit=hit.Parent.Parent:findFirstChild("Head")
        end
        if h~=nil and hit.Parent.Name~=Character.Name and hit.Parent:FindFirstChild("Torso")~=nil then
        if hit.Parent:findFirstChild("DebounceHit")~=nil then if hit.Parent.DebounceHit.Value==true then return end end
        --[[                if game.Players:GetPlayerFromCharacter(hit.Parent)~=nil then
                        return
                end]]
--                        hs(hit,1.2) 
                        local c=Instance.new("ObjectValue")
                        c.Name="creator"
                        c.Value=game:service("Players").LocalPlayer
                        c.Parent=h
                        game:GetService("Debris"):AddItem(c,.5)
                local Damage=math.random(minim,maxim)
--                h:TakeDamage(Damage)
                local  blocked=false
                local  block=hit.Parent:findFirstChild("Block")
                if block~=nil then
                print(block.className)
                if block.className=="NumberValue" then
                if block.Value>0 then
                blocked=true
                if decreaseblock==nil then
                block.Value=block.Value-1
                end
                end
                end
                if block.className=="IntValue" then
                if block.Value>0 then
                blocked=true
                if decreaseblock~=nil then
                block.Value=block.Value-1
                end
                end
                end
                end
                if blocked==false then
--                h:TakeDamage(Damage)
                h.Health=h.Health-Damage
                ShowDamage((Part.CFrame * CFrame.new(0, 0, (Part.Size.Z / 2)).p + Vector3.new(0, 1.5, 0)), -Damage, 1.5, Part.BrickColor.Color)
                else
                h.Health=h.Health-(Damage/2)
                ShowDamage((Part.CFrame * CFrame.new(0, 0, (Part.Size.Z / 2)).p + Vector3.new(0, 1.5, 0)), -Damage, 1.5, BrickColor.new("Bright blue").Color)
                end
                if Type=="Knockdown" then
                local hum=hit.Parent.Humanoid
hum.PlatformStand=true
coroutine.resume(coroutine.create(function(HHumanoid)
swait(1)
HHumanoid.PlatformStand=false
end),hum)
                local angle=(hit.Position-(Property.Position+Vector3.new(0,0,0))).unit
--hit.CFrame=CFrame.new(hit.Position,Vector3.new(angle.x,hit.Position.y,angle.z))*CFrame.fromEulerAnglesXYZ(math.pi/4,0,0)
local bodvol=Instance.new("BodyVelocity")
bodvol.velocity=angle*knockback
bodvol.P=5000
bodvol.maxForce=Vector3.new(8e+003, 8e+003, 8e+003)
bodvol.Parent=hit
local rl=Instance.new("BodyAngularVelocity")
rl.P=3000
rl.maxTorque=Vector3.new(500000,500000,500000)*50000000000000
rl.angularvelocity=Vector3.new(math.random(-10,10),math.random(-10,10),math.random(-10,10))
rl.Parent=hit
game:GetService("Debris"):AddItem(bodvol,.5)
game:GetService("Debris"):AddItem(rl,.5)
                elseif Type=="Normal" then
                local vp=Instance.new("BodyVelocity")
                vp.P=500
                vp.maxForce=Vector3.new(math.huge,0,math.huge)
--                vp.velocity=Character.Torso.CFrame.lookVector*Knockback
                if KnockbackType==1 then
                vp.velocity=Property.CFrame.lookVector*knockback+Property.Velocity/1.05
                elseif KnockbackType==2 then
                vp.velocity=Property.CFrame.lookVector*knockback
                end
                if knockback>0 then
                        vp.Parent=hit.Parent.Torso
                end
                game:GetService("Debris"):AddItem(vp,.5)
                elseif Type=="Up" then
                local bodyVelocity=Instance.new("BodyVelocity")
                bodyVelocity.velocity=vt(0,60,0)
                bodyVelocity.P=5000
                bodyVelocity.maxForce=Vector3.new(8e+003, 8e+003, 8e+003)
                bodyVelocity.Parent=hit
                game:GetService("Debris"):AddItem(bodyVelocity,1)
                local rl=Instance.new("BodyAngularVelocity")
                rl.P=3000
                rl.maxTorque=Vector3.new(500000,500000,500000)*50000000000000
                rl.angularvelocity=Vector3.new(math.random(-30,30),math.random(-30,30),math.random(-30,30))
                rl.Parent=hit
                game:GetService("Debris"):AddItem(rl,.5)
                elseif Type=="Snare" then
                local bp=Instance.new("BodyPosition")
                bp.P=2000
                bp.D=100
                bp.maxForce=Vector3.new(math.huge,math.huge,math.huge)
                bp.position=hit.Parent.Torso.Position
                bp.Parent=hit.Parent.Torso
                game:GetService("Debris"):AddItem(bp,1)
                elseif Type=="Target" then
	            local Targetting = false
                if Targetting==false then
                ZTarget=hit.Parent.Torso
                coroutine.resume(coroutine.create(function(Part) 
                so("http://www.roblox.com/asset/?id=15666462",Part,1,1.5) 
                swait(5)
                so("http://www.roblox.com/asset/?id=15666462",Part,1,1.5) 
                end),ZTarget)
                local TargHum=ZTarget.Parent:findFirstChild("Humanoid")
                local  targetgui=Instance.new("BillboardGui")
                targetgui.Parent=ZTarget
                targetgui.Size=UDim2.new(10,100,10,100)
                local targ=Instance.new("ImageLabel")
                targ.Parent=targetgui
                targ.BackgroundTransparency=1
                targ.Image="rbxassetid://4834067"
                targ.Size=UDim2.new(1,0,1,0)
                cam.CameraType="Scriptable"
                cam.CoordinateFrame=CFrame.new(Head.CFrame.p,ZTarget.Position)
                local dir=Vector3.new(cam.CoordinateFrame.lookVector.x,0,cam.CoordinateFrame.lookVector.z)
                workspace.CurrentCamera.CoordinateFrame=CFrame.new(Head.CFrame.p,ZTarget.Position)
                Targetting=true
                RocketTarget=ZTarget
                for i=1,Property do
                --while Targetting==true and Humanoid.Health>0 and Character.Parent~=nil do
                if Humanoid.Health>0 and Character.Parent~=nil and TargHum.Health>0 and TargHum.Parent~=nil and Targetting==true then
                swait()
                end
                --workspace.CurrentCamera.CoordinateFrame=CFrame.new(Head.CFrame.p,Head.CFrame.p+rmdir*100)
                cam.CoordinateFrame=CFrame.new(Head.CFrame.p,ZTarget.Position)
                dir=Vector3.new(cam.CoordinateFrame.lookVector.x,0,cam.CoordinateFrame.lookVector.z)
                cam.CoordinateFrame=CFrame.new(Head.CFrame.p,ZTarget.Position)*cf(0,5,10)*euler(-0.3,0,0)
                end
                Targetting=false
                RocketTarget=nil
                targetgui.Parent=nil
                cam.CameraType="Custom"
                end
                end
                        local debounce=Instance.new("BoolValue")
                        debounce.Name="DebounceHit"
                        debounce.Parent=hit.Parent
                        debounce.Value=true
                        game:GetService("Debris"):AddItem(debounce,Delay)
                        c=Instance.new("ObjectValue")
                        c.Name="creator"
                        c.Value=Player
                        c.Parent=h
                        game:GetService("Debris"):AddItem(c,.5)
        end
end


function ShowDamage(Pos, Text, Time, Color)
	local Rate = (1 / 30)
	local Pos = (Pos or Vector3.new(0, 0, 0))
	local Text = (Text or "")
	local Time = (Time or 2)
	local Color = (Color or Color3.new(1, 0, 0))
	local EffectPart = part("Custom",workspace,"SmoothPlastic",0,1,BrickColor.new(Color),"Effect",vt(0,0,0))
	EffectPart.Anchored = true
	local BillboardGui = Instance.new("BillboardGui")
	BillboardGui.Size = UDim2.new(3, 0, 3, 0)
	BillboardGui.Adornee = EffectPart
	local TextLabel = Instance.new("TextLabel")
	TextLabel.BackgroundTransparency = 1
	TextLabel.Size = UDim2.new(1, 0, 1, 0)
	TextLabel.Text = Text
	TextLabel.TextColor3 = Color
	TextLabel.TextScaled = true
	TextLabel.Font = Enum.Font.ArialBold
	TextLabel.Parent = BillboardGui
	BillboardGui.Parent = EffectPart
	game.Debris:AddItem(EffectPart, (Time + 0.1))
	EffectPart.Parent = game:GetService("Workspace")
	Delay(0, function()
		local Frames = (Time / Rate)
		for Frame = 1, Frames do
			wait(Rate)
			local Percent = (Frame / Frames)
			EffectPart.CFrame = CFrame.new(Pos) + Vector3.new(0, Percent, 0)
			TextLabel.TextTransparency = Percent
		end
		if EffectPart and EffectPart.Parent then
			EffectPart:Destroy()
		end
	end)
end

--example: local con = HitboxB.Touched:connect(function(hit) Damagefunc(Hitbox,hit,Dmg,Dmg,math.random(Knockback,Knockback),"Normal",RootPart,.2,1) end) 

HandleA=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,1,"Institutional white","HandleA",Vector3.new(1, 0.400000036, 1))
HandleAweld=weld(m,Character["Right Arm"],HandleA,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.000177383423, 0.000635385513, 7.62939453e-006, 0.999995708, -5.82661198e-013, 0, 5.82665426e-013, 0.999988437, 0, 0, 0, 1))
BladeHandleConnectorA=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","BladeHandleConnectorA",Vector3.new(1.4000001, 0.220000014, 1))
BladeHandleConnectorAweld=weld(m,HandleA,BladeHandleConnectorA,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.89938426, -2.86102295e-005, 1.19999695, -5.82656156e-013, 0.999988437, 0, 0.999995708, 5.82660385e-013, 0, 0, 0, -1))
mesh("CylinderMesh",BladeHandleConnectorA,"","",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(1.01999998, 0.200000003, 0.200000003))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.000186920166, 0.692876816, -0.409996033, 0.999995708, 5.82660385e-013, 0, -5.82656156e-013, 0.999988437, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(0.200000003, 2, 0.200000003))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.200004578, 0.000294685364, -0.799995422, 0.999994278, 1.95156391e-017, 0, -1.10588622e-017, 0.999987006, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(0.200000003, 0.200000003, 0.620000005))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.409797668, 0.693174839, 0, 0.999995708, 5.82660385e-013, 0, -5.82656156e-013, 0.999988437, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.600000083, 0.240000024, 0.200000003))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(1.09938335, -2.86102295e-005, 1.20000458, -5.82656156e-013, 0.999988437, 0, 0.999995708, 5.82660385e-013, 0, 0, 0, -1))
mesh("CylinderMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(0.200000003, 0.200000003, 0.620000005))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.410173416, 0.693437576, 0, 0.999995708, 5.82660385e-013, 0, -5.82656156e-013, 0.999988437, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","Part",Vector3.new(0.200000003, 0.200000003, 0.400000006))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.200004578, -1.10005522, -0.699996948, -0.999998927, -5.96037353e-008, 0, 5.96046021e-008, -0.999984384, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","Part",Vector3.new(0.200000003, 0.200000003, 0.400000006))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.199983597, -1.1000526, -0.699996948, -0.999999642, -5.96029111e-008, 0, 5.96037779e-008, -0.999985099, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","Part",Vector3.new(0.600000024, 2, 0.200000003))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-1.14440918e-005, -4.72068787e-005, -0.599998474, 1, -1.73368871e-012, 0, 1.73371408e-012, 0.999985456, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(1.01999998, 0.200000003, 0.200000003))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.000186920166, -0.707019329, 0.410003662, 0.999995708, 5.82660385e-013, 0, -5.82656156e-013, 0.999988437, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(1.01999998, 0.200000003, 0.200000003))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.000183105469, -0.706961393, -0.409988403, 1, 5.82662878e-013, 0, -5.82654422e-013, 0.999985456, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","Part",Vector3.new(0.200000003, 0.200000003, 0.200000003))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.20000267, -1.09964895, -0.400001526, 1, 2.79724161e-017, 0, -1.10588622e-017, 0.999985456, 0, 0, 0, 1))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(1.01999998, 0.200000003, 0.200000003))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.000186920166, 0.692876816, 0.410003662, 0.999995708, 5.82660385e-013, 0, -5.82656156e-013, 0.999988437, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","Part",Vector3.new(0.200000003, 0.200000003, 0.400000006))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.199975967, -1.09949017, -0.699996948, 0.999990344, -1.73369435e-012, 0, 1.73371972e-012, 0.999975801, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(0.200000003, 0.200000003, 0.620000005))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.409814835, -0.706642628, 7.62939453e-006, 1, 5.82662878e-013, 0, -5.82654422e-013, 0.999985456, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","Part",Vector3.new(0.200000003, 0.200000003, 0.200000003))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.199972153, -1.09945822, -0.400001526, 1, -1.73367744e-012, 0, 1.7337195e-012, 0.999985456, 0, 0, 0, 1))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(0.200000003, 2, 0.200000003))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.199972153, 0.000449895859, -0.799995422, 1, -1.73367744e-012, 0, 1.7337195e-012, 0.999985456, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(0.200000003, 0.200000003, 0.620000005))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.41018486, -0.706405401, 7.62939453e-006, 1, 5.82662878e-013, 0, -5.82654422e-013, 0.999985456, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","Part",Vector3.new(0.200000003, 0.200000003, 0.400000006))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.200000763, -1.09963894, -0.699996948, 1, 2.79724161e-017, 0, -1.10588622e-017, 0.999985456, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","Part",Vector3.new(0.200000003, 0.200000003, 0.200000003))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.199943542, -1.09989512, -0.400009155, -0.999995708, -5.96046945e-008, 0, 5.96051279e-008, -0.999988437, 0, 0, 0, 1))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","Part",Vector3.new(0.200000003, 0.200000003, 0.200000003))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.200027466, -1.09989035, -0.400009155, -0.999995708, -5.96046945e-008, 0, 5.96051279e-008, -0.999988437, 0, 0, 0, 1))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.600000083, 0.240000024, 0.200000003))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.899385691, -2.86102295e-005, 1.40000153, -5.82656156e-013, 0.999988437, 0, 0.999995708, 5.82660385e-013, 0, 0, 0, -1))
mesh("CylinderMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.600000083, 0.240000024, 0.200000003))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.699409246, -2.86102295e-005, 1.20000458, -5.82656156e-013, 0.999988437, 0, 0.999995708, 5.82660385e-013, 0, 0, 0, -1))
mesh("CylinderMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.600000083, 0.240000024, 0.200000003))
Partweld=weld(m,HandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.899385691, -2.86102295e-005, 1, -5.82656156e-013, 0.999988437, 0, 0.999995708, 5.82660385e-013, 0, 0, 0, -1))
mesh("CylinderMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))

HandleB=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,1,"Institutional white","HandleB",Vector3.new(1, 0.400000036, 1))
HandleBweld=weld(m,Character["Left Arm"],HandleB,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.000177383423, 0.000635385513, 7.62939453e-006, 0.999995708, -5.82661198e-013, 0, 5.82665426e-013, 0.999988437, 0, 0, 0, 1))
BladeHandleConnectorB=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","BladeHandleConnectorB",Vector3.new(1.4000001, 0.220000014, 1))
BladeHandleConnectorBweld=weld(m,HandleB,BladeHandleConnectorB,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.89938426, -2.86102295e-005, 1.19999695, -5.82656156e-013, 0.999988437, 0, 0.999995708, 5.82660385e-013, 0, 0, 0, -1))
mesh("CylinderMesh",BladeHandleConnectorB,"","",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(1.01999998, 0.200000003, 0.200000003))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.000186920166, 0.692876816, -0.409996033, 0.999995708, 5.82660385e-013, 0, -5.82656156e-013, 0.999988437, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(0.200000003, 2, 0.200000003))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.200004578, 0.000294685364, -0.799995422, 0.999994278, 1.95156391e-017, 0, -1.10588622e-017, 0.999987006, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(0.200000003, 0.200000003, 0.620000005))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.409797668, 0.693174839, 0, 0.999995708, 5.82660385e-013, 0, -5.82656156e-013, 0.999988437, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.600000083, 0.240000024, 0.200000003))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(1.09938335, -2.86102295e-005, 1.20000458, -5.82656156e-013, 0.999988437, 0, 0.999995708, 5.82660385e-013, 0, 0, 0, -1))
mesh("CylinderMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(0.200000003, 0.200000003, 0.620000005))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.410173416, 0.693437576, 0, 0.999995708, 5.82660385e-013, 0, -5.82656156e-013, 0.999988437, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","Part",Vector3.new(0.200000003, 0.200000003, 0.400000006))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.200004578, -1.10005498, -0.699996948, -0.999998927, -5.96037353e-008, 0, 5.96046021e-008, -0.999984384, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","Part",Vector3.new(0.200000003, 0.200000003, 0.400000006))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.199983597, -1.10005188, -0.699996948, -0.999999642, -5.96029111e-008, 0, 5.96037779e-008, -0.999985099, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","Part",Vector3.new(0.600000024, 2, 0.200000003))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-1.14440918e-005, -4.79221344e-005, -0.599998474, 1, -1.73368871e-012, 0, 1.73371408e-012, 0.999985456, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(1.01999998, 0.200000003, 0.200000003))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.000186920166, -0.707019329, 0.410003662, 0.999995708, 5.82660385e-013, 0, -5.82656156e-013, 0.999988437, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(1.01999998, 0.200000003, 0.200000003))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.000183105469, -0.706961393, -0.409988403, 1, 5.82662878e-013, 0, -5.82654422e-013, 0.999985456, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","Part",Vector3.new(0.200000003, 0.200000003, 0.200000003))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.20000267, -1.09964895, -0.400001526, 1, 2.79724161e-017, 0, -1.10588622e-017, 0.999985456, 0, 0, 0, 1))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(1.01999998, 0.200000003, 0.200000003))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.000186920166, 0.692876816, 0.410003662, 0.999995708, 5.82660385e-013, 0, -5.82656156e-013, 0.999988437, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","Part",Vector3.new(0.200000003, 0.200000003, 0.400000006))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.199975967, -1.09949064, -0.699996948, 0.999990344, -1.73369435e-012, 0, 1.73371972e-012, 0.999975801, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(0.200000003, 0.200000003, 0.620000005))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.409814835, -0.706642628, 7.62939453e-006, 1, 5.82662878e-013, 0, -5.82654422e-013, 0.999985456, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","Part",Vector3.new(0.200000003, 0.200000003, 0.200000003))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.199972153, -1.09945869, -0.400001526, 1, -1.73367744e-012, 0, 1.7337195e-012, 0.999985456, 0, 0, 0, 1))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(0.200000003, 2, 0.200000003))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.199972153, 0.000449419022, -0.799995422, 1, -1.73367744e-012, 0, 1.7337195e-012, 0.999985456, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Medium stone grey","Part",Vector3.new(0.200000003, 0.200000003, 0.620000005))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.41018486, -0.706405401, 7.62939453e-006, 1, 5.82662878e-013, 0, -5.82654422e-013, 0.999985456, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","Part",Vector3.new(0.200000003, 0.200000003, 0.400000006))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.200000763, -1.09963894, -0.699996948, 1, 2.79724161e-017, 0, -1.10588622e-017, 0.999985456, 0, 0, 0, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","Part",Vector3.new(0.200000003, 0.200000003, 0.200000003))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-0.19994545, -1.09989488, -0.400009155, -0.999995708, -5.96046945e-008, 0, 5.96051279e-008, -0.999988437, 0, 0, 0, 1))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Institutional white","Part",Vector3.new(0.200000003, 0.200000003, 0.200000003))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.200025558, -1.09989011, -0.400009155, -0.999995708, -5.96046945e-008, 0, 5.96051279e-008, -0.999988437, 0, 0, 0, 1))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.600000083, 0.240000024, 0.200000003))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.899385691, -2.86102295e-005, 1.40000153, -5.82656156e-013, 0.999988437, 0, 0.999995708, 5.82660385e-013, 0, 0, 0, -1))
mesh("CylinderMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.600000083, 0.240000024, 0.200000003))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.699409246, -2.86102295e-005, 1.20000458, -5.82656156e-013, 0.999988437, 0, 0.999995708, 5.82660385e-013, 0, 0, 0, -1))
mesh("CylinderMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.600000083, 0.240000024, 0.200000003))
Partweld=weld(m,HandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.899385691, -2.86102295e-005, 1, -5.82656156e-013, 0.999988437, 0, 0.999995708, 5.82660385e-013, 0, 0, 0, -1))
mesh("CylinderMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))

BladeHandleA=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,1,"Institutional white","BladeHandleA",Vector3.new(1.4000001, 0.220000014, 1))
BladeHandleAweld=weld(m,BladeHandleConnectorA,BladeHandleA,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-2.38418579e-007, 5.7220459e-006, 5.34057617e-005, 0.999991417, 0, 0, 0, 0.999991417, 0, 0, 0, 1))
mesh("CylinderMesh",BladeHandleA,"","",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
HitboxA=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,1,"Bright violet","HitboxA",Vector3.new(0.200000003, 4.46999931, 1.20000005))
HitboxAweld=weld(m,BladeHandleA,HitboxA,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-3.81469727e-006, -2.33488393, -0.0999603271, -5.07829956e-009, 0.999991417, 2.48707389e-014, 0.999991417, 5.07829956e-009, -1.34119915e-007, -1.34118736e-007, 2.4189428e-014, -1))
mesh("BlockMesh",HitboxA,"","",Vector3.new(0, 0, 0),Vector3.new(0.400000036, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 0.400000036, 0.400000006))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(2.28881836e-005, -4.28574753, -0.731384277, -8.52119482e-013, 0.999991417, -1.12192414e-013, 0.965912759, 8.52119536e-013, 0.258836478, 0.258834273, 1.12191493e-013, -0.965921223))
mesh("BlockMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(0.400000036, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 0.200000003, 0.389999986))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-2.28881836e-005, -4.9856987, 0.336387634, 8.52119482e-013, -0.999991417, 1.12192414e-013, 0.965912759, 8.52119536e-013, 0.258836478, -0.258834273, -1.12191493e-013, 0.965921223))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(0.419999957, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(0.200000003, 0.400000036, 0.200000003))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-2.67028809e-005, -4.28572464, 0.831382751, 8.66855741e-013, -0.999991417, 7.10592626e-015, 0.96591264, 8.39153616e-013, 0.258836836, -0.25883466, -2.17510512e-013, 0.965921164))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.220000014, 0.200000003, 0.200000003))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-4.57763672e-005, 1.57149315, 0.617614746, 2.90723055e-008, -0.999991417, -3.90545196e-008, -0.9659127, -3.81902048e-008, 0.258836657, -0.258834481, 3.01982901e-008, -0.965921164))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 0.400000036, 0.400000006))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-2.28881836e-005, -4.68569565, 0.731384277, 8.52119482e-013, -0.999991417, 1.12192414e-013, 0.965912759, 8.52119536e-013, 0.258836478, -0.258834273, -1.12191493e-013, 0.965921223))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(0.419999957, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(0.200000003, 0.200000003, 0.200000003))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-2.67028809e-005, -4.58571625, 0.631385803, 8.66855741e-013, -0.999991417, 7.10592626e-015, 0.96591264, 8.39153616e-013, 0.258836836, -0.25883466, -2.17510512e-013, 0.965921164))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 0.800000012, 0.390000015))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(2.28881836e-005, -4.48573303, -0.336387634, -8.52119482e-013, 0.999991417, -1.12192414e-013, 0.965912759, 8.52119536e-013, 0.258836478, 0.258834273, 1.12191493e-013, -0.965921223))
mesh("BlockMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(0.400000036, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(0.200000003, 0.200000003, 0.400000006))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-2.67028809e-005, -4.78570175, 0.331382751, 8.66855741e-013, -0.999991417, 7.10592626e-015, 0.96591264, 8.39153616e-013, 0.258836836, -0.25883466, -2.17510512e-013, 0.965921164))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(0.200000003, 2.39999986, 0.400000006))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(2.67028809e-005, -3.48581314, -0.331382751, -8.52120132e-013, 0.999991417, -1.12192563e-013, 0.9659127, 8.52120186e-013, 0.258836657, 0.258834481, 1.12191696e-013, -0.965921164))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.220000014, 0.200000003, 0.200000003))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-4.76837158e-005, -1.9578495, -0.121131897, 0, -0.999991417, 0, 0.9659127, -1.34918379e-019, -0.258836657, 0.258834481, -7.18554996e-021, 0.965921164))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(0.200000003, 1.79999971, 0.200000003))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(2.67028809e-005, -3.18583298, -0.831367493, -8.52120132e-013, 0.999991417, -1.12192563e-013, 0.9659127, 8.52120186e-013, 0.258836657, 0.258834481, 1.12191696e-013, -0.965921164))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.220000014, 0.200000003, 0.400000006))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(4.57763672e-005, -1.57133484, 0.317611694, -2.90723055e-008, 0.999991417, 3.90545196e-008, 0.9659127, 3.81902048e-008, -0.258836657, -0.258834481, 3.01982901e-008, -0.965921164))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(0.200000003, 1.19999969, 0.200000003))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(2.67028809e-005, -2.88584137, -1.03137207, -8.52120132e-013, 0.999991417, -1.12192563e-013, 0.9659127, 8.52120186e-013, 0.258836657, 0.258834481, 1.12191696e-013, -0.965921164))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(0.200000003, 0.600000024, 0.200000003))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-2.28881836e-005, -3.78577423, 1.03136444, 8.66855741e-013, -0.999991417, 7.10592626e-015, 0.96591264, 8.39153616e-013, 0.258836836, -0.25883466, -2.17510512e-013, 0.965921164))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 2.46999955, 0.200000003))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-3.81469727e-006, -1.33489347, -0.599960327, -5.07829956e-009, 0.999991417, 2.48707389e-014, 0.999991417, 5.07829956e-009, -1.34119915e-007, -1.34118736e-007, 2.4189428e-014, -1))
mesh("BlockMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(0.400000036, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 0.400000006, 0.200000003))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-2.28881836e-005, -4.28572083, 1.03136444, 8.52119482e-013, -0.999991417, 1.12192414e-013, 0.965912759, 8.52119536e-013, 0.258836478, -0.258834273, -1.12191493e-013, 0.965921223))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(0.419999957, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.220000014, 0.200000003, 0.200000003))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-4.76837158e-005, -1.5715065, -0.0176010132, 2.90723055e-008, -0.999991417, -3.90545196e-008, 0.9659127, 3.81902048e-008, -0.258836657, 0.258834481, -3.01982901e-008, 0.965921164))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(0.200000003, 2.59999967, 1))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(2.67028809e-005, -1.20041084, 4.57763672e-005, -8.66888917e-013, 0.999991417, 0, 0.999991417, 8.66888917e-013, 0, 0, 0, -1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.220000014, 0.200000003, 0.400000006))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(4.19616699e-005, -1.18499756, 0.214080811, 0, 0.999991417, 0, 0.9659127, -1.34918379e-019, -0.258836746, -0.258834541, 7.18560166e-021, -0.965921104))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(0.200000003, 2.19999981, 0.200000003))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(2.67028809e-005, -3.38580704, -0.631378174, -8.52120132e-013, 0.999991417, -1.12192563e-013, 0.9659127, 8.52120186e-013, 0.258836657, 0.258834481, 1.12191696e-013, -0.965921164))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 1.3999995, 0.200000003))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(2.28881836e-005, -2.98582458, -1.23136902, -8.52643693e-013, 0.999991417, -1.12261525e-013, 0.9659127, 8.52643748e-013, 0.258836716, 0.258834511, 1.12260631e-013, -0.965921164))
mesh("BlockMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(0.400000036, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 0.600000024, 0.200000003))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(2.28881836e-005, -3.78577423, -1.03137207, -8.52119482e-013, 0.999991417, -1.12192414e-013, 0.965912759, 8.52119536e-013, 0.258836478, 0.258834273, 1.12191493e-013, -0.965921223))
mesh("BlockMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(0.400000036, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.220000014, 0.200000003, 0.200000003))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-4.76837158e-005, 1.95782471, 0.721138, 0, -0.999991417, 0, -0.96591264, 1.34918328e-019, 0.258836567, -0.258834392, 7.18547241e-021, -0.965921164))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 0.200000003, 0.200000018))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.000118255615, 0.0005671978, 0.599990845, -2.08617564e-007, 0.999991417, 0, -0.999991417, -2.08617564e-007, 0, 0, 0, 1))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(0.419999957, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(1.20000005, 0.200000003, 1))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.100055456, 2.67028809e-005, -1.52587891e-005, 0.999990702, 5.82641737e-013, 0, -5.82641737e-013, 0.999990702, 0, 0, 0, 1))
mesh("CylinderMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.220000014, 0.200000003, 0.400000006))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(4.19616699e-005, -1.95767403, 0.421142578, 0, 0.999991417, 0, 0.9659127, -1.34918379e-019, -0.258836657, -0.258834481, 7.18554996e-021, -0.965921164))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 0.400000006, 0.200000003))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-1.71661377e-005, -3.88577271, 1.23136902, 1.47676383e-014, -0.999991417, -1.12192414e-013, 0.965912759, -1.47748211e-014, 0.258836478, -0.258834273, -1.12190537e-013, 0.965921223))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(0.419999957, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.220000014, 0.200000003, 0.200000003))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-4.76837158e-005, -1.18516731, 0.0859222412, 0, -0.999991417, 0, 0.9659127, -1.34918379e-019, -0.258836746, 0.258834541, -7.18560166e-021, 0.965921104))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.220000014, 0.200000003, 0.200000003))
Partweld=weld(m,BladeHandleA,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-4.76837158e-005, 1.18514824, 0.514091492, 0, -0.999991417, 0, -0.9659127, 1.34918379e-019, 0.258836687, -0.258834511, 7.18557581e-021, -0.965921223))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))

BladeHandleB=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,1,"Institutional white","BladeHandleB",Vector3.new(1.4000001, 0.220000014, 1))
BladeHandleBweld=weld(m,BladeHandleConnectorB,BladeHandleB,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-2.38418579e-007, 0, 5.34057617e-005, 0.999991417, 0, 0, 0, 0.999991417, 0, 0, 0, 1))
mesh("CylinderMesh",BladeHandleB,"","",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
HitboxB=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,1,"Bright violet","HitboxB",Vector3.new(0.200000003, 4.46999931, 1.20000005))
HitboxBweld=weld(m,BladeHandleB,HitboxB,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-3.81469727e-006, -2.33488393, -0.0999603271, -5.07829956e-009, 0.999991417, 2.48707389e-014, 0.999991417, 5.07829956e-009, -1.34119915e-007, -1.34118736e-007, 2.4189428e-014, -1))
mesh("BlockMesh",HitboxB,"","",Vector3.new(0, 0, 0),Vector3.new(0.400000036, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 0.400000036, 0.400000006))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(2.28881836e-005, -4.28574753, -0.731384277, -8.52119482e-013, 0.999991417, -1.12192414e-013, 0.965912759, 8.52119536e-013, 0.258836478, 0.258834273, 1.12191493e-013, -0.965921223))
mesh("BlockMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(0.400000036, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 0.200000003, 0.389999986))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-2.28881836e-005, -4.9856987, 0.336387634, 8.52119482e-013, -0.999991417, 1.12192414e-013, 0.965912759, 8.52119536e-013, 0.258836478, -0.258834273, -1.12191493e-013, 0.965921223))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(0.419999957, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(0.200000003, 0.400000036, 0.200000003))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-2.67028809e-005, -4.28572464, 0.831382751, 8.66855741e-013, -0.999991417, 7.10592626e-015, 0.96591264, 8.39153616e-013, 0.258836836, -0.25883466, -2.17510512e-013, 0.965921164))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.220000014, 0.200000003, 0.200000003))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-4.57763672e-005, 1.57149315, 0.617614746, 2.90723055e-008, -0.999991417, -3.90545196e-008, -0.9659127, -3.81902048e-008, 0.258836657, -0.258834481, 3.01982901e-008, -0.965921164))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 0.400000036, 0.400000006))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-2.28881836e-005, -4.68569565, 0.731384277, 8.52119482e-013, -0.999991417, 1.12192414e-013, 0.965912759, 8.52119536e-013, 0.258836478, -0.258834273, -1.12191493e-013, 0.965921223))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(0.419999957, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(0.200000003, 0.200000003, 0.200000003))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-2.67028809e-005, -4.58571625, 0.631385803, 8.66855741e-013, -0.999991417, 7.10592626e-015, 0.96591264, 8.39153616e-013, 0.258836836, -0.25883466, -2.17510512e-013, 0.965921164))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 0.800000012, 0.390000015))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(2.28881836e-005, -4.48573303, -0.336387634, -8.52119482e-013, 0.999991417, -1.12192414e-013, 0.965912759, 8.52119536e-013, 0.258836478, 0.258834273, 1.12191493e-013, -0.965921223))
mesh("BlockMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(0.400000036, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(0.200000003, 0.200000003, 0.400000006))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-2.67028809e-005, -4.78570175, 0.331382751, 8.66855741e-013, -0.999991417, 7.10592626e-015, 0.96591264, 8.39153616e-013, 0.258836836, -0.25883466, -2.17510512e-013, 0.965921164))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(0.200000003, 2.39999986, 0.400000006))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(2.67028809e-005, -3.48581314, -0.331382751, -8.52120132e-013, 0.999991417, -1.12192563e-013, 0.9659127, 8.52120186e-013, 0.258836657, 0.258834481, 1.12191696e-013, -0.965921164))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.220000014, 0.200000003, 0.200000003))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-4.76837158e-005, -1.9578495, -0.121131897, 0, -0.999991417, 0, 0.9659127, -1.34918379e-019, -0.258836657, 0.258834481, -7.18554996e-021, 0.965921164))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(0.200000003, 1.79999971, 0.200000003))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(2.67028809e-005, -3.18583298, -0.831367493, -8.52120132e-013, 0.999991417, -1.12192563e-013, 0.9659127, 8.52120186e-013, 0.258836657, 0.258834481, 1.12191696e-013, -0.965921164))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.220000014, 0.200000003, 0.400000006))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(4.57763672e-005, -1.57133484, 0.317611694, -2.90723055e-008, 0.999991417, 3.90545196e-008, 0.9659127, 3.81902048e-008, -0.258836657, -0.258834481, 3.01982901e-008, -0.965921164))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(0.200000003, 1.19999969, 0.200000003))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(2.67028809e-005, -2.88584137, -1.03137207, -8.52120132e-013, 0.999991417, -1.12192563e-013, 0.9659127, 8.52120186e-013, 0.258836657, 0.258834481, 1.12191696e-013, -0.965921164))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(0.200000003, 0.600000024, 0.200000003))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-2.28881836e-005, -3.78577423, 1.03136444, 8.66855741e-013, -0.999991417, 7.10592626e-015, 0.96591264, 8.39153616e-013, 0.258836836, -0.25883466, -2.17510512e-013, 0.965921164))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 2.46999955, 0.200000003))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-3.81469727e-006, -1.33489347, -0.599960327, -5.07829956e-009, 0.999991417, 2.48707389e-014, 0.999991417, 5.07829956e-009, -1.34119915e-007, -1.34118736e-007, 2.4189428e-014, -1))
mesh("BlockMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(0.400000036, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 0.400000006, 0.200000003))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-2.28881836e-005, -4.28572083, 1.03136444, 8.52119482e-013, -0.999991417, 1.12192414e-013, 0.965912759, 8.52119536e-013, 0.258836478, -0.258834273, -1.12191493e-013, 0.965921223))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(0.419999957, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.220000014, 0.200000003, 0.200000003))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-4.76837158e-005, -1.5715065, -0.0176010132, 2.90723055e-008, -0.999991417, -3.90545196e-008, 0.9659127, 3.81902048e-008, -0.258836657, 0.258834481, -3.01982901e-008, 0.965921164))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(0.200000003, 2.59999967, 1))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(2.67028809e-005, -1.20041084, 4.57763672e-005, -8.66888917e-013, 0.999991417, 0, 0.999991417, 8.66888917e-013, 0, 0, 0, -1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.220000014, 0.200000003, 0.400000006))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(4.19616699e-005, -1.18499756, 0.214080811, 0, 0.999991417, 0, 0.9659127, -1.34918379e-019, -0.258836746, -0.258834541, 7.18560166e-021, -0.965921104))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(0.200000003, 2.19999981, 0.200000003))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(2.67028809e-005, -3.38580704, -0.631378174, -8.52120132e-013, 0.999991417, -1.12192563e-013, 0.9659127, 8.52120186e-013, 0.258836657, 0.258834481, 1.12191696e-013, -0.965921164))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 1.3999995, 0.200000003))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(2.28881836e-005, -2.98582458, -1.23136902, -8.52643693e-013, 0.999991417, -1.12261525e-013, 0.9659127, 8.52643748e-013, 0.258836716, 0.258834511, 1.12260631e-013, -0.965921164))
mesh("BlockMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(0.400000036, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 0.600000024, 0.200000003))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(2.28881836e-005, -3.78577423, -1.03137207, -8.52119482e-013, 0.999991417, -1.12192414e-013, 0.965912759, 8.52119536e-013, 0.258836478, 0.258834273, 1.12191493e-013, -0.965921223))
mesh("BlockMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(0.400000036, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.220000014, 0.200000003, 0.200000003))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-4.76837158e-005, 1.95782471, 0.721138, 0, -0.999991417, 0, -0.96591264, 1.34918328e-019, 0.258836567, -0.258834392, 7.18547241e-021, -0.965921164))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 0.200000003, 0.200000018))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.000118255615, 0.0005671978, 0.599990845, -2.08617564e-007, 0.999991417, 0, -0.999991417, -2.08617564e-007, 0, 0, 0, 1))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(0.419999957, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0.5,0,"Light stone grey","Part",Vector3.new(1.20000005, 0.200000003, 1))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(0.100055456, 2.67028809e-005, -1.52587891e-005, 0.999990702, 5.82641737e-013, 0, -5.82641737e-013, 0.999990702, 0, 0, 0, 1))
mesh("CylinderMesh",Part,"","",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.220000014, 0.200000003, 0.400000006))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(4.19616699e-005, -1.95767403, 0.421142578, 0, 0.999991417, 0, 0.9659127, -1.34918379e-019, -0.258836657, -0.258834481, 7.18554996e-021, -0.965921164))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0.30000001192093,"Bright violet","Part",Vector3.new(0.200000003, 0.400000006, 0.200000003))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-1.71661377e-005, -3.88577271, 1.23136902, 1.47676383e-014, -0.999991417, -1.12192414e-013, 0.965912759, -1.47748211e-014, 0.258836478, -0.258834273, -1.12190537e-013, 0.965921223))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(0.419999957, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.220000014, 0.200000003, 0.200000003))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-4.76837158e-005, -1.18516731, 0.0859222412, 0, -0.999991417, 0, 0.9659127, -1.34918379e-019, -0.258836746, 0.258834541, -7.18560166e-021, 0.965921104))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))
Part=part(Enum.FormFactor.Custom,m,Enum.Material.SmoothPlastic,0,0,"Really black","Part",Vector3.new(0.220000014, 0.200000003, 0.200000003))
Partweld=weld(m,BladeHandleB,Part,CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(-4.76837158e-005, 1.18514824, 0.514091492, 0, -0.999991417, 0, -0.9659127, 1.34918379e-019, 0.258836687, -0.258834511, 7.18557581e-021, -0.965921223))
mesh("SpecialMesh",Part,Enum.MeshType.Wedge,"",Vector3.new(0, 0, 0),Vector3.new(1, 1, 1))

function attackone()
attack = true
local con = HitboxA.Touched:connect(function(hit) Damagefunc(HitboxA,hit,10,20,math.random(5,10),"Normal",RootPart,.2,1) end) 
for i = 0,1,0.3 do
swait()
RootJoint.C0 = clerp(RootJoint.C0,RootCF*cf(0,0,-0.3)* angles(math.rad(5),math.rad(0),math.rad(-30)),.5)
Torso.Neck.C0 = clerp(Torso.Neck.C0,necko *angles(math.rad(0),math.rad(0),math.rad(30)),.5)
RW.C0 = clerp(RW.C0, CFrame.new(1.3, 0.5, 0) * angles(math.rad(0), math.rad(50), math.rad(90)), 0.3)
LW.C0 = clerp(LW.C0, CFrame.new(-1.3, 0.5, -0.5) * angles(math.rad(0), math.rad(-120), math.rad(-70)),.5)
LH.C0=clerp(LH.C0,cf(-1,-.7,-.5)*angles(math.rad(0),math.rad(-60),math.rad(-10)),.5)
RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(-40)),.5)
end
so("http://www.roblox.com/asset/?id=243711349",HitboxA,1,1.2) 
for i = 0,1,0.2 do
swait()
local blcf = HitboxA.CFrame*CFrame.new(0,.5,0)
if scfr and (HitboxA.Position-scfr.p).magnitude > .1 then
local h = 5
local a,b = Triangle((scfr*CFrame.new(0,h/2,0)).p,(scfr*CFrame.new(0,-h/2,0)).p,(blcf*CFrame.new(0,h/2,0)).p)
if a then game.Debris:AddItem(a,1) end if b then game.Debris:AddItem(b,1) end
local a,b = Triangle((blcf*CFrame.new(0,h/2,0)).p,(blcf*CFrame.new(0,-h/2,0)).p,(scfr*CFrame.new(0,-h/2,0)).p)
if a then game.Debris:AddItem(a,1) end if b then game.Debris:AddItem(b,1) end
scfr = blcf
elseif not scfr then
scfr = blcf
end
RootJoint.C0 = clerp(RootJoint.C0,RootCF*cf(0,0,-0.3)* angles(math.rad(5),math.rad(0),math.rad(140)),.5)
Torso.Neck.C0 = clerp(Torso.Neck.C0,necko *angles(math.rad(10),math.rad(0),math.rad(-90)),.3)
RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, -.5) * angles(math.rad(0), math.rad(160), math.rad(90)),.5)
LW.C0 = clerp(LW.C0, CFrame.new(-1.3, 0.5, -0.5) * angles(math.rad(0), math.rad(-50), math.rad(-70)),.5)
RH.C0=clerp(RH.C0,cf(1,-.7,0)*angles(math.rad(0),math.rad(60),math.rad(10)),.5)
LH.C0=clerp(LH.C0,cf(-1.1,-1,-.5)*angles(math.rad(0),math.rad(-90),math.rad(40)),.5)
end
attack = false
con:disconnect()
scfr = nil
end

function attacktwo()
attack = true
local con = HitboxB.Touched:connect(function(hit) Damagefunc(HitboxB,hit,10,20,math.random(5,10),"Normal",RootPart,.2,1) end) 
for i = 0,1,0.3 do
swait()
RootJoint.C0 = clerp(RootJoint.C0,RootCF*cf(0,0,-0.3)* angles(math.rad(5),math.rad(0),math.rad(30)),.5)
Torso.Neck.C0 = clerp(Torso.Neck.C0,necko *angles(math.rad(0),math.rad(0),math.rad(-40)),.5)
RW.C0 = clerp(RW.C0, CFrame.new(1.3, 0.5, 0) * angles(math.rad(0), math.rad(50), math.rad(90)),.5)
LW.C0 = clerp(LW.C0, CFrame.new(-1.3, 0.5, -0.5) * angles(math.rad(0), math.rad(-120), math.rad(-70)),.5)
RH.C0=clerp(RH.C0,cf(1,-.7,0)*angles(math.rad(0),math.rad(60),math.rad(10)),.5)
LH.C0=clerp(LH.C0,cf(-1.1,-1,-.5)*angles(math.rad(0),math.rad(-90),math.rad(40)),.5)
end
so("http://www.roblox.com/asset/?id=243711349",HitboxA,1,1.3) 
for i = 0,1,0.2 do
swait()
local blcf = HitboxB.CFrame*CFrame.new(0,.5,0)
if scfr and (HitboxB.Position-scfr.p).magnitude > .1 then
local h = 5
local a,b = Triangle((scfr*CFrame.new(0,h/2,0)).p,(scfr*CFrame.new(0,-h/2,0)).p,(blcf*CFrame.new(0,h/2,0)).p)
if a then game.Debris:AddItem(a,1) end if b then game.Debris:AddItem(b,1) end
local a,b = Triangle((blcf*CFrame.new(0,h/2,0)).p,(blcf*CFrame.new(0,-h/2,0)).p,(scfr*CFrame.new(0,-h/2,0)).p)
if a then game.Debris:AddItem(a,1) end if b then game.Debris:AddItem(b,1) end
scfr = blcf
elseif not scfr then
scfr = blcf
end
RootJoint.C0 = clerp(RootJoint.C0,RootCF*cf(0,0,-0.3)* angles(math.rad(5),math.rad(0),math.rad(-140)),.5)
Torso.Neck.C0 = clerp(Torso.Neck.C0,necko *angles(math.rad(10),math.rad(0),math.rad(90)),.5)
RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, -.5) * angles(math.rad(0), math.rad(160), math.rad(90)),.5)
LW.C0 = clerp(LW.C0, CFrame.new(-1.3, 0.5, -0.5) * angles(math.rad(0), math.rad(-150), math.rad(-90)),.5)
LH.C0=clerp(LH.C0,cf(-1,-.7,-.5)*angles(math.rad(0),math.rad(-60),math.rad(-10)),.5)
RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(-40)),.5)
end
attack = false
con:disconnect()
scfr = nil
end

function JumpSpin()
attack = true
Humanoid.Jump = true
local con = HitboxA.Touched:connect(function(hit) Damagefunc(HitboxB,hit,10,20,math.random(5,10),"Normal",RootPart,.2,1) end) 
local con2 = HitboxB.Touched:connect(function(hit) Damagefunc(HitboxB,hit,10,20,math.random(5,10),"Normal",RootPart,.2,1) end) 
for i = 0,1,0.1 do
swait()
RootJoint.C0 = clerp(RootJoint.C0,RootCF*cf(0,0,0)* angles(math.rad(0),math.rad(0),math.rad(0)),.3)
Torso.Neck.C0 = clerp(Torso.Neck.C0,necko *angles(math.rad(10),math.rad(0),math.rad(0)),.3)
RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-50), math.rad(0), math.rad(20)), 0.3)
LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-50), math.rad(0), math.rad(-20)), 0.3)
RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(20)),.3)
LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(-20)),.3)
BladeHandleAweld.C0=clerp(BladeHandleAweld.C0,cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0)),.3)
BladeHandleBweld.C0=clerp(BladeHandleBweld.C0,cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0)),.3)
end
for i = 0,1,1 do
swait()
so("http://www.roblox.com/asset/?id=243711322",Torso,1,1) 
for i = 0,1,0.1 do
swait()
RootJoint.C0 = clerp(RootJoint.C0,RootCF*cf(0,0,3)* angles(6*i,math.rad(0),math.rad(0)),.5)
Torso.Neck.C0 = clerp(Torso.Neck.C0,necko *angles(math.rad(10),math.rad(0),math.rad(0)),.3)
RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(160), math.rad(0), math.rad(0)), 0.3)
LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(160), math.rad(0), math.rad(-0)), 0.3)
RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(-50)),.3)
LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(-30)),.3)
BladeHandleAweld.C0=clerp(BladeHandleAweld.C0,cf(0,0,0)*angles(math.rad(0),math.rad(180),math.rad(0)),.3)
BladeHandleBweld.C0=clerp(BladeHandleBweld.C0,cf(0,0,0)*angles(math.rad(0),math.rad(180),math.rad(0)),.3)
end
end
attack = false
con:disconnect()
con2:disconnect()
end

function OmegaSlash()
attack = true
so("http://www.roblox.com/asset/?id=152052659",HitboxA,1,1)
so("http://www.roblox.com/asset/?id=152052659",HitboxB,1,1)
local con = HitboxA.Touched:connect(function(hit) Damagefunc(HitboxB,hit,20,30,math.random(5,10),"Normal",RootPart,.2,1) end) 
local con2 = HitboxB.Touched:connect(function(hit) Damagefunc(HitboxB,hit,20,30,math.random(5,10),"Normal",RootPart,.2,1) end) 
for i = 0,1,0.2 do
swait()
RootJoint.C0 = clerp(RootJoint.C0,RootCF*cf(0,0,0)* angles(math.rad(0),math.rad(0),math.rad(50)),.5)
Torso.Neck.C0 = clerp(Torso.Neck.C0,necko *angles(math.rad(0),math.rad(0),math.rad(-50)),.5)
RW.C0 = clerp(RW.C0, CFrame.new(1.3, 0.5, -0.5) * angles(math.rad(0), math.rad(120), math.rad(120)), 0.5)
LW.C0 = clerp(LW.C0, CFrame.new(-1.3, 0.5, 0) * angles(math.rad(0), math.rad(120), math.rad(110)), 0.5)
RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(50),math.rad(0)),.5)
LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(20)),.5)
BladeHandleAweld.C0=clerp(BladeHandleAweld.C0,cf(0,0,0)*angles(math.rad(0),math.rad(180),math.rad(0)),.3)
BladeHandleBweld.C0=clerp(BladeHandleBweld.C0,cf(0,0,0)*angles(math.rad(0),math.rad(180),math.rad(0)),.3)
end
so("http://www.roblox.com/asset/?id=241816017",HitboxA,1,1)
so("http://www.roblox.com/asset/?id=241816017",HitboxB,1,1)
for i = 0,1,0.2 do
swait()
RootJoint.C0 = clerp(RootJoint.C0,RootCF*cf(0,0,0)* angles(math.rad(20),math.rad(0),math.rad(-80)),.5)
Torso.Neck.C0 = clerp(Torso.Neck.C0,necko *angles(math.rad(10),math.rad(0),math.rad(70)),.5)
RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(0), math.rad(50), math.rad(80)), 0.5)
LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, -0.5) * angles(math.rad(0), math.rad(50), math.rad(80)), 0.5)
RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(-20)),.5)
LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-50),math.rad(-50)),.5)
BladeHandleAweld.C0=clerp(BladeHandleAweld.C0,cf(0,0,0)*angles(math.rad(0),math.rad(180),math.rad(0)),.3)
BladeHandleBweld.C0=clerp(BladeHandleBweld.C0,cf(0,0,0)*angles(math.rad(0),math.rad(180),math.rad(0)),.3)
Torso.Velocity=Head.CFrame.lookVector*100
end
attack = false
con:disconnect()
con2:disconnect()
end

mouse.Button1Down:connect(function()
if attack == false and attacktype == 1 then
attacktype = 2
attackone()
elseif attack == false and attacktype == 2 then
attacktype = 1
attacktwo()
end
end)

mouse.KeyDown:connect(function(k)
k=k:lower()
if attack == false and k == 'q' then
JumpSpin()
elseif attack == false and k == 'e' then
OmegaSlash()
end
end)


local sine = 0
local change = 1
local val = 0

while true do
swait()
sine = sine + change
local torvel=(RootPart.Velocity*Vector3.new(1,0,1)).magnitude 
local velderp=RootPart.Velocity.y
hitfloor,posfloor=rayCast(RootPart.Position,(CFrame.new(RootPart.Position,RootPart.Position - Vector3.new(0,1,0))).lookVector,4,Character)
if equipped==true or equipped==false then
if attack==false then
idle=idle+1
else
idle=0
end
if idle>=500 then
if attack==false then
end
end
if RootPart.Velocity.y > 1 and hitfloor==nil then 
Anim="Jump"
if attack==false then
RootJoint.C0 = clerp(RootJoint.C0,RootCF*cf(0,0,0)* angles(math.rad(0),math.rad(0),math.rad(0)),.3)
Torso.Neck.C0 = clerp(Torso.Neck.C0,necko *angles(math.rad(-10),math.rad(0),math.rad(0)),.3)
RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(0), math.rad(0), math.rad(20)), 0.3)
LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(0), math.rad(0), math.rad(-20)), 0.3)
RH.C0=clerp(RH.C0,cf(1,-.5,-.5)*angles(math.rad(0),math.rad(90),math.rad(-10)),.3)
LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(-20)),.3)
BladeHandleAweld.C0=clerp(BladeHandleAweld.C0,cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0)),.3)
BladeHandleBweld.C0=clerp(BladeHandleBweld.C0,cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0)),.3)
end
elseif RootPart.Velocity.y < -1 and hitfloor==nil then 
Anim="Fall"
if attack==false then
RootJoint.C0 = clerp(RootJoint.C0,RootCF*cf(0,0,0)* angles(math.rad(10),math.rad(0),math.rad(0)),.3)
Torso.Neck.C0 = clerp(Torso.Neck.C0,necko *angles(math.rad(10),math.rad(0),math.rad(0)),.3)
RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(10), math.rad(0), math.rad(30)), 0.3)
LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(10), math.rad(0), math.rad(-30)), 0.3)
RH.C0=clerp(RH.C0,cf(1,-.5,-.5)*angles(math.rad(0),math.rad(90),math.rad(20)),.3)
LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(10)),.3)
BladeHandleAweld.C0=clerp(BladeHandleAweld.C0,cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0)),.3)
BladeHandleBweld.C0=clerp(BladeHandleBweld.C0,cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0)),.3)
end
elseif torvel<1 and hitfloor~=nil then
Anim="Idle"
if attack==false then
RootJoint.C0 = clerp(RootJoint.C0,RootCF*cf(0,0,-0.3)* angles(math.rad(5),math.rad(0),math.rad(30)),.3)
Torso.Neck.C0 = clerp(Torso.Neck.C0,necko *angles(math.rad(10),math.rad(0),math.rad(-30)),.3)
RW.C0 = clerp(RW.C0, CFrame.new(1.3, 0.5, 0) * angles(math.rad(90), math.rad(50), math.rad(20)), 0.3)
LW.C0 = clerp(LW.C0, CFrame.new(-1.3, 0.5, -0.5) * angles(math.rad(90), math.rad(-50), math.rad(20)), 0.3)
RH.C0=clerp(RH.C0,cf(1,-.7,0)*angles(math.rad(0),math.rad(60),math.rad(10)),.3)
LH.C0=clerp(LH.C0,cf(-1.1,-1,-.5)*angles(math.rad(0),math.rad(-90),math.rad(40)),.3)
BladeHandleAweld.C0=clerp(BladeHandleAweld.C0,cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0)),.3)
BladeHandleBweld.C0=clerp(BladeHandleBweld.C0,cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0)),.3)
end
elseif torvel>2 and hitfloor~=nil then
Anim="Walk"
if attack==false then
change=3
RootJoint.C0 = clerp(RootJoint.C0,RootCF*cf(0,0,0)* angles(math.rad(30),math.rad(0),math.rad(0)),.3)
Torso.Neck.C0 = clerp(Torso.Neck.C0,necko *angles(math.rad(-20),math.rad(0),math.rad(0)),.3)
RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-10), math.rad(20), math.rad(20)), 0.3)
LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-10), math.rad(-20), math.rad(-20)), 0.3)
RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0)),.3)
LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0)),.3)
BladeHandleAweld.C0=clerp(BladeHandleAweld.C0,cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0)),.3)
BladeHandleBweld.C0=clerp(BladeHandleBweld.C0,cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0)),.3)
end
end
end
if #Effects>0 then
for e=1,#Effects do
if Effects[e]~=nil then
local Thing=Effects[e]
if Thing~=nil then
local Part=Thing[1]
local Mode=Thing[2]
local Delay=Thing[3]
local IncX=Thing[4]
local IncY=Thing[5]
local IncZ=Thing[6]
if Thing[1].Transparency<=1 then
if Thing[2]=="Block1" then
Thing[1].CFrame=Thing[1].CFrame*euler(math.random(-50,50),math.random(-50,50),math.random(-50,50))
Mesh=Thing[1].Mesh
Mesh.Scale=Mesh.Scale+vt(Thing[4],Thing[5],Thing[6])
Thing[1].Transparency=Thing[1].Transparency+Thing[3]
elseif Thing[2]=="Cylinder" then
Mesh=Thing[1].Mesh
Mesh.Scale=Mesh.Scale+vt(Thing[4],Thing[5],Thing[6])
Thing[1].Transparency=Thing[1].Transparency+Thing[3]
elseif Thing[2]=="Blood" then
Mesh=Thing[7]
Thing[1].CFrame=Thing[1].CFrame*cf(0,.5,0)
Mesh.Scale=Mesh.Scale+vt(Thing[4],Thing[5],Thing[6])
Thing[1].Transparency=Thing[1].Transparency+Thing[3]
elseif Thing[2]=="Elec" then
Mesh=Thing[1].Mesh
Mesh.Scale=Mesh.Scale+vt(Thing[7],Thing[8],Thing[9])
Thing[1].Transparency=Thing[1].Transparency+Thing[3]
elseif Thing[2]=="Disappear" then
Thing[1].Transparency=Thing[1].Transparency+Thing[3]
end
else
Part.Parent=nil
table.remove(Effects,e)
end
end
end
end
end
end