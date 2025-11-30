shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform vec4 base_color : source_color = vec4(0.78, 0.78, 0.78, 1.0); // aluminum-ish
uniform float grain_scale = 900.0;   // higher = finer grain
uniform float grain_strength = 0.14; // 0..1 streak contrast
uniform float blur = 10.0;           // samples along the grain
uniform float rotation = 0.0;        // radians; 0 = horizontal grain
uniform float seed = 0.0;            // change to vary the pattern

float hash(vec2 p){
    p = vec2(dot(p, vec2(127.1,311.7)), dot(p, vec2(269.5,183.3)));
    return fract(sin(p.x + p.y + seed) * 43758.5453123);
}

float noise(vec2 p){
    vec2 i = floor(p);
    vec2 f = fract(p);
    float a = hash(i);
    float b = hash(i + vec2(1.0,0.0));
    float c = hash(i + vec2(0.0,1.0));
    float d = hash(i + vec2(1.0,1.0));
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(mix(a,b,u.x), mix(c,d,u.x), u.y);
}

void fragment(){
    vec2 uv = UV;
    // rotate UVs to control grain direction
    float s = sin(rotation), c = cos(rotation);
   	mat2 R = mat2(vec2(c, -s), vec2(s, c));
    vec2 p = R * (uv - 0.5) + 0.5;

    // blur 1D noise along one axis to get “brushed” streaks
    float samples = max(1.0, blur);
    float halfw = samples * 0.5;
    float n = 0.0;
    // limit loop for Godot: use a fixed upper bound and break
    for (float i = 0.0; i < 64.0; i += 1.0) {
        if (i >= samples) break;
        float o = (i - halfw) / grain_scale;  // spacing of streaks
        n += noise(vec2(p.x, p.y + o));
    }
    n /= samples;

    // center and boost contrast a bit
    float streak = (n - 0.5) * 2.0; // -1..1
    vec3 col = base_color.rgb + streak * grain_strength;

    COLOR = vec4(col, base_color.a);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
