-- `tuikamod` mod の初期設定ファイル

-- 他のファイルを読み込む
dofile(minetest.get_modpath("tuikamod") .. "/cold_warrior.lua")
dofile(minetest.get_modpath("tuikamod") .. "/cold_sword.lua")

-- 氷のディメンション (cold_world) の追加
minetest.register_biome({
    name = "cold_world",
    node_top = "default:ice",
    node_filler = "default:snowblock",
    depth_top = 1,
    depth_filler = 3,
    node_river_water = "default:water_source",
    temperature = 0.0,
    humidity = 0.5,
})
