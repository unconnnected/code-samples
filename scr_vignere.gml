/// @author unconnnected [Paul Bennett]
/// @function scr_vignere(input_text, input_key, encrypt)
/// @description Implementation of a vignere cipher 
/// This does not allow for special characters but I might include numbers
/// String should be checked before running scr_vignerenx()
/// see: https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher
/// @param input_text									//string
/// @param input_key									//string
/// @param encrypt_boolean								//boolean
/// @return string || undefined

var script_name		   = "scr_vignere";
var expected_arguments = 3;
var script_debug	   = true;
var input_text		   = undefined;//argument[0]		//string
var input_key		   = undefined;//argument[1]		//string
var encrypt_boolean    = undefined;//argument[2]		//boolean



/* Error Check - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
#region Error Check
if(argument_count >= 1 && !is_undefined(argument[0]))
	input_text = argument[0];
	
if(argument_count >= 2 && !is_undefined(argument[1]))
	input_key = argument[1];

if(argument_count == 3 && !is_undefined(argument[2]))
	encrypt_boolean = argument[2];
	
	//Console output
	//if(debug && script_debug){
	//	scr_error_check_argument_count(script_name,		argument_count,		expected_arguments);	//integer
	//	scr_error_check_argument_string(script_name,	"input_text",		input_text);			//string
	//	scr_error_check_argument_string(script_name,	"input_key",		input_key);				//string
	//	scr_error_check_argument_binary(script_name,	"encrypt_boolean",	encrypt_boolean);		//boolean
	//}
#endregion Error Check


	
/* Execute Script - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
var vignerenx_sequence	   = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
var return_string		   = "";

if(!is_undefined(input_text) && string_length(input_text) > 0 && !is_undefined(input_key) && string_length(input_key) > 0 && !is_undefined(encrypt_boolean)){
	
	var len		= string_length(input_text);
	var key_len = string_length(input_key);
	var seq_len = string_length(vignerenx_sequence);
	
	if(encrypt_boolean){
		for(var i = 0; i < len; i++){
			var a_char	   = string_char_at(input_text, i + 1);
			var a_key_char = string_char_at(input_key, (i % key_len) + 1);	
			
			var initial_char_pos = string_pos(a_char, vignerenx_sequence);
			var key_char_pos	 = string_pos(a_key_char, vignerenx_sequence);
			var encrypted_pos	 = ((initial_char_pos + key_char_pos) % 62);
			if(encrypted_pos == 0)
				encrypted_pos = 62;
			var encrypted_char	 = string_char_at(vignerenx_sequence, encrypted_pos);
			return_string += encrypted_char;
		}
	}
	//decrypt
	else{
		for(var i = 0; i < len; i++){
			var a_char	   = string_char_at(input_text, i + 1);
			var a_key_char = string_char_at(input_key, (i % key_len) + 1);
			
			var initial_char_pos = string_pos(a_char, vignerenx_sequence);
			var key_char_pos	 = string_pos(a_key_char, vignerenx_sequence);
			var mod_shift		 = seq_len - key_char_pos;
			var encrypted_pos	 = ((initial_char_pos + mod_shift) % 62);
			if(encrypted_pos == 0)
				encrypted_pos = 62;
			var encrypted_char   = string_char_at(vignerenx_sequence, encrypted_pos);
			return_string += encrypted_char;
		}
	}
}
else
	return_string = undefined;
	

return return_string;
