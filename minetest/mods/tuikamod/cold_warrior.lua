-- コールドウォーリアーエンティティの設定ファイル

minetest.register_entity("tuikamod:cold_warrior", {
    initial_properties = {
        hp_max = 120,  -- 通常の敵より少し強めのHP
        physical = true,
        collisionbox = {-0.3, 0, -0.3, 0.3, 1.5, 0.3},
        visual = "mesh",
        mesh = "character.b3d",  -- キャラクターのメッシュを使用
        textures = {"cold_warrior.png"},
        pointable = true,
    },

    -- プレイヤー追跡と攻撃のAI
    timer = 0,
    attack_range = 2.0, -- 攻撃可能な距離
    damage = 10,        -- 攻撃力

    on_step = function(self, dtime)
        self.timer = self.timer + dtime
        if self.timer < 1 then return end -- 1秒ごとに処理
        self.timer = 0

        -- 周囲のプレイヤーを探す
        local pos = self.object:get_pos()
        local players = minetest.get_connected_players()
        local target = nil
        local min_dist = 10 -- 追跡開始距離

        for _, player in ipairs(players) do
            local player_pos = player:get_pos()
            local dist = vector.distance(pos, player_pos)
            if dist < min_dist then
                min_dist = dist
                target = player
            end
        end

        -- プレイヤーが近くにいる場合、追跡および攻撃
        if target then
            local target_pos = target:get_pos()
            local dir = vector.direction(pos, target_pos)
            local new_velocity = vector.multiply(dir, 2) -- 移動速度を調整
            self.object:set_velocity(new_velocity)

            -- 攻撃距離に入った場合に攻撃
            if min_dist <= self.attack_range then
                target:set_hp(target:get_hp() - self.damage) -- プレイヤーにダメージ
            end
        else
            -- ターゲットがいない場合は停止
            self.object:set_velocity({x = 0, y = 0, z = 0})
        end
    end,
})
