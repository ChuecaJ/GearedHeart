//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.	
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2  size;//The actual size in pixels
uniform float pixelSize;

uniform float speedChange;//Step by step untill the total time
uniform float stepsChange;//Total time to become B&W

void main()
{
    //Pixelate
    vec2 realTexPos  = v_vTexcoord*size; //5
    vec2 floorTexPos = floor(realTexPos/pixelSize)*pixelSize; //1.0*5.0=5.0
    vec2 texPos = floorTexPos/size; //Final position rounded down
    
    //Get the original color of the pixel (already pixelated)
    vec4 originalColor = texture2D(gm_BaseTexture, texPos);
    //Original alpha, because if it isn't an object is all black
    float outputAlpha = originalColor.a;
    //This is the B&W color
    float average = (originalColor.r+originalColor.g+originalColor.b)/3.0;
    //The original colors until average
    float outputRed   = originalColor.r;
    float outputGreen = originalColor.g;
    float outputBlue  = originalColor.b;
    //The change in every step until average
    float changeRed   = ((average-outputRed)/stepsChange)*speedChange;
    float changeGreen = ((average-outputGreen)/stepsChange)*speedChange;
    float changeBlue  = ((average-outputBlue)/stepsChange)*speedChange;
    
    outputRed   += changeRed;
    outputGreen += changeGreen;
    outputBlue  += changeBlue;
    
    //Create the color
    vec4 outputColor = vec4(outputRed, outputGreen, outputBlue, outputAlpha);
    
    
    //Output the new color with the pixelate
    gl_FragColor = outputColor;
    //gl_FragColor = v_vColour * texture2D( gm_BaseTexture, texPos );
    
    /*vec4 originalColor = texture2D(gm_BaseTexture, v_vTexcoord);
    
    float outputRed   = 1.0-originalColor.r;
    float outputGreen = 1.0-originalColor.g;
    float outputBlue  = 1.0-originalColor.b;
    float outputAlpha = originalColor.a;
    
    vec4 outputColor = vec4(outputRed, outputGreen, outputBlue, outputAlpha);
    
    gl_FragColor = outputColor;*/
    
}

