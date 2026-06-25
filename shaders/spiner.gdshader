shader_type canvas_item;

uniform float progress = 0.5;
uniform vec3 empty_color = vec3(0.0);
uniform vec3 fill_color_start = vec3(1.0,0.0,0.0);
uniform vec3 fill_color_end = vec3(0.0,1.0,0.0);
uniform float in_radius = 0.2;
uniform float out_radius = 0.4;
uniform float domain_start = 0.1;
uniform float domain_end = 0.9;

float map_to_domain(float a){
    return  domain_start + (domain_end - domain_start) * a;
}

float point_to_progress(vec2 uv, vec2 center){
    uv -= center;
    return (atan(uv.y, uv.x)+PI)/(PI/.5);
}

vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}


vec3 blend(vec3 a, vec3 b, float rate){
    a = rgb2hsv(a);
    b = rgb2hsv(b);
    return hsv2rgb(a + (b-a)*rate);
}

void fragment() {
    COLOR.a = 0.;
    float dist = distance(UV, vec2(0.5));
    float point_progress = point_to_progress(UV,vec2(.5));
    if (dist < out_radius && dist > in_radius &&  point_progress > domain_start && point_progress < domain_end){
        COLOR.a = 1.;
    }
    COLOR.rgb = empty_color;
    if (point_progress < map_to_domain(progress)){
        COLOR.rgb = blend(fill_color_start, fill_color_end, progress);
    }
}