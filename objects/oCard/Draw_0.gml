if (is_flippable && is_mouse_entered) {
	shader_set(BrightenShader);
	var brightness = shader_get_uniform(BrightenShader, "brightness");
	shader_set_uniform_f(brightness, 0.25);
}
draw_self();
shader_reset();