/// @author unconnnected [Paul Bennett]
/// @function scr_predict_string_in_list(input_string, comparison_list)
/// @description Check text inputted against list of possible input. Remove any matches where initial text does not match
///	return_array[0, 1] is the auto-complete 
/// return_array[0, 0] return_array[1, 0] etc are the possible answers
/// @param input_string							//string
/// @param comparison_list						//ds_list
/// @return 2d array string || undefined

var script_name			= "scr_predict_string_in_list";
var expected_arguments	= 2;
var script_debug		= true;
var input_string		= undefined;//argument[0]		//string
var comparison_list		= undefined;//argument[1]		//ds_list
var return_array		= undefined;//return
var slots				= undefined;
var initial_results		= undefined;					//1d array string
var complete_match		= undefined;					//boolean
var comparison_string	= undefined;					//string
var auto_complete_to	= undefined;					//string
var current_character	= undefined;					//character
var compared_character	= undefined;					//character


/* Error Check - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
#region Error Check
if(argument_count >= 1 && !is_undefined(argument[0]))
	input_string = argument[0];

if(argument_count == 2 && !is_undefined(argument[1]))
	comparison_list = argument[1];

	//Console output
	//if(debug && script_debug){
	//	scr_error_check_argument_count(script_name,	 argument_count, expected_arguments);	//integer
	//	scr_error_check_argument_string(script_name, "input_string", input_string);			//string
	//	//comparison_list																	//NA ds_list
	//}
#endregion Error Check


/* Execute Script - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
initial_results			= scr_find_text_in_list(input_string, comparison_list);
complete_match			= false;
return_array[0, 0]		= undefined;
slots					= 0;

if(!is_undefined(initial_results)){
	//Go through all matches in initial_results
	for(var i = 0; i < array_length_1d(initial_results); i++){
		complete_match = false;
		//Look for complete_match against the input_string from first character
		for(var j = 1; j < string_length(input_string) + 1; j++){
			if(string_char_at(initial_results[i], j) == string_char_at(input_string, j)){
				complete_match = true;
			}
			else{
				complete_match = false;
				break;
			}
		}
		if(complete_match == true){
			return_array[slots, 0] = initial_results[i];
			slots++;	
		}
	}
	
	//Find the most matching characters along all return_results
	if(array_height_2d(return_array) >= 2){
		comparison_string	= return_array[0, 0];
		auto_complete_to	= "";
		//Find the shortest (by string length) possible match
		for(var i = 0; i < array_height_2d(return_array); i++){
			if(string_length(comparison_string) > string_length(return_array[i, 0]))
				comparison_string = return_array[i, 0];
		}
		
		//Check all characters of shortest string against other matches. Build new string to autocomplete to
		for(var i = 1; i < string_length(comparison_string) + 1; i++){
			current_character	= string_copy(comparison_string, i, 1);
			complete_match		= true;
			
			for(var j = 0; j < array_height_2d(return_array); j++){
				compared_character = string_copy(return_array[j, 0], i, 1);
				
				if(current_character == compared_character && complete_match == true)
					complete_match = true;
				else
					complete_match = false;
			}
			
			//Add after checking character against all other matches
			if(complete_match == true)
				auto_complete_to = auto_complete_to + current_character;
			else
				break;
			
		}
		//How far to autocomplete to
		return_array[0, 1] = auto_complete_to;
	}
	else
		//Autocomplete to the single answer
		return_array[0, 1] = return_array[0, 0];

	if(!is_undefined(return_array[0, 0]))
		return return_array;
	else
		return undefined;
}
else 
	return undefined;