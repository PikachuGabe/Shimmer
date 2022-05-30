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
    int lightCount;
    vec3 camPos;
};

vec4 color_light(vec3 pos, vec4 vertex_color) {
    vec3 lightColor = vec3(0., 0., 0.);
    vec3 fragPos = pos + camPos;
    for (int i = 0; i < lightCount; i++) {
        Light l = lights[i];
        float radius = pow(l.radius, 2);
        vec3 poss = vec3(0.,0.,0.);
        float intensity = pow(max(0., 1. - distance(l.position, fragPos) / l.radius), 2);
        lightColor += l.color.rgb * l.color.a * intensity;
    }

    vec3 lcolor_2 = clamp(lightColor.rgb, 0.0f, 1.0f);

    // blend
    return vec4(vertex_color.rgb + lcolor_2, 1.0);
    //    return vec4(max(vertex_color.rgb, lcolor_2), 1.0);
}

vec4 color_light_uv(vec3 pos, vec4 vertex_color,ivec2 uv) {
    float blockLight = smoothstep(0.5 / 16.0, 20.5 / 16.0, uv.x / 256.0);

    if (blockLight > 0.) {
        vec3 lightColor = vec3(0., 0., 0.);
        vec3 fragPos = pos + camPos;
        for (int i = 0; i < lightCount; i++) {
            Light l = lights[i];
            float radius = pow(l.radius, 2);
            vec3 poss = vec3(0.,0.,0.);
            float intensity = pow(max(0., 1. - distance(l.position, fragPos) / l.radius), 2);
            lightColor += l.color.rgb * l.color.a * intensity;
        }

        // from light.glsl#minecraft_sample_lightmap

        //        vec3 lcolor_2 = clamp(lightColor.rgb, 0.0f, 1.0f);
        return vec4(vertex_color.rgb + clamp(lightColor.rgb * blockLight * 3.5, 0.0, 1.0), 1.0);
        //        return vec4(vertex_color.rgb + lcolor_2 * blockLight * 3., 1.0);
    } else {
        return vertex_color;
    }

    // just take x coordinate into account as it represent block light , skip the sky light
}
