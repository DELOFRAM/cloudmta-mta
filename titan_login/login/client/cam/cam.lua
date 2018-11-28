----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

camPosition = {}
camData = {}

camPosition[#camPosition + 1] = {1573.006592, -1598.320435, -4.944113, 1572.520020, -1666.170044, -2.530392, 1487.590210, -1584.006226, 45.047333, 1507.403564, -1716.821167, 53.987839, 10000}
camPosition[#camPosition + 1] = {1572.520020, -1666.170044, -2.530392, 1577.178711, -1829.642944, 10.939192, 1507.403564, -1716.821167, 53.987839, 1558.427856, -1732.269287, 23.853445, 10000}
camPosition[#camPosition + 1] = {1577.178711, -1829.642944, 10.939192, 1569.679688, -1962.786255, 2.965276, 1558.427856, -1732.269287, 23.853445, 1567.960327, -1864.450317, 21.050629, 10000}
camPosition[#camPosition + 1] = {1569.679688, -1962.786255, 2.965276, 1664.523438, -1857.660400, 41.780590, 1567.960327, -1864.450317, 21.050629, 1571.311523, -1856.334473, 77.971428, 10000}
camPosition[#camPosition + 1] = {1664.523438, -1857.660400, 41.780590, 1723.841064, -1928.479736, 9.053623, 1571.311523, -1856.334473, 77.971428, 1673.827637, -1848.116821, 41.309757, 10000}
camPosition[#camPosition + 1] = {1723.841064, -1928.479736, 9.053623, 1819.823730, -1870.588135, 28.623436, 1673.827637, -1848.116821, 41.309757, 1719.890015, -1869.689819, 32.150127, 10000}
camPosition[#camPosition + 1] = {1819.823730, -1870.588135, 28.623436, 1866.801270, -1921.478638, 18.142744, 1719.890015, -1869.689819, 32.150127, 1795.094482, -1855.755127, 41.349644, 10000}
camPosition[#camPosition + 1] = {1866.801270, -1921.478638, 18.142744, 1937.045288, -1721.500732, -14.408785, 1795.094482, -1855.755127, 41.349644, 1949.183472, -1809.354126, 31.791237, 10000}
camPosition[#camPosition + 1] = {1937.045288, -1721.500732, -14.408785, 1989.832642, -1564.008057, 2.694421, 1949.183472, -1809.354126, 31.791237, 1935.950806, -1642.625122, 32.961555, 10000}
camPosition[#camPosition + 1] = {1989.832642, -1564.008057, 2.694421, 1764.875244, -1605.435913, 10.603093, 1935.950806, -1642.625122, 32.961555, 1860.637817, -1606.854858, 39.369720, 10000}
camPosition[#camPosition + 1] = {1764.875244, -1605.435913, 10.603093, 1661.782959, -1663.071289, 13.365737, 1860.637817, -1606.854858, 39.369720, 1681.971313, -1567.796631, 36.063114, 10000}
camPosition[#camPosition + 1] = {1661.782959, -1663.071289, 13.365737, 1573.006592, -1598.320435, -4.944113, 1681.971313, -1567.796631, 36.063114, 1487.590210, -1584.006226, 45.047333, 10000}

--[[
	lX          , lY           , lZ        , X           , Y            , Z
	1573.006592, -1598.320435, -4.944113, 1487.590210, -1584.006226, 45.047333
	1572.520020, -1666.170044, -2.530392, 1507.403564, -1716.821167, 53.987839
	1577.178711, -1829.642944, 10.939192, 1558.427856, -1732.269287, 23.853445
	1569.679688, -1962.786255, 2.965276, 1567.960327, -1864.450317, 21.050629
	1664.523438, -1857.660400, 41.780590, 1571.311523, -1856.334473, 77.971428
	1723.841064, -1928.479736, 9.053623, 1673.827637, -1848.116821, 41.309757
	1819.823730, -1870.588135, 28.623436, 1719.890015, -1869.689819, 32.150127
	1866.801270, -1921.478638, 18.142744, 1795.094482, -1855.755127, 41.349644
	1937.045288, -1721.500732, -14.408785, 1949.183472, -1809.354126, 31.791237
	1989.832642, -1564.008057, 2.694421, 1935.950806, -1642.625122, 32.961555
	1764.875244, -1605.435913, 10.603093, 1860.637817, -1606.854858, 39.369720
	1661.782959, -1663.071289, 13.365737, 1681.971313, -1567.796631, 36.063114
	1530.177612, -1562.694946, 28.414461, 1488.055542, -1633.281860, 85.363785
]]

function renderCamera()
	if(camData.toggle == false) then return end

	local progress = (getTickCount() - camData.czasRozpoczecia) / camPosition[camData.choose][13]
	local camX, camY, camZ = interpolateBetween(camPosition[camData.choose][7], camPosition[camData.choose][8], camPosition[camData.choose][9], camPosition[camData.choose][10], camPosition[camData.choose][11], camPosition[camData.choose][12], progress, "InOutQuad")
	local lCamX, lCamY, lCamZ = interpolateBetween(camPosition[camData.choose][1], camPosition[camData.choose][2], camPosition[camData.choose][3], camPosition[camData.choose][4], camPosition[camData.choose][5], camPosition[camData.choose][6], progress, "InOutQuad")
	
	setCameraMatrix(camX, camY, camZ, lCamX, lCamY, lCamZ)

	if(progress >= 1) then
		if(type(camPosition[camData.choose + 1]) ~= "table") then camData.choose = 1 else camData.choose = camData.choose + 1 end
		camData.czasRozpoczecia = getTickCount()
	end
end

function cameraOn()
	camData.czasRozpoczecia = getTickCount()
	camData.choose = 1
	addEventHandler("onClientRender", root, renderCamera)
end

function cameraOff()
	removeEventHandler("onClientRender", root, renderCamera)
end