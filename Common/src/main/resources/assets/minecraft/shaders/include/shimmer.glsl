#version 150

//shimmer light
struct Light {
    vec4 color;
    vec3 position;
    float radius;
};

layout (std140) uniform Lights {
    Light lights[2048];     //  16  8 * 2048
};

layout (std140) uniform Env {
    int blockLightCount;
    int playerLightCount;
    vec3 camPos;
};

vec3 jodieReinhardTonemap(vec3 c){
    float l = dot(c, vec3(0.2126, 0.7152, 0.0722));
    vec3 tc = c / (c + 1.0);

    return mix(c / (l + 1.0), tc, tc);
}

vec3 player_light(vec3 fragPos, vec4 vertex_color) {
    vec3 lightColor = vec3(0., 0., 0.);
    for (int i= blockLightCount ; i<blockLightCount + playerLightCount;i++){
        Light l = lights[i];
        float intensity = smoothstep(0., 1., 1. - distance(l.position, fragPos) / l.radius);
        lightColor += l.color.rgb * l.color.a * intensity;
    }
    return lightColor;
}

vec4 color_light(vec3 pos, vec4 vertex_color) {
    vec3 lightColor = vec3(0., 0., 0.);
    vec3 fragPos = pos + camPos;
    for (int i = 0; i < blockLightCount; i++) {
        Light l = lights[i];
        float intensity = smoothstep(0., 1., 1. - distance(l.position, fragPos) / l.radius);
        lightColor += l.color.rgb * l.color.a * intensity;
    }
    lightColor += player_light(fragPos,vertex_color);

    lightColor = jodieReinhardTonemap(lightColor);

    vec3 lcolor_2 = clamp(lightColor.rgb, 0.0f, 1.0f);

    // blend
    return vec4(vertex_color.rgb + lcolor_2, vertex_color.a);
}

vec4 color_light_uv(vec3 pos, vec4 vertex_color,ivec2 uv) {
    float blockLight = smoothstep(0.5 / 16.0, 20.5 / 16.0, uv.x / 256.0);
    vec3 fragPos = pos + camPos;

    if (blockLight > 0. && uv.x < 255.) {
        vec3 lightColor = vec3(0., 0., 0.);
        for (int i = 0; i < blockLightCount; i++) {
            Light l = lights[i];
            float intensity = smoothstep(0., 1., 1. - distance(l.position, fragPos) / l.radius);
            lightColor += l.color.rgb * l.color.a * intensity;
        }

        lightColor = jodieReinhardTonemap(lightColor);

        return vec4(vertex_color.rgb + clamp(lightColor.rgb * blockLight * 3.5 + player_light(fragPos,vertex_color), 0.0, 1.0) , vertex_color.a);
    } else {
        return vertex_color + vec4(player_light(fragPos,vertex_color),.0);
    }
}

// for rubidium
vec4 rb_color_light_uv(vec3 pos, vec4 vertex_color, vec2 uv) {
    float blockLight = uv.x;

    if (blockLight > 0. && blockLight <= 0.97) {
        vec3 lightColor = vec3(0., 0., 0.);
        vec3 fragPos = pos + camPos;
        for (int i = 0; i < blockLightCount; i++) {
            Light l = lights[i];
            float intensity = smoothstep(0., 1., 1. - distance(l.position, fragPos) / l.radius);
            lightColor += l.color.rgb * l.color.a * intensity;
        }

        lightColor = jodieReinhardTonemap(lightColor);

        return vec4(vertex_color.rgb + clamp(lightColor.rgb * blockLight * 3.5, 0.0, 1.0), vertex_color.a);
    } else {
        return vertex_color;
    }
}
