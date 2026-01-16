shader_type canvas_item;

uniform vec4 key_color : source_color = vec4(0,1,0,1);

// From https://github.com/libretro/glsl-shaders/blob/master/nnedi3/shaders/rgb-to-yuv.glsl
vec2 RGBtoUV(vec3 rgb) {
  return vec2(
    rgb.r * -0.169 + rgb.g * -0.331 + rgb.b *  0.5    + 0.5,
    rgb.r *  0.5   + rgb.g * -0.419 + rgb.b * -0.081  + 0.5
  );
}

vec4 ProcessChromaKey(sampler2D tex,vec2 texCoord) {
  vec4 rgba = texture(tex, texCoord);
  float chromaDist = distance(RGBtoUV(texture(tex, texCoord).rgb), RGBtoUV(key_color.rgb));
  float fullMask = pow(clamp((chromaDist - 0.01) / 0., 0., 1.), 1.5);
  rgba.a = fullMask;

  return rgba;
}

void fragment() {
  COLOR = ProcessChromaKey(TEXTURE, UV);
}