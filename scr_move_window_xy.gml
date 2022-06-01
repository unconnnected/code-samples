/// @author unconnnected [Paul Bennett]
/// @function scr_move_window_xy()
/// @description Move window according to mouse_x and mouse_y
/// @return none

var script_name	 = "scr_move_window_xy";
var script_debug = true;


/* Execute Script - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
var dx = mouse_x - input.mouse_x_previous;
var dy = mouse_y - input.mouse_y_previous;


		/* x Point - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
		/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
		//Keep x point in acceptable window visibility range	
		var left_point  = 0 - window_width + (window_title_function_icon_width * 4);
		var right_point = game.settings_screen_width - (window_title_function_icon_width * 4);

		if(scr_num_in(x + dx, left_point, right_point))		x = x + dx;
		else if(x + dx <= left_point)						x = left_point
		else if (x + dx >= right_point)						x = right_point;


		/* y Point - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
		/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
		//Keep y point in acceptable window visibility range
		var top_point    = main_taskbar.taskbar_outline_y2 + 2;
		var bottom_point = game.settings_screen_height - window_title_box_height - window_outline_padding;

		if(scr_num_in(y + dy, top_point, bottom_point))		y = y + dy;
		else if(y + dy <= top_point)						y = top_point;
		else if(y + dy >= bottom_point)						y = bottom_point;