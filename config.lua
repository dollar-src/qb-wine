Config = {}

Config.GrapeItem = 'grape'
Config.WineItem = 'wine'
Config.Skill = false     -- if u want to use skill system read README.md !
Config.targetExport = 'qb-target' -- qb-target np-target , bt-target 
Config.Locale = Lang["EN"]  -- [TR] / [EN]
Config.WinePrice = 100 -- price each

Config.targetloc = {
	{x = 2006.107, y = 4830.520, z = 42.990 , name ="uzum1"},
	{x = 2001.899, y = 4834.801, z = 43.301, name= "uzum2"},
    {x = 2003.516, y = 4833.147, z = 43.228, name="uzum3"},
    {x = 2007.212, y = 4828.576, z = 42.661 ,name="uzum4"},
    { x = 2004.126, y = 4832.058, z = 43.077 ,name="uzum5"},
    { x = 2005.444, y = 4831.312, z = 43.085 ,name="uzum6"},




}

Config.JobBlips = {
    [1] = {x = 2006.2627, y = 4830.1, sprite = 237, colour = 50, scale = 0.8 ,info = Config.Locale['blip_grape_field']},
    [2] = {x = 2016.76, y = 4987.97, sprite = 237, colour = 50, scale = 0.8, info = Config.Locale['blip_grape_process']},
    [3] = {x = -1464.76, y = -705.97, sprite = 480, colour = 50, scale = 0.8, info = Config.Locale['blip_wine_sell']},

  }



Config.PedList = {                                         
	{
		model = "a_m_m_farmer_01",                          
		coords = vector3(2016.78, 4987.67, 41.1),               
		heading = 129.0,
		gender = "male",
        scenario = "WORLD_HUMAN_GUARD_STAND"
	},
    {
		model = "a_m_y_business_02",                          
		coords =   vector3(-1463.68, -704.72, 25.78),               
		heading = 136.0,
		gender = "male",
        scenario = "WORLD_HUMAN_GUARD_STAND"
	},

  
}



