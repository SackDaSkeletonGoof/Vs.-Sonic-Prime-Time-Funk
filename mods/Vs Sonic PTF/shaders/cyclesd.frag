#pragma header

uniform float amount;
uniform float pixel;

vec2 PincushionDistortion(in vec2 uv, float strength) {
	vec2 st = uv - .5;
	float uvA = atan(st.x, st.y);
	float uvD = dot(st, st);
	return .5 + vec2(sin(uvA), cos(uvA)) * sqrt(uvD) * (1.0 - strength * uvD);
}

void main() {
  vec2 uv = openfl_TextureCoordv;
  vec2 pixelScale = openfl_TextureSize / pixel;
  if (amount != .0) {
    uv = PincushionDistortion(uv, amount);
  }
  if (pixel > .0) {
    uv = floor(uv * pixelScale) / pixelScale;
  }
  if (any(lessThan(uv, vec2(.0))) || any(greaterThan(uv, vec2(1.0)))) {
    discard;
  }
  gl_FragColor = texture2D(bitmap, uv);
}