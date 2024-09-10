
draw_set_valign(valign)
draw_set_halign(halign)
draw_set_font(font)
draw_set_color(color)

draw_self();

draw_text_ext(bbox_left + margin, bbox_top + margin, text, font_get_size(font), sprite_width - 2*margin);
