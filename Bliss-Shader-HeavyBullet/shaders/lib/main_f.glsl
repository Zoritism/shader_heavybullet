#include "/settings.glsl"

#if FLASH_LIGHT > 0
uniform vec3 cameraPosition; // Позиция камеры
uniform vec3 flashlightDirection; // Направление фонарика
uniform float FLASHLIGHT_BRIGHTNESS;
uniform float FLASHLIGHT_WIDTH;

void applyFlashlight(inout vec3 color, vec3 worldPos) {
    vec3 lightDir = normalize(flashlightDirection);
    vec3 toPixel = normalize(worldPos - cameraPosition);
    float intensity = max(0.0, dot(lightDir, toPixel));
    intensity = pow(intensity, FLASHLIGHT_WIDTH) * FLASHLIGHT_BRIGHTNESS;
    color += vec3(1.0, 0.9, 0.8) * intensity; // Цвет фонарика
}
#endif