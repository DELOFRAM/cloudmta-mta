local Class = {}
Class.HUD = {}
Class.HUD.sW, Class.HUD.sH = guiGetScreenSize(  )
Class.HUD.bar = {}
Class.HUD.bar.Full = {}
Class.HUD.bar.images = {}

Class.HUD.bar[1] = {}
Class.HUD.bar.Full[1] = {}
Class.HUD.bar.images[1] = "Treadmill"
Class.HUD.bar[1].X = Class.HUD.sW / 2 - 755
Class.HUD.bar[1].Y = Class.HUD.sH - 450
Class.HUD.bar[1].W	= 217
Class.HUD.bar[1].H	= 46
Class.HUD.bar.Full[1].W = Class.HUD.bar[1].W-10
Class.HUD.bar.Full[1].H = Class.HUD.bar[1].H-14
Class.HUD.bar.Full[1].X = Class.HUD.bar[1].X+5
Class.HUD.bar.Full[1].Y = Class.HUD.bar[1].Y+5

Class.HUD.bar[2] = {}
Class.HUD.bar.Full[2] = {}
Class.HUD.bar.images[2] = "Sleep"
Class.HUD.bar[2].X = Class.HUD.bar[1].X
Class.HUD.bar[2].Y = Class.HUD.bar[1].Y + 65
Class.HUD.bar[2].W	= 217
Class.HUD.bar[2].H	= 46
Class.HUD.bar.Full[2].W = Class.HUD.bar[2].W-10
Class.HUD.bar.Full[2].H = Class.HUD.bar[2].H-14
Class.HUD.bar.Full[2].X = Class.HUD.bar[2].X+5
Class.HUD.bar.Full[2].Y = Class.HUD.bar[2].Y+5

function showBar()
	local width = math.max(math.min(Treadmill.Distance or 0,Class.HUD.bar.Full[1].W),0)
	local processing = {width,Class.HUD.bar.Full[1].W}
	dxDrawImage(Class.HUD.bar[1].X, Class.HUD.bar[1].Y, Class.HUD.bar[1].W,  Class.HUD.bar[1].H, "files/bar/"..Class.HUD.bar.images[1]..".png")
	dxDrawRectangle(Class.HUD.bar.Full[1].X, Class.HUD.bar.Full[1].Y, width, Class.HUD.bar.Full[1].H,tocolor(0, 255, 0, 90) )
	local width = math.max( math.min(Class.HUD.bar.Full[1].W-Treadmill.Fatigue or 0, Class.HUD.bar.Full[1].W),0) 
	dxDrawImage(Class.HUD.bar[2].X, Class.HUD.bar[2].Y, Class.HUD.bar[2].W,  Class.HUD.bar[2].H, "files/bar/"..Class.HUD.bar.images[2]..".png")
	dxDrawRectangle(Class.HUD.bar.Full[2].X, Class.HUD.bar.Full[2].Y, width, Class.HUD.bar.Full[2].H,tocolor(255, 150, 50, 90) )
	return processing
end