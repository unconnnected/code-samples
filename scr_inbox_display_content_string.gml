/// @author unconnnected [Paul Bennett]
/// @function scr_inbox_display_content_string(inbox_display)
/// @description Controls content string display within inbox_display
/// Alters a string (inbox_display_content) to display and scroll through
/// Used in 
/// Also sets vertical scroll bar variables
/// @param inbox_display								//object obj_inbox_display
/// @return none

var script_name			 = "scr_inbox_display_content_string";
var expected_arguments	 = 1;
var script_debug		 = true;
var inbox_display		 = undefined;//argument[0]		//object obj_inbox_display
var str_height			 = undefined;
var str_width			 = undefined;
var inbox_display_string = undefined;


/* Error Check - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
#region Error Check
if(argument_count == 1 && !is_undefined(argument[0]))
	inbox_display = argument[0];
	
	//Console output
	//if(debug && script_debug){
	//	scr_error_check_argument_count(script_name,		  argument_count, expected_arguments);	//integer
	//	scr_error_check_argument_object_type(script_name, inbox_display,  obj_inbox_display);	//object obj_inbox_display
	//}
#endregion Error Check


/* Execute Script - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

draw_set_font(inbox_display.inbox_display_body_font);
inbox_display_content_string = inbox_display.inbox_display_content;
str_width					 = string_width_ext(inbox_display_content_string, inbox_display.inbox_display_body_font_height, inbox_display.inbox_display_body_text_width);


		/* Break String - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
		/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
		//This allows for word wrapping when a inbox_display to is too small for an individual word
		if(str_width >= inbox_display.inbox_display_body_text_width){
			//Break down all words into array string_split with no spaces
			var string_split = scr_split_string_by_delim(inbox_display_content_string, " ");
			for(var i = 0; i < array_length_1d(string_split); i++){
				var string_split_width = string_width_ext(string_split[i], inbox_display.inbox_display_body_font_height, inbox_display.inbox_display_body_text_width);
				//If the word is too long for the inbox_display_body_text_width
				if(string_split_width > inbox_display.inbox_display_body_text_width){
					var string_build_array = "";
					var k = 0;
					var string_being_built = "";
					//Insert \n at points in the string
					var string_split_length = string_length(string_split[i]) + 1;
					for(var j = 1; j < string_split_length; j++){
						var a_char_						= string_char_at(string_split[i], j);
					
						string_being_built				= string_being_built + a_char_;
						var string_being_built_width	= string_width_ext(string_being_built, inbox_display.inbox_display_body_font_height, inbox_display.inbox_display_body_text_width);
						
						//If the string is about to break over the inbox_display_body_text_width
						if(string_being_built_width >= (inbox_display.inbox_display_body_text_width - inbox_display.inbox_display_body_font_width) && a_char_ != "\n"){
							string_being_built		= string_being_built + "\n";
							string_build_array[k]	= string_being_built;
							string_being_built		= "";
							k++;
						}	
					}
					//End of string
					string_build_array[k] = string_being_built;
				
					var new_string = "";
					for(var j = 0; j < array_length_1d(string_build_array); j++)
						new_string = new_string + string_build_array[j];
					
					//Reinsert corrected string
					string_split[i] = new_string;
				}
			}
			//Rebuild string
			inbox_display_content_string = "";	
			for(var j = 0; j < array_length_1d(string_split); j++)
				inbox_display_content_string = inbox_display_content_string + string_split[j] + " ";
		}

	

		str_height  = string_height_ext(inbox_display_content_string, inbox_display.inbox_display_body_font_height, inbox_display.inbox_display_body_text_width);															//height in pixels

		//If string is too long
		if(str_height > inbox_display.inbox_display_body_text_height){
	
				var exceptions_array = [",","."," ","!","?","-","_","\n",":","\\","/"];
	
				//Create the viewable part of the string
				//var temp_string = inbox_display.inbox_display_content;
				var temp_string = inbox_display_content_string;
				inbox_display.inbox_display_content_vertical_lines_total	= floor(str_height / inbox_display.inbox_display_body_font_height);
				inbox_display.inbox_display_view_vertical_line_selected_max	= inbox_display.inbox_display_content_vertical_lines_total - inbox_display.inbox_display_max_vertical_lines + 1;								//number of lines off screen
	
	
				/* Cut Start Of String - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
				/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
				if(inbox_display.inbox_display_view_vertical_line_selected > 0){
					var first_char					= string_char_at(temp_string, 1);
					var cut_string					= "";
					var cut_string_vertical_lines	= string_height_ext(cut_string, inbox_display.inbox_display_body_font_height, inbox_display.inbox_display_body_text_width) / inbox_display.inbox_display_body_font_height;	//height in lines of the cut string
				
				
					while((cut_string_vertical_lines <= inbox_display.inbox_display_view_vertical_line_selected || scr_check_character_exception_by(first_char, exceptions_array) == false)){
						cut_string					= cut_string + string_copy(temp_string, 1, 1);
						cut_string_vertical_lines	= string_height_ext(cut_string, inbox_display.inbox_display_body_font_height, inbox_display.inbox_display_body_text_width) / inbox_display.inbox_display_body_font_height;
				
						temp_string		= string_copy(temp_string, 2, string_length(temp_string));
						first_char		= string_char_at(temp_string, 1);
					}
		
		
					//temp_string will need one more word back from cut_string
					var temp_first_char = string_char_at(temp_string, 1);
					var cut_last_char	= string_char_at(cut_string, string_length(cut_string));
		
		
					while(cut_string_vertical_lines > inbox_display.inbox_display_view_vertical_line_selected 
						|| (cut_string_vertical_lines == inbox_display.inbox_display_view_vertical_line_selected && scr_check_character_exception_by(cut_last_char, exceptions_array) == false 
						&& scr_check_character_exception_by(temp_first_char, exceptions_array) == false)){
						temp_string		= string_char_at(cut_string, string_length(cut_string)) + temp_string;
						temp_first_char = string_char_at(temp_string, 1);
					
						cut_string					= string_copy(cut_string, 1, string_length(cut_string) - 1);
						cut_string_vertical_lines	= string_height_ext(cut_string, inbox_display.inbox_display_body_font_height, inbox_display.inbox_display_body_text_width) / inbox_display.inbox_display_body_font_height;
					
						cut_last_char = string_char_at(cut_string, string_length(cut_string));
					}
				}
	
	
				/* Cut End Of String - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
				/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
				var last_char		= string_char_at(temp_string, string_length(temp_string));
	
				while((string_height_ext(temp_string, inbox_display.inbox_display_body_font_height, inbox_display.inbox_display_body_text_width) > inbox_display.inbox_display_body_text_height 
						|| scr_check_character_exception_by(last_char, exceptions_array) == false)){																						
					temp_string		= string_copy(temp_string, 1, string_length(temp_string) - 1);
					last_char		= string_char_at(temp_string, string_length(temp_string));
				}
	
	
				/* Set String To Display - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
				/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
				inbox_display.inbox_display_content_display	  = temp_string;
				inbox_display.inbox_display_vertical_bar_show = true;
	
				//Check if vertical bar is over due to resize
				if(inbox_display.inbox_display_view_vertical_line_selected > inbox_display.inbox_display_view_vertical_line_selected_max)
					inbox_display.inbox_display_view_vertical_line_selected = inbox_display.inbox_display_view_vertical_line_selected_max;
		
		
				/* Set Scroll Bar - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
				/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
				//Top arrow for vertical scroll bar
				inbox_display.inbox_display_vbar_top_arrow_x1 = inbox_display.inbox_display_body_box_x2 - 14;			//left	 x_pos
				inbox_display.inbox_display_vbar_top_arrow_y1 = inbox_display.inbox_display_body_box_y1 + 1;			//top	 y_pos
				inbox_display.inbox_display_vbar_top_arrow_x2 = inbox_display.inbox_display_body_box_x2;				//right	 x_pos
				inbox_display.inbox_display_vbar_top_arrow_y2 = inbox_display.inbox_display_body_box_y1 + 15;			//bottom y_pos

				//Bottom arrow for vertical scroll bar
				inbox_display.inbox_display_vbar_bot_arrow_x1 = inbox_display.inbox_display_body_box_x2 - 14;			//left	 x_pos
				inbox_display.inbox_display_vbar_bot_arrow_y1 = inbox_display.inbox_display_body_box_y2 - 15;			//top	 y_pos
				inbox_display.inbox_display_vbar_bot_arrow_x2 = inbox_display.inbox_display_body_box_x2;				//right	 x_pos
				inbox_display.inbox_display_vbar_bot_arrow_y2 = inbox_display.inbox_display_body_box_y2 - 1;			//bottom y_pos

				//Vertical bar container
				//Between top and bottom arrow icons
				inbox_display.inbox_display_vbar_container_x1 = inbox_display.inbox_display_body_box_x2 - 15;			//left   x_pos
				inbox_display.inbox_display_vbar_container_y1 = inbox_display.inbox_display_vbar_top_arrow_y2;			//top	 y_pos
				inbox_display.inbox_display_vbar_container_x2 = inbox_display.inbox_display_body_box_x2 + 1;			//right  x_pos
				inbox_display.inbox_display_vbar_container_y2 = inbox_display.inbox_display_vbar_bot_arrow_y1;			//bottom y_pos


				/* Set Vertical Scroll Bar Indicator - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
				/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
				#region Vertical Scroll Bar Indicator Calculations
				
				//How much text is viewable inside inbox_display body compared to the total text content
				//viewable_section_distance will be the height of indicator
				var viewable_section_percentage = floor((inbox_display.inbox_display_body_text_height / str_height) * 100);
				var container_vertical_distance = point_distance(inbox_display.inbox_display_vbar_container_x1, inbox_display.inbox_display_vbar_container_y1, inbox_display.inbox_display_vbar_container_x1, inbox_display.inbox_display_vbar_container_y2);
				var viewable_section_distance	= (container_vertical_distance / 100) * viewable_section_percentage;																														//distance height in pixels
	
				//Use the remainder to find how many pixels one line is
				var viewable_remainder									 = container_vertical_distance - viewable_section_distance;
				inbox_display.inbox_display_view_vertical_line_to_pixels = viewable_remainder / inbox_display.inbox_display_view_vertical_line_selected_max;																				//distance height in pixels
	
				#endregion Vertical Scroll Bar Indicator Calculations
	
				//Vertical bar indicator
				inbox_display.inbox_display_vbar_indicator_x1 = inbox_display.inbox_display_body_box_x2 - 14;																																//left   x_pos
				inbox_display.inbox_display_vbar_indicator_y1 = inbox_display.inbox_display_body_box_y1 + 16 + floor(inbox_display.inbox_display_view_vertical_line_selected * inbox_display.inbox_display_view_vertical_line_to_pixels);	//top	 y_pos
				inbox_display.inbox_display_vbar_indicator_x2 = inbox_display.inbox_display_body_box_x2;																																	//right  x_pos
				inbox_display.inbox_display_vbar_indicator_y2 = inbox_display.inbox_display_vbar_indicator_y1 + viewable_section_distance;																									//bottom y_pos
			}
			else{
				inbox_display.inbox_display_content_display				= inbox_display_content_string;																																		//inbox_display.inbox_display_content;
				inbox_display.inbox_display_vertical_bar_show			= false;
				inbox_display.inbox_display_view_vertical_line_selected	= 0;	
			}


scr_draw_set_reset();