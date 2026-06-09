
// obj_icicle Step Event
// Do NOT use event_inherited() here.

// spawn animation: stay in place
if (!launched) {
    if (image_index >= image_number - 1) {
        launched = true;

        sprite_index = spr_projectile;
        image_index = 0;
        image_speed = 1;
    }

    exit;
}

// move 22 degrees down
var _angle = (dir == 1) ? 338 : 202;

x += lengthdir_x(spd, _angle);
y += lengthdir_y(spd, _angle);

image_angle = point_direction(0, 0, x, y);
if (dir == -1 ){ image_angle +=90;}
// hit enemies
//var _cols = ds_list_create();
//var _num = instance_place_list(x, y, obj_character, _cols, false);

//for (var i = 0; i < _num; i++) {
//    var _col = _cols[| i];

//    if (_col.is_p1 != parent.is_p1 && !array_contains(arr_hits, _col)) {
        
//        _col.hit(
//            damage,
//            knockback_x * dir,
//            knockback_y,
//            stun_duration,
//            hitpause,
//            is_launcher,
//            false
//        );

//        array_insert(arr_hits, 0, _col);

//        instance_destroy();
//        break;
//    }
//}

// parry projectile
var _parry = instance_place(x, y, obj_hitbox);

if (_parry != noone) {
    if (
        _parry.is_parry &&
        _parry.parent != parent &&
        _parry.parent.is_p1 != parent.is_p1
    ) {
        parent = _parry.parent;
        dir *= -1;
        image_xscale = dir;
        arr_hits = [];

        x += spd * dir;

        exit;
    }
}


// hit enemies
var _cols = ds_list_create();
var _num = instance_place_list(x, y, obj_character, _cols, false);

for (var i = 0; i < _num; i++) {
    var _col = _cols[| i];

    if (_col.is_p1 != parent.is_p1 && !array_contains(arr_hits, _col)) {
        
        _col.hit(
            damage,
            knockback_x * dir,
            knockback_y,
            stun_duration,
            hitpause,
            is_launcher,
            false
        );

        array_insert(arr_hits, 0, _col);
		create_vfx(_col.x,_col.y-50,vfx_ice_explosion,2,2,0);
        instance_destroy();
        break;
    }
}

ds_list_destroy(_cols);

// lifetime
life--;
if (life <= 0) {
    instance_destroy();
}