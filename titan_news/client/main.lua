----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local sW, sH = guiGetScreenSize()
local newsData = {}

function newsData.funcStart()
	newsData.renderData = 
	{
		X = 0,
		Y = sH - 71,
		W = 892,
		H = 71
	}
	newsData.nickRenderData = 
	{
		X = newsData.renderData.X + 230,
		Y = newsData.renderData.Y + 20 + 5,
		W = newsData.renderData.X + 230 + 135,
		H = newsData.renderData.Y + 20 + 20
	}
	newsData.font = dxCreateFont("client/files/OpenSans-BoldItalic.ttf", 12)
	newsData.renderTarget = dxCreateRenderTarget(780, 20, true)
	newsData.renderStateFirst = "hide"
	newsData.nextRenderState = nil
	newsData.renderTick = getTickCount()
	newsData.animationTime = 1000

	newsData.newsType = 1
	newsData.nextNewsType = 2

	newsData.reporterText = nil
	newsData.newsText = nil

	newsData.newsLength = dxGetTextWidth(string.gsub(newsData.newsText or "", "#%x%x%x%x%x%x", ""), 1.0, newsData.font)
	newsData.textWidth = 0
	newsData.slideTime = 1.5

	newsData.startTick = getTickCount()
	newsData.animType = 4

end
addEventHandler("onClientResourceStart", resourceRoot, newsData.funcStart)

function newsData.getImageFromType(typ)
	if typ == 1 then return "client/files/breaking-news.png"
	elseif typ == 2 then return "client/files/reklama.png"
	elseif typ == 3 then return "client/files/wywiad.png"
	end
end

function newsData.addMessage(who, text, mestype)
	newsData.startTime = getTickCount()
	newsData.startStyle = "block"
	newsData.reporterText = string.upper(who)
	newsData.newsText = text
	newsData.textWidth = 0
	newsData.newsLength = dxGetTextWidth(string.gsub(newsData.newsText or "", "#%x%x%x%x%x%x", ""), 1.0, newsData.font)
	newsData.newsType = mestype
end
addEvent("newsData.addMessage", true)
addEventHandler("newsData.addMessage", root, newsData.addMessage)

function newsData.funcRender()
	local additionalHeight = 0
	local alphaDivider = 1
	if newsData.renderStateFirst == "showing" then
		local progress = (getTickCount() - newsData.renderTick) / newsData.animationTime
		additionalHeight, alphaDivider = interpolateBetween(71, 0, 0, 0, 1, 0, progress, "OutQuad")
		if progress > 1 then 
			newsData.renderStateFirst = "show"
		end
	end
	if newsData.renderStateFirst == "hiding" then
		local progress = (getTickCount() - newsData.renderTick) / newsData.animationTime
		additionalHeight, alphaDivider = interpolateBetween(0, 1, 0, 71, 0, 0, progress, "InQuad")
		if progress > 1 then 
			newsData.renderStateFirst = "hide"
			if newsData.nextRenderState then
				newsData.renderStateFirst = newsData.nextRenderState
				newsData.nextRenderState = nil
				newsData.renderTick = getTickCount()
				newsData.newsType = newsData.nextNewsType
				newsData.nextNewsType = nil
			else
				removeEventHandler("onClientRender", root, newsData.funcRender)
				return
			end
		end
	end

	if localPlayer:getData("hide:playerRadar") then return end

	-- rendering heheszking
	dxDrawImage(newsData.renderData.X, newsData.renderData.Y + additionalHeight, newsData.renderData.W, newsData.renderData.H, newsData.getImageFromType(newsData.newsType) or newsData.getImageFromType(1), 0, 0, 0, tocolor(255, 255, 255, 255 * alphaDivider))
	dxDrawText(newsData.reporterText or "", newsData.nickRenderData.X, newsData.nickRenderData.Y + additionalHeight, newsData.nickRenderData.W, newsData.nickRenderData.H + additionalHeight, tocolor(255, 255, 255, 255 * alphaDivider), 1.0, newsData.font, "right", "center", false, false, false, false, false, 0, 0, 0)

	dxSetRenderTarget(newsData.renderTarget, true)
	--
		if newsData.newsLength > 780 then
			local add = 40
			if newsData.startStyle == "block" then
				local progress = (getTickCount() - newsData.startTime) / 3000
				if progress > 1 then
					newsData.startStyle = "slide"
					newsData.startTime = getTickCount()
				end
			else
				local progress = (getTickCount() - newsData.startTime) / (newsData.newsLength * 15)
				add = interpolateBetween(40, 0, 0, -newsData.newsLength, 0, 0, progress, "Linear")
				if progress > 1 then
					newsData.startTime = getTickCount()
				end
			end
			dxDrawText(tostring(newsData.newsText), add, 0, 0, 20, tocolor(0, 0, 0, 255), 1.0, newsData.font, "left", "center", false, false, false, true, true, 0, 0, 0)
			dxDrawText(tostring(newsData.newsText), add + newsData.newsLength + 40, 0, 0, 20, tocolor(0, 0, 0, 255), 1.0, newsData.font, "left", "center", false, false, false, true, true, 0, 0, 0)
		else
			dxDrawText(newsData.newsText or "Radio nadaje aktualnie standardowy blok muzyczny.", 40, 0, 0, 20, tocolor(0, 0, 0, 255), 1.0, newsData.font, "left", "center", false, false, false, true, false, 0, 0, 0)
		end
	--
	dxSetRenderTarget()

	dxDrawImage(newsData.renderData.X + 80, newsData.renderData.Y + 45 + additionalHeight, 780, 20, newsData.renderTarget, 0, 0, 0, tocolor(255, 255, 255, 255 * alphaDivider))
end

function newsData.showNews(bool)
	if bool == true then
	newsData.renderTick = getTickCount()
	newsData.renderStateFirst = "showing"
	newsData.newsType = 1
	removeEventHandler("onClientRender", root, newsData.funcRender)
	addEventHandler("onClientRender", root, newsData.funcRender)
	else
	newsData.renderTick = getTickCount()
	newsData.renderStateFirst = "hiding"
	newsData.nextRenderState = nil
	newsData.nextNewsType = 0
	end
end
addEvent("newsData.showNews", true)
addEventHandler("newsData.showNews", root, newsData.showNews)