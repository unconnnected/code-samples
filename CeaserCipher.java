package com.mycompany.cryptography;

/**
 * @author Paul Bennett
 * @description Checking CeaserCipher for potential use in a game concept
 *              Modified to allow spaces. Does not allow numbers or other
 *              special characters.
 */
public class CeaserCipher {

    private String cc_text_submitted;
    private int    cc_shift;
    
    private String cc_text_encypted;
    private String cc_text_decrypted;
    
    
    public CeaserCipher(String text, int shift){
        this.cc_text_submitted  = text;
        this.cc_shift           = shift;
        
        encryptText(text, shift);
        decryptText(this.cc_text_encypted, shift);
    }
    
    
    private void encryptText(String text, int shift){
       
        StringBuffer encrypted_text = new StringBuffer();
        char         space          = ' ';
        
        //Loop through string
        for(var i = 0; i < text.length(); i++){ 
           
            if(Character.isUpperCase(text.charAt(i))){
                char ch = (char)(((int)text.charAt(i) + shift - 65) % 26 + 65);
                encrypted_text.append(ch);
            }
            else{
                //Keep spaces
                if(text.charAt(i) == space)
                    encrypted_text.append(" ");
                else{
                    char ch = (char)(((int)text.charAt(i) + shift - 97) % 26 + 97);
                    encrypted_text.append(ch);
                }
            }
        }
        
        this.cc_text_encypted = encrypted_text.toString();
    }
    
    
    private void decryptText(String text, int shift){
        
        //Decryption method is the same as encryption but the shift is modified
        //to complete the circle
        int          shift_modified = 26 - shift;
        StringBuffer decrypted_text = new StringBuffer();
        char         space          = ' ';
        
        //Loop through string
        for(var i = 0; i < text.length(); i++){ 
           
            if(Character.isUpperCase(text.charAt(i))){
                char ch = (char)(((int)text.charAt(i) + shift_modified - 65) % 26 + 65);
                decrypted_text.append(ch);
            }
            else{
                //Keep spaces
                if(text.charAt(i) == space)
                    decrypted_text.append(" ");
                else{
                    char ch = (char)(((int)text.charAt(i) + shift_modified - 97) % 26 + 97);
                    decrypted_text.append(ch);
                }
            }
        }
     
        this.cc_text_decrypted = decrypted_text.toString();
    }
    
    
    public String getTextSubmitted(){
        return this.cc_text_submitted;
    }
    
    public int getShift(){
        return this.cc_shift;
    }
    
    public String getTextEncrypted(){
        return this.cc_text_encypted;
    }
    
    public String getTextDecrypted(){
        return this.cc_text_decrypted;
    }
}