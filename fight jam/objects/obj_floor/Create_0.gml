var fix = physics_fixture_create();

physics_fixture_set_box_shape(fix, sprite_width, sprite_height);
physics_fixture_set_density(fix, 0); // static
physics_fixture_set_friction(fix, 1);
physics_fixture_set_restitution(fix, 0);

physics_fixture_bind(fix, id);
physics_fixture_delete(fix);
