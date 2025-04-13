#include "/settings.glsl"

#if FLASH_LIGHT > 0
uniform vec3 cameraPosition; // Позиция камеры
uniform vec3 flashlightDirection; // Направление фонарика
uniform float FLASHLIGHT_BRIGHTNESS;
uniform float FLASHLIGHT_WIDTH;

uniform float viewWidth;
uniform float viewHeight;
uniform int heldItemId;
uniform int heldItemId2;
uniform int heldBlockLightValue;
uniform int heldBlockLightValue2;

void applyFlashlight(inout vec3 color, vec3 worldPos, vec2 fragCoord) {
    vec3 lightDir = normalize(flashlightDirection);
    vec3 toPixel = normalize(worldPos - cameraPosition);

    // Расчёт интенсивности фонарика
    float intensity = max(0.0, dot(lightDir, toPixel));
    intensity = pow(intensity, FLASHLIGHT_WIDTH) * FLASHLIGHT_BRIGHTNESS;

    // Добавление эффекта фонарика
    float radialEffect = clamp(1.0 - 2.0 * distance(fragCoord, 0.5 * vec2(viewWidth, viewHeight)) /
                                (viewHeight * FLASHLIGHT_WIDTH), 0.0, 1.0);
    color += vec3(1.0, 0.9, 0.8) * intensity * radialEffect;
}

#endif

void main() {
    // Временно отображаем значение flashlightDirection как цвет
    gl_FragData[0] = vec4(flashlightDirection, 1.0); // RGB = XYZ, Alpha = 1
}