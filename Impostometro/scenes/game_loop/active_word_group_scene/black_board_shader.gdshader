shader_type canvas_item;


// Base color: set to near-black (blackboard) or dark green (school board)
uniform vec4 base_color : source_color = vec4(0.07, 0.10, 0.09, 1.0); // blackboard
// Example green board: vec4(0.12, 0.22, 0.17, 1.0)

uniform float slate_scale     = 6.0;   // low-frequency slate variation
uniform float slate_strength  = 0.08;

uniform float smear_angle     = 0.0;   // radians; 0 = horizontal eraser swipes
uniform float smear_length    = 0.75;  // swipe length in UV units
uniform float smear_scale     = 50.0;  // density of smear pattern
uniform float smear_strength  = 0.10;  // brightness added by smears

uniform float dust_scale      = 600.0; // tiny speckles of chalk dust
uniform float dust_amount     = 0.015; // 0..~0.05
uniform float dust_strength   = 0.20;  // brightness of specks

uniform float edge_wear       = 0.20;  // 0..1, how strong the edge chalk build-up is
uniform float edge_softness   = 0.02;  // how wide/soft the edges are

uniform float seed            = 0.0;   // randomize the pattern

// --------- lightweight value noise / fbm ----------
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
float fbm(vec2 p){
    float v = 0.0;
    float a = 0.5;
    for (int i = 0; i < 5; i++){
        v += a * noise(p);
        p *= 2.0;
        a *= 0.5;
    }
    return v;
}

// 1D blur of noise along a direction to mimic eraser smears
float smear_along(vec2 uv, vec2 dir, float len, float scale){
    dir = normalize(dir);
    const int SAMPLES = 12;
    float acc = 0.0;
    float halfw = float(SAMPLES - 1) * 0.5;
    for (int i = 0; i < SAMPLES; i++){
        float t = (float(i) - halfw) / float(SAMPLES - 1);
        vec2 off = dir * t * len;
        acc += noise((uv + off) * scale);
    }
    return acc / float(SAMPLES);
}

void fragment(){
    vec2 uv = UV;

    // Base slate variation
    float slate = fbm(uv * slate_scale);
    float slate_term = (slate - 0.5) * 2.0 * slate_strength;

    // Eraser smears (anisotropic blur of noise along angle)
    float s = sin(smear_angle), c = cos(smear_angle);
    vec2 dir = vec2(c, s);
    float smear = smear_along(uv, dir, smear_length, smear_scale);
    // emphasize brighter chalky streaks only
    float smear_term = max(0.0, (smear - 0.5) * 2.0) * smear_strength;

    // Tiny chalk dust speckles (thresholded noise)
    float dust_n = noise(uv * dust_scale + seed * 10.0);
    float dust_mask = step(1.0 - dust_amount, dust_n); // sparse white flecks
    float dust_term = dust_mask * dust_strength;

    // Edge wear / chalk build-up near borders
    float edge_d = min(min(uv.x, 1.0 - uv.x), min(uv.y, 1.0 - uv.y));
    float edge_mask = 1.0 - smoothstep(0.0, edge_softness, edge_d);
    float edge_term = edge_mask * edge_wear;

    vec3 col = base_color.rgb;
    col += slate_term;
    col += smear_term;
    col += dust_term;
    col += edge_term;

    COLOR = vec4(clamp(col, 0.0, 1.0), base_color.a);
}



//void vertex() {
	//// Called for every vertex the material is visible on.
//}



//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
