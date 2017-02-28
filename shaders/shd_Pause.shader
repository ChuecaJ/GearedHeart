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

uniform float speedChange;
uniform float stepsChange;

void main()
{
    //Get the original color of the pixel
    vec4 originalColor = texture2D( gm_BaseTexture, v_vTexcoord );

    float outputAlpha = originalColor.a;
    
    float average = (originalColor.r+originalColor.g+originalColor.b)/3.0;
    
    float outputRed   = originalColor.r;
    float outputGreen = originalColor.g;
    float outputBlue  = originalColor.b;
    
    float changeRed   = ((average-outputRed)/stepsChange)*speedChange;
    float changeGreen = ((average-outputGreen)/stepsChange)*speedChange;
    float changeBlue  = ((average-outputBlue)/stepsChange)*speedChange;
    
    outputRed   += changeRed;
    outputGreen += changeGreen;
    outputBlue  += changeBlue;
    
    //Create the color
    vec4 outputColor = vec4(outputRed, outputGreen, outputBlue, outputAlpha);
    //Output the new color
    gl_FragColor = outputColor;
}

