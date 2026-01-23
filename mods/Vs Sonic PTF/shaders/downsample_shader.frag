#pragma header

uniform float balls; // resolution in px

void main() {
    gl_FragColor = flixel_texture2D(bitmap, floor(openfl_TextureCoordv * balls) / balls);
}