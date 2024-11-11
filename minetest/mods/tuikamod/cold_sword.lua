-- コールドソードアイテムの設定ファイル

minetest.register_craftitem("tuikamod:cold_sword", {
    description = "Cold Sword",
    inventory_image = "cold_sword.png",
    -- 攻撃力 20 を追加
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing.type == "object" then
            local target = pointed_thing.ref
            if target and target:get_luaentity() then
                -- エンティティへの攻撃
                target:punch(user, 1.0, {full_punch_interval = 1.0, damage_groups = {fleshy = 20}}, nil)
            end
        end
    end,
})

-- コールドソードのクラフトレシピ
minetest.register_craft({
    output = "tuikamod:cold_sword",
    recipe = {
        {"default:ice", "default:ice", "default:ice"},
        {"default:ice", "default:endstone", "default:ice"},
        {"", "default:stick", ""},
    },
})
