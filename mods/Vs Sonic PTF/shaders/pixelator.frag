#define sizeX 25.
#define sizeY 25.

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
 vec2 uv = fragCoord/iResolution.xy;
 float px = sizeX *(1./iResolution.x);
 float py = sizeY *(1./iResolution.y);
 vec2 c = vec2(px*floor(uv.x/px), py*floor(uv.y/py));
 fragColor = texture(iChannel0, c);
} 